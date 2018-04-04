Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4/GkIi+LU+s1k9hOvvBfXOx0dAdKSsO6lUs4Y8ygzZbq4RifOnRs9oSLqDyMwX3wQkrGz76
ARC-Seal: i=1; a=rsa-sha256; t=1522834212; cv=none;
        d=google.com; s=arc-20160816;
        b=hH3Q7cA7QHnky+cOzeO9OT9qK691fAsBn+ELaXPZSnOW+svqaRupYMn1atjRWpb3Hb
         IBjxwix/XToMo663dG8YFaXjHAViDZP1AvXy23uZea2r2axKnCj05p/i9bDSlpall4IA
         nqHIHFT9NpbCkPbMIpRNGQWgVzYlRiKw2aQveHFb3iuK3q92sZ0fxxnhX7z7o0pYPJvt
         ZYndp7hlf9j1Z0hcU72Ne65Qrs0uZPQ8EKQv/FoQVgwomDfcKXxdQ4KoWlbvrkm2xJSo
         i8oJd3FNYPAx1RYQ7lvjEsosdtq7GTHZ4DKo9dEA26b8aeuUMSOX/27gLuEAHV4K7l5V
         CU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=fFIBP+ahGIcIb6n4Cq6YRk3HktQqqw1YlPcY7vp3ac0=;
        b=dC2ZGCw28AGAHsKmImfXU3D6Wc8Y+ic9EZcM9x2K8yuH/dnvaxscL9jExDlabjN1SL
         IPNbV6nMebg16hjMIrHDyUaGfeDilExQPIEvYuVGu96BTMUnW066kHGtdqEfTJA9u5qE
         dv7EfnID3jDjMArdxlQvOEue+ThFJ9doBJvc5lp3aJylMXhmRpEvXADEeUl9e1+N09uw
         3c2yatgBhwUjrZHkglylNkdXPHq4FbgBu4GpXF5d0P3MP4HzKiyrrp0uQkG0QFaaal4o
         T3A0IzmdtsmHMXDXijAIrG4W1/QDazkBDjBQ9knZRv0EgoAtNhUAQ6RR2GfKXkf92HWF
         RbrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LgF9+Vbe;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LgF9+Vbe;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 4 Apr 2018 11:30:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403180658.GE87376@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596807406723415347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 11:06:58AM -0700, Matthias Kaehlcke wrote:

> Yes, Chrome OS R67 (currently dev, soon beta) will ship a kernel built
> with Clang for multiple x86 Chromebooks.

But there are still _known_ miscompilations....

> Given that it takes time for distributions to roll out new compiler
> versions I would like to ask for a longer period of 'exemption' from
> asm-goto for Clang, at least if it isn't an actual burden for the
> kernel, like preventing important features from being added. An ideal
> time would be after the next-next LTS version, if this is considered
> too far out, after the next LTS version would be the second best time
> IMO. Let me be clear, this is *not* to delay the implementation of
> asm-goto, but to facilitate the use of Clang-built kernels by other
> projects and distributions, as well as automated builds of upstream
> kernels with Clang, without requiring necessarily the very latest
> version of Clang or extra patches.

I don't think that's sane or realistic, given that the very latest clang
is _known_ to miscompile the kernel. How can you want to support older
compilers that are therefore also known to not work correctly.

Next LTS is still a fair way out, if we take LTS release to be
every ~5 releases, the next one would be ~.19, that's still 3 releases
hence. That's a _long_ time.

I don't see the point in waiting that long for a compiler that doesn't
work even without asm-goto.
