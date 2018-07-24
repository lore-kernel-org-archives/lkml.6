Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBE420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mJTa5/Hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBE420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeGXFBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:01:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60532 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGXFBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:01:23 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6O3ufTu129533;
        Mon, 23 Jul 2018 22:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532404601;
        bh=TQMjGh1xVLX04xvGwelsKF83cfOWC6wKER81LNIuqeQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mJTa5/HwGwd2gSebjbCxgF5/ASACLoCt4sFFodZf8liHuKd+lQY+KvN2UtYBI0u6O
         mf9iimTd33111eHNzQ12eIxwhjoPoKDoTYf+eaBhKukxRD1v+WVTpvMWP+hNeYHboR
         LsEfT9jUddJ3txU9x2DSUoXHKA8ZpNL4Z8JSp+LU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6O3ufYc001236;
        Mon, 23 Jul 2018 22:56:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 23
 Jul 2018 22:56:41 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 23 Jul 2018 22:56:41 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6O3uc0A026991;
        Mon, 23 Jul 2018 22:56:39 -0500
Subject: Re: [PATCH v2] phy: Add driver for Cadence MHDP DisplayPort SD0801
 PHY
To:     Scott Telford <stelford@cadence.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dkos@cadence.com>
References: <201807191323.JVEjlMdZ%fengguang.wu@intel.com>
 <1532090477-15559-1-git-send-email-stelford@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
Date:   Tue, 24 Jul 2018 09:26:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1532090477-15559-1-git-send-email-stelford@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 20 July 2018 06:11 PM, Scott Telford wrote:
> Add driver for the Cadence SD0801 "Torrent" PHY used with the Cadence MHDP
> DisplayPort Tx controller.
> 
> Integration with the MHDP driver will be the subject of another commit.
> 
> Signed-off-by: Scott Telford <stelford@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-dp.txt     |  28 ++
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/cadence/Kconfig                        |  10 +
>  drivers/phy/cadence/Makefile                       |   1 +
>  drivers/phy/cadence/phy-cadence-dp.c               | 436 +++++++++++++++++++++
>  drivers/phy/cadence/phy-cadence-dp.h               | 117 ++++++
>  7 files changed, 594 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>  create mode 100644 drivers/phy/cadence/Kconfig
>  create mode 100644 drivers/phy/cadence/Makefile
>  create mode 100644 drivers/phy/cadence/phy-cadence-dp.c
>  create mode 100644 drivers/phy/cadence/phy-cadence-dp.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> new file mode 100644
> index 0000000..8de0526
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> @@ -0,0 +1,28 @@
> +Cadence MHDP DisplayPort SD0801 PHY binding
> +===========================================
> +
> +This binding describes the Cadence SD0801 PHY hardware included with
> +the Cadence MHDP DisplayPort controller.
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible	: Should be "cdns,dp-phy"
> +- reg		: Defines the following sets of registers in the parent
> +		  mhdp device:
> +			- Offset of the DPTX PHY configuration registers
> +			- Offset of the SD0801 PHY configuration registers
> +- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
> +- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
> +		  2430, 2700, 3240, 4320, 5400 or 8100)
> +- #phy-cells	: from the generic PHY bindings, must be 0.
> +-------------------------------------------------------------------------------
> +
> +Example:
> +	dp_phy: phy@f0fb030a00 {
> +		compatible = "cdns,dp-phy";
> +		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
> +		      <0xf0 0xfb500000 0x0 0x00100000>;
> +		num_lanes = <4>;
> +		max_bit_rate = <8100>;
> +		#phy-cells = <0>;
> +	};

dt bindings should be a separate patch
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
> index 0000000..57fff7d
> --- /dev/null
> +++ b/drivers/phy/cadence/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# Phy driver for Cadence MHDP DisplayPort controller
> +#
> +config PHY_CADENCE_DP
> +	tristate "Cadence MHDP DisplayPort PHY driver"
> +	depends on OF
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Support for Cadence MHDP DisplayPort PHY.
> diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> new file mode 100644
> index 0000000..e5b0a11
> --- /dev/null
> +++ b/drivers/phy/cadence/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
> diff --git a/drivers/phy/cadence/phy-cadence-dp.c b/drivers/phy/cadence/phy-cadence-dp.c
> new file mode 100644
> index 0000000..c1cf89b
> --- /dev/null
> +++ b/drivers/phy/cadence/phy-cadence-dp.c
> @@ -0,0 +1,436 @@
> +/*
> + * Cadence MHDP DisplayPort SD0801 PHY driver.
> + *
> + * Copyright 2018 Cadence Design Systems, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-only
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include "phy-cadence-dp.h"

If phy-cadence-dp.h is not going to be used in multiple files, then all the
definitions should be added here and the .h can removed.
> +
> +
> +static const struct phy_ops cdns_dp_phy_ops = {
> +	.init		= cdns_dp_phy_init,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct of_device_id cdns_dp_phy_of_match[] = {
> +	{
> +		.compatible = "cdns,dp-phy"
> +	},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, cdns_dp_phy_of_match);
> +
> +static int cdns_dp_phy_probe(struct platform_device *pdev)

The file organization is slightly different. Can we follow what other drivers
do by having the probe in the bottom of the file and other functions above that?
> +{
> +	struct resource *regs;
> +	struct cdns_dp_phy *cdns_phy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	struct phy *phy;
> +	int err;
> +
> +	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
> +	if (!cdns_phy)
> +		return -ENOMEM;
> +
> +	cdns_phy->dev = &pdev->dev;
> +
> +	phy = devm_phy_create(dev, NULL, &cdns_dp_phy_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create DisplayPort PHY\n");
> +		return PTR_ERR(phy);
> +	}
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(cdns_phy->base))
> +		return PTR_ERR(cdns_phy->base);
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(cdns_phy->sd_base))
> +		return PTR_ERR(cdns_phy->sd_base);
> +
> +	err = device_property_read_u32(dev, "num_lanes",
> +				       &(cdns_phy->num_lanes));
> +	if (err)
> +		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
> +
> +	switch (cdns_phy->num_lanes) {
> +	case 1:
> +	case 2:
> +	case 4:
> +		/* valid number of lanes */
> +		break;
> +	default:
> +		dev_err(dev, "unsupported number of lanes: %d\n",
> +			cdns_phy->num_lanes);
> +		return -EINVAL;
> +	}
> +
> +	err = device_property_read_u32(dev, "max_bit_rate",
> +		   &(cdns_phy->max_bit_rate));
> +	if (err)
> +		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
> +
> +	switch (cdns_phy->max_bit_rate) {
> +	case 2160:
> +	case 2430:
> +	case 2700:
> +	case 3240:
> +	case 4320:
> +	case 5400:
> +	case 8100:
> +		/* valid bit rate */
> +		break;
> +	default:
> +		dev_err(dev, "unsupported max bit rate: %dMbps\n",
> +			cdns_phy->max_bit_rate);
> +		return -EINVAL;
> +	}
> +
> +	phy_set_drvdata(phy, cdns_phy);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
> +		 cdns_phy->num_lanes,
> +		 cdns_phy->max_bit_rate / 1000,
> +		 cdns_phy->max_bit_rate % 1000);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +
> +static int cdns_dp_phy_init(struct phy *phy)
> +{
> +	unsigned char lane_bits;
> +
> +	struct cdns_dp_phy *cdns_phy = phy_get_drvdata(phy);
> +
> +	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
> +
> +	/* PHY PMA registers configuration function */
> +	cdns_dp_phy_pma_cfg(cdns_phy);
> +
> +	/* Set lines power state to A0
> +	 * Set lines pll clk enable to 0
> +	 */
> +
> +	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ,
> +				PHY_POWER_STATE_LN_0, 6, 0x0000);
> +
> +	if (cdns_phy->num_lanes >= 2) {
> +		cdns_dp_phy_write_field(cdns_phy,
> +					PHY_PMA_XCVR_POWER_STATE_REQ,
> +					PHY_POWER_STATE_LN_1, 6, 0x0000);
> +
> +		if (cdns_phy->num_lanes == 4) {
> +			cdns_dp_phy_write_field(cdns_phy,
> +						PHY_PMA_XCVR_POWER_STATE_REQ,
> +						PHY_POWER_STATE_LN_2, 6, 0);
> +			cdns_dp_phy_write_field(cdns_phy,
> +						PHY_PMA_XCVR_POWER_STATE_REQ,
> +						PHY_POWER_STATE_LN_3, 6, 0);
> +		}
> +	}
> +
> +	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
> +				0, 1, 0x0000);
> +
> +	if (cdns_phy->num_lanes >= 2) {
> +		cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
> +					1, 1, 0x0000);
> +		if (cdns_phy->num_lanes == 4) {
> +			cdns_dp_phy_write_field(cdns_phy,
> +						PHY_PMA_XCVR_PLLCLK_EN,
> +						2, 1, 0x0000);
> +			cdns_dp_phy_write_field(cdns_phy,
> +						PHY_PMA_XCVR_PLLCLK_EN,
> +						3, 1, 0x0000);
> +		}
> +	}
> +
> +	/* release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
> +	 * used lanes
> +	 */
> +	lane_bits = (1 << cdns_phy->num_lanes) - 1;
> +	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
> +		   cdns_phy->base + PHY_RESET);
> +
> +	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
> +	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
> +
> +	/* PHY PMA registers configuration functions */
> +	cdns_dp_phy_pma_cmn_vco_cfg_25mhz(cdns_phy);
> +	cdns_dp_phy_pma_cmn_rate(cdns_phy);
> +
> +	/* take out of reset */
> +	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
> +	cdns_dp_phy_wait_pma_cmn_ready(cdns_phy);
> +	cdns_dp_phy_run(cdns_phy);
> +
> +	return 0;
> +}
> +
> +static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_CMN_READY, reg,
> +				 reg & 1, 0, 500);
> +	if (ret == -ETIMEDOUT)
> +		dev_err(cdns_phy->dev,
> +			"timeout waiting for PMA common ready\n");
> +}
> +
> +static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy)
> +{
> +	unsigned int i;
> +
> +	/* PMA common configuration */
> +	cdns_dp_phy_pma_cmn_cfg_25mhz(cdns_phy);
> +
> +	/* PMA lane configuration to deal with multi-link operation */
> +	for (i = 0; i < cdns_phy->num_lanes; i++)
> +		cdns_dp_phy_pma_lane_cfg(cdns_phy, i);
> +}
> +
> +static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
> +{
> +	/* refclock registers - assumes 25 MHz refclock */
> +	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
> +	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
> +	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
> +	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
> +	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
> +	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
> +	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
> +	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
> +	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
> +	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
> +	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
> +	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
> +	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
> +	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
> +	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
> +	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
> +	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
> +	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
> +	/* PLL registers */
> +	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
> +	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
> +	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
> +	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
> +	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
> +	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
> +	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
> +	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
> +	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);

Are these values that are written just calibration data or are they bitfields
for a specific setting. If they are not calibration data, then macros should be
added.
> +}
> +
> +static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
> +{
> +	/* Assumes 25 MHz refclock */
> +	switch (cdns_phy->max_bit_rate) {
> +		/* Setting VCO for 10.8GHz */
> +	case 2700:
> +	case 5400:
> +		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
> +		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
> +		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
> +		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
> +		break;
> +		/* Setting VCO for 9.72GHz */
> +	case 2430:
> +	case 3240:
> +		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
> +		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
> +		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
> +		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
> +		break;
> +		/* Setting VCO for 8.64GHz */
> +	case 2160:
> +	case 4320:
> +		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
> +		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
> +		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
> +		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
> +		break;
> +		/* Setting VCO for 8.1GHz */
> +	case 8100:
> +		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
> +		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
> +		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
> +		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
> +		break;
> +	}
> +
> +	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
> +	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);

same for this function also.
> +}
> +
> +static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
> +{
> +	unsigned int clk_sel_val = 0;
> +	unsigned int hsclk_div_val = 0;
> +	unsigned int i;
> +
> +	/* 16'h0000 for single DP link configuration */
> +	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
> +
> +	switch (cdns_phy->max_bit_rate) {
> +	case 1620:
> +		clk_sel_val = 0x0f01;
> +		hsclk_div_val = 2;
> +		break;
> +	case 2160:
> +	case 2430:
> +	case 2700:
> +		clk_sel_val = 0x0701;
> +		 hsclk_div_val = 1;
> +		break;
> +	case 3240:
> +		clk_sel_val = 0x0b00;
> +		hsclk_div_val = 2;
> +		break;
> +	case 4320:
> +	case 5400:
> +		clk_sel_val = 0x0301;
> +		hsclk_div_val = 0;
> +		break;
> +	case 8100:
> +		clk_sel_val = 0x0200;
> +		hsclk_div_val = 0;
> +		break;
> +	}
> +
> +	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
> +
> +	/* PMA lane configuration to deal with multi-link operation */
> +	for (i = 0; i < cdns_phy->num_lanes; i++) {
> +		writel(hsclk_div_val,
> +		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i<<11)));
> +	}
> +}
> +
> +static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
> +				     unsigned int lane)
> +{
> +	unsigned int i;
> +
> +	i = 0x0007 & lane;

macro for mask has to be added.

Thanks
Kishon
