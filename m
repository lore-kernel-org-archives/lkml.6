Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EhrPrHS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbfAPIIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:08:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45702 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfAPIIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:08:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G88ASH091281;
        Wed, 16 Jan 2019 02:08:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547626090;
        bh=/wyltN0U1eJUDXAwqVBkc8jcGljurEHhYypTiPZurFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EhrPrHS8DsWS4jh8GGzRTOlX5p4ZWoa7x3BJhq9sHFVTh2PtmHTNR7R/Ll8+9gTHc
         Jl8akJF/Y8xnvDBS0afl0spqSrDwHCLF8Jujazcc3KbEIgOh1/b1nPb0oK2pSLq/3E
         h37W1Gg49An4wctHUn2yDlVzWY+LA0KjRXIzgt4o=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G88A5P040282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 02:08:10 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:08:09 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:08:09 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8866E008832;
        Wed, 16 Jan 2019 02:08:06 -0600
Subject: Re: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <vivek.gautam@codeaurora.org>
CC:     Michal Simek <michals@xilinx.com>, <v.anuragkumar@gmail.com>,
        sundeep subbaraya <sundeep.lkml@gmail.com>,
        <apandey@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1545140733-20689-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
Date:   Wed, 16 Jan 2019 13:37:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545140733-20689-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/12/18 7:15 PM, Anurag Kumar Vulisha wrote:
> ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high speed
> peripherals such as USB, SATA, PCIE, Display Port and Ethernet SGMII can
> rely on any of the four GT lanes for PHY layer. This patch adds driver
> for that ZynqMP GT core.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
> Changes in v5:
> 	1. No functional changes. Added missing Author name
> 
> Changes in v4:
> 	1. Moved include/dt-bindings/phy/phy.h into patch 1 as suggested by
> 	   "Rob Herring"
> 
> Changes in v3:
> 	1. Corrected the Documentation as suggested by "Vivek Gautam"
> 
> Changes in v2:
> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
> ---
>  drivers/phy/Kconfig            |    8 +
>  drivers/phy/Makefile           |    1 +
>  drivers/phy/phy-zynqmp.c       | 1582 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy-zynqmp.h |   52 ++
>  4 files changed, 1643 insertions(+)
>  create mode 100644 drivers/phy/phy-zynqmp.c
>  create mode 100644 include/linux/phy/phy-zynqmp.h
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 60f949e..7a3c900 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -40,6 +40,14 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>  
> +config PHY_XILINX_ZYNQMP
> +	tristate "Xilinx ZynqMP PHY driver"
> +	depends on ARCH_ZYNQMP
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support ZynqMP High Speed Gigabit Transceiver
> +	  that is part of ZynqMP SoC.
> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 0301e25..2335e85 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> +obj-$(CONFIG_PHY_XILINX_ZYNQMP)		+= phy-zynqmp.o
>  obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
>  obj-$(CONFIG_ARCH_MESON)		+= amlogic/
>  obj-$(CONFIG_LANTIQ)			+= lantiq/
> diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
> new file mode 100644
> index 0000000..5caf4f2
> --- /dev/null
> +++ b/drivers/phy/phy-zynqmp.c
> @@ -0,0 +1,1582 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * phy-zynqmp.c - PHY driver for Xilinx ZynqMP GT.
> + *
> + * Copyright (C) 2018 Xilinx Inc.
> + *
> + * Author: Anurag Kumar Vulisha <anuragku@xilinx.com>
> + * Author: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> + *
> + * This driver is tested for USB, SATA and Display Port currently.
> + * Other controllers PCIe and SGMII should also work but that is
> + * experimental as of now.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/phy-zynqmp.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/reset.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +
> +/* Inter Connect Matrix parameters */
> +#define ICM_CFG0			0x10010
> +#define ICM_CFG1			0x10014
> +#define ICM_CFG0_L0_MASK		0x07
> +#define ICM_CFG0_L1_MASK		0x70
> +#define ICM_CFG1_L2_MASK		0x07
> +#define ICM_CFG2_L3_MASK		0x70
> +#define ICM_CFG_SHIFT			4
> +
> +/* Inter Connect Matrix allowed protocols */
> +#define ICM_PROTOCOL_PD			0x0
> +#define ICM_PROTOCOL_PCIE		0x1
> +#define ICM_PROTOCOL_SATA		0x2
> +#define ICM_PROTOCOL_USB		0x3
> +#define ICM_PROTOCOL_DP			0x4
> +#define ICM_PROTOCOL_SGMII		0x5
> +
> +/* Test Mode common reset control  parameters */
> +#define TM_CMN_RST			0x10018
> +#define TM_CMN_RST_EN			0x1
> +#define TM_CMN_RST_SET			0x2
> +#define TM_CMN_RST_MASK			0x3
> +
> +/* Refclk selection parameters */
> +#define PLL_REF_SEL0			0x10000
> +#define PLL_REF_OFFSET			0x4
> +#define PLL_FREQ_MASK			0x1F
> +#define PLL_STATUS_READ_OFFSET		0x4000
> +#define PLL_STATUS_LOCKED		0x10
> +
> +/* PLL SSC step size offsets */
> +#define L0_L0_REF_CLK_SEL		0x2860
> +#define L0_PLL_SS_STEPS_0_LSB		0x2368
> +#define L0_PLL_SS_STEPS_1_MSB		0x236C
> +#define L0_PLL_SS_STEP_SIZE_0_LSB	0x2370
> +#define L0_PLL_SS_STEP_SIZE_1		0x2374
> +#define L0_PLL_SS_STEP_SIZE_2		0x2378
> +#define L0_PLL_SS_STEP_SIZE_3_MSB	0x237C
> +#define L0_PLL_STATUS_READ_1		0x23E4
> +
> +/* SSC step size parameters */
> +#define STEP_SIZE_OFFSET		0x4000
> +#define STEP_SIZE_0_MASK		0xFF
> +#define STEP_SIZE_1_MASK		0xFF
> +#define STEP_SIZE_2_MASK		0xFF
> +#define STEP_SIZE_3_MASK		0x3
> +#define STEP_SIZE_SHIFT			8
> +#define FORCE_STEP_SIZE			0x10
> +#define FORCE_STEPS			0x20
> +#define STEPS_OFFSET			0x4000
> +#define STEPS_0_MASK			0xFF
> +#define STEPS_1_MASK			0x07
> +
> +/* BG calibration parameters */
> +#define BGCAL_REF_SEL			0x10028
> +#define BGCAL_REF_VALUE			0x0C
> +
> +/* Calibration digital logic parameters */
> +#define L3_TM_CALIB_DIG19		0xEC4C
> +#define L3_CALIB_DONE_STATUS		0xEF14
> +#define L3_TM_CALIB_DIG18		0xEC48
> +#define L3_TM_CALIB_DIG19_NSW		0x07
> +#define L3_TM_CALIB_DIG18_NSW		0xE0
> +#define L3_TM_OVERRIDE_NSW_CODE         0x20
> +#define L3_CALIB_DONE			0x02
> +#define L3_NSW_SHIFT			5
> +#define L3_NSW_PIPE_SHIFT		4
> +#define L3_NSW_CALIB_SHIFT		3
> +
> +/* DN Resistor calibration code parameters */
> +#define L0_TXPMA_ST_3			0x0B0C
> +#define L0_DN_CALIB_CODE		0x3F
> +
> +/* PLL Test Mode register parameters */
> +#define L0_TM_PLL_DIG_37		0x2094
> +#define L0_TM_PLL_DIG_37_OFFSET		0x4000
> +#define L0_TM_COARSE_CODE_LIMIT		0x10
> +
> +/* PCS control parameters */
> +#define L0_TM_DIG_6			0x106C
> +#define L0_TX_DIG_61			0x00F4
> +#define L0_TM_DIG_6_OFFSET		0x4000
> +#define L0_TX_DIG_61_OFFSET		0x4000
> +#define L0_TM_DIS_DESCRAMBLE_DECODER	0x0F
> +#define L0_TM_DISABLE_SCRAMBLE_ENCODER	0x0F
> +
> +/* TX De-emphasis parameters */
> +#define L0_TX_ANA_TM_18			0x0048
> +#define L0_TX_ANA_TM_118		0x01D8
> +#define L0_TX_ANA_TM_18_OFFSET		0x4000
> +#define L0_TX_ANA_TM_118_OFFSET		0x4000
> +#define L0_TX_ANA_TM_118_FORCE_17_0	BIT(0)
> +
> +/* PMA control parameters */
> +#define L0_TXPMD_TM_45			0x0CB4
> +#define L0_TXPMD_TM_48			0x0CC0
> +#define L0_TXPMD_TM_45_OFFSET		0x4000
> +#define L0_TXPMD_TM_48_OFFSET		0x4000
> +#define L0_TXPMD_TM_45_OVER_DP_MAIN	BIT(0)
> +#define L0_TXPMD_TM_45_ENABLE_DP_MAIN	BIT(1)
> +#define L0_TXPMD_TM_45_OVER_DP_POST1	BIT(2)
> +#define L0_TXPMD_TM_45_ENABLE_DP_POST1	BIT(3)
> +#define L0_TXPMD_TM_45_OVER_DP_POST2	BIT(4)
> +#define L0_TXPMD_TM_45_ENABLE_DP_POST2	BIT(5)
> +
> +/* Bus width parameters */
> +#define TX_PROT_BUS_WIDTH		0x10040
> +#define RX_PROT_BUS_WIDTH		0x10044
> +#define PROT_BUS_WIDTH_10		0x0
> +#define PROT_BUS_WIDTH_20		0x1
> +#define PROT_BUS_WIDTH_40		0x2
> +#define PROT_BUS_WIDTH_SHIFT		2
> +
> +/* Max number of GT lanes */
> +#define MAX_LANES			4
> +
> +/* Max Allowed refclk frequencies */
> +#define MAX_REFCLK			13
> +
> +/* Lane CLK sharing mask */
> +#define LANE_CLK_SHARE_MASK		0x8F
> +
> +/* SIOU SATA control register */
> +#define SATA_CONTROL_OFFSET		0x0100
> +
> +/* Total number of controllers */
> +#define CONTROLLERS_PER_LANE		5
> +
> +/* USB pipe control parameters */
> +#define PIPE_CLK_OFFSET			0x7c
> +#define PIPE_POWER_OFFSET		0x80
> +#define PIPE_CLK_ON			1
> +#define PIPE_CLK_OFF			0
> +#define PIPE_POWER_ON			1
> +#define PIPE_POWER_OFF			0
> +
> +/* Protocol Type Pparameters */
> +#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
> +#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
> +#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
> +#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
> +#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
> +#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
> +#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
> +#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
> +#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
> +#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
> +#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
> +#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
> +#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
> +#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
> +
> +/* Timeout values */
> +#define RST_TIMEOUT_MS			1000
> +#define TIMEOUT_US			1000
> +
> +/*
> + * This table holds the valid combinations of controllers and
> + * lanes(Interconnect Matrix).
> + */
> +static unsigned int icm_matrix[MAX_LANES][CONTROLLERS_PER_LANE] = {
> +	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
> +		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
> +	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
> +		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
> +	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
> +		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
> +	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
> +		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
> +};
> +
> +/* Allowed PLL reference clock frequencies */
> +enum pll_frequencies {
> +	REF_19_2M = 0,
> +	REF_20M,
> +	REF_24M,
> +	REF_26M,
> +	REF_27M,
> +	REF_38_4M,
> +	REF_40M,
> +	REF_52M,
> +	REF_100M,
> +	REF_108M,
> +	REF_125M,
> +	REF_135M,
> +	REF_150M,
> +};
> +
> +/**
> + * struct xpsgtr_phy - representation of a lane
> + * @phy: pointer to the kernel PHY device
> + * @type: controller which uses this lane
> + * @lane: lane number
> + * @protocol: protocol in which the lane operates
> + * @ref_clk: enum of allowed ref clock rates for this lane PLL
> + * @pll_lock: PLL status
> + * @skip_phy_init: skip phy_init() if true
> + * @data: pointer to hold private data
> + * @refclk_rate: PLL reference clock frequency
> + * @share_laneclk: lane number of the clock to be shared
> + */
> +struct xpsgtr_phy {
> +	struct phy *phy;
> +	u8 type;
> +	u8 lane;
> +	u8 protocol;
> +	enum pll_frequencies ref_clk;
> +	bool pll_lock;
> +	bool skip_phy_init;
> +	void *data;
> +	u32 refclk_rate;
> +	u32 share_laneclk;
> +};
> +
> +/**
> + * struct xpsgtr_ssc - structure to hold SSC settings for a lane
> + * @refclk_rate: PLL reference clock frequency
> + * @pll_ref_clk: value to be written to register for corresponding ref clk rate
> + * @steps: number of steps of SSC (Spread Spectrum Clock)
> + * @step_size: step size of each step
> + */
> +struct xpsgtr_ssc {
> +	u32 refclk_rate;
> +	u8  pll_ref_clk;
> +	u32 steps;
> +	u32 step_size;
> +};
> +
> +/* lookup table to hold all settings needed for a ref clock frequency */
> +static struct xpsgtr_ssc ssc_lookup[MAX_REFCLK] = {
> +	{19200000, 0x05, 608, 264020},
> +	{20000000, 0x06, 634, 243454},
> +	{24000000, 0x07, 760, 168973},
> +	{26000000, 0x08, 824, 143860},
> +	{27000000, 0x09, 856, 86551},
> +	{38400000, 0x0A, 1218, 65896},
> +	{40000000, 0x0B, 634, 243454},
> +	{52000000, 0x0C, 824, 143860},
> +	{100000000, 0x0D, 1058, 87533},
> +	{108000000, 0x0E, 856, 86551},
> +	{125000000, 0x0F, 992, 119497},
> +	{135000000, 0x10, 1070, 55393},
> +	{150000000, 0x11, 792, 187091}
> +};
> +
> +/**
> + * struct xpsgtr_dev - representation of a ZynMP GT device
> + * @dev: pointer to device
> + * @serdes: serdes base address
> + * @siou: siou base address
> + * @gtr_mutex: mutex for locking
> + * @phys: pointer to all the lanes
> + * @tx_term_fix: fix for GT issue
> + * @saved_icm_cfg0: stored value of ICM CFG0 register
> + * @saved_icm_cfg1: stored value of ICM CFG1 register
> + * @sata_rst: a reset control for SATA
> + * @dp_rst: a reset control for DP
> + * @usb0_crst: a reset control for usb0 core
> + * @usb1_crst: a reset control for usb1 core
> + * @usb0_hibrst: a reset control for usb0 hibernation module
> + * @usb1_hibrst: a reset control for usb1 hibernation module
> + * @usb0_apbrst: a reset control for usb0 apb bus
> + * @usb1_apbrst: a reset control for usb1 apb bus
> + * @gem0_rst: a reset control for gem0
> + * @gem1_rst: a reset control for gem1
> + * @gem2_rst: a reset control for gem2
> + * @gem3_rst: a reset control for gem3
> + */
> +struct xpsgtr_dev {
> +	struct device *dev;
> +	void __iomem *serdes;
> +	void __iomem *siou;
> +	struct mutex gtr_mutex; /* mutex for locking */
> +	struct xpsgtr_phy **phys;
> +	bool tx_term_fix;
> +	unsigned int saved_icm_cfg0;
> +	unsigned int saved_icm_cfg1;
> +	struct reset_control *sata_rst;
> +	struct reset_control *dp_rst;
> +	struct reset_control *usb0_crst;
> +	struct reset_control *usb1_crst;
> +	struct reset_control *usb0_hibrst;
> +	struct reset_control *usb1_hibrst;
> +	struct reset_control *usb0_apbrst;
> +	struct reset_control *usb1_apbrst;
> +	struct reset_control *gem0_rst;
> +	struct reset_control *gem1_rst;
> +	struct reset_control *gem2_rst;
> +	struct reset_control *gem3_rst;
> +};
> +
> +/**
> + * xpsgtr_override_deemph - override PIPE TX de-emphasis
> + * @phy: pointer to phy
> + * @plvl: pre-emphasis level
> + * @vlvl: voltage swing level
> + *
> + * Return: None
> + */
> +void xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl)
> +{
> +	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
> +	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
> +	static u8 pe[4][4] = { { 0x2, 0x2, 0x2, 0x2 },
> +			       { 0x1, 0x1, 0x1, 0xFF },
> +			       { 0x0, 0x0, 0xFF, 0xFF },
> +			       { 0xFF, 0xFF, 0xFF, 0xFF } };
> +
> +	writel(pe[plvl][vlvl],
> +	       gtr_dev->serdes + gtr_phy->lane * L0_TX_ANA_TM_18_OFFSET +
> +	       L0_TX_ANA_TM_18);
> +}
> +EXPORT_SYMBOL_GPL(xpsgtr_override_deemph);

I thought I gave a feedback to get rid of export symbol. This will make the
consumer driver tied to this PHY driver.

Thanks
Kishon
