Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522946621; cv=none;
        d=google.com; s=arc-20160816;
        b=mTyM3K5P7CL3zAPBobXY/RyVQEREKrai1eevFit3s5G64EDGHeD45J5o/+5HArVjob
         oQJ3GaC6CtkbQaqsbGtNn2FdhkueO4XOSsKbR3UJ2A0B/AIqi+wG17yShWYYo0JYuFB9
         +S7R2tB3yX7j1pKp/g5iknEosWVEEghLav4BegvYkXLm4QgHrgiRhTouPdD+ZEqBen/m
         ssEAHsKkSubhiitgt2uJf3k+cfgN70v4oyk0mbG08xYvzEtxlzH/bzlsM48X9NbXAa83
         6GpgCN1njyyLA8cLtD8HkqJTdrD/pstyWeoNZ+qoSJEAUkK7qZmDTH7dfYj3Fl6FYmG2
         9pDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9Y8yvMy6PwmzokINugZEF/Uev2A+39ZqW2wUigeGJFg=;
        b=Dt1oobDODJvA13R556eEtazCfpTWpd/rghuKwQyW4KJjGX48P7lodgM+WNlaeW80hb
         ParJS2bXjrFYXIlpgRyBxbjPV1ILs2MV1B6P1CcOLTtJNrlJEEPahcvfNXb61V1PJimI
         FCEYJIIFUkP3BUikhyyq+wBwV9ZvyR6CxSLz2h+29g0g6RLNXafsMrreQhC2veEBRrgh
         Jvw+N0SvGBU2mEUoWQ867LjWXIQl5AdzEkAZRso7widBal1gvfRHKUteKxMhz0yZk2iQ
         oPqvK7fXjhinvXreqvSuKT2l4IiCo7vhubqEqGK34yPwFOtmGhKxbH442f6joD2a2biJ
         JgXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RqLapFTs;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=T3vHhOTF;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RqLapFTs;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=T3vHhOTF;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/3VMdL8tuCd4flR679HNMRAxYSUqmx+AKDfbErqOSRPAKaq1vi+ZnVRk3zc8RBi1d6CkrSmazScVs+iIEpePI=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180405072401.GO4043@hirez.programming.kicks-ass.net>
References: <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
 <20180405072401.GO4043@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 09:43:40 -0700
X-Google-Sender-Auth: K26ulI72Wu-bt6hht0Mvg-hljE0
Message-ID: <CA+55aFzJ9iv6S2hczHjPS3kckWOrhfWvjNADdjivO6N7u5YNhQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>, Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596925276291578144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 12:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> I always assumed BT was a more expensive instruction than AND with
> immediate.

Oh, absolutely. That's why we do all those "depending on immediate or not".

The reason I brought that case up is that "test_bit()" and "set_bit()"
do this "is it constant" test COMPLETELY DIFFERENTLY.

The test_bit() one is arguably much more legible, and easier to
understand. And it so happens that clang will see that it's constant
because it's a macro (well, unless that macro is then used in an
inline function).

The set_bit() pattern looks completely different, and doesn't have
that abstraction of "constant_set_bit()" vs "variable_set_bit()", like
test_bit() does.

THAT was why I pointed it out - we do different things otherwise
similar operations.

Not because it would be odd that we do different things for the
"constant bit number" vs "variable bit number".

               Linus
