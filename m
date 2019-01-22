Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3033320861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SnXruTUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfAVGUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:20:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64469 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVGUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:20:23 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190122062016epoutp02b19a10999275805bcdebdacfca4937b2~8F1LGk8fc0522305223epoutp02V
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:20:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190122062016epoutp02b19a10999275805bcdebdacfca4937b2~8F1LGk8fc0522305223epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548138016;
        bh=7vD4XzFlSZIIRmcj9jPrr0E0a6cV6Trk+WM2P0nUCOI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SnXruTUEm8v8KRlFfxznbQmh2fmnZA+pmhkr9lXOIEnKKHPUK91cu/n8VzyHMVwcm
         1pWcG7G/zBCiIwULVX8oGq+1BWa8zC6mf3rcM/ZRqA0eA6h28vlHmSwV2eKjXJfeb0
         pX8bNV25Ij2a2Tjwcla14ocIVWjylXT9KK97q11A=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190122062013epcas1p119f3987c3dd386f870ba94a511a21a81~8F1IxeNom2884628846epcas1p14;
        Tue, 22 Jan 2019 06:20:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.83.04074.916B64C5; Tue, 22 Jan 2019 15:20:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190122062009epcas1p1ffd45055df60163d8f9e3d5bbf95df12~8F1Ez4aoP2885028850epcas1p1d;
        Tue, 22 Jan 2019 06:20:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190122062009epsmtrp26d574ba0a9c4b02bfbe843be3feafbd9~8F1EzEefr1941019410epsmtrp2D;
        Tue, 22 Jan 2019 06:20:09 +0000 (GMT)
X-AuditID: b6c32a35-6eb5f9c000000fea-de-5c46b619708a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.E9.03601.916B64C5; Tue, 22 Jan 2019 15:20:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190122062009epsmtip16d9d1b585b08fcef3f663a5552f74c3c~8F1Ermb1x2387623876epsmtip1F;
        Tue, 22 Jan 2019 06:20:09 +0000 (GMT)
Subject: Re: [PATCH] drivers: extcon: Add support for ptn5150
To:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7a12a709-ad89-0e79-7748-9602e2439278@samsung.com>
Date:   Tue, 22 Jan 2019 15:20:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTV1dym1uMQet2G4vLu+awWdxuXMFm
        8XL/dFYHZo+ds+6ye/RtWcXo8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtAiJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        ZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xsb+BYwFd/oYK3YfP8jUwPiwoIuRk0NCwETiwNYj
        rF2MXBxCAjsYJc7c2skI4XxilDg7YSYbhPONUaLp7hk2mJZpfQfYIRJ7GSXuP1kE5bxnlLj3
        6QyQw8EhLGAr8f5VFkiDiECIxMLei2BhZgEZie8HJEHCbAJaEvtf3ACbyS+gKHH1x2NGEJtX
        wE5i2obprCA2i4CqxJFbrUwgtqhAhETH/dVsEDWCEidnPmEBsTkFAiUuX9gMFmcWEJe49WQ+
        E4QtL9G8dTYzyGkSAifYJO5+uMcM8YCLRPvyVnYIW1ji1fEtULaUxOd3e6GerJZYefIIG0Rz
        B6PElv0XWCESxhL7l05mgnhGU2L9Ln2IZXwS7772sIKEJQR4JTrahCCqlSUuP7jLBGFLSixu
        74Qa7yHR3tvPPIFRcRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDAEDm2NzGCE6GW6Q7G
        Ked8DjEKcDAq8fBynHONEWJNLCuuzD3EKMHBrCTCKzjHLUaINyWxsiq1KD++qDQntfgQoykw
        tCcyS4km5wOTdF5JvKGpkbGxsYWJoZmpoaGSOO96B+cYIYH0xJLU7NTUgtQimD4mDk6pBsbV
        7bmXTFv3HRTzuZ6+bMdVv/nFV4MCPv14vLHsCpef1Jkri0JqAk4c/Bu0nG9yzbfQm4t9mNc1
        XDh3dSb3gi87/1UrWd1Otf/w6syfPSfkeANd1H7UhHsrGcT2fbONUvjCqFS8SvT1I3ensz/L
        +CWVn1zPvyv6ryXK8ULprEfLOTUVwroCInYrsRRnJBpqMRcVJwIAHYPm5poDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnK7kNrcYg86P4haXd81hs7jduILN
        4uX+6awOzB47Z91l9+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6Mjf0LGAvu9DFW7D5+kKmB
        8WFBFyMnh4SAicS0vgPsXYxcHEICuxkljiw9wAiRkJSYdvEocxcjB5AtLHH4cDFEzVtGiRX/
        LzGBxIUFbCXev8oCKRcRCJGYd3kxK0iYWUBG4vsBSZCwkMASRok7q3xBbDYBLYn9L26wgdj8
        AooSV388BtvEK2AnMW3DdFYQm0VAVeLIrVYmEFtUIELi7Mt1UDWCEidnPmEBsTkFAiUuX9gM
        NodZQF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJue
        W2xYYJSXWq5XnJhbXJqXrpecn7uJERwPWlo7GE+ciD/EKMDBqMTDm3DBNUaINbGsuDL3EKME
        B7OSCK/gHLcYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxS
        DYzLJh4245ef+3iylKNThiJTsuvMBsU/H99yJa3Un9L3aLHMJpGv/w/f5J/StWSeRarjrisu
        z/Juv9QWfPFroV/Ofz39eq5Q/uJrX0Mucxw+cOnC/pdvv28o1/zOyri5fet1Ft3pQgf7eW5t
        4uOr/9ro+9a+svTAzskxW7nPS1WdSp52jCsn7NR2JZbijERDLeai4kQAGsTqpIMCAAA=
X-CMS-MailID: 20190122062009epcas1p1ffd45055df60163d8f9e3d5bbf95df12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190121091105epcas2p4bad949be391e855358295cf3eae8d773
References: <CGME20190121091105epcas2p4bad949be391e855358295cf3eae8d773@epcas2p4.samsung.com>
        <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijai,

This patch looks better. But theare are comments about code clean.
I added the comments.

On 19. 1. 21. 오후 6:09, Vijai Kumar K wrote:
> PTN5150A is a small thin low power CC Logic chip supporting
> the USB Type-C connector application with Configurationn Channel(CC)
> control logic detection and indication functions.
> 
> Add driver, Kconfig and Makefile entries.
> 
> Change-Id: I3b2da147a33b913b9ec60cd914b20acd955950c7

Remove it of gerrit system.

> Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> ---
>  .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  22 ++
>  drivers/extcon/Kconfig                             |   8 +
>  drivers/extcon/Makefile                            |   1 +
>  drivers/extcon/extcon-ptn5150.c                    | 327 +++++++++++++++++++++
>  drivers/extcon/extcon-ptn5150.h                    |  51 ++++
>  5 files changed, 409 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
>  create mode 100644 drivers/extcon/extcon-ptn5150.c
>  create mode 100644 drivers/extcon/extcon-ptn5150.h
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> new file mode 100644
> index 0000000..8ea33bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> @@ -0,0 +1,22 @@
> +
> +* PTN5150 CC logic device

You better to specify the full name as following:
: PTN5150 CC (Configuration Channel) Logic device

> +PTN5150A is a small thin low power CC Logic chip supporting the USB Type-C

s/Logic/logic

> +connector application with Configuration Channel (CC) control logic detection and
> +indication functions. It is Interfaced to the host controller using an I2C interface.

s/Interfaced/interfaced

> +
> +Required properties:
> +- compatible: Should be "nxp,ptn5150"
> +- reg: Specifies the I2C slave address of the device
> +- int-gpio: GPIO to which INTB is connected

What is meaning of 'INTB'?

> +- vbus-gpio: GPIO which controls VBUS on/off
> +
> +Example:
> +		ptn5150@1d  {
> +			compatible = "nxp,ptn5150";
> +			reg = <0x1d>;
> +			int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
> +			vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ptn5150_default>;

You need to add some description why pinctrl properties are needed.
For example, some hwmon device driver[1] explained the properties
related to pinctrl. Please add the description as following.

- pinctrl-names : a pinctrl state named "default" must be defined.              
- pinctrl-0 : phandle referencing pin configuration of the PWM ports.           

[1] Documentation/devicetree/hwmon/aspeed-pwm-tacho.txt


> +			status = "okay";
> +		};

Remove the one tab in front of dt node.

	ptn5150@1d  {
		compatible = "nxp,ptn5150";
		reg = <0x1d>;
		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
		pinctrl-names = "default";
		pinctrl-0 = <&ptn5150_default>;
		status = "okay";
	};



> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index a7bca42..6adc797 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -113,6 +113,14 @@ config EXTCON_PALMAS
>  	  Say Y here to enable support for USB peripheral and USB host
>  	  detection by palmas usb.
>  
> +config EXTCON_PTN5150
> +	tristate "PTN5150 CC LOGIC USB EXTCON support"

PTN5150 CC (Configuration Channel) LOGIC USB EXTCON support

> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for USB peripheral and USB host
> +	  detection by ptn5150 cc logic chip.

cc -> CC (Configuration Channel)

> +
>  config EXTCON_QCOM_SPMI_MISC
>  	tristate "Qualcomm USB extcon support"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 0888fde..261ce4c 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
>  obj-$(CONFIG_EXTCON_MAX77843)	+= extcon-max77843.o
>  obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
>  obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
> +obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
>  obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
>  obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
>  obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> new file mode 100644
> index 0000000..bc00874
> --- /dev/null
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -0,0 +1,327 @@
> +/*
> + * extcon-ptn5150.c - PTN5150 CC logic extcon driver to support USB detection
> + *
> + * Copyright (c) 2018-2019 by Vijai Kumar K
> + * Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> + *
> + * Based on extcon-sm5502.c driver
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */

Please SPDX license format instead of old type as following according to your
license: You can find the SPDX examples in kernel code easily.

//SPDX-License-Identifier: GPL-2.0+
//
// extcon-ptn5150.c - Extcon driver to support USB detection for PTN5150 CC logic
//                                                                              
//  Copyright (C) 2018-2019 by Vijai Kumar K
//  Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>

> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/extcon.h>

This extcon driver is provider driver. You have to change is as following:
- extcon.h -> extcon-provider.h

extcon.h header file should be used on extcon consumer driver.

> +#include <linux/gpio.h>
> +
> +#include "extcon-ptn5150.h"

extcon-ptn5150.h header file is only used on drivers/extcon/extcon-ptn5150.c.
You don't need to create the separate header file. Please move all definitions
of extcon-ptn5150.h to extcon-pth5150.c and remove extcon-ptn5150.h.

> +
> +struct ptn5150_info {
> +	struct device *dev;
> +	struct extcon_dev *edev;
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
> +	struct gpio_desc *int_gpiod;
> +	struct gpio_desc *vbus_gpiod;
> +	int irq;
> +	struct work_struct irq_work;
> +	struct mutex mutex;
> +};
> +
> +/* List of detectable cables */
> +static const unsigned int ptn5150_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_NONE,
> +};
> +
> +static const struct regmap_config ptn5150_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= PTN5150_REG_END,
> +};
> +
> +static void ptn5150_irq_work(struct work_struct *work)
> +{
> +	struct ptn5150_info *info = container_of(work,
> +			struct ptn5150_info, irq_work);
> +	int ret = 0;
> +	unsigned int reg_data;
> +	unsigned int port_status;
> +	unsigned int vbus;

port_status and vbus are not always used. You can define them
under 'if (cable_attach) {' sentence.

> +	unsigned int cable_attach;
> +	unsigned int int_status;
> +
> +	if (!info->edev)
> +		return;
> +
> +	mutex_lock(&info->mutex);
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read CC STATUS %d\n", ret);

You is able to make it on one line as following: it is not over 80 line.
		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);


> +		mutex_unlock(&info->mutex);
> +		return;
> +	}

Add one blank line.

> +	/* Clear interrupt. Read would clear the register */
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
> +	if (ret) {> +		dev_err(info->dev,
> +			"failed to read INT STATUS %d\n", ret);

ditto.

> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +	if (int_status) {
> +		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
> +		if (cable_attach) {

			unsigned int port_status;
			unsigned int vbus;


> +			port_status = ((reg_data &
> +					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
> +					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
> +
> +			switch (port_status) {
> +			case PTN5150_DFP_ATTACHED:
> +				extcon_set_state_sync(info->edev,
> +						      EXTCON_USB_HOST, false);

You have to use tab for indentation. Please remove all space for indentation.

> +				gpiod_set_value(info->vbus_gpiod, 0);
> +				extcon_set_state_sync(info->edev, EXTCON_USB,
> +						      true);

ditto.

> +				break;
> +			case PTN5150_UFP_ATTACHED:
> +				extcon_set_state_sync(info->edev, EXTCON_USB,
> +						      false);

ditto.

> +				vbus = ((reg_data &
> +					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
> +					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
> +				if (vbus)
> +					gpiod_set_value(info->vbus_gpiod, 0);
> +				else
> +					gpiod_set_value(info->vbus_gpiod, 1);
> +
> +				extcon_set_state_sync(info->edev,
> +						      EXTCON_USB_HOST, true);

ditto.

> +				break;
> +			default:
> +				dev_err(info->dev,
> +					"Unknown Port status : %x\n",
> +					port_status);
> +				break;
> +			}
> +		} else {
> +			extcon_set_state_sync(info->edev,
> +					      EXTCON_USB_HOST, false);

ditto.

> +			extcon_set_state_sync(info->edev,
> +					      EXTCON_USB, false);

ditto.

> +			gpiod_set_value(info->vbus_gpiod, 0);
> +		}
> +	}
> +
> +	/* Clear interrupt. Read would clear the register */
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
> +				&int_status);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read INT REG STATUS %d\n", ret);
> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +

Remove redundant blank line.

> +	mutex_unlock(&info->mutex);
> +}
> +
> +

Remove redundant blank line.

> +static irqreturn_t ptn5150_irq_handler(int irq, void *data)
> +{
> +	struct ptn5150_info *info = data;
> +
> +	schedule_work(&info->irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ptn5150_init_dev_type(struct ptn5150_info *info)
> +{
> +	unsigned int reg_data, vendor_id, version_id;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_DEVICE_ID, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev, "failed to read DEVICE_ID %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
> +				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
> +	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
> +				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
> +
> +	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
> +			    version_id, vendor_id);
> +
> +	/* Clear any existing interrupts */
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read PTN5150_REG_INT_STATUS %d\n",
> +			ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"failed to read PTN5150_REG_INT_REG_STATUS %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ptn5150_i2c_probe(struct i2c_client *i2c,
> +				 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct device_node *np = i2c->dev.of_node;
> +	struct ptn5150_info *info;
> +	int ret;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	i2c_set_clientdata(i2c, info);
> +
> +	info->dev = &i2c->dev;
> +	info->i2c = i2c;
> +	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
> +	if (!info->int_gpiod) {
> +		dev_err(dev, "failed to get INT GPIO\n");
> +		return -EINVAL;
> +	}
> +	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
> +	if (!info->vbus_gpiod) {
> +		dev_err(dev, "failed to get VBUS GPIO\n");
> +		return -EINVAL;
> +	}
> +	ret = gpiod_direction_output(info->vbus_gpiod, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to set VBUS GPIO direction\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&info->mutex);
> +
> +	INIT_WORK(&info->irq_work, ptn5150_irq_work);
> +
> +	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		ret = PTR_ERR(info->regmap);
> +		dev_err(info->dev, "failed to allocate register map: %d\n",
> +				   ret);
> +		return ret;
> +	}
> +
> +	if (info->int_gpiod) {
> +		info->irq = gpiod_to_irq(info->int_gpiod);
> +		if (info->irq < 0) {
> +			dev_err(dev, "failed to get INTB IRQ\n");
> +			return info->irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, info->irq, NULL,
> +						ptn5150_irq_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						i2c->name, info);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request handler for INTB IRQ\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Allocate extcon device */
> +	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
> +	if (IS_ERR(info->edev)) {
> +		dev_err(info->dev, "failed to allocate memory for extcon\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Register extcon device */
> +	ret = devm_extcon_dev_register(info->dev, info->edev);
> +	if (ret) {
> +		dev_err(info->dev, "failed to register extcon device\n");
> +		return ret;
> +	}
> +
> +	/* Initialize PTN5150 device and print vendor id and version id */
> +	ret = ptn5150_init_dev_type(info);
> +	if (ret)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ptn5150_i2c_remove(struct i2c_client *i2c)
> +{
> +	return 0;
> +}

Please remove dummy ptn5150_i2c_remove() defintions.
If the remove function on later, you can add it. 

> +
> +static const struct of_device_id ptn5150_dt_match[] = {
> +	{ .compatible = "nxp,ptn5150" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ptn5150_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int ptn5150_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif

Please remove dummy functions (_suspend, _resume). You can add it on later. 


> +
> +static SIMPLE_DEV_PM_OPS(ptn5150_pm_ops,
> +			 ptn5150_suspend, ptn5150_resume);

Remove it.

> +
> +static const struct i2c_device_id ptn5150_i2c_id[] = {
> +	{ "ptn5150", TYPE_PTN5150A },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
> +
> +static struct i2c_driver ptn5150_i2c_driver = {
> +	.driver		= {
> +		.name	= "ptn5150",
> +		.pm	= &ptn5150_pm_ops,

Remove it.

> +		.of_match_table = ptn5150_dt_match,
> +	},
> +	.probe	= ptn5150_i2c_probe,
> +	.remove	= ptn5150_i2c_remove,

Remove it.

> +	.id_table = ptn5150_i2c_id,
> +};
> +
> +static int __init ptn5150_i2c_init(void)
> +{
> +	return i2c_add_driver(&ptn5150_i2c_driver);
> +}
> +subsys_initcall(ptn5150_i2c_init);
> +
> +MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
> +MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
> +MODULE_LICENSE("GPL");

If you use SPDX license format, you dont' need to add module information.
Please remove MODULE_*() macro.

> diff --git a/drivers/extcon/extcon-ptn5150.h b/drivers/extcon/extcon-ptn5150.h

As I already commented, you have to move all definitiosn of extcon-ptn5150.h
to extcon-ptn5150.c and remove extcon-ptn5150.h.

> new file mode 100644
> index 0000000..217dab0
> --- /dev/null
> +++ b/drivers/extcon/extcon-ptn5150.h
> @@ -0,0 +1,51 @@
> +/*
> + * extcon-ptn5150.h
> + *
> + * Copyright (c) 2018-2019 by Vijai Kumar K
> + * Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __LINUX_EXTCON_PTN5150_H
> +#define __LINUX_EXTCON_PTN5150_H
> +
> +enum ptn5150_types {
> +	TYPE_PTN5150A,

Do you have additional plan to suppor other type for extcon-ptn5150.c driver?
If extcon-ptn5150.c supports only one driver, you don't need to this enumeration.

> +};
> +
> +/* PTN5150 registers */
> +enum ptn5150_reg {
> +	PTN5150_REG_DEVICE_ID = 0x01,
> +	PTN5150_REG_CONTROL,
> +	PTN5150_REG_INT_STATUS,
> +	PTN5150_REG_CC_STATUS,
> +	PTN5150_REG_CON_DET = 0x09,
> +	PTN5150_REG_VCONN_STATUS,
> +	PTN5150_REG_RESET,
> +	PTN5150_REG_INT_MASK = 0x18,
> +	PTN5150_REG_INT_REG_STATUS,
> +	PTN5150_REG_END,
> +};
> +
> +#define PTN5150_DFP_ATTACHED			0x1
> +#define PTN5150_UFP_ATTACHED			0x2
> +
> +/* Define PTN5150 MASK/SHIFT constant */
> +#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
> +#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
> +#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
> +#define PTN5150_REG_DEVICE_ID_VERSION_MASK	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
> +
> +#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
> +#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
> +#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
> +#define PTN5150_REG_CC_VBUS_DETECTION_MASK	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
> +#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
> +#define PTN5150_REG_INT_CABLE_ATTACH_MASK	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
> +#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
> +#define PTN5150_REG_INT_CABLE_DETACH_MASK	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
> +#endif /*  __LINUX_EXTCON_PTN5150_H */
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
