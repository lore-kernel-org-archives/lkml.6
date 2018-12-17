Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BB3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EE72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbeLQPv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:51:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:51:25 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gYvAv-0000O5-VM; Mon, 17 Dec 2018 16:51:21 +0100
Message-ID: <1545061881.5874.10.camel@pengutronix.de>
Subject: Re: [PATCH] irqchip/irq-imx-gpcv2: add IRQCHIP_DECLARE for i.MX8MQ
 compatible
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, patchwork-lst@pengutronix.de,
        Jason Cooper <jason@lakedaemon.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Dec 2018 16:51:21 +0100
In-Reply-To: <20181214121528.5534-1-l.stach@pengutronix.de>
References: <20181214121528.5534-1-l.stach@pengutronix.de>
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

Hi Marc,

Am Freitag, den 14.12.2018, 13:15 +0100 schrieb Lucas Stach:
> The GPC node on i.MX8MQ can not claim to be compatible with the i.MX7D
> GPC, as the power gating part has some significant differences. Thus we
> can not rely on the irqchip being probed with the old compatible.
> 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/irqchip/irq-imx-gpcv2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index 17a2dad2d4c2..68b9cca24044 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -289,4 +289,5 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> >  	return 0;
>  }
>  
> -IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
> +IRQCHIP_DECLARE(imx_gpcv2_imx7d, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
> +IRQCHIP_DECLARE(imx_gpcv2_imx8mq, "fsl,imx8mq-gpc", imx_gpcv2_irqchip_init);

It would be nice if we could get this into 4.21, as this is the last
missing bit preventing me from pushing forward on the patches
describing the i.MX8MQ IRQ hierarchy properly for the next cycle.

Regards,
Lucas
