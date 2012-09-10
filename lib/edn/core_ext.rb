require 'time'

module EDN
  module CoreExt
    module Unquoted
      def to_edn
        self.to_s
      end
    end

    module String
      def to_edn
        self.inspect
      end
    end

    module Symbol
      def to_edn
        ":#{self.to_s}"
      end
    end

    module Array
      def to_edn
        '[' + self.map(&:to_edn).join(" ") + ']'
      end
    end

    module Hash
      def to_edn
        '{' + self.map { |k, v| [k, v].map(&:to_edn).join(" ") }.join(", ") + '}'
      end
    end

    module Set
      def to_edn
        '#{' + self.to_a.map(&:to_edn).join(" ") + '}'
      end
    end

    module NilClass
      def to_edn
        "nil"
      end
    end

    module Time
      def to_edn
        EDN.tagout("inst", self.xmlschema)
      end
    end
  end
end

Numeric.send(:include, EDN::CoreExt::Unquoted)
TrueClass.send(:include, EDN::CoreExt::Unquoted)
FalseClass.send(:include, EDN::CoreExt::Unquoted)
NilClass.send(:include, EDN::CoreExt::NilClass)
String.send(:include, EDN::CoreExt::String)
Symbol.send(:include, EDN::CoreExt::Symbol)
Array.send(:include, EDN::CoreExt::Array)
Hash.send(:include, EDN::CoreExt::Hash)
Set.send(:include, EDN::CoreExt::Set)
Time.send(:include, EDN::CoreExt::Time)