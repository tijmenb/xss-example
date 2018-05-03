name = "<script>alert('HACKED')</script>"

require 'erubi'

class String
  def html_safe
    SafeString.new(self)
  end

  def safe?
    false
  end
end

class SafeString < String
  def safe?
    true
  end
end

def escape_me(str)
  if str.safe?
    str
  else
    CGI.escapeHTML(str)
  end
end

puts eval Erubi::Engine.new("Hey <%= name.html_safe %>!", escape: true, escapefunc: :escape_me).src
