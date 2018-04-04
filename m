Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522870927; cv=none;
        d=google.com; s=arc-20160816;
        b=foZwVPZqb560PM8RS8hZfN11GGi3Tz01J3lRemDK7wbDsJrLtMAS9trwLhrxm/SfQ9
         E7obq8RNhZtmrAwfqZxcwOLp7FPdsMTJw6RcRXpIqdflkM5L7eHTZqII8QDaBdaANIbA
         dLc0IYYRHSDPvYfilPoCGv+9U3x6hSLr8NLaHT/jz8+ya9iFLYjW888BUDNZM+ezqRoj
         ugUHGZoIrccor8RYmUHHvjLRciALTDf1qx7GQapnATHSopep97wc5HMOTVwW0Ny4VxUv
         gJlSJcOB2MdLGHNRSKnuE1t50eZqyagpRsY07YEgq+l89qaD7lnxt7IJKXUxEGH++Sk4
         eBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=TvdTcNL2rpCNijMh6fVC7/pJnidewoZ8nflChmFR/IQ=;
        b=A2pe/z+VjkTFhFMtzgGk/caPOVZIMibvMiuMOdfvMEYeyaSBW+6jhjySSaTKjU6/J+
         CcpmA0VLaXXfgCV5cqcq6A3XYRyrqDUhSmc2ojVvFHuqR0P2DrF1aAGPsFBGC0JuJBOM
         p+LrqLddf8FY3xCZVOSARkFEhmkq24xNjLZdC1G2VLkA3Guwe3EVvCmZ5BHGbsi9xfAZ
         DQbosKEBG0vQ7ZGSH1XP/a9EUfVlUMMlghGvZI4mvxhOgCl8YW62lQ0cTcenUI7FBDKC
         jNCjhdHk+j3fCtXCCYghlE2q912bPlarPQF7uE7s6mKkgw/RDcmijbEVZlEJqqlYE/0+
         aCgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fi1GQsZ0;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=R5YTCDWM;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fi1GQsZ0;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=R5YTCDWM;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx49Rfuk54BOkdvneW3w5OoaB1L1JZNfa1eWnDJ5xb5F9y79o1lxzzRPaDXhrKmbApCsec55zn1quFFXVOqLkQD4=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404165914.GA9034@kroah.com> <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 12:42:06 -0700
X-Google-Sender-Auth: lZF43To9ro3eqOWuj8m58lN2LDc
Message-ID: <CA+55aFysRcOu7F-kZKNWp_fY1DViQoz7OmXUBeD0xhXROvPYqA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: James Y Knight <jyknight@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Matthias Kaehlcke <mka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596845906085328121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 12:26 PM, James Y Knight <jyknight@google.com> wrote:
>
> (OTOH, I _do_ expect clang to eventually gain support for a flag to treat
> NULL-pointer deref as a legal operation instead of UB. I'm not really sure
> it makes sense for the linux kernel, but it's a useful feature for the
> compiler to provide in any case, so why not...)

I would actually argue that this is more closely related to
"-fno-strict-overflow" than to "-fno-delete-null-pointer-checks'.

It just happens to be about pointer arithmetic, rather than about
signed integers. We *will* do arithmetic with NULL pointers that can
wrap.

Yes, the kernel does odd things with pointers in general. I won't
apologize for it, because we have really good reasons for doing so.

The whole "we take offsets of pointers even *backwards*" is because we
extensively rely on embedding structures inside each other. If clang
actually did proper optimization, it would have noticed that the
"offset backwards" was followed by an "offset forwards" and then a
NULL pointer check, and that there actually was no actual real
wrapping or non-contiguous behavior in reality.

But clang didn't do that, and instead blindly said "you're going
forwards and the result can't be NULL", without ever looking at "oh,
they went backwards first".

So honestly, part of the problem we had with clang was that it was too
*stupid* to see that what we did wasn't actually invalid even by
clang's own standards!

I'm not saying that the kernel use is really standards compliant,
because there definitely are those temporary pointer values (that are
never used!) that point outside an object.

But honestly, the clang "optimization" is really quite debatable, and
we'd want to turn it off - or just have clang be smarter enough that
it sees that "oh, it all stays within the object after all".

We do other things to pointers that the standard may not cover. Deal
with it. Any malloc() library will similarly just depend on pointer
arithmetic really working. We may admittedly take it to some
ridiculous degrees, with the whole "ok, we assign negative values to
pointers as error cases" in addition to the "we use container_of() to
look uip pointers *backwards*" thing.

So we'd definitely want that "-fno-strict-overflow" to affect pointer
arithmetic too (or have a separate flag for the pointer equivalent of
"we play games that may temporarily wrap pointer values around"..

                 Linus
