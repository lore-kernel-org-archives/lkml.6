Return-Path: <kernel-hardening-return-12483-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsqbv4EcLHdZ6olUpWvt656gkkbJO7og5u/r6K7ITHwzzF/NtdvVguDSUKherITp891v4hb
ARC-Seal: i=1; a=rsa-sha256; t=1520899100; cv=none;
        d=google.com; s=arc-20160816;
        b=UUNwuEBV5UcW77/ZPGSB5aydlLHwtmT9M4ptZ4iEVHZOgPsNBdUVlFho6lmYAT0V78
         S7XU1O7/CxSUfIMBGqtrifZZnvesm3HBr5IRHA2nNwZUQp2CYp79u29n77YNPzEqg3dD
         lXfPIYo+euUWPAVWHoHi+o/q8jzspIDmYC5OW3INDHi7dlVDO3Pa0g8BKcZfVKevFJe9
         zAGQBuiOGIOFf0PxFJ0wlgV1ubtn2LNowSl8U1ni9DFjqJdyBLX/KSfaOJkkKStxEEN8
         a02FXhCeU+4CYV8WQu8Z54a8A+1SWDaWL7QPGMuhUFBNN6GyuKReV+vGX5aDJRjmU7TL
         l3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=sBZnDbFKolExGXRHIstveru5fO/VVmjPe3ixwIT2GZU=;
        b=aUpaAk5Y4QySQXELRaTEDqhZ1RdxVnCNnLVCqxCEFzRJVpDB8UFo3a27KqBXUrq/Zc
         RTlAG/RLJtupjbnTj8Un8RCAPgiAogfR7vnHHZ527Mzi6W3qTkFERyXTujvrUstn89Tz
         B5rKGWpbO6hKYl2hluKP6UF7LUfjZMhGZnmnyT5ceb7JKo7x23Z6voWstsBY6eLx3nYF
         ptFjEWCzxjsKrGiQipDo/Ea3cUm85r8uS1ZnslOU0QIohy/mUj85v2ZHnKXKYuFrDeKC
         8IGUyErE5j+nsQj7yhcSEumpnqMGNB9m444D+6NVOqViknBx61SWkINnriV1LURGBO5j
         ETCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c7ZbsouK;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=T3mlOElY;
       spf=pass (google.com: domain of kernel-hardening-return-12483-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12483-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c7ZbsouK;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=T3mlOElY;
       spf=pass (google.com: domain of kernel-hardening-return-12483-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12483-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
 <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
 <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com> <20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 16:57:59 -0700
X-Google-Sender-Auth: Eb7NWZvpmKNvc0aLWOjNm8734As
Message-ID: <CA+55aFwK7W0SsaP5eR+2TxOj-j_Mu_E11fRw2Gk8ptV71ebvww@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594778295189721738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 3:55 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Replacing the __builtin_choose_expr() with ?: works of course.

Hmm. That sounds like the right thing to do. We were so myopically
staring at the __builtin_choose_expr() problem that we overlooked the
obvious solution.

Using __builtin_constant_p() together with a ?: is in fact our common
pattern, so that should be fine. The only real reason to use
__builtin_choose_expr() is if you want to get the *type* to vary
depending on which side you choose, but that's not an issue for
min/max.

> What will be the runtime effects?

There should be none. Gcc will turn the conditional for the ?: into a
constant, and DTRT.

              Linus
