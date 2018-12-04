Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B908208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IprvrREp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B908208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeLDFjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:39:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54416 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDFjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:39:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB45dBiL018891;
        Mon, 3 Dec 2018 23:39:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543901951;
        bh=3UflfmQAb+jImBBScTI1IjNvgWybKibGhFnBN1fbeTw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IprvrREpxSW86qofk/u1GSqtznE4gShsBBE7fR2JIx6Sd1p00YPjwnmwlI+uJLvRF
         U/u8KuvUR0FLxmPLcDQXvyUTsDMKqmgqmy6z2tkjklS2S3c2I8yw5Bjik6vaitNtvl
         c8HnogyIVFjZBhw17hPlzhxgxq+2cye3S+zQ2IDI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB45dBsO102626
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 23:39:11 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 23:39:11 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 23:39:10 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB45d8a5008775;
        Mon, 3 Dec 2018 23:39:08 -0600
Subject: Re: [PATCH v2 2/3] phy: sr-usb: Add stingray usb phy driver
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
References: <1543826208-22742-1-git-send-email-srinath.mannam@broadcom.com>
 <1543826208-22742-3-git-send-email-srinath.mannam@broadcom.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8b255dec-869b-91a7-1446-5f00ffedcc94@ti.com>
Date:   Tue, 4 Dec 2018 11:09:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543826208-22742-3-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/12/18 2:06 PM, Srinath Mannam wrote:
> This driver supports all versions of stingray SS and HS
> USB phys.
> In version 1 is combo phy contain both SS and HS phys
> in a common IO space.
> In version 2 a single HS phy.
> These phys support both xHCI host driver and
> BDC Broadcom device controller driver.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/phy/broadcom/Kconfig          |  11 +
>  drivers/phy/broadcom/Makefile         |   1 +
>  drivers/phy/broadcom/phy-bcm-sr-usb.c | 373 ++++++++++++++++++++++++++++++++++
>  3 files changed, 385 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
> 
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index 8786a96..c1e4dd5 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -10,6 +10,17 @@ config PHY_CYGNUS_PCIE
>  	  Enable this to support the Broadcom Cygnus PCIe PHY.
>  	  If unsure, say N.
>  
> +config PHY_BCM_SR_USB
> +	tristate "Broadcom Stingray USB PHY driver"
> +	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
> +	select GENERIC_PHY
> +	default ARCH_BCM_IPROC
> +	help
> +	  Enable this to support the Broadcom Stingray USB PHY
> +	  driver. It supports all versions of Superspeed and
> +	  Highspeed PHYs.
> +	  If unsure, say N.
> +
>  config BCM_KONA_USB2_PHY
>  	tristate "Broadcom Kona USB2 PHY Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
> index 0f60184..f453c7d 100644
> --- a/drivers/phy/broadcom/Makefile
> +++ b/drivers/phy/broadcom/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
>  phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
>  
>  obj-$(CONFIG_PHY_BCM_SR_PCIE)		+= phy-bcm-sr-pcie.o
> +obj-$(CONFIG_PHY_BCM_SR_USB)		+= phy-bcm-sr-usb.o
> diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> new file mode 100644
> index 0000000..52484b3
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016-2018 Broadcom
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +enum bcm_usb_phy_version {
> +	BCM_USB_PHY_V1,
> +	BCM_USB_PHY_V2,
> +};
> +
> +enum bcm_usb_phy_reg {
> +	PLL_NDIV_FRAC,
> +	PLL_NDIV_INT,
> +	PLL_CTRL,
> +	PHY_CTRL,
> +	PHY_PLL_CTRL,
> +};
> +
> +/* USB PHY registers */
> +
> +static const u8 bcm_usb_u3phy_v1[] = {
> +	[PLL_CTRL]		= 0x18,
> +	[PHY_CTRL]		= 0x14,
> +};
> +
> +static const u8 bcm_usb_u2phy_v1[] = {
> +	[PLL_NDIV_FRAC]	= 0x04,
> +	[PLL_NDIV_INT]	= 0x08,
> +	[PLL_CTRL]	= 0x0c,
> +	[PHY_CTRL]	= 0x10,
> +};
> +
> +#define HSPLL_NDIV_INT_VAL	0x13
> +#define HSPLL_NDIV_FRAC_VAL	0x1005
> +
> +static const u8 bcm_usb_u2phy_v2[] = {
> +	[PLL_NDIV_FRAC]	= 0x0,
> +	[PLL_NDIV_INT]	= 0x4,
> +	[PLL_CTRL]	= 0x8,
> +	[PHY_CTRL]	= 0xc,
> +};
> +
> +enum pll_ctrl_bits {
> +	PLL_RESETB,
> +	SSPLL_SUSPEND_EN,
> +	PLL_SEQ_START,
> +	PLL_LOCK,
> +	PLL_PDIV,
> +};
> +
> +static const u8 u3pll_ctrl[] = {
> +	[PLL_RESETB]		= 0,
> +	[SSPLL_SUSPEND_EN]	= 1,
> +	[PLL_SEQ_START]		= 2,
> +	[PLL_LOCK]		= 3,
> +};
> +
> +#define HSPLL_PDIV_MASK		0xF
> +#define HSPLL_PDIV_VAL		0x1
> +
> +static const u8 u2pll_ctrl[] = {
> +	[PLL_PDIV]	= 1,
> +	[PLL_RESETB]	= 5,
> +	[PLL_LOCK]	= 6,
> +};
> +
> +enum bcm_usb_phy_ctrl_bits {
> +	CORERDY,
> +	AFE_LDO_PWRDWNB,
> +	AFE_PLL_PWRDWNB,
> +	AFE_BG_PWRDWNB,
> +	PHY_ISO,
> +	PHY_RESETB,
> +	PHY_PCTL,
> +};
> +
> +#define PHY_PCTL_MASK	0xffff
> +/*
> + * 0x0806 of PCTL_VAL has below bits set
> + * BIT-8 : refclk divider 1
> + * BIT-3:2: device mode; mode is not effect
> + * BIT-1: soft reset active low
> + */
> +#define HSPHY_PCTL_VAL	0x0806
> +#define SSPHY_PCTL_VAL	0x0006
> +
> +static const u8 u3phy_ctrl[] = {
> +	[PHY_RESETB]	= 1,
> +	[PHY_PCTL]	= 2,
> +};
> +
> +static const u8 u2phy_ctrl[] = {
> +	[CORERDY]		= 0,
> +	[AFE_LDO_PWRDWNB]	= 1,
> +	[AFE_PLL_PWRDWNB]	= 2,
> +	[AFE_BG_PWRDWNB]	= 3,
> +	[PHY_ISO]		= 4,
> +	[PHY_RESETB]		= 5,
> +	[PHY_PCTL]		= 6,
> +};
> +
> +struct bcm_usb_phy_cfg {
> +	uint32_t type;
> +	uint32_t ver;
> +	void __iomem *regs;
> +	struct phy *phy;
> +	const u8 *offset;
> +};
> +
> +#define PLL_LOCK_RETRY_COUNT	1000
> +
> +enum bcm_usb_phy_type {
> +	USB_HS_PHY,
> +	USB_SS_PHY,
> +};
> +
> +static inline void bcm_usb_reg32_clrbits(void __iomem *addr, uint32_t clear)
> +{
> +	writel(readl(addr) & ~clear, addr);
> +}
> +
> +static inline void bcm_usb_reg32_setbits(void __iomem *addr, uint32_t set)
> +{
> +	writel(readl(addr) | set, addr);
> +}
> +
> +static int bcm_usb_pll_lock_check(void __iomem *addr, u32 bit)
> +{
> +	int retry;
> +	u32 rd_data;
> +
> +	retry = PLL_LOCK_RETRY_COUNT;
> +	do {
> +		rd_data = readl(addr);
> +		if (rd_data & bit)
> +			return 0;
> +		udelay(1);
> +	} while (--retry > 0);
> +
> +	pr_err("%s: FAIL\n", __func__);
> +	return -ETIMEDOUT;
> +}
> +
> +static int bcm_usb_ss_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
> +{
> +	int ret = 0;
> +	void __iomem *regs = phy_cfg->regs;
> +	const u8 *offset;
> +	u32 rd_data;
> +
> +	offset = phy_cfg->offset;
> +
> +	/* Set pctl with mode and soft reset */
> +	rd_data = readl(regs + offset[PHY_CTRL]);
> +	rd_data &= ~(PHY_PCTL_MASK << u3phy_ctrl[PHY_PCTL]);
> +	rd_data |= (SSPHY_PCTL_VAL << u3phy_ctrl[PHY_PCTL]);
> +	writel(rd_data, regs + offset[PHY_CTRL]);
> +
> +	bcm_usb_reg32_clrbits(regs + offset[PLL_CTRL],
> +			      BIT(u3pll_ctrl[SSPLL_SUSPEND_EN]));
> +	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> +			      BIT(u3pll_ctrl[PLL_SEQ_START]));
> +	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> +			      BIT(u3pll_ctrl[PLL_RESETB]));
> +
> +	/* Maximum timeout for PLL reset done */
> +	msleep(30);
> +
> +	ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
> +				     BIT(u3pll_ctrl[PLL_LOCK]));
> +
> +	return ret;
> +}
> +
> +static int bcm_usb_hs_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
> +{
> +	int ret = 0;
> +	void __iomem *regs = phy_cfg->regs;
> +	const u8 *offset;
> +	u32 rd_data;
> +
> +	offset = phy_cfg->offset;
> +
> +	writel(HSPLL_NDIV_INT_VAL, regs + offset[PLL_NDIV_INT]);
> +	writel(HSPLL_NDIV_FRAC_VAL, regs + offset[PLL_NDIV_FRAC]);
> +
> +	rd_data = readl(regs + offset[PLL_CTRL]);
> +	rd_data &= ~(HSPLL_PDIV_MASK << u2pll_ctrl[PLL_PDIV]);
> +	rd_data |= (HSPLL_PDIV_VAL << u2pll_ctrl[PLL_PDIV]);
> +	writel(rd_data, regs + offset[PLL_CTRL]);
> +
> +	/* Set Core Ready high */
> +	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> +			      BIT(u2phy_ctrl[CORERDY]));
> +
> +	/* Maximum timeout for Core Ready done */
> +	msleep(30);
> +
> +	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> +			      BIT(u2pll_ctrl[PLL_RESETB]));
> +	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> +			      BIT(u2phy_ctrl[PHY_RESETB]));
> +
> +
> +	rd_data = readl(regs + offset[PHY_CTRL]);
> +	rd_data &= ~(PHY_PCTL_MASK << u2phy_ctrl[PHY_PCTL]);
> +	rd_data |= (HSPHY_PCTL_VAL << u2phy_ctrl[PHY_PCTL]);
> +	writel(rd_data, regs + offset[PHY_CTRL]);
> +
> +	/* Maximum timeout for PLL reset done */
> +	msleep(30);
> +
> +	ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
> +				     BIT(u2pll_ctrl[PLL_LOCK]));
> +
> +	return ret;
> +}
> +
> +static int bcm_usb_phy_reset(struct phy *phy)
> +{
> +	struct bcm_usb_phy_cfg *phy_cfg = phy_get_drvdata(phy);
> +	void __iomem *regs = phy_cfg->regs;
> +	const u8 *offset;
> +
> +	offset = phy_cfg->offset;
> +
> +	if (phy_cfg->type == USB_HS_PHY) {
> +		bcm_usb_reg32_clrbits(regs + offset[PHY_CTRL],
> +				      BIT(u2phy_ctrl[CORERDY]));
> +		bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> +				      BIT(u2phy_ctrl[CORERDY]));
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm_usb_phy_init(struct phy *phy)
> +{
> +	struct bcm_usb_phy_cfg *phy_cfg = phy_get_drvdata(phy);
> +	int ret = -EINVAL;
> +
> +	if (phy_cfg->type == USB_SS_PHY)
> +		ret = bcm_usb_ss_phy_init(phy_cfg);
> +	else if (phy_cfg->type == USB_HS_PHY)
> +		ret = bcm_usb_hs_phy_init(phy_cfg);
> +
> +	return ret;
> +}
> +
> +static struct phy_ops sr_phy_ops = {
> +	.init		= bcm_usb_phy_init,
> +	.reset		= bcm_usb_phy_reset,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
> +			     void __iomem *regs, uint32_t version)
> +{
> +	struct bcm_usb_phy_cfg *phy_cfg;
> +	struct phy_provider *phy_provider;
> +
> +	phy_cfg = devm_kzalloc(dev, sizeof(struct bcm_usb_phy_cfg), GFP_KERNEL);
> +	if (!phy_cfg)
> +		return -ENOMEM;
> +
> +	phy_cfg->regs = regs;
> +	phy_cfg->ver = version;
> +
> +	if (phy_cfg->ver == BCM_USB_PHY_V1) {
> +		unsigned int id;
> +
> +		if (of_property_read_u32(node, "reg", &id)) {
> +			dev_err(dev, "missing reg property in node %s\n",
> +				node->name);
> +			return -EINVAL;
> +		}
> +
> +		if (id == 0) {
> +			phy_cfg->offset = bcm_usb_u2phy_v1;
> +			phy_cfg->type = USB_HS_PHY;
> +		} else if (id == 1) {
> +			phy_cfg->offset = bcm_usb_u3phy_v1;
> +			phy_cfg->type = USB_SS_PHY;
> +		} else {
> +			return -ENODEV;
> +		}
> +	} else if (phy_cfg->ver == BCM_USB_PHY_V2) {
> +		phy_cfg->offset = bcm_usb_u2phy_v2;
> +		phy_cfg->type = USB_HS_PHY;
> +	}
> +
> +	phy_cfg->phy = devm_phy_create(dev, node, &sr_phy_ops);
> +	if (IS_ERR(phy_cfg->phy))
> +		return PTR_ERR(phy_cfg->phy);
> +
> +	phy_set_drvdata(phy_cfg->phy, phy_cfg);
> +	phy_provider = devm_of_phy_provider_register(&phy_cfg->phy->dev,
> +						     of_phy_simple_xlate);

The phy_provider_register usage is wrong here. The device passed shouldn't be
PHY's device rather it should be PHY provider device. So
devm_of_phy_provider_register should have just used dev from the argument of
this function instead of &phy_cfg->phy->dev.

Moreover a single PHY provider can support multiple PHYs. So you can actually
move the devm_of_phy_provider_register out of this function and register the
PHY provider only once.

Remove devm_of_phy_provider_register from this function and add the following
in the probe
phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
return PTR_ERR_OR_ZERO(phy_provider);

Thanks
Kishon

> +	if (IS_ERR(phy_provider)) {
> +		dev_err(dev, "Failed to register phy provider\n");
> +		return PTR_ERR(phy_provider);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm_usb_phy_of_match[] = {
> +	{
> +		.compatible = "brcm,sr-usb-phy",
> +		.data = (void *)BCM_USB_PHY_V1,
> +	},
> +	{
> +		.compatible = "brcm,sr-usb-phy-v2",
> +		.data = (void *)BCM_USB_PHY_V2,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_usb_phy_of_match);
> +
> +static int bcm_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *dn = dev->of_node, *child;
> +	const struct of_device_id *of_id;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret;
> +	enum bcm_usb_phy_version version;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	of_id = of_match_node(bcm_usb_phy_of_match, dn);
> +	if (of_id)
> +		version = (enum bcm_usb_phy_version)of_id->data;
> +	else
> +		return -ENODEV;
> +
> +	if (of_get_child_count(dn) == 0)
> +		return bcm_usb_phy_create(dev, dn, regs, version);
> +
> +	for_each_available_child_of_node(dn, child) {
> +		ret = bcm_usb_phy_create(dev, child, regs, version);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver bcm_usb_phy_driver = {
> +	.driver = {
> +		.name = "phy-bcm-sr-usb",
> +		.of_match_table = bcm_usb_phy_of_match,
> +	},
> +	.probe = bcm_usb_phy_probe,
> +};
> +module_platform_driver(bcm_usb_phy_driver);
> +
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("Broadcom stingray USB Phy driver");
> +MODULE_LICENSE("GPL v2");
> 
