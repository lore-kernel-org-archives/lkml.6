Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B52C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3479E20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3479E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJMBZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:25:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:52676 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJMBZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:25:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 10:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="80999735"
Received: from ray.jf.intel.com (HELO [10.7.198.154]) ([10.7.198.154])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2018 10:51:34 -0700
Subject: Re: [PATCH 04/11] x86/fpu: eager switch PKRU state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-5-bigeasy@linutronix.de>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@linux.intel.com; keydata=
 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
 z5cecg==
Message-ID: <76caafd5-c85d-61bb-62ec-8056cd6d95ac@linux.intel.com>
Date:   Fri, 12 Oct 2018 10:51:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004140547.13014-5-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> While most of a task's FPU state is only needed in user space,
> the protection keys need to be in place immediately after a
> context switch.
> 
> The reason is that any accesses to userspace memory while running
> in kernel mode also need to abide by the memory permissions
> specified in the protection keys.
> 
> The "eager switch" is a preparation for loading the FPU state on return
> to userland. Instead of decoupling PKRU state from xstate I update PKRU
> within xstate on write operations by the kernel.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> [bigeasy: save pkru to xstate, no cache]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 20 +++++++++++++++----
>  arch/x86/include/asm/fpu/xstate.h   |  2 ++
>  arch/x86/include/asm/pgtable.h      |  6 +-----
>  arch/x86/include/asm/pkeys.h        |  2 +-
>  arch/x86/kernel/fpu/core.c          |  2 +-
>  arch/x86/mm/pkeys.c                 | 31 ++++++++++++++++++++++-------
>  include/linux/pkeys.h               |  2 +-
>  7 files changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 16c4077ffc945..956d967ca824a 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -570,11 +570,23 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
>   */
>  static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
>  {
> -	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
> -		       new_fpu->initialized;
> +	bool load_fpu;
>  
> -	if (preload)
> -		__fpregs_load_activate(new_fpu, cpu);
> +	load_fpu = static_cpu_has(X86_FEATURE_FPU) && new_fpu->initialized;
> +	if (!load_fpu)
> +		return;

Needs comments, please.  Especially around what an uninitialized new_fpu
means.

> +	__fpregs_load_activate(new_fpu, cpu);
> +
> +#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> +	if (static_cpu_has(X86_FEATURE_OSPKE)) {

FWIW, you should be able to use cpu_feature_enabled() instead of an
explicit #ifdef here.

> +		struct pkru_state *pk;
> +
> +		pk = __raw_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> +		if (pk->pkru != __read_pkru())
> +			__write_pkru(pk->pkru);
> +	}
> +#endif
>  }

Comments here as well, please.

I think the goal is to keep the PKRU state in the 'init state' when
possible and also to save the cost of WRPKRU.  But, it would be really
nice to be explicit.

> -static inline void write_pkru(u32 pkru)
> -{
> -	if (boot_cpu_has(X86_FEATURE_OSPKE))
> -		__write_pkru(pkru);
> -}
> +void write_pkru(u32 pkru);

One reason I inlined this was because it enables the the PK code to be
optimized away entirely.  Putting the checks behind a function call
makes this optimization impossible.

Could you elaborate on why you chose to do this and what you think the
impact is or is not?

> diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> index 19b137f1b3beb..b184f916319e5 100644
> --- a/arch/x86/include/asm/pkeys.h
> +++ b/arch/x86/include/asm/pkeys.h
> @@ -119,7 +119,7 @@ extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  		unsigned long init_val);
>  extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  		unsigned long init_val);
> -extern void copy_init_pkru_to_fpregs(void);
> +extern void pkru_set_init_value(void);

Could you elaborate on why the name is being changed?

> +void write_pkru(u32 pkru)
> +{
> +	struct pkru_state *pk;
> +
> +	if (!boot_cpu_has(X86_FEATURE_OSPKE))
> +		return;
> +
> +	pk = __raw_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
> +	/*
> +	 * Update the PKRU value in cstate and then in the CPU. A context

"cstate"?  Did you mean xstate?

> +	 * switch between those two operation would load the new value from the
> +	 * updated xstate and then we would write (the same value) to the CPU.
> +	 */
> +	pk->pkru = pkru;
> +	__write_pkru(pkru);
> +
> +}

There's an unnecessary line there.

This also needs a lot more high-level context about why it is necessary.
 I think you had that in the changelog, but we also need the function
commented.


> -void copy_init_pkru_to_fpregs(void)
> +void pkru_set_init_value(void)
>  {
>  	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
> +
>  	/*
>  	 * Any write to PKRU takes it out of the XSAVE 'init
>  	 * state' which increases context switch cost.  Avoid
> -	 * writing 0 when PKRU was already 0.
> +	 * writing then same value which is already written.
>  	 */

s/then/the/

> -	if (!init_pkru_value_snapshot && !read_pkru())
> +	if (init_pkru_value_snapshot == read_pkru())
>  		return;
> -	/*
> -	 * Override the PKRU state that came from 'init_fpstate'
> -	 * with the baseline from the process.
> -	 */
> +
>  	write_pkru(init_pkru_value_snapshot);
>  }

Isn't this doing some of the same work (including rdpkru()) as write_pkru()?
