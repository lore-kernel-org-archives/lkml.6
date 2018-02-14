Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518609861; cv=none;
        d=google.com; s=arc-20160816;
        b=VN75K1VxMcAXLVUxez5dxFb1IzMISPVU8d6IcE8dF6Ms0sG9Lo82cBNL/fesd2Or8h
         iX8ptWmvjcYw19xkxHwOeREUk4oEykZirk9Mykh8b6qtTl54WAcLo8kW9fNIVUQlxbLs
         mRewc8z4jGJsmXWmlp6xJ3BZRUbJHg5JnFgkrZaE/+kZTkjvL5cBc3hegf5SbsgsN30K
         uCQZ/IVu6DlEn5OLoQcZuVzjY9+MpjEP1uta/8JAVakNUeV/PNWPlOFkf7npu/saZS3v
         jAdVrp9zqMo5H2gggn/LOED6YbxnSFds/S+phNqDw6Kj5uvHoix1D7ZBtaZLqWfECRx5
         IqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=D5RRmQ1jPxu48MR6qSczoz8Vnmt1FF0DFhW7VkyNbYc=;
        b=mIzFEwN556c3urtOSn+jkAjxz2T8PecDg055FneHX5Fxbj486azgAEKrZpXxyAYFwJ
         pNu14Oz6a442/rDZ+yke/qIXMuVhAEbk74yTqXuYAjgjGDEWB7uDYbZNkII1zU1sqv05
         aM90eVowwtyeWXdY7E/JLNhm9Ual8XiVg0scmFW2OOcMkHPE9Z4liEOZUdVgrUi37Hkd
         sfUibU/IXV/fUK/BqJxPXYrsH+dQT2gMm5hXqOAyjiz+i6+n+CvuRKWEMrJuiS2lwceY
         z3Gsa7j+DsYkOOkh5xF25mwABsG27F4RRCi9y9WEQ5xtzRkWdqaNkqMy24z683uZ5yBz
         Kg5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kxT0PjGy;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kxT0PjGy;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x227FB+JUXWfmcqg4ov43Uk3eXEZbvykRYMsZhvKKfpAcVNg1qWaI8UyHlcS0RIjmnDuMLiyeKw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 14 Feb 2018 13:04:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>,
	Kees Cook <keescook@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>,
	"rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>,
	"ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>,
	Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>,
	James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Message-ID: <20180214120417.kwj2jzjvfxbu2vxw@gmail.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <20180214090851.GU25181@hirez.programming.kicks-ass.net>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771900@hasmsx107.ger.corp.intel.com>
 <20180214103434.GY25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214103434.GY25181@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592377854218729221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 14, 2018 at 09:52:59AM +0000, Yatsina, Marina wrote:
> > Hi Peter,
> > 
> > When I started the original thread last year I was in favor of adding
> > "asm goto" and didn't understand why it wasn't done by that time.  The
> > feedback I got is that this feature (optimizing tracepoints) is very
> > useful and that we do want it in llvm, but perhaps there's a cleaner
> > way of implementing than "asm goto". An alternative suggestion arose
> > as well. 
> 
> So it's far more than just tracepoints. We use it all over the kernel to
> do runtime branch patching.
> 
> One example is avoiding the scheduler preemption callbacks if we know
> there are no users. This shaves a few % off a context switch
> micro-bench.
> 
> But it is really _all_ over the place.

To quantify it: I just performed a test build of a Linux distro kernel config 
(Fedora x86-64), and counted the number of callsites that use 'asm goto' 
functionality with the v4.15 kernel (including drivers).

The results:

                                                Linux distro | !CONFIG_TRACING
 -----------------------------------------------------------------------------
 total # of functions                         :      191,567 |         184,443
 total # of instructions                      :   14,251,355 |      13,526,112
 -----------------------------------------------------------------------------
 total # of spin_lock*() calls                :       25,246 |          25,177
 total # of mutex_lock*() calls               :       13,062 |          12,861
 total # of kmalloc*() calls                  :        5,148 |           5,118
 -----------------------------------------------------------------------------
 total # of 'asm goto' usage sites            :       34,851 |          31,059
 total # of 'asm goto' using functions        :       18,209 |          16,089
 -----------------------------------------------------------------------------
 percent of kernel functions using 'asm goto' :         9.5% |            8.7%
 -----------------------------------------------------------------------------


( Note: I added the 'tracing disabled' column only to demonstrate how widely
        'asm goto' is used beyond tracing - but since *all* major Linux 
        distributions have tracing enabled it's the first column that matters in 
        practice. )

So 'asm goto' is a major, major compiler feature the Linux kernel relies on:
in fact in the Linux kernel there's more 'asm goto' usage sites than there are
spin-lock critical sections!

Thanks,

	Ingo
