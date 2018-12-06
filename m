Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2625520850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2625520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeLFLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:12:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53345 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:12:15 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gUrZd-0003iR-4q; Thu, 06 Dec 2018 12:12:05 +0100
Message-ID: <1544094724.3709.60.camel@pengutronix.de>
Subject: Re: [PATCH 3/5] irqchip/irq-imx-gpcv2: Make use of BIT() macro
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 12:12:04 +0100
In-Reply-To: <20181206073125.7255-4-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
         <20181206073125.7255-4-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 05.12.2018, 23:31 -0800 schrieb Andrey Smirnov:
> Convert all instances of 1 << x to BIT(x) for consistency with other
> kernel code.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/irqchip/irq-imx-gpcv2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-
> imx-gpcv2.c
> index b262ba8b2652..077d56b3183a 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -78,7 +78,7 @@ static int imx_gpcv2_irq_set_wake(struct irq_data
> *d, unsigned int on)
>  	u32 mask, val;
>  
>  	raw_spin_lock_irqsave(&cd->rlock, flags);
> -	mask = 1 << d->hwirq % 32;
> +	mask = BIT(d->hwirq % 32);
>  	val = cd->wakeup_sources[idx];
>  
>  	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
> @@ -101,7 +101,7 @@ static void imx_gpcv2_irq_unmask(struct irq_data
> *d)
>  	raw_spin_lock(&cd->rlock);
>  	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
>  	val = readl_relaxed(reg);
> -	val &= ~(1 << d->hwirq % 32);
> +	val &= ~BIT(d->hwirq % 32);
>  	writel_relaxed(val, reg);
>  	raw_spin_unlock(&cd->rlock);
>  
> @@ -117,7 +117,7 @@ static void imx_gpcv2_irq_mask(struct irq_data
> *d)
>  	raw_spin_lock(&cd->rlock);
>  	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
>  	val = readl_relaxed(reg);
> -	val |= 1 << (d->hwirq % 32);
> +	val |= BIT(d->hwirq % 32);
>  	writel_relaxed(val, reg);
>  	raw_spin_unlock(&cd->rlock);
>  
