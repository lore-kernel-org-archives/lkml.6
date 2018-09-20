Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06001C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5C9206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cFLRjM+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5C9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeITPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:53:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbeITPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:53:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8KAAIAX083994;
        Thu, 20 Sep 2018 05:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537438218;
        bh=mNxHNG1wzBxs/VtZBPuzePIZQUkwDrq0J52ITQ5qoN0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=cFLRjM+ccDzGNukTRoW+B4jEZnHlnqfZQXJBfAUWPuSQIpVu3qNRPJ7/oa8dryc2a
         +XwKPDqBEImXz0XQQ2wnSzSa43daChZYpvpzIidGqGQJ38qmoixyaFYlw8fZ2EVRCc
         uRPbUiqijyK/p7ibYZCMT0VneJYUI9oqVTTV1n1Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8KAAIu8007820;
        Thu, 20 Sep 2018 05:10:18 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 20
 Sep 2018 05:10:18 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 20 Sep 2018 05:10:18 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8KAAF2q013525;
        Thu, 20 Sep 2018 05:10:16 -0500
Subject: Re: [RFC PATCH v2 2/2] phy: cadence: Add driver for Sierra PHY
To:     Alan Douglas <adouglas@cadence.com>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <1536244971-26714-1-git-send-email-adouglas@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <80328703-d99d-599f-956f-ed13cb8313a7@ti.com>
Date:   Thu, 20 Sep 2018 15:40:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536244971-26714-1-git-send-email-adouglas@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 06 September 2018 08:12 PM, Alan Douglas wrote:
> Add a Sierra PHY driver with PCIe and USB support.
> 
> The PHY has multiple lanes, which can be configured into
> groups, and a generic PHY device is created for each group.
> 
> There are two resets controlling the overall PHY block, one
> to enable the APB interface for programming registers, and
> another to enable the PHY itself.  Additionally there are
> resets for each PHY lane.
> 
> The PHY can be configured in hardware to read register
> settings from ROM, or they can be written by the driver.
> 
> The sequence of operation on startup is to enable the APB
> bus, write the PHY registers (if required)  for each lane
> group, and then enable the PHY.  Each group of lanes
> can then be individually controlled using the power_on()/
> power_off() function for that generic PHY
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  drivers/phy/Kconfig               |   1 +
>  drivers/phy/Makefile              |   1 +
>  drivers/phy/cadence/Kconfig       |   9 +
>  drivers/phy/cadence/Makefile      |   2 +
>  drivers/phy/cadence/cdns-sierra.c | 385 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 398 insertions(+)
>  create mode 100644 drivers/phy/cadence/Kconfig
>  create mode 100644 drivers/phy/cadence/Makefile
>  create mode 100644 drivers/phy/cadence/cdns-sierra.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 5c8d452..cc47f85 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -43,6 +43,7 @@ config PHY_XGENE
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> +source "drivers/phy/cadence/Kconfig"
>  source "drivers/phy/hisilicon/Kconfig"
>  source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 84e3bd9..ba48acd 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>  obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
>  obj-y					+= broadcom/	\
> +					   cadence/	\
>  					   hisilicon/	\
>  					   marvell/	\
>  					   motorola/	\
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> new file mode 100644
> index 0000000..098df0f
> --- /dev/null
> +++ b/drivers/phy/cadence/Kconfig
> @@ -0,0 +1,9 @@
> +#
> +# Phy drivers for Cadence PHYs
> +#
> +config CDNS_SIERRA_PHY
> +	tristate "Cadence Sierra PHY Driver"
> +	depends on OF && HAS_IOMEM && RESET_CONTROLLER
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Cadence Sierra PHY driver
> diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> new file mode 100644
> index 0000000..c396c69
> --- /dev/null
> +++ b/drivers/phy/cadence/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_CDNS_SIERRA_PHY)		+= cdns-sierra.o
> diff --git a/drivers/phy/cadence/cdns-sierra.c b/drivers/phy/cadence/cdns-sierra.c
> new file mode 100644
> index 0000000..83568b4
> --- /dev/null
> +++ b/drivers/phy/cadence/cdns-sierra.c
> @@ -0,0 +1,385 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence Sierra PHY Driver
> + *
> + * Copyright (c) 2018 Cadence Design Systems
> + * Author: Alan Douglas <adouglas@cadence.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/* PHY register offsets */
> +#define SIERRA_PHY_PLL_CFG		(0xc00e << 2)
> +#define SIERRA_DET_STANDEC_A		(0x4000 << 2)
> +#define SIERRA_DET_STANDEC_B		(0x4001 << 2)
> +#define SIERRA_DET_STANDEC_C		(0x4002 << 2)
> +#define SIERRA_DET_STANDEC_D		(0x4003 << 2)
> +#define SIERRA_DET_STANDEC_E		(0x4004 << 2)
> +#define SIERRA_PSM_LANECAL		(0x4008 << 2)
> +#define SIERRA_PSM_DIAG			(0x4015 << 2)
> +#define SIERRA_PSC_TX_A0		(0x4028 << 2)
> +#define SIERRA_PSC_TX_A1		(0x4029 << 2)
> +#define SIERRA_PSC_TX_A2		(0x402A << 2)
> +#define SIERRA_PSC_TX_A3		(0x402B << 2)
> +#define SIERRA_PSC_RX_A0		(0x4030 << 2)
> +#define SIERRA_PSC_RX_A1		(0x4031 << 2)
> +#define SIERRA_PSC_RX_A2		(0x4032 << 2)
> +#define SIERRA_PSC_RX_A3		(0x4033 << 2)
> +#define SIERRA_PLLCTRL_SUBRATE		(0x403A << 2)
> +#define SIERRA_PLLCTRL_GEN_D		(0x403E << 2)
> +#define SIERRA_DRVCTRL_ATTEN		(0x406A << 2)
> +#define SIERRA_CLKPATHCTRL_TMR		(0x4081 << 2)
> +#define SIERRA_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
> +#define SIERRA_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
> +#define SIERRA_CREQ_CCLKDET_MODE01	(0x408E << 2)
> +#define SIERRA_RX_CTLE_MAINTENANCE	(0x4091 << 2)
> +#define SIERRA_CREQ_FSMCLK_SEL		(0x4092 << 2)
> +#define SIERRA_CTLELUT_CTRL		(0x4098 << 2)
> +#define SIERRA_DFE_ECMP_RATESEL		(0x40C0 << 2)
> +#define SIERRA_DFE_SMP_RATESEL		(0x40C1 << 2)
> +#define SIERRA_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
> +#define SIERRA_TMRVAL_MODE3		(0x416E << 2)
> +#define SIERRA_TMRVAL_MODE2		(0x416F << 2)
> +#define SIERRA_TMRVAL_MODE1		(0x4170 << 2)
> +#define SIERRA_TMRVAL_MODE0		(0x4171 << 2)
> +#define SIERRA_PICNT_MODE1		(0x4174 << 2)
> +#define SIERRA_CPI_OUTBUF_RATESEL	(0x417C << 2)
> +#define SIERRA_LFPSFILT_NS		(0x418A << 2)
> +#define SIERRA_LFPSFILT_RD		(0x418B << 2)
> +#define SIERRA_LFPSFILT_MP		(0x418C << 2)
> +#define SIERRA_SDFILT_H2L_A		(0x4191 << 2)
> +
> +#define SIERRA_MACRO_ID			0x00007364
> +#define SIERRA_MAX_LANES		4
> +
> +struct cdns_sierra_inst {
> +	struct phy *phy;
> +	u32 phy_type;
> +	u32 num_lanes;
> +	u32 mlane;
> +	struct reset_control *lnk_rst;
> +};
> +
> +struct cdns_reg_pairs {
> +	u16 val;
> +	u32 off;
> +};
> +
> +struct cdns_sierra_data {
> +		u32 id_value;
> +		u32 pcie_regs;
> +		u32 usb_regs;
> +		struct cdns_reg_pairs *pcie_vals;
> +		struct cdns_reg_pairs  *usb_vals;
> +};
> +
> +struct cdns_sierra_phy {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct cdns_sierra_data *init_data;
> +	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
> +	struct reset_control *phy_rst;
> +	struct reset_control *apb_rst;
> +	struct clk *clk;
> +	struct phy *pcie_phy;
> +	bool autoconf;
> +};
> +
> +static void cdns_sierra_phy_init(struct phy *gphy)
> +{
> +	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
> +	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
> +	int i, j;
> +	struct cdns_reg_pairs *vals;
> +	u32 num_regs;
> +
> +	if (ins->phy_type == PHY_TYPE_PCIE) {
> +		num_regs = phy->init_data->pcie_regs;
> +		vals = phy->init_data->pcie_vals;
> +	} else if (ins->phy_type == PHY_TYPE_USB3) {
> +		num_regs = phy->init_data->usb_regs;
> +		vals = phy->init_data->usb_vals;
> +	} else {
> +		return;
> +	}
> +	for (i = 0; i < ins->num_lanes; i++)
> +		for (j = 0; j < num_regs ; j++)
> +			writel(vals[j].val, phy->base +
> +				vals[j].off + (i + ins->mlane) * 0x800);
> +}
> +
> +static int cdns_sierra_phy_on(struct phy *gphy)
> +{
> +	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
> +	int ret;
> +
> +	/* Take the PHY out of reset */
> +	ret = reset_control_deassert(ins->lnk_rst);
> +
> +	if (ret)

This check is unncessary.
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static int cdns_sierra_phy_off(struct phy *gphy)
> +{
> +	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
> +
> +	reset_control_assert(ins->lnk_rst);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops ops = {
> +	.power_on	= cdns_sierra_phy_on,
> +	.power_off	= cdns_sierra_phy_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
> +				    struct device_node *child)
> +{
> +	if (of_property_read_u32(child, "reg", &inst->mlane))
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cdns_sierra_id_table[];
> +
> +static int cdns_sierra_phy_probe(struct platform_device *pdev)
> +{
> +	struct cdns_sierra_phy *sp;
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	struct resource *res;
> +	int ret, node = 0;
> +	struct device_node *dn = dev->of_node, *child;
> +
> +	if (of_get_child_count(dn) == 0)
> +		return -ENODEV;
> +
> +	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
> +	if (!sp)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, sp);
> +	sp->dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> +	sp->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(sp->base)) {
> +		dev_err(dev, "missing \"reg\"\n");
> +		return PTR_ERR(sp->base);
> +	}
> +
> +	/* Get init data for this PHY */
> +	match = of_match_device(cdns_sierra_id_table, dev);
> +	if (!match)
> +		return -EINVAL;
> +	sp->init_data = (struct cdns_sierra_data *)match->data;
> +
> +	platform_set_drvdata(pdev, sp);
> +
> +	sp->clk = devm_clk_get(dev, "phy_clk");
> +	if (IS_ERR(sp->clk)) {
> +		dev_err(dev, "failed to get clock phy_clk\n");
> +		return PTR_ERR(sp->clk);
> +	}
> +
> +	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
> +	if (IS_ERR(sp->phy_rst)) {
> +		dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(sp->phy_rst);
> +	}
> +
> +	sp->apb_rst = devm_reset_control_get(dev, "sierra_apb");
> +	if (IS_ERR(sp->apb_rst)) {
> +		dev_err(dev, "failed to get apb reset\n");
> +		return PTR_ERR(sp->apb_rst);
> +	}
> +
> +	ret = clk_prepare_enable(sp->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable APB */
> +	reset_control_deassert(sp->apb_rst);
> +
> +	/* Check that PHY is present */
> +	if  (sp->init_data->id_value != readl(sp->base)) {
> +		goto clk_disable;
> +		return -EINVAL;
> +	}
> +
> +	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
> +
> +	for_each_available_child_of_node(dn, child) {
> +		struct phy *gphy;
> +
> +		if (IS_ERR(sp->phys[node].lnk_rst)) {
> +			dev_err(dev, "failed to get reset %s\n", child->name);
> +			return PTR_ERR(sp->phys[node].lnk_rst);
> +		}
> +		sp->phys[node].lnk_rst =
> +				devm_reset_control_get(dev, child->name);
> +
> +		if (!sp->autoconf) {
> +			ret = cdns_sierra_get_optional(&sp->phys[node], child);
> +			if (ret) {
> +				dev_err(dev, "missing property in node %s\n",
> +					child->name);
> +				goto put_child;
> +			}
> +		}
> +
> +		gphy = devm_phy_create(dev, child, &ops);
> +
> +		if (IS_ERR(gphy)) {
> +			ret = PTR_ERR(gphy);
> +			goto put_child;
> +		}
> +		sp->phys[node].phy = gphy;
> +		phy_set_drvdata(gphy, &sp->phys[node]);
> +
> +		/* Initialise the PHY registers, unless auto configured */
> +		if (!sp->autoconf)
> +			cdns_sierra_phy_init(gphy);
> +
> +		node++;
> +	}
> +
> +	/* If more than one subnode, configure the PHY as multilink */
> +	if (!sp->autoconf && of_get_child_count(dn) > 1)
> +		writel(2, sp->base + SIERRA_PHY_PLL_CFG);
> +
> +	pm_runtime_enable(dev);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	reset_control_deassert(sp->phy_rst);
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +put_child:
> +	of_node_put(child);
> +clk_disable:
> +	clk_disable_unprepare(sp->clk);
> +	reset_control_assert(sp->apb_rst);
> +	return ret;
> +}
> +
> +static int cdns_sierra_phy_remove(struct platform_device *pdev)
> +{
> +	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
> +
> +	reset_control_assert(phy->phy_rst);
> +	reset_control_assert(phy->apb_rst);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct cdns_reg_pairs cdns_usb_regs[] = {
> +	/*
> +	 * Write USB configuration parameters to the PHY.
> +	 * These values are specific to this specific hardware
> +	 * configuration.

Your intention is to have different arrays for different hardware configurations?
> +	 */
> +	{0xFE0A, SIERRA_DET_STANDEC_A},
> +	{0x000F, SIERRA_DET_STANDEC_B},
> +	{0x55A5, SIERRA_DET_STANDEC_C},
> +	{0x69AD, SIERRA_DET_STANDEC_D},
> +	{0x0241, SIERRA_DET_STANDEC_E},
> +	{0x0110, SIERRA_PSM_LANECAL},
> +	{0xCF00, SIERRA_PSM_DIAG},
> +	{0x001F, SIERRA_PSC_TX_A0},
> +	{0x0007, SIERRA_PSC_TX_A1},
> +	{0x0003, SIERRA_PSC_TX_A2},
> +	{0x0003, SIERRA_PSC_TX_A3},
> +	{0x0FFF, SIERRA_PSC_RX_A0},
> +	{0x0003, SIERRA_PSC_RX_A1},
> +	{0x0003, SIERRA_PSC_RX_A2},
> +	{0x0001, SIERRA_PSC_RX_A3},
> +	{0x0001, SIERRA_PLLCTRL_SUBRATE},
> +	{0x0406, SIERRA_PLLCTRL_GEN_D},
> +	{0x0000, SIERRA_DRVCTRL_ATTEN},
> +	{0x823E, SIERRA_CLKPATHCTRL_TMR},
> +	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1},
> +	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0},
> +	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01},
> +	{0x023C, SIERRA_RX_CTLE_MAINTENANCE},
> +	{0x3232, SIERRA_CREQ_FSMCLK_SEL},
> +	{0x8452, SIERRA_CTLELUT_CTRL},
> +	{0x4121, SIERRA_DFE_ECMP_RATESEL},
> +	{0x4121, SIERRA_DFE_SMP_RATESEL},
> +	{0x9999, SIERRA_DEQ_VGATUNE_CTRL},
> +	{0x0330, SIERRA_TMRVAL_MODE0},
> +	{0x01FF, SIERRA_PICNT_MODE1},
> +	{0x0009, SIERRA_CPI_OUTBUF_RATESEL},
> +	{0x000F, SIERRA_LFPSFILT_NS},
> +	{0x0009, SIERRA_LFPSFILT_RD},
> +	{0x0001, SIERRA_LFPSFILT_MP},
> +	{0x8013, SIERRA_SDFILT_H2L_A},
> +	{0x0400, SIERRA_TMRVAL_MODE1},

Are all of them 16 bit value fields? Or some of them coalesced to form 16 bit
values?

Thanks
Kishon
