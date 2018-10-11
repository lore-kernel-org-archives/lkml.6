Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF1C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047CB214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRYuKaRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047CB214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJLDYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:24:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45533 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeJLDYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:24:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id u12-v6so4920301pfn.12;
        Thu, 11 Oct 2018 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRwR/eV8AC3ULdG+TuoWwU8vVuPkBiAH84wARhm7k/M=;
        b=VRYuKaRKEnWD2p4yJb9+dCIqz6KzbYPPZaGZjfsdhHydGSCbeyFBy/VnyTtf+neeRv
         Edb8rurWU9zG9AaBJDvTKz561lYHI7kmRxW9PgDy5vokJ8/37lWCaskOcEVN6FRCuBSy
         U5LtZ2SiPM9Oi9qyAoTZlntC8O4hFPmlCOUTCoMiZZj6IPKkaXCZRR86tXfrxK2y0vbn
         YpOHVWXhA7eu2h1i29Ejlf69j0Ra+pSgr3GicIKDXLVhzQ0dqS8WMcZjAcQWWymhcdty
         TA81VX5t+UCDtldrs5t4ziKItw5DuMK99018HZZpNHQY/6beEVXeE9Rm/WMz5zUk3Tjo
         D66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRwR/eV8AC3ULdG+TuoWwU8vVuPkBiAH84wARhm7k/M=;
        b=TrXiBY0MD7jUE7GxQzw3nVn1PqkQxkDJ4KxzDgnxA96b7OmRR85qEHTcPETstFPhWq
         Vti2r/JhoIbaRgM3e+c2XxVRCsqEK8bgohNIJX08w8WDHBOuSIcjQl8Ui8m6E15imePF
         tdLnI5/bwBDDBRDhc4Dp7HQF6BG9RwBF1CQ76MRiGOQ8bEASFYy/9D6RD/LBGyCNU9+3
         ICJK8kYSx3SatJWsaR/IP8tLt/ZM73eP9A5yBRJZReBVMVoWgmVkX9b/VUIucHUVFhtn
         wJGyjAMcqtBTYpXNJnMMoE7rK2AHWyJ1oSJhiidQmUptDKKOHzFKgc23YR3mTHNeVw8E
         My5A==
X-Gm-Message-State: ABuFfogiQ6u7qvdNblC7me0R/yWygvx+LrPWdG0AEO/3DxD+xqHYyYat
        An4gcamSrb0ADWBl+TPq1gg=
X-Google-Smtp-Source: ACcGV61I/qQT6faAfWR08W5okHjAScVjfpvvma02IPENEaxGDjDCmg8zXECACjrbMLiyH94Pv5Glkg==
X-Received: by 2002:a63:1624:: with SMTP id w36-v6mr2558274pgl.409.1539287763353;
        Thu, 11 Oct 2018 12:56:03 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y19-v6sm47935709pff.14.2018.10.11.12.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:56:02 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/3] powernv/cpuidle: Pass pointers instead of
 values to stop loop
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     huntbag@linux.vnet.ibm.com, npiggin@gmail.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com
References: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
 <20181011132237.14604-3-akshay.adiga@linux.vnet.ibm.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <38ed1a99-0916-e293-7564-268b49001de0@gmail.com>
Date:   Thu, 11 Oct 2018 12:56:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011132237.14604-3-akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ devicetree mail list

On 10/11/18 06:22, Akshay Adiga wrote:
> Passing pointer to the pnv_idle_state instead of psscr value and mask.
> This helps us to pass more information to the stop loop. This will help to
> figure out the method to enter/exit idle state.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> 
> ---
> Changes from v1 :
>  - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
>    idle code in C"
> 
>  arch/powerpc/include/asm/processor.h  |  5 ++-
>  arch/powerpc/platforms/powernv/idle.c | 47 ++++++++++-----------------
>  drivers/cpuidle/cpuidle-powernv.c     | 15 +++------
>  3 files changed, 24 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 936795acba48..822d3236ad7f 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -43,6 +43,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
>  #include <asm/hw_breakpoint.h>
> +#include <asm/cpuidle.h>
>  
>  /* We do _not_ want to define new machine types at all, those must die
>   * in favor of using the device-tree
> @@ -518,9 +519,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
>  extern int powersave_nap;	/* set if nap mode can be used in idle loop */
>  
>  extern void power7_idle_type(unsigned long type);
> -extern void power9_idle_type(unsigned long stop_psscr_val,
> -			      unsigned long stop_psscr_mask);
> -
> +extern void power9_idle_type(struct pnv_idle_states_t *state);
>  extern void flush_instruction_cache(void);
>  extern void hard_reset_now(void);
>  extern void poweroff_now(void);
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 755918402591..681a23a066bb 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -44,8 +44,7 @@ int nr_pnv_idle_states;
>   * The default stop state that will be used by ppc_md.power_save
>   * function on platforms that support stop instruction.
>   */
> -static u64 pnv_default_stop_val;
> -static u64 pnv_default_stop_mask;
> +struct pnv_idle_states_t *pnv_default_state;
>  static bool default_stop_found;
>  
>  /*
> @@ -72,9 +71,7 @@ const int nr_known_versions = 1;
>   * psscr value and mask of the deepest stop idle state.
>   * Used when a cpu is offlined.
>   */
> -static u64 pnv_deepest_stop_psscr_val;
> -static u64 pnv_deepest_stop_psscr_mask;
> -static u64 pnv_deepest_stop_flag;
> +static struct pnv_idle_states_t *pnv_deepest_state;
>  static bool deepest_stop_found;
>  
>  static unsigned long power7_offline_type;
> @@ -96,7 +93,7 @@ static int pnv_save_sprs_for_deep_states(void)
>  	uint64_t hid5_val	= mfspr(SPRN_HID5);
>  	uint64_t hmeer_val	= mfspr(SPRN_HMEER);
>  	uint64_t msr_val = MSR_IDLE;
> -	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
> +	uint64_t psscr_val = pnv_deepest_state->psscr_val;
>  
>  	for_each_present_cpu(cpu) {
>  		uint64_t pir = get_hard_smp_processor_id(cpu);
> @@ -820,17 +817,15 @@ static unsigned long power9_offline_stop(unsigned long psscr)
>  	return srr1;
>  }
>  
> -static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
> -				      unsigned long stop_psscr_mask)
> +static unsigned long __power9_idle_type(struct pnv_idle_states_t *state)
>  {
>  	unsigned long psscr;
>  	unsigned long srr1;
>  
>  	if (!prep_irq_for_idle_irqsoff())
>  		return 0;
> -
>  	psscr = mfspr(SPRN_PSSCR);
> -	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
> +	psscr = (psscr & ~state->psscr_mask) | state->psscr_val;
>  
>  	__ppc64_runlatch_off();
>  	srr1 = power9_idle_stop(psscr, true);
> @@ -841,12 +836,10 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
>  	return srr1;
>  }
>  
> -void power9_idle_type(unsigned long stop_psscr_val,
> -				      unsigned long stop_psscr_mask)
> +void power9_idle_type(struct pnv_idle_states_t *state)
>  {
>  	unsigned long srr1;
> -
> -	srr1 = __power9_idle_type(stop_psscr_val, stop_psscr_mask);
> +	srr1 = __power9_idle_type(state);
>  	irq_set_pending_from_srr1(srr1);
>  }
>  
> @@ -855,7 +848,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
>   */
>  void power9_idle(void)
>  {
> -	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
> +	power9_idle_type(pnv_default_state);
>  }
>  
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> @@ -974,8 +967,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  		unsigned long psscr;
>  
>  		psscr = mfspr(SPRN_PSSCR);
> -		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
> -						pnv_deepest_stop_psscr_val;
> +		psscr = (psscr & ~pnv_deepest_state->psscr_mask) |
> +						pnv_deepest_state->psscr_val;
>  		srr1 = power9_offline_stop(psscr);
>  	} else if (cpu_has_feature(CPU_FTR_ARCH_206) && power7_offline_type) {
>  		srr1 = power7_offline();
> @@ -1123,16 +1116,13 @@ static void __init pnv_power9_idle_init(void)
>  
>  		if (max_residency_ns < state->residency_ns) {
>  			max_residency_ns = state->residency_ns;
> -			pnv_deepest_stop_psscr_val = state->psscr_val;
> -			pnv_deepest_stop_psscr_mask = state->psscr_mask;
> -			pnv_deepest_stop_flag = state->flags;
> +			pnv_deepest_state = state;
>  			deepest_stop_found = true;
>  		}
>  
>  		if (!default_stop_found &&
>  		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
> -			pnv_default_stop_val = state->psscr_val;
> -			pnv_default_stop_mask = state->psscr_mask;
> +			pnv_default_state = state;
>  			default_stop_found = true;
>  			WARN_ON(state->flags & OPAL_PM_LOSE_FULL_CONTEXT);
>  		}
> @@ -1143,15 +1133,15 @@ static void __init pnv_power9_idle_init(void)
>  	} else {
>  		ppc_md.power_save = power9_idle;
>  		pr_info("cpuidle-powernv: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
> -			pnv_default_stop_val, pnv_default_stop_mask);
> +			pnv_default_state->psscr_val, pnv_default_state->psscr_mask);
>  	}
>  
>  	if (unlikely(!deepest_stop_found)) {
>  		pr_warn("cpuidle-powernv: No suitable stop state for CPU-Hotplug. Offlined CPUs will busy wait");
>  	} else {
>  		pr_info("cpuidle-powernv: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
> -			pnv_deepest_stop_psscr_val,
> -			pnv_deepest_stop_psscr_mask);
> +			pnv_deepest_state->psscr_val,
> +			pnv_deepest_state->psscr_mask);
>  	}
>  
>  	pr_info("cpuidle-powernv: First stop level that may lose SPRs = 0x%lld\n",
> @@ -1173,16 +1163,15 @@ static void __init pnv_disable_deep_states(void)
>  	pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
>  
>  	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> -	    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
> +	    (pnv_deepest_state->flags & OPAL_PM_LOSE_FULL_CONTEXT)) {
>  		/*
>  		 * Use the default stop state for CPU-Hotplug
>  		 * if available.
>  		 */
>  		if (default_stop_found) {
> -			pnv_deepest_stop_psscr_val = pnv_default_stop_val;
> -			pnv_deepest_stop_psscr_mask = pnv_default_stop_mask;
> +			pnv_deepest_state = pnv_default_state;
>  			pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
> -				pnv_deepest_stop_psscr_val);
> +				pnv_deepest_state->psscr_val);
>  		} else { /* Fallback to snooze loop for CPU-Hotplug */
>  			deepest_stop_found = false;
>  			pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index a15514ebd1c3..5116d5991d30 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -35,13 +35,7 @@ static struct cpuidle_driver powernv_idle_driver = {
>  static int max_idle_state __read_mostly;
>  static struct cpuidle_state *cpuidle_state_table __read_mostly;
>  
> -struct stop_psscr_table {
> -	u64 val;
> -	u64 mask;
> -};
> -
> -static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
> -
> +struct pnv_idle_states_t idx_to_state_ptr[CPUIDLE_STATE_MAX] __read_mostly;
>  static u64 default_snooze_timeout __read_mostly;
>  static bool snooze_timeout_en __read_mostly;
>  
> @@ -143,8 +137,9 @@ static int stop_loop(struct cpuidle_device *dev,
>  		     struct cpuidle_driver *drv,
>  		     int index)
>  {
> -	power9_idle_type(stop_psscr_table[index].val,
> -			 stop_psscr_table[index].mask);
> +	struct pnv_idle_states_t *state;
> +	state = &pnv_idle_states[index];
> +	power9_idle_type(state);
>  	return index;
>  }
>  
> @@ -242,8 +237,6 @@ static inline void add_powernv_state(int index, const char *name,
>  	powernv_states[index].exit_latency = exit_latency;
>  	powernv_states[index].enter = idle_fn;
>  	/* For power8 and below psscr_* will be 0 */
> -	stop_psscr_table[index].val = psscr_val;
> -	stop_psscr_table[index].mask = psscr_mask;
>  }
>  
>  /*
> 

