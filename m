Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA670C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719F3208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AkstCyjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719F3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeGIEcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:32:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeGIEcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:32:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w694VSrt057116;
        Sun, 8 Jul 2018 23:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531110688;
        bh=m9xkC1s3VPzMUuLWIf3TMNVIiWOGE1857P6awZeescw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=AkstCyjhK4mHD4D3IJbkNua4p7KciGq+fxe2T9R8ZMBT3Tc7u7KZfxWHkWACRrOq7
         AGqiGSWU/+6i2Jqm6JyN2mNNj36Qc27G9lUUVtPCx4fXB5JpXdSmPg7jHFFd1TzeSF
         2Lo/dSTYJ7Jl8jlMtC+qYwigQqvMeaZzR8J/GDZ0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w694VStr012884;
        Sun, 8 Jul 2018 23:31:28 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 8 Jul
 2018 23:31:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 8 Jul 2018 23:31:28 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w694VPXx010297;
        Sun, 8 Jul 2018 23:31:26 -0500
Subject: Re: [PATCH v2 7/9] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180706153805.25842-1-icenowy@aosc.io>
 <20180706153805.25842-8-icenowy@aosc.io>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-sunxi@googlegroups.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <438f1123-a619-61d0-36cd-d65c1430435a@ti.com>
Date:   Mon, 9 Jul 2018 10:01:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180706153805.25842-8-icenowy@aosc.io>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 06 July 2018 09:08 PM, Icenowy Zheng wrote:
> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
> controlled).
> 
> Add a driver for it.
> 
> The register operations in this driver is mainly extracted from the BSP
> USB3 driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Splitted out the DT binding.
> 
>  drivers/phy/allwinner/Kconfig           |  13 ++
>  drivers/phy/allwinner/Makefile          |   1 +
>  drivers/phy/allwinner/phy-sun50i-usb3.c | 194 ++++++++++++++++++++++++
>  3 files changed, 208 insertions(+)
>  create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
> 
> diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
> index cdc1e745ba47..cf373bcee034 100644
> --- a/drivers/phy/allwinner/Kconfig
> +++ b/drivers/phy/allwinner/Kconfig
> @@ -29,3 +29,16 @@ config PHY_SUN9I_USB
>  	  sun9i SoCs.
>  
>  	  This driver controls each individual USB 2 host PHY.
> +
> +config PHY_SUN50I_USB3
> +	tristate "Allwinner sun50i SoC USB3 PHY driver"
> +	depends on ARCH_SUNXI && HAS_IOMEM && OF
> +	depends on RESET_CONTROLLER
> +	depends on USB_SUPPORT
> +	select USB_COMMON

Doesn't look like this driver depends on USB_SUPPORT.
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the USB3.0-capable transceiver that is
> +	  part of some Allwinner sun50i SoCs.
> +
> +	  This driver controls each individual USB 2+3 host PHY combo.
> diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
> index 8605529c01a1..a8d01e9073c2 100644
> --- a/drivers/phy/allwinner/Makefile
> +++ b/drivers/phy/allwinner/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
> +obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
> new file mode 100644
> index 000000000000..226c99c2d664
> --- /dev/null
> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Allwinner sun50i(H6) USB 3.0 phy driver
> + *
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * Based on phy-sun9i-usb.c, which is:
> + *
> + * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
> + *
> + * Based on code from Allwinner BSP, which is:
> + *
> + * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.

Does the BSP also use GPL license?
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/usb/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +/* Interface Status and Control Registers */
> +#define SUNXI_ISCR			0x00
> +#define SUNXI_PIPE_CLOCK_CONTROL	0x14
> +#define SUNXI_PHY_TUNE_LOW		0x18
> +#define SUNXI_PHY_TUNE_HIGH		0x1c
> +#define SUNXI_PHY_EXTERNAL_CONTROL	0x20
> +
> +/* USB2.0 Interface Status and Control Register */
> +#define SUNXI_ISCR_FORCE_VBUS		(3 << 12)
> +
> +/* PIPE Clock Control Register */
> +#define SUNXI_PCC_PIPE_CLK_OPEN		(1 << 6)
> +
> +/* PHY External Control Register */
> +#define SUNXI_PEC_EXTERN_VBUS		(3 << 1)
> +#define SUNXI_PEC_SSC_EN		(1 << 24)
> +#define SUNXI_PEC_REF_SSP_EN		(1 << 26)
> +
> +/* PHY Tune High Register */
> +#define SUNXI_TX_DEEMPH_3P5DB(n)	((n) << 19)
> +#define SUNXI_TX_DEEMPH_3P5DB_MASK	GENMASK(24, 19)
> +#define SUNXI_TX_DEEMPH_6DB(n)		((n) << 13)
> +#define SUNXI_TX_DEEMPH_6GB_MASK	GENMASK(18, 13)
> +#define SUNXI_TX_SWING_FULL(n)		((n) << 6)
> +#define SUNXI_TX_SWING_FULL_MASK	GENMASK(12, 6)
> +#define SUNXI_LOS_BIAS(n)		((n) << 3)
> +#define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
> +#define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
> +
> +struct sun50i_usb3_phy {
> +	struct phy *phy;
> +	void __iomem *regs;
> +	struct reset_control *reset;
> +	struct clk *clk;
> +};
> +
> +static void sun50i_usb3_phy_open(struct sun50i_usb3_phy *phy)
> +{
> +	u32 val;
> +
> +	val = readl(phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
> +	val |= SUNXI_PEC_EXTERN_VBUS;
> +	val |= SUNXI_PEC_SSC_EN | SUNXI_PEC_REF_SSP_EN;
> +	writel(val, phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
> +
> +	val = readl(phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
> +	val |= SUNXI_PCC_PIPE_CLK_OPEN;
> +	writel(val, phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
> +
> +	val = readl(phy->regs + SUNXI_ISCR);
> +	val |= SUNXI_ISCR_FORCE_VBUS;
> +	writel(val, phy->regs + SUNXI_ISCR);
> +
> +	/*
> +	 * All the magic numbers written to the PHY_TUNE_{LOW_HIGH}
> +	 * registers are directly taken from the BSP USB3 driver from
> +	 * Allwiner.

%s/Allwiner/Allwinner/
> +	 */
> +	writel(0x0047fc87, phy->regs + SUNXI_PHY_TUNE_LOW);

PHY_TUNE_LOW should also configure individual parameters like how you've done
below for PHY_TUNE_HIGH.

Thanks
Kishon
