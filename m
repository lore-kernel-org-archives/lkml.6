Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0531B21C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m0Yz4Ze0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0531B21C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeHIMzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:55:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44534 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeHIMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:55:05 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w79AUNf0056693;
        Thu, 9 Aug 2018 05:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533810623;
        bh=gVWmpOKSULWsm0n2m7CVnzZ1wJkO3C2k8XTIqSkBQqw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=m0Yz4Ze0zq3SENtcIt40epy9ztPyhPS2u66+PpAUK1N0O2ibUnmHbmKBOPZoUMAZk
         0VUtWisN6XYq9ceHkocRgWrpJ/bFV59/XoxDDRBlaDRlIG8jaoLwq7MetxRyJmDvH7
         yq1aT0R2ohSrIunSHYUysbjn4K/yrNUWANPDxFZ4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w79AUNB1009431;
        Thu, 9 Aug 2018 05:30:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 9 Aug
 2018 05:30:23 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 9 Aug 2018 05:30:23 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w79AUKU0020083;
        Thu, 9 Aug 2018 05:30:20 -0500
Subject: Re: [PATCH v2 2/4] phy: socionext: add USB3 PHY driver for UniPhier
 SoC
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1533290045-18969-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1533290045-18969-3-git-send-email-hayashi.kunihiko@socionext.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <312d10ae-7909-bede-ea0a-5d92a497f639@ti.com>
Date:   Thu, 9 Aug 2018 16:00:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1533290045-18969-3-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 03 August 2018 03:24 PM, Kunihiko Hayashi wrote:
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
>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 423 ++++++++++++++++++++++++++++
>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 350 +++++++++++++++++++++++
>  6 files changed, 793 insertions(+)
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
> index 0000000..e230fa31
> --- /dev/null
> +++ b/drivers/phy/socionext/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the phy drivers.
> +#
> +
> +obj-$(CONFIG_PHY_UNIPHIER_USB3)	+= phy-uniphier-usb3hs.o phy-uniphier-usb3ss.o
> diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> new file mode 100644
> index 0000000..d5f5d895
> --- /dev/null
> +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> +// Copyright 2015-2018 Socionext Inc.
> +// Author:
> +//      Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +// Contributors:
> +//      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> +//      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> +

I'm not sure if there is a standard format for adding SPDX identifiers. But
other PHY drivers seems to have used single line comment style only for the
first line. (see drivers/phy/amlogic/phy-meson-gxl-usb3.c)
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
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
> +#define PHY_F(regno, msb, lsb) { (regno), (msb), (lsb) }
> +
> +#define LS_SLEW		PHY_F(10, 6, 6)	/* LS mode slew rate */
> +#define FS_LS_DRV	PHY_F(10, 5, 5)	/* FS/LS slew rate */
> +
> +#define MAX_PHY_PARAMS	2
> +
> +struct uniphier_u3hsphy_param {
> +	struct {
> +		int reg_no;
> +		int msb;
> +		int lsb;
> +	} field;
> +	u8 value;
> +};
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
> +	struct clk *clk, *clk_parent, *clk_ext;
> +	struct reset_control *rst, *rst_parent;
> +	struct regulator *vbus;
> +	const struct uniphier_u3hsphy_soc_data *data;
> +};
> +
> +struct uniphier_u3hsphy_soc_data {
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
> +	u32 field_mask = GENMASK(p->field.msb, p->field.lsb);
> +	u8 data;
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~HSPHY_CFG1_ADR_MASK;
> +	val |= FIELD_PREP(HSPHY_CFG1_ADR_MASK, p->field.reg_no)
> +		| HSPHY_CFG1_ADR_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~HSPHY_CFG1_ADR_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~FIELD_PREP(HSPHY_CFG1_DAT_MASK, field_mask);
> +	data = field_mask & (p->value << p->field.lsb);
> +	val |=  FIELD_PREP(HSPHY_CFG1_DAT_MASK, data) | HSPHY_CFG1_DAT_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +
> +	val = readl(priv->base + HSPHY_CFG1);
> +	val &= ~HSPHY_CFG1_DAT_EN;
> +	writel(val, priv->base + HSPHY_CFG1);
> +}
> +
> +static int uniphier_u3hsphy_power_on(struct phy *phy)
> +{
> +	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk_ext);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		goto out_clk_ext_disable;
> +
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	if (priv->vbus) {
> +		ret = regulator_enable(priv->vbus);
> +		if (ret)
> +			goto out_rst_assert;
> +	}
> +
> +	return 0;
> +
> +out_rst_assert:
> +	reset_control_assert(priv->rst);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk);
> +out_clk_ext_disable:
> +	clk_disable_unprepare(priv->clk_ext);
> +
> +	return ret;
> +}
> +
> +static int uniphier_u3hsphy_power_off(struct phy *phy)
> +{
> +	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
> +
> +	if (priv->vbus)
> +		regulator_disable(priv->vbus);
> +
> +	reset_control_assert(priv->rst);
> +	clk_disable_unprepare(priv->clk);
> +	clk_disable_unprepare(priv->clk_ext);
> +
> +	return 0;
> +}
> +
> +static int uniphier_u3hsphy_init(struct phy *phy)
> +{
> +	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
> +	u32 config0, config1;
> +	int i, ret;
> +
> +	ret = clk_prepare_enable(priv->clk_parent);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(priv->rst_parent);
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
> +	reset_control_assert(priv->rst_parent);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk_parent);
> +
> +	return ret;
> +}
> +
> +static int uniphier_u3hsphy_exit(struct phy *phy)
> +{
> +	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
> +
> +	reset_control_assert(priv->rst_parent);
> +	clk_disable_unprepare(priv->clk_parent);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops uniphier_u3hsphy_ops = {
> +	.init           = uniphier_u3hsphy_init,
> +	.exit           = uniphier_u3hsphy_exit,
> +	.power_on       = uniphier_u3hsphy_power_on,
> +	.power_off      = uniphier_u3hsphy_power_off,
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
> +	priv->clk = devm_clk_get(dev, "phy");
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->clk_parent = devm_clk_get(dev, "link");
> +	if (IS_ERR(priv->clk_parent))
> +		return PTR_ERR(priv->clk_parent);
> +
> +	priv->clk_ext = devm_clk_get(dev, "phy-ext");
> +	if (IS_ERR(priv->clk_ext)) {
> +		if (PTR_ERR(priv->clk_ext) == -ENOENT)
> +			priv->clk_ext = NULL;
> +		else
> +			return PTR_ERR(priv->clk_ext);
> +	}
> +
> +	priv->rst = devm_reset_control_get_shared(dev, "phy");
> +	if (IS_ERR(priv->rst))
> +		return PTR_ERR(priv->rst);
> +
> +	priv->rst_parent = devm_reset_control_get_shared(dev, "link");
> +	if (IS_ERR(priv->rst_parent))
> +		return PTR_ERR(priv->rst_parent);
> +
> +	priv->vbus = devm_regulator_get_optional(dev, "vbus");
> +	if (IS_ERR(priv->vbus)) {
> +		if (PTR_ERR(priv->vbus) == -EPROBE_DEFER)
> +			return PTR_ERR(priv->vbus);
> +		priv->vbus = NULL;
> +	}
> +
> +	phy = devm_phy_create(dev, dev->of_node, &uniphier_u3hsphy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, priv);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);

return PTR_ERR_OR_ZERO()?
> +
> +	return 0;
> +}
> +
> +static const struct uniphier_u3hsphy_soc_data uniphier_pxs2_data = {
> +	.nparams = 0,
> +};
> +
> +static const struct uniphier_u3hsphy_soc_data uniphier_ld20_data = {
> +	.nparams = 2,
> +	.param = {
> +		{ LS_SLEW, 1 },
> +		{ FS_LS_DRV, 1 },
> +	},
> +	.trim_func = uniphier_u3hsphy_trim_ld20,
> +	.config0 = 0x92316680,
> +	.config1 = 0x00000106,
> +};
> +
> +static const struct uniphier_u3hsphy_soc_data uniphier_pxs3_data = {
> +	.nparams = 0,
> +	.trim_func = uniphier_u3hsphy_trim_ld20,
> +	.config0 = 0x92316680,
> +	.config1 = 0x00000106,
> +};
> +
> +static const struct of_device_id uniphier_u3hsphy_match[] = {
> +	{
> +		.compatible = "socionext,uniphier-pxs2-usb3-hsphy",
> +		.data = &uniphier_pxs2_data,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-ld20-usb3-hsphy",
> +		.data = &uniphier_ld20_data,
> +	},
> +	{
> +		.compatible = "socionext,uniphier-pxs3-usb3-hsphy",
> +		.data = &uniphier_pxs3_data,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_u3hsphy_match);
> +
> +static struct platform_driver uniphier_u3hsphy_driver = {
> +	.probe = uniphier_u3hsphy_probe,
> +	.driver	= {
> +		.name = "uniphier-usb3-hsphy",
> +		.of_match_table	= uniphier_u3hsphy_match,
> +	},
> +};
> +
> +module_platform_driver(uniphier_u3hsphy_driver);
> +
> +MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier HS-PHY driver for USB3 controller");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
> new file mode 100644
> index 0000000..9456653
> --- /dev/null
> +++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// phy-uniphier-usb3ss.c - SS-PHY driver for Socionext UniPhier USB3 controller
> +// Copyright 2015-2018 Socionext Inc.
> +// Author:
> +//      Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +// Contributors:
> +//      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> +//      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> +

Same here..
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +
> +#define SSPHY_TESTI		0x0
> +#define SSPHY_TESTO		0x4
> +#define TESTI_DAT_MASK		GENMASK(13, 6)
> +#define TESTI_ADR_MASK		GENMASK(5, 1)
> +#define TESTI_WR_EN		BIT(0)
> +
> +#define PHY_F(regno, msb, lsb) { (regno), (msb), (lsb) }
> +
> +#define CDR_CPD_TRIM	PHY_F(7, 3, 0)	/* RxPLL charge pump current */
> +#define CDR_CPF_TRIM	PHY_F(8, 3, 0)	/* RxPLL charge pump current 2 */
> +#define TX_PLL_TRIM	PHY_F(9, 3, 0)	/* TxPLL charge pump current */
> +#define BGAP_TRIM	PHY_F(11, 3, 0)	/* Bandgap voltage */
> +#define CDR_TRIM	PHY_F(13, 6, 5)	/* Clock Data Recovery setting */
> +#define VCO_CTRL	PHY_F(26, 7, 4)	/* VCO control */
> +#define VCOPLL_CTRL	PHY_F(27, 2, 0)	/* TxPLL VCO tuning */
> +#define VCOPLL_CM	PHY_F(28, 1, 0)	/* TxPLL voltage */
> +
> +#define MAX_PHY_PARAMS	7
> +
> +struct uniphier_u3ssphy_param {
> +	struct {
> +		int reg_no;
> +		int msb;
> +		int lsb;
> +	} field;
> +	u8 value;
> +};
> +
> +struct uniphier_u3ssphy_priv {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *clk, *clk_ext, *clk_parent, *clk_parent_gio;
> +	struct reset_control *rst, *rst_parent, *rst_parent_gio;
> +	struct regulator *vbus;
> +	const struct uniphier_u3ssphy_soc_data *data;
> +};
> +
> +struct uniphier_u3ssphy_soc_data {
> +	bool is_legacy;
> +	int nparams;
> +	const struct uniphier_u3ssphy_param param[MAX_PHY_PARAMS];
> +};
> +
> +static void uniphier_u3ssphy_testio_write(struct uniphier_u3ssphy_priv *priv,
> +					  u32 data)
> +{
> +	/* need to read TESTO twice after accessing TESTI */
> +	writel(data, priv->base + SSPHY_TESTI);
> +	readl(priv->base + SSPHY_TESTI);
> +	readl(priv->base + SSPHY_TESTI);
> +}
> +
> +static void uniphier_u3ssphy_set_param(struct uniphier_u3ssphy_priv *priv,
> +				       const struct uniphier_u3ssphy_param *p)
> +{
> +	u32 val;
> +	u8 field_mask = GENMASK(p->field.msb, p->field.lsb);
> +	u8 data;
> +
> +	/* read previous data */
> +	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
> +	val |= FIELD_PREP(TESTI_ADR_MASK, p->field.reg_no);
> +	uniphier_u3ssphy_testio_write(priv, val);
> +	val = readl(priv->base + SSPHY_TESTO);
> +
> +	/* update value */
> +	val &= ~FIELD_PREP(TESTI_DAT_MASK, field_mask);
> +	data = field_mask & (p->value << p->field.lsb);
> +	val  = FIELD_PREP(TESTI_DAT_MASK, data);
> +	val |= FIELD_PREP(TESTI_ADR_MASK, p->field.reg_no);
> +	uniphier_u3ssphy_testio_write(priv, val);
> +	uniphier_u3ssphy_testio_write(priv, val | TESTI_WR_EN);
> +	uniphier_u3ssphy_testio_write(priv, val);
> +
> +	/* read current data as dummy */
> +	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
> +	val |= FIELD_PREP(TESTI_ADR_MASK, p->field.reg_no);
> +	uniphier_u3ssphy_testio_write(priv, val);
> +	readl(priv->base + SSPHY_TESTO);
> +}
> +
> +static int uniphier_u3ssphy_power_on(struct phy *phy)
> +{
> +	struct uniphier_u3ssphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk_ext);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		goto out_clk_ext_disable;
> +
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	if (priv->vbus) {
> +		ret = regulator_enable(priv->vbus);
> +		if (ret)
> +			goto out_rst_assert;
> +	}
> +
> +	return 0;
> +
> +out_rst_assert:
> +	reset_control_assert(priv->rst);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk);
> +out_clk_ext_disable:
> +	clk_disable_unprepare(priv->clk_ext);
> +
> +	return ret;
> +}
> +
> +static int uniphier_u3ssphy_power_off(struct phy *phy)
> +{
> +	struct uniphier_u3ssphy_priv *priv = phy_get_drvdata(phy);
> +
> +	if (priv->vbus)
> +		regulator_disable(priv->vbus);
> +
> +	reset_control_assert(priv->rst);
> +	clk_disable_unprepare(priv->clk);
> +	clk_disable_unprepare(priv->clk_ext);
> +
> +	return 0;
> +}
> +
> +static int uniphier_u3ssphy_init(struct phy *phy)
> +{
> +	struct uniphier_u3ssphy_priv *priv = phy_get_drvdata(phy);
> +	int i, ret;
> +
> +	ret = clk_prepare_enable(priv->clk_parent);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(priv->clk_parent_gio);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	ret = reset_control_deassert(priv->rst_parent);
> +	if (ret)
> +		goto out_clk_gio_disable;
> +
> +	ret = reset_control_deassert(priv->rst_parent_gio);
> +	if (ret)
> +		goto out_rst_assert;
> +
> +	if (priv->data->is_legacy)
> +		return 0;
> +
> +	for (i = 0; i < priv->data->nparams; i++)
> +		uniphier_u3ssphy_set_param(priv, &priv->data->param[i]);
> +
> +	return 0;
> +
> +out_rst_assert:
> +	reset_control_assert(priv->rst_parent);
> +out_clk_gio_disable:
> +	clk_disable_unprepare(priv->clk_parent_gio);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk_parent);
> +
> +	return ret;
> +}
> +
> +static int uniphier_u3ssphy_exit(struct phy *phy)
> +{
> +	struct uniphier_u3ssphy_priv *priv = phy_get_drvdata(phy);
> +
> +	reset_control_assert(priv->rst_parent_gio);
> +	reset_control_assert(priv->rst_parent);
> +	clk_disable_unprepare(priv->clk_parent_gio);
> +	clk_disable_unprepare(priv->clk_parent);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops uniphier_u3ssphy_ops = {
> +	.init           = uniphier_u3ssphy_init,
> +	.exit           = uniphier_u3ssphy_exit,
> +	.power_on       = uniphier_u3ssphy_power_on,
> +	.power_off      = uniphier_u3ssphy_power_off,
> +	.owner          = THIS_MODULE,
> +};
> +
> +static int uniphier_u3ssphy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_u3ssphy_priv *priv;
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	struct phy *phy;
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
> +	if (!priv->data->is_legacy) {
> +		priv->clk = devm_clk_get(dev, "phy");
> +		if (IS_ERR(priv->clk))
> +			return PTR_ERR(priv->clk);
> +
> +		priv->clk_ext = devm_clk_get(dev, "phy-ext");
> +		if (IS_ERR(priv->clk_ext)) {
> +			if (PTR_ERR(priv->clk_ext) == -ENOENT)
> +				priv->clk_ext = NULL;
> +			else
> +				return PTR_ERR(priv->clk_ext);
> +		}
> +
> +		priv->rst = devm_reset_control_get_shared(dev, "phy");
> +		if (IS_ERR(priv->rst))
> +			return PTR_ERR(priv->rst);
> +	} else {
> +		priv->clk_parent_gio = devm_clk_get(dev, "gio");
> +		if (IS_ERR(priv->clk_parent_gio))
> +			return PTR_ERR(priv->clk_parent_gio);
> +
> +		priv->rst_parent_gio =
> +			devm_reset_control_get_shared(dev, "gio");
> +		if (IS_ERR(priv->rst_parent_gio))
> +			return PTR_ERR(priv->rst_parent_gio);
> +	}
> +
> +	priv->clk_parent = devm_clk_get(dev, "link");
> +	if (IS_ERR(priv->clk_parent))
> +		return PTR_ERR(priv->clk_parent);
> +
> +	priv->rst_parent = devm_reset_control_get_shared(dev, "link");
> +	if (IS_ERR(priv->rst_parent))
> +		return PTR_ERR(priv->rst_parent);
> +
> +	priv->vbus = devm_regulator_get_optional(dev, "vbus");
> +	if (IS_ERR(priv->vbus)) {
> +		if (PTR_ERR(priv->vbus) == -EPROBE_DEFER)
> +			return PTR_ERR(priv->vbus);
> +		priv->vbus = NULL;
> +	}
> +
> +	phy = devm_phy_create(dev, dev->of_node, &uniphier_u3ssphy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, priv);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);

here too return PTR_ERR_OR_ZERO()

Thanks
Kishon
