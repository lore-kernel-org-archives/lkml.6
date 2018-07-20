Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA4FECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B9420833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B9420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeGTBTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:19:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:46059 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeGTBTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:19:36 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Jul 2018 09:33:57 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id A01A0180B7D;
        Fri, 20 Jul 2018 09:33:57 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 20 Jul 2018 09:33:57 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 263DC40318;
        Fri, 20 Jul 2018 09:33:57 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id DEA6E120448;
        Fri, 20 Jul 2018 09:33:56 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?= 
        <yamada.masahiro@socionext.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <linux-kernel@vger.kernel.org>,
        =?iso-2022-jp?B?SGF5YXNoaSwgS3VuaWhpa28vGyRCTlMbKEIgGyRCSy5JJxsoQg==?= 
        <hayashi.kunihiko@socionext.com>
References: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com> <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com> <20180719165150.GI27938@sirena.org.uk>
In-Reply-To: <20180719165150.GI27938@sirena.org.uk>
Subject: RE: [PATCH 2/2] spi: add SPI controller driver for UniPhier SoC
Date:   Fri, 20 Jul 2018 09:33:53 +0900
Message-ID: <000901d41fc1$565160f0$02f422d0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUHy008XXZ7cNvsUuL8UjbwsGq1qSWLFkAgAELjEA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, July 20, 2018 1:52 AM
> Subject: Re: [PATCH 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, Jul 19, 2018 at 03:51:57PM +0900, Keiji Hayashibara wrote:
> 
> This all looks good, just a small number of fairly minor things - mostly style points.
> 
> > @@ -0,0 +1,532 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * spi-uniphier.c - Socionext UniPhier SPI controller driver
> > + *
> > + * Copyright 2012      Panasonic Corporation
> > + * Copyright 2016-2018 Socionext Inc.
> > + */
> 
> Please make the entire comment a C++ one, it makes things look a bit more joined up/intentional.

OK. I will modify to C++ style.


> > +#define BYTES_PER_WORD(x)			\
> > +({						\
> > +	int __x;				\
> > +	__x = (x <= 8)  ? 1 :			\
> > +	      (x <= 16) ? 2 : 4;		\
> > +	__x;					\
> > +})
> 
> Could this be replaced with an inline function?  The usage seems fine but it's a bit big for a macro.  The end
> result should be similar.

OK. I will replace with an inline function.

> 
> > +static irqreturn_t uniphier_spi_handler(int irq, void *dev_id) {
> > +	struct uniphier_spi_priv *priv = dev_id;
> > +	u32 val, stat;
> > +
> > +	stat = readl(priv->base + SSI_IS);
> > +	val = SSI_IC_TCIC | SSI_IC_RCIC | SSI_IC_RORIC;
> > +	writel(val, priv->base + SSI_IC);
> > +
> > +	/* rx fifo overrun */
> > +	if (stat & SSI_IS_RORID) {
> > +		priv->error = -EIO;
> > +		goto done;
> > +	}
> > +
> > +	/* rx complete */
> > +	if ((stat & SSI_IS_RCID) && (stat & SSI_IS_RXRS)) {
> 
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +
> > +done:
> > +	complete(&priv->xfer_done);
> > +	return IRQ_HANDLED;
> 
> This will unconditionally report IRQ_HANDLED even if none of the flags were set by the hardware which will cause
> problems if something goes wrong - the interrupt will continually be serviced and the interrupt framework won't
> be able to mitigate or provide diagnostics.  It's better to return IRQ_NONE if nothing is detected from the hardware.

I agree. I will modify it.

> > +static const struct of_device_id uniphier_spi_match[] = {
> > +	{ .compatible = "socionext,uniphier-scssi", },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, uniphier_spi_match);
> 
> The binding document also listed socionext,uniphier-mcssi as a compatible but this driver doesn't match that.

This driver doesn't support uniphier-mcssi, and support uniphier-scssi only.
I described in the commit comment,
but I will also describe it in the binding document.

Thank you.

-----------------
Best Regards,
Keiji Hayashibara



