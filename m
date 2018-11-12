Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87BDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE7E223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wRxuUq01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE7E223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeKLTCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:02:20 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51322 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeKLTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:02:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAC99iGZ069688;
        Mon, 12 Nov 2018 03:09:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542013784;
        bh=NUbK1Ces8LyeyJjitxpeWxr7jYAvZkZVWQufXUQwpPI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wRxuUq01ow5A0zrFuapalEbJHicLcklYW4/bvtTnuD6RdLv0/urQfkK28E/dzl06w
         aXWjD7n9GNpEyy6GFJpFbjhna6crL6ichWnatKGzne64sP/r9CqH3A/rwHbRxYQaBl
         LxIlM0lAfCKvjgR7UWXX2fkSYcnthlcJ//zKsnRk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAC99it2030444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 03:09:44 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 03:09:44 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 03:09:43 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAC99cEk031642;
        Mon, 12 Nov 2018 03:09:39 -0600
Subject: Re: [PATCH 06/10] phy: Add usb phy support for hi3660 Soc of
 Hisilicon
To:     Yu Chen <chenyu56@huawei.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-7-chenyu56@huawei.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cce0cd9a-c6e1-b2dd-1050-81c3c62461d0@ti.com>
Date:   Mon, 12 Nov 2018 14:39:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027095820.40056-7-chenyu56@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/10/18 3:28 PM, Yu Chen wrote:
> This driver handles usb phy power on and shutdown for hi3660 Soc of
> Hisilicon.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Pengcheng Li <lpc.li@hisilicon.com>
> Cc: Jianguo Sun <sunjianguo1@huawei.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  MAINTAINERS                             |   2 +
>  drivers/phy/hisilicon/Kconfig           |  10 ++
>  drivers/phy/hisilicon/Makefile          |   1 +
>  drivers/phy/hisilicon/phy-hi3660-usb3.c | 254 ++++++++++++++++++++++++++++++++
>  4 files changed, 267 insertions(+)
>  create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e485449f7811..7adf167588ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15294,7 +15294,9 @@ M:	Binghui Wang <wangbinghui@hisilicon.com>
>  L:	linux-usb@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> +F:	Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>  F:	drivers/usb/dwc3/dwc3-hisi.c
> +F:	drivers/phy/hisilicon/phy-hi3660-usb3.c
>  
>  USB ISP116X DRIVER
>  M:	Olav Kongas <ok@artecdesign.ee>
> diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
> index b40ee54a1a50..3c142f08987c 100644
> --- a/drivers/phy/hisilicon/Kconfig
> +++ b/drivers/phy/hisilicon/Kconfig
> @@ -12,6 +12,16 @@ config PHY_HI6220_USB
>  
>  	  To compile this driver as a module, choose M here.
>  
> +config PHY_HI3660_USB
> +	tristate "hi3660 USB PHY support"
> +	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the HISILICON HI3660 USB PHY.
> +
> +	  To compile this driver as a module, choose M here.
> +
>  config PHY_HISTB_COMBPHY
>  	tristate "HiSilicon STB SoCs COMBPHY support"
>  	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
> index f662a4fe18d8..75ba64e2faf8 100644
> --- a/drivers/phy/hisilicon/Makefile
> +++ b/drivers/phy/hisilicon/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
> +obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
>  obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
>  obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
>  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> diff --git a/drivers/phy/hisilicon/phy-hi3660-usb3.c b/drivers/phy/hisilicon/phy-hi3660-usb3.c
> new file mode 100644
> index 000000000000..041c542750e2
> --- /dev/null
> +++ b/drivers/phy/hisilicon/phy-hi3660-usb3.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Phy provider for USB 3.0 controller on HiSilicon 3660 platform
> + *
> + * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
> + *		http://www.huawei.com
> + *
> + * Authors: Yu Chen <chenyu56@huawei.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

This license text doesn't have to added explicitly. It should be already
governed by SPDX line.
> +
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +
> +#define PERI_CRG_CLK_EN4			(0x40)
> +#define PERI_CRG_CLK_DIS4			(0x44)
> +#define GT_CLK_USB3OTG_REF			BIT(0)
> +#define GT_ACLK_USB3OTG				BIT(1)
> +
> +#define PERI_CRG_RSTEN4				(0x90)
> +#define PERI_CRG_RSTDIS4			(0x94)
> +#define IP_RST_USB3OTGPHY_POR			BIT(3)
> +#define IP_RST_USB3OTG				BIT(5)
> +
> +#define PERI_CRG_ISODIS				(0x148)
> +#define USB_REFCLK_ISO_EN			BIT(25)
> +
> +#define PCTRL_PERI_CTRL3			(0x10)
> +#define PCTRL_PERI_CTRL3_MSK_START		(16)
> +#define USB_TCXO_EN				BIT(1)
> +
> +#define PCTRL_PERI_CTRL24			(0x64)
> +#define SC_CLK_USB3PHY_3MUX1_SEL		BIT(25)
> +
> +#define USBOTG3_CTRL0				(0x00)
> +#define SC_USB3PHY_ABB_GT_EN			BIT(15)
> +
> +#define USBOTG3_CTRL2				(0x08)
> +#define USBOTG3CTRL2_POWERDOWN_HSP		BIT(0)
> +#define USBOTG3CTRL2_POWERDOWN_SSP		BIT(1)
> +
> +#define USBOTG3_CTRL3				(0x0C)
> +#define USBOTG3_CTRL3_VBUSVLDEXT		BIT(6)
> +#define USBOTG3_CTRL3_VBUSVLDEXTSEL		BIT(5)
> +
> +#define USBOTG3_CTRL4				(0x10)
> +
> +#define USBOTG3_CTRL7				(0x1c)
> +#define REF_SSP_EN				BIT(16)
> +
> +#define HI3660_USB_DEFAULT_PHY_PARAM		(0x1c466e3)
> +
> +struct hi3660_priv {
> +	struct device *dev;
> +	struct regmap *peri_crg;
> +	struct regmap *pctrl;
> +	struct regmap *otg_bc;
> +	u32 eye_diagram_param;
> +
> +	u32 peri_crg_offset;
> +	u32 pctrl_offset;
> +	u32 otg_bc_offset;
> +};
> +
> +static int hi3660_phy_init(struct phy *phy)
> +{
> +	struct hi3660_priv *priv = phy_get_drvdata(phy);
> +	u32 val, mask;
> +	int ret;
> +
> +	/* usb refclk iso disable */
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS, USB_REFCLK_ISO_EN);
> +	if (ret)
> +		goto out;
> +
> +	/* enable usb_tcxo_en */
> +	val = USB_TCXO_EN | (USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
> +	ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3, val);
> +	if (ret)
> +		goto out;
> +
> +	/* select usbphy clk from abb */
> +	mask = SC_CLK_USB3PHY_3MUX1_SEL;

Shouldn't we use clock API's for enabling/selecting clocks?
> +	ret = regmap_update_bits(priv->pctrl, PCTRL_PERI_CTRL24, mask, 0);
> +	if (ret)
> +		goto out;
> +
> +	/* assert phy */
> +	val = IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG;
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTEN4, val);
> +	if (ret)
> +		goto out;
> +
> +	/* enable phy ref clk */
> +	val = SC_USB3PHY_ABB_GT_EN;
> +	mask = val;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL0, mask, val);
> +	if (ret)
> +		goto out;
> +
> +	val = REF_SSP_EN;
> +	mask = val;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL7, mask, val);
> +	if (ret)
> +		goto out;
> +
> +	/* exit from IDDQ mode */
> +	mask = USBOTG3CTRL2_POWERDOWN_HSP | USBOTG3CTRL2_POWERDOWN_SSP;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL2, mask, 0);
> +	if (ret)
> +		goto out;
> +
> +	udelay(100);

Please add a comment for this delay. Does the HW manual states that or it's a
result of experimentation.

Also according to timers/timers-howto.txt, it's preferable to use usleep_range
for 10us - 20ms.
> +
> +	/* deassert phy */
> +	val = IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG;
> +	ret = regmap_write(priv->peri_crg, PERI_CRG_RSTDIS4, val);
> +	if (ret)
> +		goto out;
> +
> +	usleep_range(10000, 15000);

Add a comment for this delay.
> +
> +	/* fake vbus valid signal */
> +	val = USBOTG3_CTRL3_VBUSVLDEXT | USBOTG3_CTRL3_VBUSVLDEXTSEL;
> +	mask = val;
> +	ret = regmap_update_bits(priv->otg_bc, USBOTG3_CTRL3, mask, val);
> +	if (ret)
> +		goto out;
> +
> +	udelay(100);

Same comment here.

Thanks
Kishon
