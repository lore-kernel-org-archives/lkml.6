Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CA7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7898208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w8rFO2yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7898208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeGIFUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:20:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41148 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbeGIFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:20:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w695JsUh020127;
        Mon, 9 Jul 2018 00:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531113594;
        bh=9R9/E3EmByGl9LbJHZas0/Wvrre9b2XU0aKLsVsizO0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=w8rFO2yGpSKGlyuGJ3RWAp4jyl0JBi4Zjg0BFFBzHamTvUklQvClOC4PDFYfp5xXM
         tu1HOBWiAplCWGHszcM4YWPiST1LeWcmtoOYo9yAxMD2Tp4f1WaUm8Dr+4kMUOaYZ1
         ML0850dsi85MMJ/8OUaupLZDCwQJ7h5IpSYCSJ3Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w695Jskd010954;
        Mon, 9 Jul 2018 00:19:54 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 9 Jul
 2018 00:19:54 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 9 Jul 2018 00:19:53 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w695JoDs015767;
        Mon, 9 Jul 2018 00:19:51 -0500
Subject: Re: [PATCH 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1530261541-23104-3-git-send-email-hayashi.kunihiko@socionext.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4b436a46-9046-25ad-ee6d-ad2cdb16e2ca@ti.com>
Date:   Mon, 9 Jul 2018 10:49:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1530261541-23104-3-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 29 June 2018 02:08 PM, Kunihiko Hayashi wrote:
> Add a driver for PHY interface built into USB3 controller
> implemented in UniPhier SoCs.
> This driver supports High-Speed PHY and Super-Speed PHY.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> ---
>  drivers/phy/Kconfig                         |   1 +
>  drivers/phy/Makefile                        |   1 +
>  drivers/phy/socionext/Kconfig               |  12 +
>  drivers/phy/socionext/Makefile              |   6 +
>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 422 ++++++++++++++++++++++++++++
>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 369 ++++++++++++++++++++++++
>  6 files changed, 811 insertions(+)
>  create mode 100644 drivers/phy/socionext/Kconfig
>  create mode 100644 drivers/phy/socionext/Makefile
>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 5c8d452..b752589 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -53,6 +53,7 @@ source "drivers/phy/ralink/Kconfig"
>  source "drivers/phy/renesas/Kconfig"
>  source "drivers/phy/rockchip/Kconfig"
>  source "drivers/phy/samsung/Kconfig"
> +source "drivers/phy/socionext/Kconfig"
>  source "drivers/phy/st/Kconfig"
>  source "drivers/phy/tegra/Kconfig"
>  source "drivers/phy/ti/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 84e3bd9..5539cde 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -21,5 +21,6 @@ obj-y					+= broadcom/	\
>  					   qualcomm/	\
>  					   ralink/	\
>  					   samsung/	\
> +					   socionext/	\
>  					   st/		\
>  					   ti/
> diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
> new file mode 100644
> index 0000000..4a172fc
> --- /dev/null
> +++ b/drivers/phy/socionext/Kconfig
> @@ -0,0 +1,12 @@
> +#
> +# PHY drivers for Socionext platforms.
> +#
> +
> +config PHY_UNIPHIER_USB3
> +	tristate "UniPhier USB3 PHY driver"
> +	depends on ARCH_UNIPHIER || COMPILE_TEST
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support USB PHY implemented in USB3 controller
> +	  on UniPhier SoCs. This controller supports USB3.0 and lower speed.
> diff --git a/drivers/phy/socionext/Makefile b/drivers/phy/socionext/Makefile
> new file mode 100644
> index 0000000..dfa5cec
> --- /dev/null
> +++ b/drivers/phy/socionext/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-identifier: GPL-2.0
> +#
> +# Makefile for the phy drivers.
> +#
> +
> +obj-$(CONFIG_PHY_UNIPHIER_USB3)	+= phy-uniphier-usb3hs.o phy-uniphier-usb3ss.o
> diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> new file mode 100644
> index 0000000..cea8983
> --- /dev/null
> +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> + * Copyright 2015-2018 Socionext Inc.
> + * Author:
> + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> + * Contributors:
> + *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> + *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#define HSPHY_CFG0		0x0
> +#define HSPHY_CFG0_HS_I_MASK	GENMASK(31, 28)
> +#define HSPHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
> +#define HSPHY_CFG0_SWING_MASK	GENMASK(17, 16)
> +#define HSPHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
> +#define HSPHY_CFG0_RTERM_MASK	GENMASK(7, 6)
> +#define HSPHY_CFG0_TRIMMASK	(HSPHY_CFG0_HS_I_MASK \
> +				 | HSPHY_CFG0_SEL_T_MASK \
> +				 | HSPHY_CFG0_RTERM_MASK)
> +
> +#define HSPHY_CFG1		0x4
> +#define HSPHY_CFG1_DAT_EN	BIT(29)
> +#define HSPHY_CFG1_ADR_EN	BIT(28)
> +#define HSPHY_CFG1_ADR_MASK	GENMASK(27, 16)
> +#define HSPHY_CFG1_DAT_MASK	GENMASK(23, 16)
> +
> +#define MAX_CLKS	3
> +#define MAX_RSTS	2
> +#define MAX_PHY_PARAMS	1
> +
> +struct uniphier_u3hsphy_param {
> +	u32 addr;
> +	u32 mask;
> +	u32 val;
> +};

I'd like to avoid configure the PHY this way, since it's impossible to know
which register is being configured.
> +
> +struct uniphier_u3hsphy_trim_param {
> +	unsigned int rterm;
> +	unsigned int sel_t;
> +	unsigned int hs_i;
> +};
> +
> +#define trim_param_is_valid(p)	((p)->rterm || (p)->sel_t || (p)->hs_i)
> +
> +struct uniphier_u3hsphy_priv {
> +	struct device *dev;
> +	void __iomem *base;
> +	int nclks;
> +	struct clk *clk[MAX_CLKS], *clk_phy, *clk_phy_ext;
> +	int nrsts;
> +	struct reset_control *rst[MAX_RSTS], *rst_phy;
> +	const struct uniphier_u3hsphy_soc_data *data;
> +};
> +
> +struct uniphier_u3hsphy_soc_data {
> +	const char *clock_names[MAX_CLKS];
> +	const char *reset_names[MAX_RSTS];
> +	int nparams;
> +	const struct uniphier_u3hsphy_param param[MAX_PHY_PARAMS];
> +	u32 config0;
> +	u32 config1;
> +	void (*trim_func)(struct uniphier_u3hsphy_priv *priv, u32 *pconfig,
> +			  struct uniphier_u3hsphy_trim_param *pt);
> +};
> +
> +static void uniphier_u3hsphy_trim_ld20(struct uniphier_u3hsphy_priv *priv,
> +				       u32 *pconfig,
> +				       struct uniphier_u3hsphy_trim_param *pt)
> +{
> +	*pconfig &= ~HSPHY_CFG0_RTERM_MASK;
> +	*pconfig |= FIELD_PREP(HSPHY_CFG0_RTERM_MASK, pt->rterm);
> +
> +	*pconfig &= ~HSPHY_CFG0_SEL_T_MASK;
> +	*pconfig |= FIELD_PREP(HSPHY_CFG0_SEL_T_MASK, pt->sel_t);
> +
> +	*pconfig &= ~HSPHY_CFG0_HS_I_MASK;
> +	*pconfig |= FIELD_PREP(HSPHY_CFG0_HS_I_MASK,  pt->hs_i);
> +}
> +
> +static int uniphier_u3hsphy_get_nvparam(struct uniphier_u3hsphy_priv *priv,
> +					const char *name, unsigned int *val)
> +{
> +	struct nvmem_cell *cell;
> +	u8 *buf;
> +
> +	cell = devm_nvmem_cell_get(priv->dev, name);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, NULL);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	*val = *buf;
> +
> +	kfree(buf);
> +
> +	return 0;
> +}
> +
> +static int uniphier_u3hsphy_get_nvparams(struct uniphier_u3hsphy_priv *priv,
> +					 struct uniphier_u3hsphy_trim_param *pt)
> +{
> +	int ret;
> +
> +	ret = uniphier_u3hsphy_get_nvparam(priv, "rterm", &pt->rterm);
> +	if (ret)
> +		return ret;
> +
> +	ret = uniphier_u3hsphy_get_nvparam(priv, "sel_t", &pt->sel_t);
> +	if (ret)
> +		return ret;
> +
> +	ret = uniphier_u3hsphy_get_nvparam(priv, "hs_i", &pt->hs_i);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int uniphier_u3hsphy_update_config(struct uniphier_u3hsphy_priv *priv,
> +					  u32 *pconfig)
> +{
> +	struct uniphier_u3hsphy_trim_param trim;
> +	int ret, trimmed = 0;
> +
> +	if (priv->data->trim_func) {
> +		ret = uniphier_u3hsphy_get_nvparams(priv, &trim);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		/*
> +		 * call trim_func only when trimming parameters that aren't
> +		 * all-zero can be acquired. All-zero parameters mean nothing
> +		 * has been written to nvmem.
> +		 */
> +		if (!ret && trim_param_is_valid(&trim)) {
> +			priv->data->trim_func(priv, pconfig, &trim);
> +			trimmed = 1;
> +		} else {
> +			dev_dbg(priv->dev, "can't get parameter from nvmem\n");
> +		}
> +	}
> +
> +	/* use default parameters without trimming values */
> +	if (!trimmed) {
> +		*pconfig &= ~HSPHY_CFG0_HSDISC_MASK;
> +		*pconfig |= FIELD_PREP(HSPHY_CFG0_HSDISC_MASK, 3);
> +	}
> +
> +	return 0;
> +}
> +
> +static void uniphier_u3hsphy_set_param(struct uniphier_u3hsphy_priv *priv,
> +				       const struct uniphier_u3hsphy_param *p)
> +{
> +	u32 val;
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~HSPHY_CFG1_ADR_MASK;
> +	val |= FIELD_PREP(HSPHY_CFG1_ADR_MASK, p->addr) | HSPHY_CFG1_ADR_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~HSPHY_CFG1_ADR_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~FIELD_PREP(HSPHY_CFG1_DAT_MASK, p->mask);
> +	val |=  FIELD_PREP(HSPHY_CFG1_DAT_MASK, p->val) | HSPHY_CFG1_DAT_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~HSPHY_CFG1_DAT_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +}
> +
> +static int uniphier_u3hsphy_init(struct phy *phy)
> +{
> +	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
> +	u32 config0, config1;
> +	int i, ret;
> +
> +	ret = clk_prepare_enable(priv->clk_phy_ext);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(priv->clk_phy);
> +	if (ret)
> +		goto out_clk_ext_disable;
> +
> +	ret = reset_control_deassert(priv->rst_phy);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	if (!priv->data->config0 && !priv->data->config1)
> +		return 0;
> +
> +	config0 = priv->data->config0;
> +	config1 = priv->data->config1;
> +
> +	ret = uniphier_u3hsphy_update_config(priv, &config0);
> +	if (ret)
> +		goto out_rst_assert;
> +
> +	writel(config0, priv->base + HSPHY_CFG0);
> +	writel(config1, priv->base + HSPHY_CFG1);
> +
> +	for (i = 0; i < priv->data->nparams; i++)
> +		uniphier_u3hsphy_set_param(priv, &priv->data->param[i]);
> +
> +	return 0;
> +
> +out_rst_assert:
> +	reset_control_assert(priv->rst_phy);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk_phy);
> +out_clk_ext_disable:
> +	clk_disable_unprepare(priv->clk_phy_ext);
> +
> +	return ret;
> +}
> +
> +static int uniphier_u3hsphy_exit(struct phy *phy)
> +{
> +	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
> +
> +	reset_control_assert(priv->rst_phy);
> +	clk_disable_unprepare(priv->clk_phy);
> +	clk_disable_unprepare(priv->clk_phy_ext);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops uniphier_u3hsphy_ops = {
> +	.init           = uniphier_u3hsphy_init,
> +	.exit           = uniphier_u3hsphy_exit,
> +	.owner          = THIS_MODULE,
> +};
> +
> +static int uniphier_u3hsphy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_u3hsphy_priv *priv;
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	struct phy *phy;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	const char *name;
> +	int i, ret, nc, nr;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->data = of_device_get_match_data(dev);
> +	if (WARN_ON(!priv->data ||
> +		    priv->data->nparams > MAX_PHY_PARAMS))
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	for (i = 0; i < MAX_CLKS; i++) {
> +		name = priv->data->clock_names[i];
> +		if (!name)
> +			break;
> +		clk = devm_clk_get(dev, name);
> +		/* "phy-ext" is optional */
> +		if (!strcmp(name, "phy-ext")) {
> +			if (PTR_ERR(clk) == -ENOENT)
> +				clk = NULL;
> +			priv->clk_phy_ext = clk;
> +		} else if (!strcmp(name, "phy")) {
> +			priv->clk_phy = clk;
> +		} else {
> +			priv->clk[priv->nclks++] = clk;

Only "link" clock will be here? Do we need an array for this?

I think the above can be replaced with 3 separate clk_get calls instead of
storing clock names in uniphier_u3hsphy_soc_data.

Thanks
Kishon
