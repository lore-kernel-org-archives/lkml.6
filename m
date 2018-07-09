Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B800C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF220896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AF220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeGILXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:23:23 -0400
Received: from mx.socionext.com ([202.248.49.38]:49719 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932743AbeGILXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:23:22 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Jul 2018 20:23:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B59AA180B66;
        Mon,  9 Jul 2018 20:23:20 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 9 Jul 2018 20:23:20 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 72694403E2;
        Mon,  9 Jul 2018 20:23:20 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3B3F012014D;
        Mon,  9 Jul 2018 20:23:20 +0900 (JST)
Date:   Mon, 09 Jul 2018 20:23:19 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <4b436a46-9046-25ad-ee6d-ad2cdb16e2ca@ti.com>
References: <1530261541-23104-3-git-send-email-hayashi.kunihiko@socionext.com> <4b436a46-9046-25ad-ee6d-ad2cdb16e2ca@ti.com>
Message-Id: <20180709202319.1091.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,
Thank you for your comments.

On Mon, 9 Jul 2018 10:49:50 +0530 <kishon@ti.com> wrote:

> Hi,
> 
> On Friday 29 June 2018 02:08 PM, Kunihiko Hayashi wrote:
> > Add a driver for PHY interface built into USB3 controller
> > implemented in UniPhier SoCs.
> > This driver supports High-Speed PHY and Super-Speed PHY.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > ---
> >  drivers/phy/Kconfig                         |   1 +
> >  drivers/phy/Makefile                        |   1 +
> >  drivers/phy/socionext/Kconfig               |  12 +
> >  drivers/phy/socionext/Makefile              |   6 +
> >  drivers/phy/socionext/phy-uniphier-usb3hs.c | 422 ++++++++++++++++++++++++++++
> >  drivers/phy/socionext/phy-uniphier-usb3ss.c | 369 ++++++++++++++++++++++++
> >  6 files changed, 811 insertions(+)
> >  create mode 100644 drivers/phy/socionext/Kconfig
> >  create mode 100644 drivers/phy/socionext/Makefile
> >  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
> >  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

(snip...)

> > --- /dev/null
> > +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> > @@ -0,0 +1,422 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> > + * Copyright 2015-2018 Socionext Inc.
> > + * Author:
> > + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > + * Contributors:
> > + *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > + *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +
> > +#define HSPHY_CFG0		0x0
> > +#define HSPHY_CFG0_HS_I_MASK	GENMASK(31, 28)
> > +#define HSPHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
> > +#define HSPHY_CFG0_SWING_MASK	GENMASK(17, 16)
> > +#define HSPHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
> > +#define HSPHY_CFG0_RTERM_MASK	GENMASK(7, 6)
> > +#define HSPHY_CFG0_TRIMMASK	(HSPHY_CFG0_HS_I_MASK \
> > +				 | HSPHY_CFG0_SEL_T_MASK \
> > +				 | HSPHY_CFG0_RTERM_MASK)
> > +
> > +#define HSPHY_CFG1		0x4
> > +#define HSPHY_CFG1_DAT_EN	BIT(29)
> > +#define HSPHY_CFG1_ADR_EN	BIT(28)
> > +#define HSPHY_CFG1_ADR_MASK	GENMASK(27, 16)
> > +#define HSPHY_CFG1_DAT_MASK	GENMASK(23, 16)
> > +
> > +#define MAX_CLKS	3
> > +#define MAX_RSTS	2
> > +#define MAX_PHY_PARAMS	1
> > +
> > +struct uniphier_u3hsphy_param {
> > +	u32 addr;
> > +	u32 mask;
> > +	u32 val;
> > +};
> 
> I'd like to avoid configure the PHY this way, since it's impossible to know
> which register is being configured.

I see. 
In order to know which register is set, I'll add definitions for address
and mask.
And I think the driver might have functions for each SoC to configure
the registers instead of uniphier_u3hsphy_param.

Furthermore, I'll omit the register values that are already set
at power on if the configurations are not affected.


> > +
> > +struct uniphier_u3hsphy_trim_param {
> > +	unsigned int rterm;
> > +	unsigned int sel_t;
> > +	unsigned int hs_i;
> > +};
> > +
> > +#define trim_param_is_valid(p)	((p)->rterm || (p)->sel_t || (p)->hs_i)

(snip...)

> > +static int uniphier_u3hsphy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct uniphier_u3hsphy_priv *priv;
> > +	struct phy_provider *phy_provider;
> > +	struct resource *res;
> > +	struct phy *phy;
> > +	struct clk *clk;
> > +	struct reset_control *rst;
> > +	const char *name;
> > +	int i, ret, nc, nr;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev = dev;
> > +	priv->data = of_device_get_match_data(dev);
> > +	if (WARN_ON(!priv->data ||
> > +		    priv->data->nparams > MAX_PHY_PARAMS))
> > +		return -EINVAL;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	for (i = 0; i < MAX_CLKS; i++) {
> > +		name = priv->data->clock_names[i];
> > +		if (!name)
> > +			break;
> > +		clk = devm_clk_get(dev, name);
> > +		/* "phy-ext" is optional */
> > +		if (!strcmp(name, "phy-ext")) {
> > +			if (PTR_ERR(clk) == -ENOENT)
> > +				clk = NULL;
> > +			priv->clk_phy_ext = clk;
> > +		} else if (!strcmp(name, "phy")) {
> > +			priv->clk_phy = clk;
> > +		} else {
> > +			priv->clk[priv->nclks++] = clk;
> 
> Only "link" clock will be here? Do we need an array for this?
> 
> I think the above can be replaced with 3 separate clk_get calls instead of
> storing clock names in uniphier_u3hsphy_soc_data.

Indeed, in case of HS, we don't need such an array.
I'll rewrite it.

Thank you,

---
Best Regards,
Kunihiko Hayashi


