Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1920C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F9521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA4ENPUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBHEfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:35:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46851 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfBHEft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:35:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so1669385edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 20:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUTj8B+GtmhHYkTK2S0PrlLERdhvTf9uHTNZBWObPfs=;
        b=GA4ENPUYXXfI6dTgK7yb5NQbiBIxPYGT+YuxWGwl57lRxHD2Df47j0sshvJzH1W/WX
         LOWrxR+SwA+QLA/BVwPdOfQ8SRPrGeo6p9uRz1Wktg0ODV1/hqOIb+gsNnCHUcQFKotY
         U2an3HDhbB6imFEzRUGUWZSehYjv3FIU72ahBdW9jBRKlOwq8Wui7eMlhiHZPTQx3GZH
         /QO+t+UELXbJbbItEdJ1lzmJ49RuHO4LQIwKyvsN569rc1OSKSBzuHE32EamMSOvtBro
         Q0/Hj1oAH4ims5aw3PC1lA8EK13Dynh4zC5ZHzuGLZXmVaAa04RVwxaqYqTVY+Ighj5T
         Csvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUTj8B+GtmhHYkTK2S0PrlLERdhvTf9uHTNZBWObPfs=;
        b=NAE1pn9HHgZvhScKAYraquVeNT6EAIdiRUrnrwN2HnMKSC2mJdKzTmJXOEwJ4N8pEO
         KI3PfkmMa9FT2YKAmlg3VitKHJICdnunuWWBXMcA4srOiOZsQX8hC5/knHRuFwUav5+c
         Fv0uiLhR617kwe5gX8jQxi40uXG/QRJG3Z6HCCVBAp/c2epdQ+chVz9P3YwvJHeHa3z0
         diFgT4sXMfPYKKjXoqPSVNQqLuUapSd7WA3BxS0fHd4cJcrpPS8zsm3QCt3Jab+VNqH7
         oplo5Neui+VrrXHXW5llRj+d9JRnpwfA7FCM3cANGRFolNQ+CQGyH9yBKxuqXADKc6wQ
         QyKg==
X-Gm-Message-State: AHQUAublFCLrL2GbtPnYQo64ArS3XctCCXAEkEriWeikQ7bnwts7ppEd
        DbQdsBqh9wQtNqFz0ZOLKEQ=
X-Google-Smtp-Source: AHgI3IZuyZAbsoC4WXl+nDIJS142UwHnH+D5NgN25xfaqDSzz9LJTvPxGQEMqVtIQ1n5eodOvisK9w==
X-Received: by 2002:a17:906:7f95:: with SMTP id f21mr900294ejr.131.1549600546809;
        Thu, 07 Feb 2019 20:35:46 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v5sm244274eju.37.2019.02.07.20.35.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 20:35:46 -0800 (PST)
Date:   Thu, 7 Feb 2019 21:35:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190208043543.GA5040@archlinux-ryzen>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 02:58:50PM +0000, Julien Thierry wrote:
> Instead disabling interrupts by setting the PSR.I bit, use a priority
> higher than the one used for interrupts to mask them via PMR.
> 
> When using PMR to disable interrupts, the value of PMR will be used
> instead of PSR.[DAIF] for the irqflags.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/arm64/include/asm/efi.h      |  11 +++++
>  arch/arm64/include/asm/irqflags.h | 100 +++++++++++++++++++++++++++-----------
>  2 files changed, 83 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..c9e9a69 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -44,6 +44,17 @@
>  
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>  
> +/*
> + * Even when Linux uses IRQ priorities for IRQ disabling, EFI does not.
> + * And EFI shouldn't really play around with priority masking as it is not aware
> + * which priorities the OS has assigned to its interrupts.
> + */
> +#define arch_efi_save_flags(state_flags)		\
> +	((void)((state_flags) = read_sysreg(daif)))
> +
> +#define arch_efi_restore_flags(state_flags)	write_sysreg(state_flags, daif)
> +
> +
>  /* arch specific definitions used by the stub code */
>  
>  /*
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..d4597b2 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,9 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/alternative.h>
>  #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
>  
>  /*
>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> @@ -36,33 +38,27 @@
>  /*
>   * CPU interrupt mask handling.
>   */
> -static inline unsigned long arch_local_irq_save(void)
> -{
> -	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_irq_save\n"
> -		"msr	daifset, #2"
> -		: "=r" (flags)
> -		:
> -		: "memory");
> -	return flags;
> -}
> -
>  static inline void arch_local_irq_enable(void)
>  {
> -	asm volatile(
> -		"msr	daifclr, #2		// arch_local_irq_enable"
> -		:
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
> +		"nop",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		"dsb	sy",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (GIC_PRIO_IRQON)
>  		: "memory");
>  }
>  
>  static inline void arch_local_irq_disable(void)
>  {
> -	asm volatile(
> -		"msr	daifset, #2		// arch_local_irq_disable"
> -		:
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifset, #2		// arch_local_irq_disable",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (GIC_PRIO_IRQOFF)
>  		: "memory");
>  }
>  
> @@ -71,12 +67,44 @@ static inline void arch_local_irq_disable(void)
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> +	unsigned long daif_bits;
>  	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> -		:
> +
> +	daif_bits = read_sysreg(daif);
> +
> +	/*
> +	 * The asm is logically equivalent to:
> +	 *
> +	 * if (system_uses_irq_prio_masking())
> +	 *	flags = (daif_bits & PSR_I_BIT) ?
> +	 *			GIC_PRIO_IRQOFF :
> +	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
> +	 * else
> +	 *	flags = daif_bits;
> +	 */
> +	asm volatile(ALTERNATIVE(
> +			"mov	%0, %1\n"
> +			"nop\n"
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
> +			"csel	%0, %0, %2, eq",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (flags), "+r" (daif_bits)
> +		: "r" (GIC_PRIO_IRQOFF)
>  		: "memory");
> +
> +	return flags;
> +}
> +
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +	unsigned long flags;
> +
> +	flags = arch_local_save_flags();
> +
> +	arch_local_irq_disable();
> +
>  	return flags;
>  }
>  
> @@ -85,16 +113,32 @@ static inline unsigned long arch_local_save_flags(void)
>   */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -	asm volatile(
> -		"msr	daif, %0		// arch_local_irq_restore"
> -	:
> -	: "r" (flags)
> -	: "memory");
> +	asm volatile(ALTERNATIVE(
> +			"msr	daif, %0\n"
> +			"nop",
> +			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
> +			"dsb	sy",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "+r" (flags)
> +		:
> +		: "memory");
>  }
>  
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
> -	return flags & PSR_I_BIT;
> +	int res;
> +
> +	asm volatile(ALTERNATIVE(
> +			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
> +			"nop",
> +			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
> +			"cset	%w0, ls",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (res)
> +		: "r" ((int) flags)
> +		: "memory");
> +
> +	return res;
>  }
>  #endif
>  #endif
> -- 
> 1.9.1
> 

Hi Julien,

This patch introduced a slew of Clang warnings:

In file included from arch/arm64/kernel/signal.c:21:
In file included from include/linux/compat.h:10:
In file included from include/linux/time.h:6:
In file included from include/linux/seqlock.h:36:
In file included from include/linux/spinlock.h:54:
In file included from include/linux/irqflags.h:16:
arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQON)
                       ^
arch/arm64/include/asm/ptrace.h:39:25: note: expanded from macro 'GIC_PRIO_IRQON'
#define GIC_PRIO_IRQON          0xf0
                                ^
arch/arm64/include/asm/irqflags.h:46:44: note: use constraint modifier "w"
                "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
                                                         ^~
                                                         %w0
arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
        _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
                                   ^
arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
        __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
                                    ^
arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
        newinstr "\n"                                                   \
        ^
In file included from arch/arm64/kernel/signal.c:21:
In file included from include/linux/compat.h:10:
In file included from include/linux/time.h:6:
In file included from include/linux/seqlock.h:36:
In file included from include/linux/spinlock.h:54:
In file included from include/linux/irqflags.h:16:
arch/arm64/include/asm/irqflags.h:61:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQOFF)
                       ^
arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
#define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
                                ^
arch/arm64/include/asm/irqflags.h:58:45: note: use constraint modifier "w"
                "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
                                                          ^
arch/arm64/include/asm/irqflags.h:94:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQOFF)
                       ^
arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
#define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
                                ^
arch/arm64/include/asm/irqflags.h:91:18: note: use constraint modifier "w"
                        "csel   %0, %0, %2, eq",
                                        ^~
                                        %w2
arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
        _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
                                   ^
arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
        __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
                                    ^
arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
        newinstr "\n"                                                   \
        ^
3 warnings generated.


I am not sure if they should be fixed with Clang's suggestion of a
constraint modifier or a cast like commit 1b57ec8c7527 ("arm64: io:
Ensure value passed to __iormb() is held in a 64-bit register"), hence
this message.

Thanks,
Nathan
