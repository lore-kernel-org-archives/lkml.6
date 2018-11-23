Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A532020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A532020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503629AbeKWV5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:57:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38348 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbeKWV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:57:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANBDGfK059571;
        Fri, 23 Nov 2018 05:13:16 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANBDG65072556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 05:13:16 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 05:13:16 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 05:13:16 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANBDE4A031752;
        Fri, 23 Nov 2018 05:13:14 -0600
Subject: Re: [PATCH v2] phy: phy-pxa-usb: add a new driver
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20181015144538.22410-1-lkundrak@v3.sk>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57265fcf-332e-3882-a855-210b21f26b03@ti.com>
Date:   Fri, 23 Nov 2018 16:43:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181015144538.22410-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/10/18 8:15 PM, Lubomir Rintel wrote:
> Turned from arch/arm/mach-mmp/devices.c into a proper PHY driver, so
> that in can be instantiated from a DT.
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

I'm unable to apply this patch as the raw format of this patch [1] has weird
characters. Please fix and resend.

Thanks
Kishon

[1] -> https://lore.kernel.org/lkml/20181015144538.22410-1-lkundrak@v3.sk/raw
> ---
> Greg,
> 
> please include this in the USB tree. Changes to mv-ehci driver that are already
> in can utilize this and it got an Ack from the PHY maintainer.
> 
> Changes since v1:
> - None, just added Kishon's Ack
> 
> Thanks,
> Lubo
> 
>  drivers/phy/marvell/Kconfig       |  11 +
>  drivers/phy/marvell/Makefile      |   1 +
>  drivers/phy/marvell/phy-pxa-usb.c | 345 ++++++++++++++++++++++++++++++
>  3 files changed, 357 insertions(+)
>  create mode 100644 drivers/phy/marvell/phy-pxa-usb.c
> 
> diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> index 68e321225400..6fb4b56e4c14 100644
> --- a/drivers/phy/marvell/Kconfig
> +++ b/drivers/phy/marvell/Kconfig
> @@ -59,3 +59,14 @@ config PHY_PXA_28NM_USB2
>  	  The PHY driver will be used by Marvell udc/ehci/otg driver.
>  
>  	  To compile this driver as a module, choose M here.
> +
> +config PHY_PXA_USB
> +	tristate "Marvell PXA USB PHY Driver"
> +	depends on ARCH_PXA || ARCH_MMP
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support Marvell PXA USB PHY driver for Marvell
> +	  SoC. This driver will do the PHY initialization and shutdown.
> +	  The PHY driver will be used by Marvell udc/ehci/otg driver.
> +
> +	  To compile this driver as a module, choose M here.
> diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
> index 5c3ec5d10e0d..3975b144f8ec 100644
> --- a/drivers/phy/marvell/Makefile
> +++ b/drivers/phy/marvell/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
>  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
>  obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
>  obj-$(CONFIG_PHY_PXA_28NM_USB2)		+= phy-pxa-28nm-usb2.o
> +obj-$(CONFIG_PHY_PXA_USB)		+= phy-pxa-usb.o
> diff --git a/drivers/phy/marvell/phy-pxa-usb.c b/drivers/phy/marvell/phy-pxa-usb.c
> new file mode 100644
> index 000000000000..87ff7550b912
> --- /dev/null
> +++ b/drivers/phy/marvell/phy-pxa-usb.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
> + * Copyright (C) 2018 Lubomir Rintel <lkundrak@v3.sk>
> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +/* phy regs */
> +#define UTMI_REVISION		0x0
> +#define UTMI_CTRL		0x4
> +#define UTMI_PLL		0x8
> +#define UTMI_TX			0xc
> +#define UTMI_RX			0x10
> +#define UTMI_IVREF		0x14
> +#define UTMI_T0			0x18
> +#define UTMI_T1			0x1c
> +#define UTMI_T2			0x20
> +#define UTMI_T3			0x24
> +#define UTMI_T4			0x28
> +#define UTMI_T5			0x2c
> +#define UTMI_RESERVE		0x30
> +#define UTMI_USB_INT		0x34
> +#define UTMI_DBG_CTL		0x38
> +#define UTMI_OTG_ADDON		0x3c
> +
> +/* For UTMICTRL Register */
> +#define UTMI_CTRL_USB_CLK_EN                    (1 << 31)
> +/* pxa168 */
> +#define UTMI_CTRL_SUSPEND_SET1                  (1 << 30)
> +#define UTMI_CTRL_SUSPEND_SET2                  (1 << 29)
> +#define UTMI_CTRL_RXBUF_PDWN                    (1 << 24)
> +#define UTMI_CTRL_TXBUF_PDWN                    (1 << 11)
> +
> +#define UTMI_CTRL_INPKT_DELAY_SHIFT             30
> +#define UTMI_CTRL_INPKT_DELAY_SOF_SHIFT		28
> +#define UTMI_CTRL_PU_REF_SHIFT			20
> +#define UTMI_CTRL_ARC_PULLDN_SHIFT              12
> +#define UTMI_CTRL_PLL_PWR_UP_SHIFT              1
> +#define UTMI_CTRL_PWR_UP_SHIFT                  0
> +
> +/* For UTMI_PLL Register */
> +#define UTMI_PLL_PLLCALI12_SHIFT		29
> +#define UTMI_PLL_PLLCALI12_MASK			(0x3 << 29)
> +
> +#define UTMI_PLL_PLLVDD18_SHIFT			27
> +#define UTMI_PLL_PLLVDD18_MASK			(0x3 << 27)
> +
> +#define UTMI_PLL_PLLVDD12_SHIFT			25
> +#define UTMI_PLL_PLLVDD12_MASK			(0x3 << 25)
> +
> +#define UTMI_PLL_CLK_BLK_EN_SHIFT               24
> +#define CLK_BLK_EN                              (0x1 << 24)
> +#define PLL_READY                               (0x1 << 23)
> +#define KVCO_EXT                                (0x1 << 22)
> +#define VCOCAL_START                            (0x1 << 21)
> +
> +#define UTMI_PLL_KVCO_SHIFT			15
> +#define UTMI_PLL_KVCO_MASK                      (0x7 << 15)
> +
> +#define UTMI_PLL_ICP_SHIFT			12
> +#define UTMI_PLL_ICP_MASK                       (0x7 << 12)
> +
> +#define UTMI_PLL_FBDIV_SHIFT                    4
> +#define UTMI_PLL_FBDIV_MASK                     (0xFF << 4)
> +
> +#define UTMI_PLL_REFDIV_SHIFT                   0
> +#define UTMI_PLL_REFDIV_MASK                    (0xF << 0)
> +
> +/* For UTMI_TX Register */
> +#define UTMI_TX_REG_EXT_FS_RCAL_SHIFT		27
> +#define UTMI_TX_REG_EXT_FS_RCAL_MASK		(0xf << 27)
> +
> +#define UTMI_TX_REG_EXT_FS_RCAL_EN_SHIFT	26
> +#define UTMI_TX_REG_EXT_FS_RCAL_EN_MASK		(0x1 << 26)
> +
> +#define UTMI_TX_TXVDD12_SHIFT                   22
> +#define UTMI_TX_TXVDD12_MASK                    (0x3 << 22)
> +
> +#define UTMI_TX_CK60_PHSEL_SHIFT                17
> +#define UTMI_TX_CK60_PHSEL_MASK                 (0xf << 17)
> +
> +#define UTMI_TX_IMPCAL_VTH_SHIFT                14
> +#define UTMI_TX_IMPCAL_VTH_MASK                 (0x7 << 14)
> +
> +#define REG_RCAL_START                          (0x1 << 12)
> +
> +#define UTMI_TX_LOW_VDD_EN_SHIFT                11
> +
> +#define UTMI_TX_AMP_SHIFT			0
> +#define UTMI_TX_AMP_MASK			(0x7 << 0)
> +
> +/* For UTMI_RX Register */
> +#define UTMI_REG_SQ_LENGTH_SHIFT                15
> +#define UTMI_REG_SQ_LENGTH_MASK                 (0x3 << 15)
> +
> +#define UTMI_RX_SQ_THRESH_SHIFT                 4
> +#define UTMI_RX_SQ_THRESH_MASK                  (0xf << 4)
> +
> +#define UTMI_OTG_ADDON_OTG_ON			(1 << 0)
> +
> +enum pxa_usb_phy_version {
> +	PXA_USB_PHY_MMP2,
> +	PXA_USB_PHY_PXA910,
> +	PXA_USB_PHY_PXA168,
> +};
> +
> +struct pxa_usb_phy {
> +	struct phy *phy;
> +	void __iomem *base;
> +	enum pxa_usb_phy_version version;
> +};
> +
> +/*****************************************************************************
> + * The registers read/write routines
> + *****************************************************************************/
> +
> +static unsigned int u2o_get(void __iomem *base, unsigned int offset)
> +{
> +	return readl_relaxed(base + offset);
> +}
> +
> +static void u2o_set(void __iomem *base, unsigned int offset,
> +		unsigned int value)
> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(base + offset);
> +	reg |= value;
> +	writel_relaxed(reg, base + offset);
> +	readl_relaxed(base + offset);
> +}
> +
> +static void u2o_clear(void __iomem *base, unsigned int offset,
> +		unsigned int value)
> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(base + offset);
> +	reg &= ~value;
> +	writel_relaxed(reg, base + offset);
> +	readl_relaxed(base + offset);
> +}
> +
> +static void u2o_write(void __iomem *base, unsigned int offset,
> +		unsigned int value)
> +{
> +	writel_relaxed(value, base + offset);
> +	readl_relaxed(base + offset);
> +}
> +
> +static int pxa_usb_phy_init(struct phy *phy)
> +{
> +	struct pxa_usb_phy *pxa_usb_phy = phy_get_drvdata(phy);
> +	void __iomem *base = pxa_usb_phy->base;
> +	int loops;
> +
> +	dev_info(&phy->dev, "initializing Marvell PXA USB PHY");
> +
> +	/* Initialize the USB PHY power */
> +	if (pxa_usb_phy->version == PXA_USB_PHY_PXA910) {
> +		u2o_set(base, UTMI_CTRL, (1<<UTMI_CTRL_INPKT_DELAY_SOF_SHIFT)
> +			| (1<<UTMI_CTRL_PU_REF_SHIFT));
> +	}
> +
> +	u2o_set(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
> +	u2o_set(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
> +
> +	/* UTMI_PLL settings */
> +	u2o_clear(base, UTMI_PLL, UTMI_PLL_PLLVDD18_MASK
> +		| UTMI_PLL_PLLVDD12_MASK | UTMI_PLL_PLLCALI12_MASK
> +		| UTMI_PLL_FBDIV_MASK | UTMI_PLL_REFDIV_MASK
> +		| UTMI_PLL_ICP_MASK | UTMI_PLL_KVCO_MASK);
> +
> +	u2o_set(base, UTMI_PLL, 0xee<<UTMI_PLL_FBDIV_SHIFT
> +		| 0xb<<UTMI_PLL_REFDIV_SHIFT | 3<<UTMI_PLL_PLLVDD18_SHIFT
> +		| 3<<UTMI_PLL_PLLVDD12_SHIFT | 3<<UTMI_PLL_PLLCALI12_SHIFT
> +		| 1<<UTMI_PLL_ICP_SHIFT | 3<<UTMI_PLL_KVCO_SHIFT);
> +
> +	/* UTMI_TX */
> +	u2o_clear(base, UTMI_TX, UTMI_TX_REG_EXT_FS_RCAL_EN_MASK
> +		| UTMI_TX_TXVDD12_MASK | UTMI_TX_CK60_PHSEL_MASK
> +		| UTMI_TX_IMPCAL_VTH_MASK | UTMI_TX_REG_EXT_FS_RCAL_MASK
> +		| UTMI_TX_AMP_MASK);
> +	u2o_set(base, UTMI_TX, 3<<UTMI_TX_TXVDD12_SHIFT
> +		| 4<<UTMI_TX_CK60_PHSEL_SHIFT | 4<<UTMI_TX_IMPCAL_VTH_SHIFT
> +		| 8<<UTMI_TX_REG_EXT_FS_RCAL_SHIFT | 3<<UTMI_TX_AMP_SHIFT);
> +
> +	/* UTMI_RX */
> +	u2o_clear(base, UTMI_RX, UTMI_RX_SQ_THRESH_MASK
> +		| UTMI_REG_SQ_LENGTH_MASK);
> +	u2o_set(base, UTMI_RX, 7<<UTMI_RX_SQ_THRESH_SHIFT
> +		| 2<<UTMI_REG_SQ_LENGTH_SHIFT);
> +
> +	/* UTMI_IVREF */
> +	if (pxa_usb_phy->version == PXA_USB_PHY_PXA168) {
> +		/*
> +		 * fixing Microsoft Altair board interface with NEC hub issue -
> +		 * Set UTMI_IVREF from 0x4a3 to 0x4bf
> +		 */
> +		u2o_write(base, UTMI_IVREF, 0x4bf);
> +	}
> +
> +	/* toggle VCOCAL_START bit of UTMI_PLL */
> +	udelay(200);
> +	u2o_set(base, UTMI_PLL, VCOCAL_START);
> +	udelay(40);
> +	u2o_clear(base, UTMI_PLL, VCOCAL_START);
> +
> +	/* toggle REG_RCAL_START bit of UTMI_TX */
> +	udelay(400);
> +	u2o_set(base, UTMI_TX, REG_RCAL_START);
> +	udelay(40);
> +	u2o_clear(base, UTMI_TX, REG_RCAL_START);
> +	udelay(400);
> +
> +	/* Make sure PHY PLL is ready */
> +	loops = 0;
> +	while ((u2o_get(base, UTMI_PLL) & PLL_READY) == 0) {
> +		mdelay(1);
> +		loops++;
> +		if (loops > 100) {
> +			dev_warn(&phy->dev, "calibrate timeout, UTMI_PLL %x\n",
> +						u2o_get(base, UTMI_PLL));
> +			break;
> +		}
> +	}
> +
> +	if (pxa_usb_phy->version == PXA_USB_PHY_PXA168) {
> +		u2o_set(base, UTMI_RESERVE, 1 << 5);
> +		/* Turn on UTMI PHY OTG extension */
> +		u2o_write(base, UTMI_OTG_ADDON, 1);
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static int pxa_usb_phy_exit(struct phy *phy)
> +{
> +	struct pxa_usb_phy *pxa_usb_phy = phy_get_drvdata(phy);
> +	void __iomem *base = pxa_usb_phy->base;
> +
> +	dev_info(&phy->dev, "deinitializing Marvell PXA USB PHY");
> +
> +	if (pxa_usb_phy->version == PXA_USB_PHY_PXA168)
> +		u2o_clear(base, UTMI_OTG_ADDON, UTMI_OTG_ADDON_OTG_ON);
> +
> +	u2o_clear(base, UTMI_CTRL, UTMI_CTRL_RXBUF_PDWN);
> +	u2o_clear(base, UTMI_CTRL, UTMI_CTRL_TXBUF_PDWN);
> +	u2o_clear(base, UTMI_CTRL, UTMI_CTRL_USB_CLK_EN);
> +	u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
> +	u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops pxa_usb_phy_ops = {
> +	.init	= pxa_usb_phy_init,
> +	.exit	= pxa_usb_phy_exit,
> +	.owner	= THIS_MODULE,
> +};
> +
> +static const struct of_device_id pxa_usb_phy_of_match[] = {
> +	{
> +		.compatible = "marvell,mmp2-usb-phy",
> +		.data = (void *)PXA_USB_PHY_MMP2,
> +	}, {
> +		.compatible = "marvell,pxa910-usb-phy",
> +		.data = (void *)PXA_USB_PHY_PXA910,
> +	}, {
> +		.compatible = "marvell,pxa168-usb-phy",
> +		.data = (void *)PXA_USB_PHY_PXA168,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pxa_usb_phy_of_match);
> +
> +static int pxa_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *resource;
> +	struct pxa_usb_phy *pxa_usb_phy;
> +	struct phy_provider *provider;
> +	const struct of_device_id *of_id;
> +
> +	pxa_usb_phy = devm_kzalloc(dev, sizeof(struct pxa_usb_phy), GFP_KERNEL);
> +	if (!pxa_usb_phy)
> +		return -ENOMEM;
> +
> +	of_id = of_match_node(pxa_usb_phy_of_match, dev->of_node);
> +	if (of_id)
> +		pxa_usb_phy->version = (enum pxa_usb_phy_version)of_id->data;
> +	else
> +		pxa_usb_phy->version = PXA_USB_PHY_MMP2;
> +
> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pxa_usb_phy->base = devm_ioremap_resource(dev, resource);
> +	if (IS_ERR(pxa_usb_phy->base)) {
> +		dev_err(dev, "failed to remap PHY regs\n");
> +		return PTR_ERR(pxa_usb_phy->base);
> +	}
> +
> +	pxa_usb_phy->phy = devm_phy_create(dev, NULL, &pxa_usb_phy_ops);
> +	if (IS_ERR(pxa_usb_phy->phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(pxa_usb_phy->phy);
> +	}
> +
> +	phy_set_drvdata(pxa_usb_phy->phy, pxa_usb_phy);
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(dev, "failed to register PHY provider\n");
> +		return PTR_ERR(provider);
> +	}
> +
> +	if (!dev->of_node) {
> +		phy_create_lookup(pxa_usb_phy->phy, "usb", "mv-udc");
> +		phy_create_lookup(pxa_usb_phy->phy, "usb", "pxa-u2oehci");
> +		phy_create_lookup(pxa_usb_phy->phy, "usb", "mv-otg");
> +	}
> +
> +	dev_info(dev, "Marvell PXA USB PHY");
> +	return 0;
> +}
> +
> +static struct platform_driver pxa_usb_phy_driver = {
> +	.probe		= pxa_usb_phy_probe,
> +	.driver		= {
> +		.name	= "pxa-usb-phy",
> +		.of_match_table = pxa_usb_phy_of_match,
> +	},
> +};
> +module_platform_driver(pxa_usb_phy_driver);
> +
> +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
> +MODULE_DESCRIPTION("Marvell PXA USB PHY Driver");
> +MODULE_LICENSE("GPL v2");
> 
