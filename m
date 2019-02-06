Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C214C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E0E20818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OTUoDPEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfBFMjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:39:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38104 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfBFMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:39:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16CdSfo105863;
        Wed, 6 Feb 2019 06:39:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549456768;
        bh=Wf3z2vrJUaZP7fxSoIeDiSBr7DNlZT/mgDGNfAZ29GA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OTUoDPEwq6sbMWOh71GFZyGfKT2PsElKBRE+5EWala/q3/M6vqtkO7qkm/nrn5+/a
         RfeC6j7u8crSJy2pKz2JyRHmHx3nToTeZ7n3g6YLeMTuRzUuLZwGRw/BDxSSxefuw0
         DjRrwpWklR7Rmx8KJZUJA4q/Osh3ikbrRrs66Vo8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16CdSjt104218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 06:39:28 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:39:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:39:28 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16CdPAS025010;
        Wed, 6 Feb 2019 06:39:26 -0600
Subject: Re: [PATCH 02/35] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-3-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <eb09a892-d965-3ee2-dfe7-2dcbbcb03791@ti.com>
Date:   Wed, 6 Feb 2019 18:09:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/19 7:08 PM, Bartosz Golaszewski wrote:

> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 67805ca74ff8..b9aec3c48a6a 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  
> +#include <asm/exception.h>
>  #include <mach/common.h>
>  #include "cp_intc.h"
>  
> @@ -97,6 +98,16 @@ static struct irq_chip cp_intc_irq_chip = {
>  
>  static struct irq_domain *cp_intc_domain;
>  
> +static asmlinkage void __exception_irq_entry
> +cp_intc_handle_irq(struct pt_regs *regs)
> +{
> +	int irqnr = cp_intc_read(CP_INTC_PRIO_IDX);
> +
> +	irqnr &= 0xff;
> +
> +	handle_domain_irq(cp_intc_domain, irqnr, regs);

This leaves out spurious interrupt handling present in existing assembly
code. Can you add it back. May be use omap_intc_handle_irq() as an
example for handling spurious IRQs.

> +}
> +

> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 952dc126c390..3bbbef78d9ac 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -28,11 +28,13 @@
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
> @@ -45,6 +47,11 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
>  	__raw_writel(value, davinci_intc_base + offset);
>  }
>  
> +static inline unsigned long davinci_irq_readl(int offset)
> +{
> +	return __raw_readl(davinci_intc_base + offset);
> +}

Can we use readl_relaxed() here? I know there is existing __raw_writel()
usage. May be add a patch to fix the existing code first.

Thanks,
Sekhar
