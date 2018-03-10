Return-Path: <kernel-hardening-return-12385-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvZhSTHj7dSVkjS1lrnizixGrZrVsXDIgJbfZAOGiimmyMMxVxehrbHKgaGyh6N2g7pn9fJ
ARC-Seal: i=1; a=rsa-sha256; t=1520708974; cv=none;
        d=google.com; s=arc-20160816;
        b=a8RBsml0DirTKN8VzVodb/q6oP2rDYvBzSOs3irb3wj0dTnTWKStipqTkJFh9XVqb/
         jQzVWY9qvE6vZclpXIJj3k93H31DRY5MOWoojLJqVTJLYTayPJU+9pQM9f3E+cuzwjJD
         SUqMuHklxfrKkgmF0yOC1PupD+p48fqqaAQfxRAwR2gcvQAHj2LS7BNkSUb0RcAms265
         YOyDCGQ3t9gnsY1orRR7oOa0WzHKI13pjDFO+n03DVpvaXjCU0cqaDQAdJ+J9Y02M3Qv
         OdGUM8bUvU6yDu/DXGkvz9jznCGnoilVuVJGT3q0DGxcetVEfaUOZQj8Rvtfwpj9ZLnr
         rFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=XJUNSdJLPTAB9EPny0aEb+atJmBZWnMr09bidkf90+0=;
        b=K+xXRJJDjiHxB/aJirvf9LZm/gzN8GmkiCgU2IxS+lI5kJPsZ3LMD08/xMZOcVQUo5
         s3vFcDCoEABA8/Ssk+zbYRorvDhPWNxYKzUKwJny5CF9cEOIJT23iIWp7kg951u4HKN+
         7znnw/3ODehMGUAUk+/PvCTpPe3U/6e8XsGsFvaDZ2MWUj6ZDNigsW65ZSiHqB8RmRFz
         PBJQ6epYpzVh10tlQZKujktnWgR46D7ZWTHEuE6w8BXqhbmI/d+Fh3bIKDpuOLaex0fV
         uDLCcP/o+OKq7Z7jTNDoFE6FmirKsFA/7hzn+ZW7TRK6yYqE20LN1WIhsE4j+LjmZkYc
         BQvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ozVNO5hS;
       spf=pass (google.com: domain of kernel-hardening-return-12385-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12385-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ozVNO5hS;
       spf=pass (google.com: domain of kernel-hardening-return-12385-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12385-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CA+55aFw+guiiJ3OavrP-RpFV9NRAF4t=oj3-GDfSyuZ9zBRfdg@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
 <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com>
 <CA+55aFyLicYSe+R4yQ2Eu+P9m6qsRfso-HiK78Sw+-dPuZvAYg@mail.gmail.com>
 <CANiq72nwg3mMhWeE_bLKdQ5WP+0E+SxxvcuUF=Rn9a1MM+EapQ@mail.gmail.com> <CA+55aFw+guiiJ3OavrP-RpFV9NRAF4t=oj3-GDfSyuZ9zBRfdg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Mar 2018 20:08:55 +0100
Message-ID: <CANiq72mTC6oo5WnomzOOh31FO_a9hiUebPmensLOcDAfi0sQ-A@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>,
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594578934222034661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 6:51 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So in *historical* context - when a compiler didn't do variable length
> arrays at all - the original semantics of C "constant expressions"
> actually make a ton of sense.
>
> You can basically think of a constant expression as something that can
> be (historically) handled by the front-end without any real
> complexity, and no optimization phases - just evaluating a simple
> parse tree with purely compile-time constants.
>
> So there's a good and perfectly valid reason for why C limits certain
> expressions to just a very particular subset. It's not just array
> sizes, it's  case statements etc too. And those are very much part of
> the C standard.
>
> So an error message like
>
>    warning: ISO C90 requires array sizes to be constant-expressions
>
> would be technically correct and useful from a portability angle. It
> tells you when you're doing something non-portable, and should be
> automatically enabled with "-ansi -pedantic", for example.
>
> So what's misleading is actually the name of the warning and the
> message, not that it happens. The warning isn't about "variable
> length", it's literally about the rules for what a
> "constant-expression" is.
>
> And in C, the expression (2,3) has a constant _value_ (namely 3), but
> it isn't a constant-expression as specified by the language.
>
> Now, the thing is that once you actually do variable length arrays,
> those old front-end rules make no sense any more (outside of the "give
> portability warnings" thing).
>
> Because once you do variable length arrays, you obviously _parse_
> everything just fine, and you're doing to evaluate much more complex
> expressions than some limited constant-expression rule.
>
> And at that point it would make a whole lot more sense to add a *new*
> warning that basically says "I have to generate code for a
> variable-sized array", if you actually talk about VLA's.
>
> But that's clearly not what gcc actually did.
>
> So the problem really is that -Wvla doesn't actually warn about VLA's,
> but about something technically completely different.
>

I *think* I followed your reasoning. For gcc, -Wvla is the "I have to
generate code for a variable-sized array" one; but in this case, the
array size is the actual issue that you would have liked to be warned
about; since people writing:

    int a[(2,3)];

did not really mean to declare a VLA. Therefore, you say warning them
about the "warning: ISO C90 requires array sizes to be
constant-expressions" (let's call it -Wpedantic-array-sizes) would be
more helpful here instead of saying stuff about VLAs.

In my case, I was just expecting gcc to give us both warnings and
that's it, instead of trying to be smart and give only the
-Wpedantic-array-sizes one (which is the one I was wondering in my
previous email about why it was missing). I think it would be clear
enough if both warnings are shown are the same time. And it makes
sense, since if you write that line in ISO C90 it means there really
are 2 things going wrong in the end (fishy syntax while in ISO C90
mode and, due to that, VLA code generated as well), no?

Thanks for taking the time to write about the historical context, by the way!

Miguel

> And that's why those stupid syntactic issues with min/max matter. It's
> not whether the end result is a compile-time constant or not, it's
> about completely different issues, like whether there is a
> comma-expression in it.
>
>               Linus
