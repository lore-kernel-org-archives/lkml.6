Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522861993; cv=none;
        d=google.com; s=arc-20160816;
        b=y/REXP5i9uRpF2IyLV3+P8eaj17t4ov3dgufNUfNHU0pAg8AFOig7GNt+B9794235T
         QTR78HMcK3MVNvKZI+Kwka0YwDWkF1MDG1a+FZ27C2Be/oSWew+8la1qQ5vSGcLhMRTK
         IlbPNdsHR0X4kzPfQkD/3sFzcCcYL3IwGvSRSCaHLETkFJ7eePXhIG9XSmd7o+XoU7FN
         ZEVhU41kErD5sVoK+V5Bdxog9TuH9Fg++0pvFdDpeg02j1JTHFeA3veLxoQwd1yrdotf
         cFLdrkbqldr2lChcMAW51p/4pb1E6dhlglzqOUDOVeEcm3V5NuxBSDBoU3iY7f3Gqp+g
         ZKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=uLBES9rVO65pBo26Z3dg65RT+Ate0Kli9koibkvUH7k=;
        b=E1HUDsuN1wruwcMhD/agY1N8NInj1OkpMDFpZNy6Qjjm03d28kAiJmxtaWODC9otOb
         SEj6P6bIC5ClAoBgRQ8zdPm0AV37Jl4pRercY5rHVG5I1PU4aAYhQu+rA35izihCcgrK
         el8R/Ayx9/oIob65Ou6S5Y7ZE17aRaznbQkB9A9SSggGBmq/tSt7QKpt3fdXuE9wzbRg
         0Kvvcbc6NosM9WgTUO4OI5BBibPVVH6aBjecX6LjGDnzWTgVfNOTU+mDQdsNSN0DOAyk
         4USxu4Y1lbfTKsrKht4/uzXEatV/BRMX7y921bvZGg/UGX21sc/T7IHljqUuPVT4C4eN
         83Lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HOv4R2wC;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AJ5/uyRn;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HOv4R2wC;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AJ5/uyRn;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4+eY9zYih0hFRWdGN7gFVaFyT4zVS9f0B+z/+1UTX5pgvnWPbVBTkthACTq2NcJ3dS8EZ8WNlnWGpzsfIKqghk=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKwvOdkjB2LGXGn-9chPDtGyVmw9JF1FZ1ZBjSKEtK7BqbwF2g@mail.gmail.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdkjB2LGXGn-9chPDtGyVmw9JF1FZ1ZBjSKEtK7BqbwF2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 10:13:12 -0700
X-Google-Sender-Auth: yvxERTsyduEGpPz8Iu_eTaWzgRs
Message-ID: <CA+55aFyZA5t-+OyzSDDPGjDoaKsh=Erz8zuoEdDo7hOCBU6ZfQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596836537685624801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 9:49 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> It's definitely something curious that I'll need to sit down and investigate
> more.  If there are other known instances, it would be good to let me know.

Note that we explicitly use "-fno-delete-null-pointer-checks" because
we do *not* want NULL pointer check removal even in the case of a bug.

See commit a3ca86aea507 ("Add '-fno-delete-null-pointer-checks' to gcc
CFLAGS") for the reason: we had buggy code that accessed a pointer
before the NULL pointer check, but the bug was "benign" as long as the
compiler didn't actually remove the check.

And note how the buggy code *looked* safe. It was doing the right
check, it was just that the check was hidden and disabled by another
bug.

Removing the NULL pointer check turned a benign bug into a trivially
exploitable one by just mapping user space data at NULL (which avoided
the kernel oops, and then made the kernel use the user value!).

Now, admittedly we have a ton of other security features in place to
avoid these kinds of issues - SMAP helps on the hardware side, and not
allowing users to mmap() NULL in the first place helps with most
distributions, but the point remains: the kernel generally really
doesn't want optimizations that are perhaps allowed by the standard,
but that result in code generation that doesn't match the source code.

The NULL pointer removal is one such thing: don't remove checks in the
kernel based on "standard says". It's ok to do optimizations that are
based on "hardware does the exact same thing", but not on "the
standard says this is undefined so we can remove it".

Other examples of where the kernel doesn't want the compiler to do
"the standard says this is undefined so I can take shortcuts" include:

 -fno-strict-aliasing: the standard is just wrong and full of shit,
and the misguided type-based aliasing can cause serious problems for
the kernel (but also other code)

 -fno-strict-overflow: again, this is a stupid optimization that
purely depends on the compiler generating faster code by generating
incorrect code.

The one I'm actually upset about is when a compiler goes even
*further* and does things that are NOT EVEN allowed by the paper
standard, much less by real code.

The fact that clang by default enables "-fmerge-all-constants"
behavior is just inexcusable. That's not just "let's do invalid
optimizations based on undefined behavior". That's an actual "let's do
known invalid optimizations that are explicitly disallowed even by the
standard".

             Linus
