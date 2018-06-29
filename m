Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E7CC6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95125275BF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95125275BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936976AbeF2Q3H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:29:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:55817 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934570AbeF2Q3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:29:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 09:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="236652611"
Received: from unknown (HELO [10.7.201.18]) ([10.7.201.18])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2018 09:29:05 -0700
Subject: Re: [PATCH v2 3/4] x86/split_lock: Handle #AC exception for split
 lock
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-4-git-send-email-fenghua.yu@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <f528ef21-0e6f-3c76-5fac-bd88279facc0@intel.com>
Date:   Fri, 29 Jun 2018 09:29:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530282807-66555-4-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * #AC handler for split lock is called by generic #AC handler.
> + *
> + * On split lock in kernel, warn and disable #AC for split lock on current CPU.
> + *
> + * On split lock in user process, send SIGBUS in the generic #AC handler.
> + */

Don't comment the function, comment the code, please.  The thing that
needs to be here that is missing is what the return values mean.

> +bool do_ac_split_lock(struct pt_regs *regs)
> +{
> +	/* Generic #AC handler will handle split lock in user. */
> +	if (user_mode(regs))
> +		return false;
> +
> +	/* Clear the split lock bit to disable the feature on local CPU. */
> +	msr_clear_bit(MSR_TEST_CTL, MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT);
> +
> +	WARN_ONCE(1, "A split lock issue is detected. Please FIX it\n");

I think folks understand that warnings need to get fixed.  They don't
need to be urged to FIX IT IN CAPS, or asked nicely.  This can simply be:

	"lock split across cacheline boundary"

But, warning here is also not super useful.  Shouldn't we be dumping out
the info in 'regs' instead of the current context?  We don't care about
the state in the #AC handler, we care about 'regs'.


> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 18de4e35a4e5..ca4ef8325dfe 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -954,6 +954,8 @@ void __init setup_arch(char **cmdline_p)
>  	parse_early_param();
>  
>  	detect_ac_split_lock();

This ^ needs:

	/* Do detection only on the boot cpu. */

> +	/* Set up #AC for split lock at the earliest phase. */
> +	setup_ac_split_lock();
>  
>  	if (efi_enabled(EFI_BOOT))
>  		efi_memblock_x86_reserve_range();
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index c2f7d1d2a5c3..d6b224e6284f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -225,6 +225,9 @@ static void notrace start_secondary(void *unused)
>  #endif
>  	load_current_idt();
>  	cpu_init();
> +
> +	setup_ac_split_lock();

and:

	/* Feature detection was done on the boot cpu, only do setup */

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index e6db475164ed..dd309a7b46bd 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -61,6 +61,7 @@
>  #include <asm/mpx.h>
>  #include <asm/vm86.h>
>  #include <asm/umip.h>
> +#include <asm/cpu.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -318,7 +319,36 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_seg
>  DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",		invalid_TSS)
>  DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",	segment_not_present)
>  DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",		stack_segment)
> -DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",		alignment_check)
> +
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	unsigned int trapnr = X86_TRAP_AC;
> +	char str[] = "alignment check";
> +	int signr = SIGBUS;
> +	siginfo_t info;
> +	int ret;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
> +			NOTIFY_STOP) {

There does not seem to be a _lot_ of consistency for whether
notify_die() gets called before or after kernel exceptions are handled.
Why did you choose to do it this way?

Also, please unindent this block and just return if notify_die() returns
false.

> +		/* #AC exception could be handled by split lock handler. */
> +		ret = do_ac_split_lock(regs);
> +		if (ret) {
> +			cond_local_irq_enable(regs);
> +
> +			return;
> +		}
> +
> +		cond_local_irq_enable(regs);

FWIW, you can consolidate the cond_local_irq_enable() calls:

	ret = do_ac_split_lock(regs);
	cond_local_irq_enable(regs);
	if (ret)
		return;

	...

