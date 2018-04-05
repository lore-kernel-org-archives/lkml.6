Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522962810; cv=none;
        d=google.com; s=arc-20160816;
        b=YVBi3oBHYFha7Fbu0OfCBqYuI6RqdavKOtcqMiQF2KmI3Rli4VUObNYNcDOKImgHJK
         X9fg7ywFffgLH0znaqT9dJqDCgQpgkWF0LCIxZjnpTuictW1Ym5N0hZ2o1u8uy8ubJ5C
         noes63vgIykDTzLTdmRgbycdIgjn6Mfptm709BhXKfSQ8vAGaQEPP23IXMNYUJTSYo/7
         DxyOv5uRSTpUJIso8qigO8JWbGkO4Rq3iK/EQkEeSQO1kyUs+57zret/tg5mcv0thctS
         W0cnVe1oMGQeEngar68hWnbQyMne8n1NveafUUcyVHsl2INPupcrNTlYMs902IbTmkKV
         S8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jmScqC1fsWiKnfnDdIrF8ef3DocZ+Z0QNqXKRB+xzuo=;
        b=KeG1YOES426v7ispFJ6C8IVT9XpuWtXXbOChuWz28Tki4o4PblObXwJwgWH3znkX2X
         65/jUZ+jVrlrKe2K9Rmv7LUoSgoakScGeD/VXfiVDbDv9MrZ973MwET7qKbdA3NFwDP0
         4Ztnedl41KjQS+H8jMfgbt5//cQcbLwiRd3SxBDMjfUxaG1uocB5opLU8PHnBspRT6PP
         0hgsQ0GSCgHkNja4uhWqWCnQ7SqSRDto1TaGwlJGdgFFdpKryLEWq+f9jjigOXOMdqqI
         G6fDX9a4TkrrzmZzoLEFPXGB5wh2QnrLkKV/Okni4e/CsVQlk6BUO2C/1zOcDOLkC4Hs
         YMGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u808vdmc;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=B5wybUn4;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u808vdmc;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=B5wybUn4;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/RE/4aXWwhvpmtJRPmrBgN5HcLSJiQEZGVRdOzAvvIYY0vrfvqQRNbbrah1XrEznXhiN7AKwdwiPmoVcpPmss=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAA2zVHrF+teb3SwigH_sDqkWfKDg4itq4TkefYXUXw2RF9+4qw@mail.gmail.com>
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
 <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com>
 <CA+55aFwrZU-VPa9HShikNDkvuOvFXtO2vw8sDeRRTCU_hV7dWA@mail.gmail.com> <CAA2zVHrF+teb3SwigH_sDqkWfKDg4itq4TkefYXUXw2RF9+4qw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 14:13:29 -0700
X-Google-Sender-Auth: MwXyxIFgRJCTi2O3eOWli31EboY
Message-ID: <CA+55aFz3PUE1mSM+yFeb55ca3EZAYHHqTyHjktiW1FVfK-tP9A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: James Y Knight <jyknight@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthias Kaehlcke <mka@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596942252037037846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 1:51 PM, James Y Knight <jyknight@google.com> wrote:
>
> I had actually meant that the __builtin_constant_p **itself** had to be a
> constant expression, not that its *argument* must be an I-C-E for
> __builtin_constant_p to return true.

I actually really wish that were true, and that it would always be
considered an ICE.

But it's not, as you also found out.

This exact problem is why we had to come up with that crazy
alternative test for an actual integer constant expression.

> Which means that __builtin_constant_p(v) was _not_ evaluated as an integer
> constant expression by GCC. Instead, it was left as an expression. And, the
> stack frame being only 24 bytes indicates that the __bcp eventually
> evaluated to true.

Yeah.

The best of all worlds would be that __builtin_constant_p() would
itself always evaluate as an integer constant expression, but the
expression inside of it could be expanded as if it was not.

I realize that that can be very inconvenient for a compiler, since the
two are basically done at different points in the evaluation, but it's
the nicest semantics for the user.

But since gcc doesn't actually provide those semantics, clearly clang
doesn't have to either.

I claim that it *could* be done right, though, if you happened to care
about giving the best possible quality end result to the user.

Instead of doing the integer constant expression testing early (before
inlining etc), you do it later, but you carry along a bit in the
expression that says "was this expression actually _syntactically_ an
I-C-E?"

And btw, I hate how stupid gcc is about "constant size arrays but acts
as a VLA because it wasn't an integer-constant-expression size"
things.

Your code generation example really is a sad sad example of it. A good
optimizer should have generated the same code even if the stupid array
again syntactically was VLA, because it damn well isn't in reality.

So if you get really excited about this, and decide that clang can do
much better than gcc, I can only salute you!

             Linus
