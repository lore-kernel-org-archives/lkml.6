Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C197C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E473620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C5Su3ZOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbfAOUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:39:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57598 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfAOUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:39:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FKcGrL128867;
        Tue, 15 Jan 2019 14:38:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547584696;
        bh=/pgd+Ll8xsTZnWJrMPDfx9mKFYkkMbjqzeko7eVi3u0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=C5Su3ZOVLI1qrwvPYnHaYdkAY5n80BF1EDlDnRiyAmsEDBu4NS1zdcqjF3XS6mrr/
         GWyLQiBfNZLhnNLSC93HQSZ60SB0zxynBOcctd7O6ncR2+4aavPC3ZlSWGk2aacVN3
         /mdmiYsWzdGfrEOUgU3YZQ5j75ov6QldL41Bsve4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FKcGl2057464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 14:38:16 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 14:38:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 14:38:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FKcF8r024607;
        Tue, 15 Jan 2019 14:38:15 -0600
Date:   Tue, 15 Jan 2019 14:38:15 -0600
From:   Bin Liu <b-liu@ti.com>
To:     <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH v2 4/4] usb: musb: Add support for MediaTek musb
 controller
Message-ID: <20190115203815.GD18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yonglong Wu <yonglong.wu@mediatek.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-5-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547516626-5084-5-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

very close, thanks.
Below I tried to explain a further cleanup in musb_clearb/w() and
musb_get/set_toggle() implementation. Please let me know if it is not
clear.

Basically, we don't need musb_default_clearb/w(), just assign the
musb_io function pointers to musb_readb/w().

Then the mtk platform musb_clearb/w() calls musb_readb/w() and
musb_writeb/w() to handle W1C.

On Tue, Jan 15, 2019 at 09:43:46AM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> There are some quirk of MediaTek musb controller, such as:
>  -W1C interrupt status registers
>  -Private data toggle registers
>  -No dedicated DMA interrupt line
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
> ---
>  drivers/usb/musb/Kconfig     |   8 +-
>  drivers/usb/musb/Makefile    |   1 +
>  drivers/usb/musb/mediatek.c  | 617 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/musb/musb_core.c |  69 +++++
>  drivers/usb/musb/musb_core.h |   9 +
>  drivers/usb/musb/musb_dma.h  |   9 +
>  drivers/usb/musb/musb_host.c |  26 +-
>  drivers/usb/musb/musb_io.h   |   6 +
>  drivers/usb/musb/musbhsdma.c |  55 ++--
>  9 files changed, 762 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/usb/musb/mediatek.c
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index ad08895..b72b7c1 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -115,6 +115,12 @@ config USB_MUSB_JZ4740
>  	depends on USB_MUSB_GADGET
>  	depends on USB_OTG_BLACKLIST_HUB
>  
> +config USB_MUSB_MEDIATEK
> +	tristate "MediaTek platforms"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on NOP_USB_XCEIV
> +	depends on GENERIC_PHY
> +
>  config USB_MUSB_AM335X_CHILD
>  	tristate
>  
> @@ -141,7 +147,7 @@ config USB_UX500_DMA
>  
>  config USB_INVENTRA_DMA
>  	bool 'Inventra'
> -	depends on USB_MUSB_OMAP2PLUS
> +	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_MEDIATEK
>  	help
>  	  Enable DMA transfers using Mentor's engine.
>  
> diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
> index 3a88c79..63d82d0 100644
> --- a/drivers/usb/musb/Makefile
> +++ b/drivers/usb/musb/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
>  obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
>  obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
>  obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
> +obj-$(CONFIG_USB_MUSB_MEDIATEK)      		+= mediatek.o
>  
>  
>  obj-$(CONFIG_USB_MUSB_AM335X_CHILD)		+= musb_am335x.o
> diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> new file mode 100644
> index 0000000..7221989
> --- /dev/null
> +++ b/drivers/usb/musb/mediatek.c
> @@ -0,0 +1,617 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 MediaTek Inc.
> + *
> + * Author:
> + *  Min Guo <min.guo@mediatek.com>
> + *  Yonglong Wu <yonglong.wu@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/usb_phy_generic.h>
> +#include "musb_core.h"
> +#include "musb_dma.h"
> +
> +#define USB_L1INTS	0x00a0
> +#define USB_L1INTM	0x00a4
> +#define MTK_MUSB_TXFUNCADDR	0x0480
> +
> +/* MediaTek controller toggle enable and status reg */
> +#define MUSB_RXTOG		0x80
> +#define MUSB_RXTOGEN		0x82
> +#define MUSB_TXTOG		0x84
> +#define MUSB_TXTOGEN		0x86
> +
> +#define TX_INT_STATUS		BIT(0)
> +#define RX_INT_STATUS		BIT(1)
> +#define USBCOM_INT_STATUS	BIT(2)

missing a TAB for the alignment?

> +#define DMA_INT_STATUS		BIT(3)
> +
> +#define DMA_INTR_STATUS_MSK		GENMASK(7, 0)
> +#define DMA_INTR_UNMASK_SET_MSK	GENMASK(31, 24)
> +
> +enum mtk_vbus_id_state {
> +	MTK_ID_FLOAT = 1,
> +	MTK_ID_GROUND,
> +	MTK_VBUS_OFF,
> +	MTK_VBUS_VALID,
> +};
> +
> +struct mtk_glue {
> +	struct device *dev;
> +	struct musb *musb;
> +	struct platform_device *musb_pdev;
> +	struct platform_device *usb_phy;
> +	struct phy *phy;
> +	struct usb_phy *xceiv;
> +	enum phy_mode phy_mode;
> +	struct clk *main;
> +	struct clk *mcu;
> +	struct clk *univpll;
> +	struct regulator *vbus;
> +	struct extcon_dev *edev;
> +	struct notifier_block vbus_nb;
> +	struct notifier_block id_nb;
> +};
> +
> +static int mtk_musb_clks_get(struct mtk_glue *glue)
> +{
> +	struct device *dev = glue->dev;
> +
> +	glue->main = devm_clk_get(dev, "main");
> +	if (IS_ERR(glue->main)) {
> +		dev_err(dev, "fail to get main clock\n");
> +		return PTR_ERR(glue->main);
> +	}
> +
> +	glue->mcu = devm_clk_get(dev, "mcu");
> +	if (IS_ERR(glue->mcu)) {
> +		dev_err(dev, "fail to get mcu clock\n");
> +		return PTR_ERR(glue->mcu);
> +	}
> +
> +	glue->univpll = devm_clk_get(dev, "univpll");
> +	if (IS_ERR(glue->univpll)) {
> +		dev_err(dev, "fail to get univpll clock\n");
> +		return PTR_ERR(glue->univpll);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_musb_clks_enable(struct mtk_glue *glue)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(glue->main);
> +	if (ret) {
> +		dev_err(glue->dev, "failed to enable main clock\n");
> +		goto err_main_clk;
> +	}
> +
> +	ret = clk_prepare_enable(glue->mcu);
> +	if (ret) {
> +		dev_err(glue->dev, "failed to enable mcu clock\n");
> +		goto err_mcu_clk;
> +	}
> +
> +	ret = clk_prepare_enable(glue->univpll);
> +	if (ret) {
> +		dev_err(glue->dev, "failed to enable univpll clock\n");
> +		goto err_univpll_clk;
> +	}
> +
> +	return 0;
> +
> +err_univpll_clk:
> +	clk_disable_unprepare(glue->mcu);
> +err_mcu_clk:
> +	clk_disable_unprepare(glue->main);
> +err_main_clk:
> +	return ret;
> +}
> +
> +static void mtk_musb_clks_disable(struct mtk_glue *glue)
> +{
> +	clk_disable_unprepare(glue->univpll);
> +	clk_disable_unprepare(glue->mcu);
> +	clk_disable_unprepare(glue->main);
> +}
> +
> +static void mtk_musb_set_vbus(struct musb *musb, int is_on)
> +{
> +	struct device *dev = musb->controller;
> +	struct mtk_glue *glue = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	/* vbus is optional */
> +	if (!glue->vbus)
> +		return;
> +
> +	dev_dbg(musb->controller, "%s, is_on=%d\r\n", __func__, is_on);
> +	if (is_on) {
> +		ret = regulator_enable(glue->vbus);
> +		if (ret) {
> +			dev_err(glue->dev, "fail to enable vbus regulator\n");
> +			return;
> +		}
> +	} else {
> +		regulator_disable(glue->vbus);
> +	}
> +}
> +
> +/*
> + * switch to host: -> MTK_VBUS_OFF --> MTK_ID_GROUND
> + * switch to device: -> MTK_ID_FLOAT --> MTK_VBUS_VALID
> + */
> +static void mtk_musb_set_mailbox(struct mtk_glue *glue,
> +	enum mtk_vbus_id_state status)

add one more TAB for params.

> +{
> +	struct musb *musb = glue->musb;
> +	u8 devctl = 0;
> +
> +	dev_dbg(glue->dev, "mailbox state(%d)\n", status);
> +	switch (status) {
> +	case MTK_ID_GROUND:
> +		phy_power_on(glue->phy);
> +		devctl = readb(musb->mregs + MUSB_DEVCTL);
> +		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> +		mtk_musb_set_vbus(musb, 1);
> +		glue->phy_mode = PHY_MODE_USB_HOST;
> +		phy_set_mode(glue->phy, glue->phy_mode);
> +		devctl |= MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +		MUSB_HST_MODE(musb);
> +		break;
> +	/*
> +	 * MTK_ID_FLOAT process is the same as MTK_VBUS_VALID
> +	 * except that turn off VBUS
> +	 */
> +	case MTK_ID_FLOAT:
> +		mtk_musb_set_vbus(musb, 0);
> +		/* fall through */
> +	case MTK_VBUS_OFF:
> +		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
> +		devctl &= ~MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +		phy_power_off(glue->phy);
> +		break;
> +	case MTK_VBUS_VALID:
> +		phy_power_on(glue->phy);
> +		glue->phy_mode = PHY_MODE_USB_DEVICE;
> +		phy_set_mode(glue->phy, glue->phy_mode);
> +		MUSB_DEV_MODE(musb);
> +		break;
> +	default:
> +		dev_err(glue->dev, "invalid state\n");
> +	}
> +}
> +
> +static int mtk_musb_id_notifier(struct notifier_block *nb,
> +	unsigned long event, void *ptr)
> +{
> +	struct mtk_glue *glue = container_of(nb, struct mtk_glue, id_nb);
> +
> +	if (event)
> +		mtk_musb_set_mailbox(glue, MTK_ID_GROUND);
> +	else
> +		mtk_musb_set_mailbox(glue, MTK_ID_FLOAT);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int mtk_musb_vbus_notifier(struct notifier_block *nb,
> +	unsigned long event, void *ptr)
> +{
> +	struct mtk_glue *glue = container_of(nb, struct mtk_glue, vbus_nb);
> +
> +	if (event)
> +		mtk_musb_set_mailbox(glue, MTK_VBUS_VALID);
> +	else
> +		mtk_musb_set_mailbox(glue, MTK_VBUS_OFF);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void mtk_otg_switch_init(struct mtk_glue *glue)
> +{
> +	int ret;
> +
> +	/* extcon is optional */
> +	if (!glue->edev)
> +		return;
> +
> +	glue->vbus_nb.notifier_call = mtk_musb_vbus_notifier;
> +	ret = devm_extcon_register_notifier(glue->dev, glue->edev, EXTCON_USB,
> +					&glue->vbus_nb);
> +	if (ret < 0)
> +		dev_err(glue->dev, "failed to register notifier for USB\n");
> +
> +	glue->id_nb.notifier_call = mtk_musb_id_notifier;
> +	ret = devm_extcon_register_notifier(glue->dev, glue->edev,
> +					EXTCON_USB_HOST, &glue->id_nb);
> +	if (ret < 0)
> +		dev_err(glue->dev, "failed to register notifier for USB-HOST\n");
> +
> +	dev_dbg(glue->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
> +		extcon_get_state(glue->edev, EXTCON_USB),
> +		extcon_get_state(glue->edev, EXTCON_USB_HOST));
> +
> +	/* default as host, switch to device mode if needed */
> +	if (extcon_get_state(glue->edev, EXTCON_USB_HOST) == false)
> +		mtk_musb_set_mailbox(glue, MTK_ID_FLOAT);
> +	if (extcon_get_state(glue->edev, EXTCON_USB) == true)
> +		mtk_musb_set_mailbox(glue, MTK_VBUS_VALID);
> +}
> +
> +static irqreturn_t generic_interrupt(int irq, void *__hci)
> +{
> +	unsigned long flags;
> +	irqreturn_t retval = IRQ_NONE;
> +	struct musb *musb = __hci;
> +
> +	spin_lock_irqsave(&musb->lock, flags);
> +	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB) &
> +	    musb_readb(musb->mregs, MUSB_INTRUSBE);
> +	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX)
> +	    & musb_readw(musb->mregs, MUSB_INTRTXE);
> +	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX)
> +	    & musb_readw(musb->mregs, MUSB_INTRRXE);
> +	/* MediaTek controller interrupt status is W1C */
> +	musb_clearw(musb->mregs, MUSB_INTRRX, musb->int_rx);
> +	musb_clearw(musb->mregs, MUSB_INTRTX, musb->int_tx);
> +	musb_clearb(musb->mregs, MUSB_INTRUSB, musb->int_usb);
> +
> +	if (musb->int_usb || musb->int_tx || musb->int_rx)
> +		retval = musb_interrupt(musb);
> +
> +	spin_unlock_irqrestore(&musb->lock, flags);
> +
> +	return retval;
> +}
> +
> +static irqreturn_t mtk_musb_interrupt(int irq, void *dev_id)
> +{
> +	irqreturn_t retval = IRQ_NONE;
> +	struct musb *musb = (struct musb *)dev_id;
> +	u32 l1_ints;
> +
> +	l1_ints = musb_readl(musb->mregs, USB_L1INTS) &
> +			musb_readl(musb->mregs, USB_L1INTM);
> +
> +	if (l1_ints & (TX_INT_STATUS | RX_INT_STATUS | USBCOM_INT_STATUS))
> +		retval = generic_interrupt(irq, musb);
> +
> +#if defined(CONFIG_USB_INVENTRA_DMA)
> +	if (l1_ints & DMA_INT_STATUS)
> +		retval = dma_controller_irq(irq, musb->dma_controller);
> +#endif
> +	return retval;
> +}
> +
> +static u32 mtk_musb_busctl_offset(u8 epnum, u16 offset)
> +{
> +	return MTK_MUSB_TXFUNCADDR + offset + 8 * epnum;
> +}
> +
> +static void mtk_musb_clearb(void __iomem *addr, unsigned int offset, u8 data)

remove 'u8 data' parameter, then add:

> +{

	u8 data;

> +	/* W1C */
	data = musb_readb(addr, offset);
> +	musb_writeb(addr, offset, data);
> +}
> +
> +static void mtk_musb_clearw(void __iomem *addr, unsigned int offset, u16 data)
> +{
> +	/* W1C */
> +	musb_writew(addr, offset, data);
> +}

similar as mtk_musb_clearb() above.

> +
> +static int mtk_musb_init(struct musb *musb)
> +{
> +	struct device *dev = musb->controller;
> +	struct mtk_glue *glue = dev_get_drvdata(dev->parent);
> +	int ret;

[snip]

> +	if (pdata->mode == USB_DR_MODE_OTG)
> +		mtk_otg_switch_init(glue);
> +
> +	dev_info(dev, "USB probe done!\n");

not really useful, can be removed.

> +	return 0;
> +
> +err_device_register:
> +	mtk_musb_clks_disable(glue);
> +err_enable_clk:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +err_unregister_usb_phy:
> +	usb_phy_generic_unregister(glue->usb_phy);
> +	return ret;
> +}
> +
> +static int mtk_musb_remove(struct platform_device *pdev)
> +{
> +	struct mtk_glue *glue = platform_get_drvdata(pdev);
> +	struct platform_device *usb_phy = glue->usb_phy;
> +
> +	platform_device_unregister(glue->musb_pdev);
> +	usb_phy_generic_unregister(usb_phy);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id mtk_musb_match[] = {
> +	{.compatible = "mediatek,mtk-musb",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_musb_match);
> +#endif
> +
> +static struct platform_driver mtk_musb_driver = {
> +	.probe = mtk_musb_probe,
> +	.remove = mtk_musb_remove,
> +	.driver = {
> +		   .name = "musb-mtk",
> +		   .of_match_table = of_match_ptr(mtk_musb_match),
> +	},
> +};
> +
> +module_platform_driver(mtk_musb_driver);
> +
> +MODULE_DESCRIPTION("MediaTek MUSB Glue Layer");
> +MODULE_AUTHOR("Min Guo <min.guo@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index b7d5627..2c0d102 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -260,6 +260,11 @@ static void musb_default_writeb(void __iomem *addr, unsigned offset, u8 data)
>  	__raw_writeb(data, addr + offset);
>  }
>  
> +static void
> +musb_default_clearb(void __iomem *addr, unsigned int offset, u8 data)
> +{
> +}

don't need this, use musb_readb() for the function pointer.

> +
>  static u16 musb_default_readw(const void __iomem *addr, unsigned offset)
>  {
>  	u16 data = __raw_readw(addr + offset);
> @@ -274,6 +279,43 @@ static void musb_default_writew(void __iomem *addr, unsigned offset, u16 data)
>  	__raw_writew(data, addr + offset);
>  }
>  
> +static void
> +musb_default_clearw(void __iomem *addr, unsigned int offset, u16 data)
> +{
> +}

don't need this, use musb_readw() for the function pointer.

> +
> +static u16 musb_default_get_toggle(struct musb_qh *qh, int is_in)
> +{
> +	void __iomem *epio = qh->hw_ep->regs;
> +	u16 csr;
> +
> +	if (is_in)
> +		csr = musb_readw(epio, MUSB_RXCSR) & MUSB_RXCSR_H_DATATOGGLE;
> +	else
> +		csr = musb_readw(epio, MUSB_TXCSR) & MUSB_TXCSR_H_DATATOGGLE;
> +
> +	return csr;
> +}
> +
> +static u16 musb_default_set_toggle(struct musb_qh *qh, int is_in,
> +	struct urb *urb)
> +{
> +	u16 csr = 0;
> +	u16 toggle = 0;

no need to assign them 0.

> +
> +	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> +
> +	if (is_in)
> +		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
> +				| MUSB_RXCSR_H_DATATOGGLE) : 0;
> +	else
> +		csr |= toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
> +				| MUSB_TXCSR_H_DATATOGGLE)
> +				: MUSB_TXCSR_CLRDATATOG;
> +
> +	return csr;
> +}
> +
>  /*
>   * Load an endpoint's FIFO
>   */
> @@ -370,12 +412,18 @@ static void musb_default_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
>  void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
>  EXPORT_SYMBOL_GPL(musb_writeb);
>  
> +void (*musb_clearb)(void __iomem *addr, unsigned int offset, u8 data);
> +EXPORT_SYMBOL_GPL(musb_clearb);
> +
>  u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
>  EXPORT_SYMBOL_GPL(musb_readw);
>  
>  void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
>  EXPORT_SYMBOL_GPL(musb_writew);
>  
> +void (*musb_clearw)(void __iomem *addr, unsigned int offset, u16 data);
> +EXPORT_SYMBOL_GPL(musb_clearw);
> +
>  u32 musb_readl(const void __iomem *addr, unsigned offset)
>  {
>  	u32 data = __raw_readl(addr + offset);
> @@ -1028,6 +1076,11 @@ static void musb_disable_interrupts(struct musb *musb)
>  	temp = musb_readb(mbase, MUSB_INTRUSB);
>  	temp = musb_readw(mbase, MUSB_INTRTX);
>  	temp = musb_readw(mbase, MUSB_INTRRX);

replace the 3 line above with
	musb_clearb/w();

> +
> +	/* some platform needs clear pending interrupts by manual */
> +	musb_clearb(mbase, MUSB_INTRUSB, musb_readb(mbase, MUSB_INTRUSB));
> +	musb_clearw(mbase, MUSB_INTRRX, musb_readw(mbase, MUSB_INTRRX));
> +	musb_clearw(mbase, MUSB_INTRTX, musb_readw(mbase, MUSB_INTRTX));

then those are no longer needed.

>  }
>  
>  static void musb_enable_interrupts(struct musb *musb)
> @@ -2192,6 +2245,8 @@ static void musb_deassert_reset(struct work_struct *work)
>  	musb_writeb = musb_default_writeb;
>  	musb_readw = musb_default_readw;
>  	musb_writew = musb_default_writew;
> +	musb_clearb = musb_default_clearb;
> +	musb_clearw = musb_default_clearw;
>  
>  	/* The musb_platform_init() call:
>  	 *   - adjusts musb->mregs
> @@ -2252,10 +2307,14 @@ static void musb_deassert_reset(struct work_struct *work)
>  		musb_readb = musb->ops->readb;
>  	if (musb->ops->writeb)
>  		musb_writeb = musb->ops->writeb;
> +	if (musb->ops->clearb)
> +		musb_clearb = musb->ops->clearb;
	else
		musb_clearb = musb_readb;

>  	if (musb->ops->readw)
>  		musb_readw = musb->ops->readw;
>  	if (musb->ops->writew)
>  		musb_writew = musb->ops->writew;
> +	if (musb->ops->clearw)
> +		musb_clearw = musb->ops->clearw;
	else
		musb_clearw = musb_readw;
>  
>  #ifndef CONFIG_MUSB_PIO_ONLY
>  	if (!musb->ops->dma_init || !musb->ops->dma_exit) {
> @@ -2277,6 +2336,16 @@ static void musb_deassert_reset(struct work_struct *work)
>  	else
>  		musb->io.write_fifo = musb_default_write_fifo;
>  
> +	if (musb->ops->get_toggle)
> +		musb->io.get_toggle = musb->ops->get_toggle;
> +	else
> +		musb->io.get_toggle = musb_default_get_toggle;
> +
> +	if (musb->ops->set_toggle)
> +		musb->io.set_toggle = musb->ops->set_toggle;
> +	else
> +		musb->io.set_toggle = musb_default_set_toggle;
> +
>  	if (!musb->xceiv->io_ops) {
>  		musb->xceiv->io_dev = musb->controller;
>  		musb->xceiv->io_priv = musb->mregs;
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 04203b7..71dca80 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -27,6 +27,7 @@
>  struct musb;
>  struct musb_hw_ep;
>  struct musb_ep;
> +struct musb_qh;
>  
>  /* Helper defines for struct musb->hwvers */
>  #define MUSB_HWVERS_MAJOR(x)	((x >> 10) & 0x1f)
> @@ -119,10 +120,14 @@ enum musb_g_ep0_state {
>   * @fifo_offset: returns the fifo offset
>   * @readb:	read 8 bits
>   * @writeb:	write 8 bits
> + * @clearb:	clear 8 bits,

add "could be clear-on-read or W1C" to give more info.

>   * @readw:	read 16 bits
>   * @writew:	write 16 bits
> + * @clearw:	clear 16 bits
>   * @read_fifo:	reads the fifo
>   * @write_fifo:	writes to fifo
> + * @get_toggle:	platform specific get toggle function
> + * @set_toggle:	platform specific set toggle function
>   * @dma_init:	platform specific dma init function
>   * @dma_exit:	platform specific dma exit function
>   * @init:	turns on clocks, sets up platform-specific registers, etc
> @@ -163,10 +168,14 @@ struct musb_platform_ops {
>  	u32	(*busctl_offset)(u8 epnum, u16 offset);
>  	u8	(*readb)(const void __iomem *addr, unsigned offset);
>  	void	(*writeb)(void __iomem *addr, unsigned offset, u8 data);
> +	void	(*clearb)(void __iomem *addr, unsigned int offset, u8 data);
>  	u16	(*readw)(const void __iomem *addr, unsigned offset);
>  	void	(*writew)(void __iomem *addr, unsigned offset, u16 data);
> +	void	(*clearw)(void __iomem *addr, unsigned int offset, u16 data);
>  	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
>  	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
> +	u16	(*get_toggle)(struct musb_qh *qh, int is_in);
> +	u16	(*set_toggle)(struct musb_qh *qh, int is_in, struct urb *urb);
>  	struct dma_controller *
>  		(*dma_init) (struct musb *musb, void __iomem *base);
>  	void	(*dma_exit)(struct dma_controller *c);
> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
> index 8f60271..05103ea 100644
> --- a/drivers/usb/musb/musb_dma.h
> +++ b/drivers/usb/musb/musb_dma.h
> @@ -35,6 +35,12 @@
>   *    whether shared with the Inventra core or separate.
>   */
>  
> +#define MUSB_HSDMA_BASE		0x200
> +#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
> +#define MUSB_HSDMA_CONTROL		0x4
> +#define MUSB_HSDMA_ADDRESS		0x8
> +#define MUSB_HSDMA_COUNT		0xc
> +
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
>  
>  #ifdef CONFIG_MUSB_PIO_ONLY
> @@ -191,6 +197,9 @@ static inline void musb_dma_controller_destroy(struct dma_controller *d) { }
>  extern struct dma_controller *
>  musbhs_dma_controller_create(struct musb *musb, void __iomem *base);
>  extern void musbhs_dma_controller_destroy(struct dma_controller *c);
> +extern struct dma_controller *
> +musbhs_dma_controller_create_noirq(struct musb *musb, void __iomem *base);
> +extern irqreturn_t dma_controller_irq(int irq, void *private_data);
>  
>  extern struct dma_controller *
>  tusb_dma_controller_create(struct musb *musb, void __iomem *base);
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 16d0ba4..ba66f44 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -290,39 +290,23 @@ static void musb_giveback(struct musb *musb, struct urb *urb, int status)
>  static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
>  				    struct urb *urb)
>  {
> -	void __iomem		*epio = qh->hw_ep->regs;
> -	u16			csr;
> +	struct musb *musb = qh->hw_ep->musb;
> +	u16 csr;
>  
>  	/*
>  	 * FIXME: the current Mentor DMA code seems to have
>  	 * problems getting toggle correct.
>  	 */
> -
> -	if (is_in)
> -		csr = musb_readw(epio, MUSB_RXCSR) & MUSB_RXCSR_H_DATATOGGLE;
> -	else
> -		csr = musb_readw(epio, MUSB_TXCSR) & MUSB_TXCSR_H_DATATOGGLE;
> -
> +	csr = musb->io.get_toggle(qh, is_in);
>  	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
>  }
>  
>  static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
>  	struct urb *urb)
>  {
> -	u16 csr = 0;
> -	u16 toggle = 0;
> -
> -	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> -
> -	if (is_in)
> -		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
> -				| MUSB_RXCSR_H_DATATOGGLE) : 0;
> -	else
> -		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
> -				| MUSB_TXCSR_H_DATATOGGLE)
> -				: MUSB_TXCSR_CLRDATATOG;
> +	struct musb *musb = qh->hw_ep->musb;
>  
> -	return csr;
> +	return musb->io.set_toggle(qh, is_in, urb);
>  }

Those two functions - musb_save_toggle() and musb_set_toggle() are very
short now, we can get rid of them, and directly use
musb->io.get/set_toggle().

>  
>  /*
> diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
> index 8058a58..9bae09b 100644
> --- a/drivers/usb/musb/musb_io.h
> +++ b/drivers/usb/musb/musb_io.h
> @@ -22,6 +22,8 @@
>   * @read_fifo:	platform specific function to read fifo
>   * @write_fifo:	platform specific function to write fifo
>   * @busctl_offset: platform specific function to get busctl offset
> + * @get_toggle: platform specific function to get toggle
> + * @set_toggle: platform specific function to set toggle
>   */
>  struct musb_io {
>  	u32	(*ep_offset)(u8 epnum, u16 offset);
> @@ -30,13 +32,17 @@ struct musb_io {
>  	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
>  	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
>  	u32	(*busctl_offset)(u8 epnum, u16 offset);
> +	u16	(*get_toggle)(struct musb_qh *qh, int is_in);
> +	u16	(*set_toggle)(struct musb_qh *qh, int is_in, struct urb *urb);
>  };
>  
>  /* Do not add new entries here, add them the struct musb_io instead */
>  extern u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
>  extern void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
> +extern void (*musb_clearb)(void __iomem *addr, unsigned int offset, u8 data);
>  extern u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
>  extern void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
> +extern void (*musb_clearw)(void __iomem *addr, unsigned int offset, u16 data);
>  extern u32 musb_readl(const void __iomem *addr, unsigned offset);
>  extern void musb_writel(void __iomem *addr, unsigned offset, u32 data);
>  
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index a688f7f..b05fe68 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -10,12 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include "musb_core.h"
> -
> -#define MUSB_HSDMA_BASE		0x200
> -#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
> -#define MUSB_HSDMA_CONTROL		0x4
> -#define MUSB_HSDMA_ADDRESS		0x8
> -#define MUSB_HSDMA_COUNT		0xc
> +#include "musb_dma.h"
>  
>  #define MUSB_HSDMA_CHANNEL_OFFSET(_bchannel, _offset)		\
>  		(MUSB_HSDMA_BASE + (_bchannel << 4) + _offset)
> @@ -268,7 +263,7 @@ static int dma_channel_abort(struct dma_channel *channel)
>  	return 0;
>  }
>  
> -static irqreturn_t dma_controller_irq(int irq, void *private_data)
> +irqreturn_t dma_controller_irq(int irq, void *private_data)
>  {
>  	struct musb_dma_controller *controller = private_data;
>  	struct musb *musb = controller->private_data;
> @@ -291,6 +286,9 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
>  
>  	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
>  
> +	/* some platform needs clear pending interrupts by manual */
> +	musb_clearb(musb->mregs, MUSB_HSDMA_INTR, int_hsdma);
> +
>  	if (!int_hsdma) {
>  		musb_dbg(musb, "spurious DMA irq");
>  
> @@ -382,6 +380,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  	return retval;
>  }
> +EXPORT_SYMBOL_GPL(dma_controller_irq);
>  
>  void musbhs_dma_controller_destroy(struct dma_controller *c)
>  {
> @@ -397,18 +396,10 @@ void musbhs_dma_controller_destroy(struct dma_controller *c)
>  }
>  EXPORT_SYMBOL_GPL(musbhs_dma_controller_destroy);
>  
> -struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
> +static struct musb_dma_controller *dma_controller_alloc(struct musb *musb,
>  						    void __iomem *base)
>  {
>  	struct musb_dma_controller *controller;
> -	struct device *dev = musb->controller;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	int irq = platform_get_irq_byname(pdev, "dma");
> -
> -	if (irq <= 0) {
> -		dev_err(dev, "No DMA interrupt line!\n");
> -		return NULL;
> -	}
>  
>  	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
>  	if (!controller)
> @@ -422,6 +413,25 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
>  	controller->controller.channel_release = dma_channel_release;
>  	controller->controller.channel_program = dma_channel_program;
>  	controller->controller.channel_abort = dma_channel_abort;
> +	return controller;
> +}
> +
> +struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
> +						    void __iomem *base)
> +{
> +	struct musb_dma_controller *controller;
> +	struct device *dev = musb->controller;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq = platform_get_irq_byname(pdev, "dma");
> +
> +	if (irq <= 0) {
> +		dev_err(dev, "No DMA interrupt line!\n");
> +		return NULL;
> +	}
> +
> +	controller = dma_controller_alloc(musb, base);
> +	if (!controller)
> +		return NULL;
>  
>  	if (request_irq(irq, dma_controller_irq, 0,
>  			dev_name(musb->controller), &controller->controller)) {
> @@ -436,3 +446,16 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
>  	return &controller->controller;
>  }
>  EXPORT_SYMBOL_GPL(musbhs_dma_controller_create);
> +
> +struct dma_controller *musbhs_dma_controller_create_noirq(struct musb *musb,
> +						    void __iomem *base)
> +{
> +	struct musb_dma_controller *controller;
> +
> +	controller = dma_controller_alloc(musb, base);
> +	if (!controller)
> +		return NULL;
> +
> +	return &controller->controller;
> +}
> +EXPORT_SYMBOL_GPL(musbhs_dma_controller_create_noirq);

regards,
-Bin.
