Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518649642; cv=none;
        d=google.com; s=arc-20160816;
        b=XfyUmhqJt7fkzGNwBNHwwsaYIFpWfD4FTHK8E5A4O+GycdiYMeU6hZ5KytHygz704J
         SFtTx9gRyDX41QXwumGmZbWRRs/xX93E1C4/GeuVWBtI+U6Ie5TFaubjK7TVJFoIdFj8
         MeAY3GjlloxTsrDh5yRjGc4jFhrV8uZt4MQ4l2Kn+HpSa7rQfbH2gaArO4ALpCiaVJmY
         xi/8pZHpPs5g9xIhDyCJts8VfJD/20kwluC5I222L/VGacwfAO2/Hmqc6kDNDTP2j9SQ
         LbrrYB2CRQCRtqI72cJa0yIps4xd/R5sJ02jQfOEyrbDmklQgtp2oPhe+ALG6plvUlfx
         XIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=i5Zhlz3m/ob7Kbl9TLFAyY2CbsbPRE46XDXxRpS4ChQ=;
        b=tgJwXkSO2hjXSOJ5PrPTLFlWKvbmvFyQbVILvK68Tpc5JNrg/GNL9pjDk/KhrRbSK4
         EHc+sxvnuFgIqOEu+eMDjTzb/AbpW7lM0xbQrxmTerIxeh83FfLjyF/YL6xhB5oblVSB
         /QY8aJi9jHIJVrpq4SJTaukNuBpCD0Fk+8VpzK2ulLV45FczmxXef+FYzcXdw18rpNJ3
         +lQ6ZoY7qOwHqZ2/BKDLN+HaTeS42XtS4mvvgyqn91YclrtHn9aMEl+QwcE0YJ1EyNmp
         dWzilZCvGL5a5ymEph0uC61JWp9OmH3miINy/cLtR5TCT2SLlsDcpdc7HH0MuVFFU5T7
         bW0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KPOhAKYT;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KPOhAKYT;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x227TZ4KmHsJUKuIfVPqd4RvgH+Jq452ej3QKeKpUTcPo7D3BBuKMx6xQtOF9DGZpK6Iu1gx8eQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 15 Feb 2018 00:07:18 +0100
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
Message-ID: <20180214230718.vjeap2oilb27tlii@gmail.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <20180214090851.GU25181@hirez.programming.kicks-ass.net>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771900@hasmsx107.ger.corp.intel.com>
 <20180214103434.GY25181@hirez.programming.kicks-ass.net>
 <20180214120417.kwj2jzjvfxbu2vxw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214120417.kwj2jzjvfxbu2vxw@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592419567858700803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ingo Molnar <mingo@kernel.org> wrote:

> To quantify it: I just performed a test build of a Linux distro kernel config 
> (Fedora x86-64), and counted the number of callsites that use 'asm goto' 
> functionality with the v4.15 kernel (including drivers).
> 
> The results:
> 
>                                                 Linux distro | !CONFIG_TRACING
>  -----------------------------------------------------------------------------
>  total # of functions                         :      191,567 |         184,443
>  total # of instructions                      :   14,251,355 |      13,526,112
>  -----------------------------------------------------------------------------
>  total # of spin_lock*() calls                :       25,246 |          25,177
>  total # of mutex_lock*() calls               :       13,062 |          12,861
>  total # of kmalloc*() calls                  :        5,148 |           5,118
>  -----------------------------------------------------------------------------
>  total # of 'asm goto' usage sites            :       34,851 |          31,059
>  total # of 'asm goto' using functions        :       18,209 |          16,089
>  -----------------------------------------------------------------------------
>  percent of kernel functions using 'asm goto' :         9.5% |            8.7%
>  -----------------------------------------------------------------------------

Here's the size stats of kernel/sched/built-in.o for the same distro config:

                                                     optimized |     no asm goto
   -----------------------------------------------------------------------------
   total # of functions                         :          765 |            764
   total # of instructions                      :       46,830 |         47,051

I.e. asm goto support reduces scheduler size by ~0.5%, which is a major generated 
code size reduction.

This doesn't count the live branch patching performance advantages: many of those 
asm goto usage sites are in hot paths, so the performance impact of it is much 
larger than that: easily a couple of percentage points in scheduler intensive 
benchmarks, as Peter mentioned.

For example here's a thread context switch benchmark comparison on a modern x86 
system running a v4.15 kernel:

  $ perf stat --repeat 20 --sync --null perf bench sched messaging -t -g 25

         no asm goto:     0.136778505 seconds time elapsed      ( stddev: +- 0.55% )
  asm goto optimized:     0.133773904 seconds time elapsed      ( stddev: +- 0.51% )

The asm goto enabled kernel is ~2.25% faster in this benchmark, and the 
performance penalty of not having asm goto support will only increase in the 
future.

i.e. it very much makes sense to implement asm goto support not just for 
compatibility reasons, but for performance reasons as well.

Thanks,

	Ingo
