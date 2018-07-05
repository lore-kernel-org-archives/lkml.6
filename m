Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC29C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4421624052
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RWO3hq5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4421624052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeGELkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:40:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbeGELkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:40:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w65BdvjA062405;
        Thu, 5 Jul 2018 06:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530790797;
        bh=CGYeW54JCNJVqAX1PmEzq9rQ4SO2qKPbp6C79XokJvE=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=RWO3hq5k5g2oBy1SXOE4iLpqbp8wGLcDdBqj/ZB37boKX8QxGAnMAffBU4p/TJ1Mk
         bOo7JZNrWDEc3etfbGwmIVzF0clVbHYgFkZ9AFRbXaFURMX6To1CcKQqIrbXQYba2B
         INWRmhE/4PhRqV1znACN1W9IlzkEepnaOozZ4t3Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65BdvBA013008;
        Thu, 5 Jul 2018 06:39:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 5 Jul
 2018 06:39:57 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 5 Jul 2018 06:39:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65BdrN5025048;
        Thu, 5 Jul 2018 06:39:55 -0500
Subject: Re: [PATCH v3 2/2] phy: bcm-sr-pcie: Add Stingray PCIe PHY driver
To:     Ray Jui <ray.jui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1530728533-28770-1-git-send-email-ray.jui@broadcom.com>
 <1530728533-28770-3-git-send-email-ray.jui@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b6b9afb5-4644-537d-92b0-1d1e7ea1b026@ti.com>
Date:   Thu, 5 Jul 2018 17:09:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1530728533-28770-3-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 04 July 2018 11:52 PM, Ray Jui wrote:
> Add Stingray PCIe PHY driver for both PAXB and PAXC root complex
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/phy/broadcom/Kconfig           |  10 +
>  drivers/phy/broadcom/Makefile          |   2 +
>  drivers/phy/broadcom/phy-bcm-sr-pcie.c | 327 +++++++++++++++++++++++++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c
> 
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index 97d27b0d5..8786a96 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -80,3 +80,13 @@ config PHY_BRCM_USB
>  	  This driver is required by the USB XHCI, EHCI and OHCI
>  	  drivers.
>  	  If unsure, say N.
> +
> +config PHY_BCM_SR_PCIE
> +	tristate "Broadcom Stingray PCIe PHY driver"
> +	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	default ARCH_BCM_IPROC
> +	help
> +	  Enable this to support the Broadcom Stingray PCIe PHY
> +	  If unsure, say N.
> diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
> index 13e000c..0f60184 100644
> --- a/drivers/phy/broadcom/Makefile
> +++ b/drivers/phy/broadcom/Makefile
> @@ -9,3 +9,5 @@ obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
>  obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
>  
>  phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
> +
> +obj-$(CONFIG_PHY_BCM_SR_PCIE)		+= phy-bcm-sr-pcie.o
> diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
> new file mode 100644
> index 0000000..ff15dae
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016-2018 Broadcom
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/* we have up to 8 PAXB based RC. The 9th one is always PAXC */
> +#define SR_NR_PCIE_PHYS               9
> +#define SR_PAXC_PHY_IDX               (SR_NR_PCIE_PHYS - 1)
> +
> +#define PCIE_PIPEMUX_CFG_OFFSET       0x10c
> +#define PCIE_PIPEMUX_SELECT_STRAP     0xf
> +
> +#define CDRU_STRAP_DATA_LSW_OFFSET    0x5c
> +#define PCIE_PIPEMUX_SHIFT            19
> +#define PCIE_PIPEMUX_MASK             0xf
> +
> +#define MHB_MEM_PW_PAXC_OFFSET        0x1c0
> +#define MHB_PWR_ARR_POWERON           0x8
> +#define MHB_PWR_ARR_POWEROK           0x4
> +#define MHB_PWR_POWERON               0x2
> +#define MHB_PWR_POWEROK               0x1
> +#define MHB_PWR_STATUS_MASK           (MHB_PWR_ARR_POWERON | \
> +				       MHB_PWR_ARR_POWEROK | \
> +				       MHB_PWR_POWERON | \
> +				       MHB_PWR_POWEROK)
> +
> +struct sr_pcie_phy_core;
> +
> +/**
> + * struct sr_pcie_phy - Stingray PCIe PHY
> + *
> + * @core: pointer to the Stingray PCIe PHY core control
> + * @index: PHY index
> + * @phy: pointer to the kernel PHY device
> + */
> +struct sr_pcie_phy {
> +	struct sr_pcie_phy_core *core;
> +	unsigned int index;
> +	struct phy *phy;
> +};
> +
> +/**
> + * struct sr_pcie_phy_core - Stingray PCIe PHY core control
> + *
> + * @dev: pointer to device
> + * @base: base register of PCIe SS
> + * @cdru: regmap to the CDRU device
> + * @mhb: regmap to the MHB device
> + * @pipemux: pipemuex strap
> + * @phys: array of PCIe PHYs
> + */
> +struct sr_pcie_phy_core {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct regmap *cdru;
> +	struct regmap *mhb;
> +	u32 pipemux;
> +	struct sr_pcie_phy phys[SR_NR_PCIE_PHYS];
> +};
> +
> +/*
> + * PCIe PIPEMUX lookup table
> + *
> + * Each array index represents a PIPEMUX strap setting
> + * The array element represents a bitmap where a set bit means the PCIe
> + * core and associated serdes has been enabled as RC and is available for use
> + */
> +static const u8 pipemux_table[] = {
> +	/* PIPEMUX = 0, EP 1x16 */
> +	0x00,
> +	/* PIPEMUX = 1, EP 2x8 */
> +	0x00,
> +	/* PIPEMUX = 2, EP 4x4 */
> +	0x00,
> +	/* PIPEMUX = 3, RC 2x8, cores 0, 7 */
> +	0x81,
> +	/* PIPEMUX = 4, RC 4x4, cores 0, 1, 6, 7 */
> +	0xc3,
> +	/* PIPEMUX = 5, RC 8x2, all 8 cores */
> +	0xff,
> +	/* PIPEMUX = 6, RC 3x4 + 2x2, cores 0, 2, 3, 6, 7 */
> +	0xcd,
> +	/* PIPEMUX = 7, RC 1x4 + 6x2, cores 0, 2, 3, 4, 5, 6, 7 */
> +	0xfd,
> +	/* PIPEMUX = 8, EP 1x8 + RC 4x2, cores 4, 5, 6, 7 */
> +	0xf0,
> +	/* PIPEMUX = 9, EP 1x8 + RC 2x4, cores 6, 7 */
> +	0xc0,
> +	/* PIPEMUX = 10, EP 2x4 + RC 2x4, cores 1, 6 */
> +	0x42,
> +	/* PIPEMUX = 11, EP 2x4 + RC 4x2, cores 2, 3, 4, 5 */
> +	0x3c,
> +	/* PIPEMUX = 12, EP 1x4 + RC 6x2, cores 2, 3, 4, 5, 6, 7 */
> +	0xfc,
> +	/* PIPEMUX = 13, RC 2x4 + RC 1x4 + 2x2, cores 2, 3, 6 */
> +	0x4c,
> +};

Please use mux framework for this. (drivers/mux/mmio.c)
> +
> +/*
> + * Return true if the strap setting is valid
> + */
> +static bool pipemux_strap_is_valid(u32 pipemux)
> +{
> +	return !!(pipemux < ARRAY_SIZE(pipemux_table));
> +}
> +
> +/*
> + * Read the PCIe PIPEMUX from strap
> + */
> +static u32 pipemux_strap_read(struct sr_pcie_phy_core *core)
> +{
> +	u32 pipemux;
> +
> +	/*
> +	 * Read PIPEMUX configuration register to determine the pipemux setting
> +	 *
> +	 * In the case when the value indicates using HW strap, fall back to
> +	 * use HW strap
> +	 */
> +	pipemux = readl(core->base + PCIE_PIPEMUX_CFG_OFFSET);
> +	pipemux &= PCIE_PIPEMUX_MASK;
> +	if (pipemux == PCIE_PIPEMUX_SELECT_STRAP) {
> +		regmap_read(core->cdru, CDRU_STRAP_DATA_LSW_OFFSET, &pipemux);
> +		pipemux >>= PCIE_PIPEMUX_SHIFT;
> +		pipemux &= PCIE_PIPEMUX_MASK;
> +	}
> +
> +	return pipemux;
> +}
> +
> +/*
> + * Given a PIPEMUX strap and PCIe core index, this function returns true if the
> + * PCIe core needs to be enabled
> + */
> +static bool pcie_core_is_for_rc(struct sr_pcie_phy *phy)
> +{
> +	struct sr_pcie_phy_core *core = phy->core;
> +	unsigned int core_idx = phy->index;
> +
> +	return !!((pipemux_table[core->pipemux] >> core_idx) & 0x1);
> +}
> +
> +static int sr_pcie_phy_init(struct phy *p)
> +{
> +	struct sr_pcie_phy *phy = phy_get_drvdata(p);
> +
> +	/*
> +	 * Check whether this PHY is for root complex or not. If yes, return
> +	 * zero so the host driver can proceed to enumeration. If not, return
> +	 * an error and that will force the host driver to bail out
> +	 */
> +	if (pcie_core_is_for_rc(phy))
> +		return 0;
> +	else

This else can be removed.
> +		return -ENODEV;
> +}
> +
> +static int sr_paxc_phy_init(struct phy *p)
> +{
> +	struct sr_pcie_phy *phy = phy_get_drvdata(p);
> +	struct sr_pcie_phy_core *core = phy->core;
> +	unsigned int core_idx = phy->index;
> +	u32 val;
> +
> +	if (core_idx != SR_PAXC_PHY_IDX)
> +		return -EINVAL;
> +
> +	regmap_read(core->mhb, MHB_MEM_PW_PAXC_OFFSET, &val);
> +	if ((val & MHB_PWR_STATUS_MASK) != MHB_PWR_STATUS_MASK) {
> +		dev_err(core->dev, "PAXC is not powered up\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sr_pcie_phy_exit(struct phy *p)
> +{
> +	/* dummy function to allow host driver to proceed */
> +	return 0;
> +}
> +
> +static int sr_pcie_phy_power_on(struct phy *p)
> +{
> +	/* dummy function to allow host driver to proceed */
> +	return 0;
> +}
> +
> +static int sr_pcie_phy_power_off(struct phy *p)
> +{
> +	/* dummy function to allow host to proceed */
> +	return 0;
> +}

dummy functions are not required.
> +
> +static const struct phy_ops sr_pcie_phy_ops = {
> +	.init = sr_pcie_phy_init,
> +	.exit = sr_pcie_phy_exit,
> +	.power_on = sr_pcie_phy_power_on,
> +	.power_off = sr_pcie_phy_power_off,
> +};
> +
> +static const struct phy_ops sr_paxc_phy_ops = {
> +	.init = sr_paxc_phy_init,
> +	.exit = sr_pcie_phy_exit,
> +	.power_on = sr_pcie_phy_power_on,
> +	.power_off = sr_pcie_phy_power_off,
> +};

phy_ops should have .owner.

Thanks
Kishon
