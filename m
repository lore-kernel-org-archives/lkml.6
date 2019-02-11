Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2B218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfBKMue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:50:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47640 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKMud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:50:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E840E80D;
        Mon, 11 Feb 2019 04:50:32 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D87F93F557;
        Mon, 11 Feb 2019 04:50:30 -0800 (PST)
Subject: Re: [RESEND PATCH v2 03/33] ARM: davinci: select
 GENERIC_IRQ_MULTI_HANDLER
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-4-brgl@bgdev.pl>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <0220fbc8-a73f-0f40-2b62-14bec019ac7c@arm.com>
Date:   Mon, 11 Feb 2019 12:50:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211122606.8662-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 12:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to support SPARSE_IRQ we first need to make davinci use the
> generic irq handler for ARM. Translate the legacy assembly to C and
> put the irq handlers into their respective drivers (aintc and cp-intc).
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/Kconfig                              |  1 +
>  arch/arm/mach-davinci/cp_intc.c               | 28 +++++++++++++
>  .../mach-davinci/include/mach/entry-macro.S   | 39 -------------------
>  arch/arm/mach-davinci/irq.c                   | 23 +++++++++++
>  4 files changed, 52 insertions(+), 39 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 664e918e2624..f7770fdcad68 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -589,6 +589,7 @@ config ARCH_DAVINCI
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_IRQ_CHIP
> +	select GENERIC_IRQ_MULTI_HANDLER
>  	select GPIOLIB
>  	select HAVE_IDE
>  	select PM_GENERIC_DOMAINS if PM
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 67805ca74ff8..4a372add8cf9 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -19,9 +19,13 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  
> +#include <asm/exception.h>
>  #include <mach/common.h>
>  #include "cp_intc.h"
>  
> +#define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
> +#define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
> +
>  static inline unsigned int cp_intc_read(unsigned offset)
>  {
>  	return __raw_readl(davinci_intc_base + offset);
> @@ -97,6 +101,28 @@ static struct irq_chip cp_intc_irq_chip = {
>  
>  static struct irq_domain *cp_intc_domain;
>  
> +static asmlinkage void __exception_irq_entry
> +cp_intc_handle_irq(struct pt_regs *regs)
> +{
> +	int gpir, irqnr, none;
> +
> +	/*
> +	 * The interrupt number is in first ten bits. The NONE field set to 1
> +	 * indicates a spurious irq.
> +	 */
> +
> +	gpir = cp_intc_read(CP_INTC_PRIO_IDX);
> +	irqnr = gpir & DAVINCI_CP_INTC_PRI_INDX_MASK;
> +	none = gpir & DAVINCI_CP_INTC_GPIR_NONE;
> +
> +	if (unlikely(none)) {
> +		pr_err_once("%s: spurious irq!\n", __func__);
> +		return;
> +	}
> +
> +	handle_domain_irq(cp_intc_domain, irqnr, regs);
> +}
> +
>  static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
>  			  irq_hw_number_t hw)
>  {
> @@ -196,6 +222,8 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
>  		return -EINVAL;
>  	}
>  
> +	set_handle_irq(cp_intc_handle_irq);
> +
>  	/* Enable global interrupt */
>  	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
>  
> diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
> deleted file mode 100644
> index cf5f573eb5fd..000000000000
> --- a/arch/arm/mach-davinci/include/mach/entry-macro.S
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/*
> - * Low-level IRQ helper macros for TI DaVinci-based platforms
> - *
> - * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
> - *
> - * 2007 (c) MontaVista Software, Inc. This file is licensed under
> - * the terms of the GNU General Public License version 2. This program
> - * is licensed "as is" without any warranty of any kind, whether express
> - * or implied.
> - */
> -#include <mach/irqs.h>
> -
> -		.macro  get_irqnr_preamble, base, tmp
> -		ldr \base, =davinci_intc_base
> -		ldr \base, [\base]
> -		.endm
> -
> -		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> -#if defined(CONFIG_AINTC) && defined(CONFIG_CP_INTC)
> -		ldr \tmp, =davinci_intc_type
> -		ldr \tmp, [\tmp]
> -		cmp \tmp, #DAVINCI_INTC_TYPE_CP_INTC
> -		beq 1001f
> -#endif
> -#if defined(CONFIG_AINTC)
> -		ldr \tmp, [\base, #0x14]
> -		movs \tmp, \tmp, lsr #2
> -		sub \irqnr, \tmp, #1
> -		b 1002f
> -#endif
> -#if defined(CONFIG_CP_INTC)
> -1001:		ldr \irqnr, [\base, #0x80] /* get irq number */
> -		mov \tmp, \irqnr, lsr #31
> -		and \irqnr, \irqnr, #0xff  /* irq is in bits 0-9 */
> -		and \tmp, \tmp, #0x1
> -		cmp \tmp, #0x1
> -#endif
> -1002:
> -		.endm
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 07d8ef8037e4..3ce821a06e52 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -29,11 +29,13 @@
>  #include <mach/cputype.h>
>  #include <mach/common.h>
>  #include <asm/mach/irq.h>
> +#include <asm/exception.h>
>  
>  #define FIQ_REG0_OFFSET		0x0000
>  #define FIQ_REG1_OFFSET		0x0004
>  #define IRQ_REG0_OFFSET		0x0008
>  #define IRQ_REG1_OFFSET		0x000C
> +#define IRQ_IRQENTRY_OFFSET	0x0014
>  #define IRQ_ENT_REG0_OFFSET	0x0018
>  #define IRQ_ENT_REG1_OFFSET	0x001C
>  #define IRQ_INCTL_REG_OFFSET	0x0020
> @@ -48,6 +50,11 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
>  	__raw_writel(value, davinci_intc_base + offset);
>  }
>  
> +static inline unsigned long davinci_irq_readl(int offset)
> +{
> +	return __raw_readl(davinci_intc_base + offset);

I appreciate that you're converting assembly code dating from a while
back, but if we're going to do this correctly, I don't think we should
entertain the use of __raw_readl().

Surely the bus has a fixed endianness (and I'd assume it to be LE). Why
aren't you using readl_relaxed() instead, which will have the exact same
generated code with an LE kernel, and will do the right thing should you
run a BE kernel.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
