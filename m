Return-Path: <kernel-hardening-return-12838-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+6zrhpk2O+stj0CD2FpqGXIjdHx1AaoLIilbwexB4NSw+SJp+G5XIKccQquBY4UphhO+FV
ARC-Seal: i=1; a=rsa-sha256; t=1522474496; cv=none;
        d=google.com; s=arc-20160816;
        b=WHKZZMgq+sNGTi55+02Ee5ctRXF8uaDbfevEDuUt60wxFKT5QUPck4OnLHzObZsk8U
         OMuxHF6aYS6eq6hzwaZk9ceKcYDbwGPUehpla+plvMIcjXDUQiRPjc5jE8/FKIdoeGa5
         HIv0AoXZVG83r9SYxAjvv8rKL7rLbmMsvcREGz8sARzkgBZGofiBfOcZkyEbTpqQIuc3
         /xPFiW5ZrkFp9UWK0wjWrwHXMCl5jHWl/wfegrcEZYCU/AaOnY1QIZHdTfhvkah2vm/1
         rTQBiJh2CscWWFm9qlnwKQNzavve2WnufZ0b2fKLayf+BPqOSrBC7fP/iKrruXBMAlyG
         xiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=U4/9pGwXtG2foD/Qo+64uCaGI6AQqk/rAxgSrJ+dfEE=;
        b=R5kZVhPZHVr4g/jF44zMqLYyw/BNlwT5GPHbsCZx1O/4OPjqxQ8oLhoh/Zzp/fTlyL
         7bq0mBpy6lx+jf8YrNS96bDgREdsOcIqxpsMgW4BOCgkRPtsMWGPJgAD7GskSnERS71b
         qot/20xaj/gGvUBT8nCUBjJFoXW3kvpY/ioeDO44pTqDC+0W2GZaxnyYB42vTMbNmdHY
         7VnVCal8VTk7WKcrq1vhP6MtGhwtshd9xwZe8MawMNtP+mq9TZvvWvyKnIzs63jnCC8/
         IuZkjYA74dMRhlMw9l2CKCV8Z2+rLKxQtZU34PSsP49ukqLRk5kPjM2ZW204HEbQvU16
         sZ6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fUQQBzNq;
       spf=pass (google.com: domain of kernel-hardening-return-12838-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12838-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fUQQBzNq;
       spf=pass (google.com: domain of kernel-hardening-return-12838-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12838-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 31 Mar 2018 07:34:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Message-ID: <20180331053434.akno723avvcri654@gmail.com>
References: <20180326221554.GA45166@beast>
 <20180327054748.jx6mzywguuqfkqpv@gmail.com>
 <CAGXu5jK74cVQPigf2Q23E2pjonfzq+MMxhbqTNvzbWFxP4aGig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK74cVQPigf2Q23E2pjonfzq+MMxhbqTNvzbWFxP4aGig@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596430217609925027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Kees Cook <keescook@chromium.org> wrote:

> On Mon, Mar 26, 2018 at 10:47 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Kees Cook <keescook@chromium.org> wrote:
> >
> >> In the effort to remove all VLAs from the kernel[1], it is desirable to
> >> build with -Wvla. However, this warning is overly pessimistic, in that
> >> it is only happy with stack array sizes that are declared as constant
> >> expressions, and not constant values. One case of this is the evaluation
> >> of the max() macro which, due to its construction, ends up converting
> >> constant expression arguments into a constant value result.
> >>
> >> All attempts to rewrite this macro with __builtin_constant_p() failed with
> >> older compilers (e.g. gcc 4.4)[2]. However, Martin Uecker constructed[3] a
> >> mind-shattering solution that works everywhere. Cthulhu fhtagn!
> >>
> >> This patch updates the min()/max() macros to evaluate to a constant
> >> expression when called on constant expression arguments. This removes
> >> several false-positive stack VLA warnings from an x86 allmodconfig
> >> build when -Wvla is added:
> >
> > Cool!
> >
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> >
> > How many warnings are left in an allmodconfig build?
> 
> For -Wvla? Out of the original 112 files with VLAs, 42 haven't had a
> patch applied yet. Doing a linux-next allmodconfig build with the
> max() patch and my latest ecc patch, we've gone from 316 warning
> instances to 205. More than half of those are in
> include/crypto/skcipher.h and include/crypto/hash.h.

Great - once the number of warnings is zero, is the plan to enable the warning 
unconditionally?

Thanks,

	Ingo
