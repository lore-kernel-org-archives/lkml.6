Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518847603; cv=none;
        d=google.com; s=arc-20160816;
        b=bvL/R3v+cKCgeyXg7zSe0DB3YGIqu1WfGdhYpjyC1+khjlyJ7jILJ2cTsYbVGleiUU
         7/S4aawNCzLXEn67NkZQ4OuluejKvi+clZGUDpQU7VieNjWsN8dlkOehH4i4j1+mDDpO
         C+rgIMJpXVlqWhYeEQ4mLFa38tArsw5RQAOkdu9vpQfbxMjuzUgCmmfz4l31XFViC0Vt
         jKqNexWhYisOLDDoobsUD5vo6YrDpSkfuGUQnrOxNzGJ41e7lKqFEjG7MmH6RQ1vUtVt
         xCxCPY/2tU6MIjWpo5JVPlVvZwgul+Slol4KZCIGrYUQN220/toUJzwAVtpCfWsmep9+
         CG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=J4Qa4XFD2FFmHbaZiYkxNatPKzUSIjvobSP1JFRm838=;
        b=E/q396qcgpaxGl0LEnF5ZgYVcsz5K91uTymH/HG6zEHJQv+vLTrwEhtIek3hiW544X
         nzAbi/Iif9DsCl+3BWNh9CvfqVXUinZMDRyBtihjD6bKa7rbvKZbzWs142o0Hqp4Zj8D
         iyHOXxQT9EuBCZoZbcDALrgRSCeoDud0U2y61Dgu5harnVwn/Is8n+JkY2N4cETQdKB3
         lRIO9HnHLtfL+mYXaoFDkaivRlpMgdWCAYIls5O7kNlZPE5kDyKzaIxH6qii7A29R3aE
         V65Z40C6/7yqwi+20nu5bouWLZao4F60QXXrrLFWz1JX3V8uAP4i7YYNnSz8H2Suyd+1
         tJ9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uF47xfAV;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uF47xfAV;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224gdxakpsH1VPC5WihP0dVicr/M8sAhu5OmJGjo4mI9kmYZTLtX0r7a/qrkYbpNQSGW9u9rog==
Date: Sat, 17 Feb 2018 07:06:39 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/23] kconfig: add 'macro' keyword to support
 user-defined function
Message-ID: <20180217060639.jfcrgzvemluatnmo@huvuddator>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-9-git-send-email-yamada.masahiro@socionext.com>
 <nycvar.YSQ.7.76.1802161438470.31719@knanqh.ubzr>
 <20180216235138.b4p6q62auvnzb2sy@huvuddator>
 <nycvar.YSQ.7.76.1802162118010.31644@knanqh.ubzr>
 <CAFkk2KTUGdLm+7HAFCq+dv78+QT9-GJivayh7M4pG9O_UkeLMQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1802162331400.31644@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1802162331400.31644@knanqh.ubzr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925591879125?=
X-GMAIL-MSGID: =?utf-8?q?1592627144347076381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:44:25PM -0500, Nicolas Pitre wrote:
> On Sat, 17 Feb 2018, Ulf Magnusson wrote:
> 
> > On Sat, Feb 17, 2018 at 3:30 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > On Sat, 17 Feb 2018, Ulf Magnusson wrote:
> > >
> > >> On Fri, Feb 16, 2018 at 02:49:31PM -0500, Nicolas Pitre wrote:
> > >> > On Sat, 17 Feb 2018, Masahiro Yamada wrote:
> > >> >
> > >> > > Now, we got a basic ability to test compiler capability in Kconfig.
> > >> > >
> > >> > > config CC_HAS_STACKPROTECTOR
> > >> > >         bool
> > >> > >         default $(shell $CC -Werror -fstack-protector -c -x c /dev/null -o /dev/null)
> > >> > >
> > >> > > This works, but it is ugly to repeat this long boilerplate.
> > >> > >
> > >> > > We want to describe like this:
> > >> > >
> > >> > > config CC_HAS_STACKPROTECTOR
> > >> > >         bool
> > >> > >         default $(cc-option -fstack-protector)
> > >> > >
> > >> > > It is straight-forward to implement a new function, but I do not like
> > >> > > to hard-code specialized functions like this.  Hence, here is another
> > >> > > feature to add functions from Kconfig files.
> > >> > >
> > >> > > A user-defined function can be defined as a string type symbol with
> > >> > > a special keyword 'macro'.  It can be referenced in the same way as
> > >> > > built-in functions.  This feature was also inspired by Makefile where
> > >> > > user-defined functions are referenced by $(call func-name, args...),
> > >> > > but I omitted the 'call' to makes it shorter.
> > >> > >
> > >> > > The macro definition can contain $(1), $(2), ... which will be replaced
> > >> > > with arguments from the caller.
> > >> > >
> > >> > > Example code:
> > >> > >
> > >> > >   config cc-option
> > >> > >           string
> > >> > >           macro $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> > >> >
> > >> > I think this syntax for defining a macro shouldn't start with the
> > >> > "config" keyword, unless you want it to be part of the config symbol
> > >> > space and land it in .config. And typing it as a "string" while it
> > >> > actually returns y/n (hence a bool) is also strange.
> > >> >
> > >> > What about this instead:
> > >> >
> > >> > macro cc-option
> > >> >     bool $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> > >> >
> > >> > This makes it easier to extend as well if need be.
> > >> >
> > >> >
> > >> > Nicolas
> > >>
> > >> I haven't gone over the patchset in detail yet and might be missing
> > >> something here, but if this is just meant to be a textual shorthand,
> > >> then why give it a type at all?
> > >
> > > It is meant to be like a user-defined function.
> > >
> > >> Do you think a simpler syntax like this would make sense?
> > >>
> > >>       macro cc-option "$(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)"
> > >>
> > >> That's the most general version, where you could use it for other stuff
> > >> besides $(shell ...) as well, just to keep parity.
> > >
> > > This is not extendable.  Let's imagine that you might want to implement
> > > some kind of conditionals some day e.g.:
> > >
> > > macro complex_test
> > >         bool $(shell foo) if LOCKDEP_SUPPORT
> > >         bool y if DEBUG_DRIVER
> > >         bool n
> > 
> > I still don't quite get the semantics here. How would the behavior
> > change if the type was changed to say string or int in some or all of
> > the lines?
> 
> I admit this wouldn't make sense to have multiple different types. In 
> this example, the bool keyword acts as syntactic sugar more than 
> anything else.
> 
> > Since the current model is to evaluate $() while the Kconfig files are
> > being parsed, would this require evaluating Kconfig expressions during
> > parsing? There is a relatively clean and (somewhat) easy to understand
> > parsing/evaluation separation at the moment, which I like.
> 
> Agreed. Let's forget about the conditionals then.
> 
> 
> Nicolas

This is also related to why it feels off to me to (at least for its own
sake) make macro definitions mimic symbol definitions.

To me, parsing being a different domain makes it "okay" to use a
different syntax for macros compared to symbol definitions, especially
if it happens to be handier. It even makes things less confusing,
because there's less risk of mixing up the two domains (it's rare to mix
up the preprocessor with C "proper", since the syntax is so different).

More practically, I'm not sure that

	macro foo "definition"

would be that hard to extend in practice, if you'd ever need to. You could
always add a new keyword:

	fancy-macro/function/whatever foo ...

I admit it'd be a bit ugly if you'd ever end up with something like

	macro foo "definition"
		bit_ugly

It's still not the end of the world though, IMO, and I suspect there'd
be better-looking options if you'd need to extend things on the macro
side.

That macro syntax seems like the simplest possible thing to me, with no
obvious major drawbacks. Keeping parsing and evaluation cleanly
separated is more important than the exact syntax though. It's a bonus
if symbols and macros stand out as coming from different universes to
people reading the Kconfig.

Cheers,
Ulf
