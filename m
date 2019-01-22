Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76219C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C5020854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkGibwNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfAVHzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:55:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35085 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfAVHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:55:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so11383242pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=REvApJ0GDtR4rTaz7OxsaNAvzEUs+8lQW3QmiJ4p8UM=;
        b=nkGibwNYnBZjp+egFUh405G1PfdzCDqaAoLIbiZ4rmAsoXb/kXWbgsjMMMQ4t/6g4+
         AN2ZnrzmaGwSxyWZ+0ZPg0A856w2xCXiTLXcdFhXg8+xWG9mlTx2gBuw5NarZJl31/zu
         vuanGPnn69ueIY4JCNvHm+lp5BacYGBKqhNEUkRjhVgQO2fDiDowUdfZWH7UL4Fd54zK
         WcwijJahCorWLNRK21uLGPzZNhto4dbUy3DiF2piqOvFkURdikHi8r3ROoktbKzfWeVG
         tUUAk3iiEtZrfWuLfEWUOu0IHRINA4PlcJyQE0yJ7l3Yr8dLawVbbacy1Gr6dQpMPJES
         oZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=REvApJ0GDtR4rTaz7OxsaNAvzEUs+8lQW3QmiJ4p8UM=;
        b=oTKcmjr4Gv96UzEbWRsUXLF6XNfn6sI94Va9nO6+vo+kzfvvvKoev7YKfPlRnb/W15
         rqeSyTLRGXmwKbOhzNOHwtYfxKoZ8hncGJVShqHYfmacaLB3aZByYI4K4m6n2e+f8x39
         pVzi0T47lsEm1cOtN1geeI75fOx8ShYM4/q/ttncE3kyHox310b6jiU9p1FF9FsUzojr
         LiYYB3u+WV+Lnh2AEAOQd1uh5UuSSdi8V2CrgkIHzGilQ8No0p2rNPRktxFecfZHKHCI
         Z+qbPBDBTSRIBoaigWhO9Kb52lz+iDBHQJTBY6blCZqvmt4H/IHHtQ+i97odWgLRJZC6
         zBMQ==
X-Gm-Message-State: AJcUukdHt4Bozuq+Hxe2JtDYw2Iqr+7MTqtJgQGcsD01o5Y0Bm0E9JXH
        4UTK/82FghNl/qirSgjnojbbmwfsd1k=
X-Google-Smtp-Source: ALg8bN5SOe0oaoiSUPZ0aPJHbMCFHBiOgQjMGUhfdJkBYTWmsmeWVGNb3rJXnGN/Dx3yKO06vSVawg==
X-Received: by 2002:a63:587:: with SMTP id 129mr30722677pgf.273.1548143752764;
        Mon, 21 Jan 2019 23:55:52 -0800 (PST)
Received: from chikyu ([106.51.36.2])
        by smtp.gmail.com with ESMTPSA id m19sm31485402pgn.35.2019.01.21.23.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 23:55:52 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:25:48 +0530
From:   Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com
Subject: Re: [PATCH] drivers: extcon: Add support for ptn5150
Message-ID: <20190122075548.GA30388@chikyu>
References: <CGME20190121091105epcas2p4bad949be391e855358295cf3eae8d773@epcas2p4.samsung.com>
 <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
 <7a12a709-ad89-0e79-7748-9602e2439278@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a12a709-ad89-0e79-7748-9602e2439278@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:20:09PM +0900, Chanwoo Choi wrote:
> Hi Vijai,
> 
> This patch looks better. But theare are comments about code clean.
> I added the comments.
> 
Thanks. And Thank you for reviewing it Chanwoo. Please find my inline comments.

I will rebase, implement the review comments and will push an updated
patch.
> On 19. 1. 21. 오후 6:09, Vijai Kumar K wrote:
> > PTN5150A is a small thin low power CC Logic chip supporting
> > the USB Type-C connector application with Configurationn Channel(CC)
> > control logic detection and indication functions.
> > 
> > Add driver, Kconfig and Makefile entries.
> > 
> > Change-Id: I3b2da147a33b913b9ec60cd914b20acd955950c7
> 
> Remove it of gerrit system.
> 
Sure.

> > Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> > ---
> >  .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  22 ++
> >  drivers/extcon/Kconfig                             |   8 +
> >  drivers/extcon/Makefile                            |   1 +
> >  drivers/extcon/extcon-ptn5150.c                    | 327 +++++++++++++++++++++
> >  drivers/extcon/extcon-ptn5150.h                    |  51 ++++
> >  5 files changed, 409 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> >  create mode 100644 drivers/extcon/extcon-ptn5150.c
> >  create mode 100644 drivers/extcon/extcon-ptn5150.h
> > 
> > diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> > new file mode 100644
> > index 0000000..8ea33bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
> > @@ -0,0 +1,22 @@
> > +
> > +* PTN5150 CC logic device
> 
> You better to specify the full name as following:
> : PTN5150 CC (Configuration Channel) Logic device
> 
> > +PTN5150A is a small thin low power CC Logic chip supporting the USB Type-C
> 
> s/Logic/logic
> 
noted.

> > +connector application with Configuration Channel (CC) control logic detection and
> > +indication functions. It is Interfaced to the host controller using an I2C interface.
> 
> s/Interfaced/interfaced
> 
noted.

> > +
> > +Required properties:
> > +- compatible: Should be "nxp,ptn5150"
> > +- reg: Specifies the I2C slave address of the device
> > +- int-gpio: GPIO to which INTB is connected
> 
> What is meaning of 'INTB'?
> 
INTB is the interrupt out pin of PTN5150.

> > +- vbus-gpio: GPIO which controls VBUS on/off
> > +
> > +Example:
> > +		ptn5150@1d  {
> > +			compatible = "nxp,ptn5150";
> > +			reg = <0x1d>;
> > +			int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
> > +			vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&ptn5150_default>;
> 
> You need to add some description why pinctrl properties are needed.
> For example, some hwmon device driver[1] explained the properties
> related to pinctrl. Please add the description as following.
> 
> - pinctrl-names : a pinctrl state named "default" must be defined.              
> - pinctrl-0 : phandle referencing pin configuration of the PWM ports.           
> 
> [1] Documentation/devicetree/hwmon/aspeed-pwm-tacho.txt
> 
Thanks for the pointer. Will look into it and add appropiate description.

> 
> > +			status = "okay";
> > +		};
> 
> Remove the one tab in front of dt node.
noted.

> 
> 	ptn5150@1d  {
> 		compatible = "nxp,ptn5150";
> 		reg = <0x1d>;
> 		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
> 		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&ptn5150_default>;
> 		status = "okay";
> 	};
> 
> 
> 
> > diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> > index a7bca42..6adc797 100644
> > --- a/drivers/extcon/Kconfig
> > +++ b/drivers/extcon/Kconfig
> > @@ -113,6 +113,14 @@ config EXTCON_PALMAS
> >  	  Say Y here to enable support for USB peripheral and USB host
> >  	  detection by palmas usb.
> >  
> > +config EXTCON_PTN5150
> > +	tristate "PTN5150 CC LOGIC USB EXTCON support"
> 
> PTN5150 CC (Configuration Channel) LOGIC USB EXTCON support
> 
noted.

> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y here to enable support for USB peripheral and USB host
> > +	  detection by ptn5150 cc logic chip.
> 
> cc -> CC (Configuration Channel)
> 
noted.

> > +
> >  config EXTCON_QCOM_SPMI_MISC
> >  	tristate "Qualcomm USB extcon support"
> >  	depends on ARCH_QCOM || COMPILE_TEST
> > diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> > index 0888fde..261ce4c 100644
> > --- a/drivers/extcon/Makefile
> > +++ b/drivers/extcon/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
> >  obj-$(CONFIG_EXTCON_MAX77843)	+= extcon-max77843.o
> >  obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
> >  obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
> > +obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
> >  obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
> >  obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
> >  obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
> > diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> > new file mode 100644
> > index 0000000..bc00874
> > --- /dev/null
> > +++ b/drivers/extcon/extcon-ptn5150.c
> > @@ -0,0 +1,327 @@
> > +/*
> > + * extcon-ptn5150.c - PTN5150 CC logic extcon driver to support USB detection
> > + *
> > + * Copyright (c) 2018-2019 by Vijai Kumar K
> > + * Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> > + *
> > + * Based on extcon-sm5502.c driver
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> 
> Please SPDX license format instead of old type as following according to your
> license: You can find the SPDX examples in kernel code easily.
> 
> //SPDX-License-Identifier: GPL-2.0+
> //
> // extcon-ptn5150.c - Extcon driver to support USB detection for PTN5150 CC logic
> //                                                                              
> //  Copyright (C) 2018-2019 by Vijai Kumar K
> //  Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> 
Noted. Will update them.

> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/extcon.h>
> 
> This extcon driver is provider driver. You have to change is as following:
> - extcon.h -> extcon-provider.h
> 
> extcon.h header file should be used on extcon consumer driver.
> 
noted.

> > +#include <linux/gpio.h>
> > +
> > +#include "extcon-ptn5150.h"
> 
> extcon-ptn5150.h header file is only used on drivers/extcon/extcon-ptn5150.c.
> You don't need to create the separate header file. Please move all definitions
> of extcon-ptn5150.h to extcon-pth5150.c and remove extcon-ptn5150.h.
> 
Sure, I will move them to extcon-ptn5150.c file.

> > +
> > +struct ptn5150_info {
> > +	struct device *dev;
> > +	struct extcon_dev *edev;
> > +	struct i2c_client *i2c;
> > +	struct regmap *regmap;
> > +	struct gpio_desc *int_gpiod;
> > +	struct gpio_desc *vbus_gpiod;
> > +	int irq;
> > +	struct work_struct irq_work;
> > +	struct mutex mutex;
> > +};
> > +
> > +/* List of detectable cables */
> > +static const unsigned int ptn5150_extcon_cable[] = {
> > +	EXTCON_USB,
> > +	EXTCON_USB_HOST,
> > +	EXTCON_NONE,
> > +};
> > +
> > +static const struct regmap_config ptn5150_regmap_config = {
> > +	.reg_bits	= 8,
> > +	.val_bits	= 8,
> > +	.max_register	= PTN5150_REG_END,
> > +};
> > +
> > +static void ptn5150_irq_work(struct work_struct *work)
> > +{
> > +	struct ptn5150_info *info = container_of(work,
> > +			struct ptn5150_info, irq_work);
> > +	int ret = 0;
> > +	unsigned int reg_data;
> > +	unsigned int port_status;
> > +	unsigned int vbus;
> 
> port_status and vbus are not always used. You can define them
> under 'if (cable_attach) {' sentence.
> 
It is not always used. Will move it under 'if (cable_attach) {' sentence.

> > +	unsigned int cable_attach;
> > +	unsigned int int_status;
> > +
> > +	if (!info->edev)
> > +		return;
> > +
> > +	mutex_lock(&info->mutex);
> > +
> > +	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
> > +	if (ret) {
> > +		dev_err(info->dev,
> > +			"failed to read CC STATUS %d\n", ret);
> 
> You is able to make it on one line as following: it is not over 80 line.
> 		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
> 
> 
> > +		mutex_unlock(&info->mutex);
> > +		return;
> > +	}
> 
> Add one blank line.
>
noted. 

> > +	/* Clear interrupt. Read would clear the register */
> > +	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
> > +	if (ret) {> +		dev_err(info->dev,
> > +			"failed to read INT STATUS %d\n", ret);
> 
> ditto.
> 
noted.

> > +		mutex_unlock(&info->mutex);
> > +		return;
> > +	}
> > +
> > +	if (int_status) {
> > +		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
> > +		if (cable_attach) {
> 
> 			unsigned int port_status;
> 			unsigned int vbus;
> 
> 
> > +			port_status = ((reg_data &
> > +					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
> > +					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
> > +
> > +			switch (port_status) {
> > +			case PTN5150_DFP_ATTACHED:
> > +				extcon_set_state_sync(info->edev,
> > +						      EXTCON_USB_HOST, false);
> 
> You have to use tab for indentation. Please remove all space for indentation.
> 
oops. noted.

> > +				gpiod_set_value(info->vbus_gpiod, 0);
> > +				extcon_set_state_sync(info->edev, EXTCON_USB,
> > +						      true);
> 
> ditto.
> 
noted.

> > +				break;
> > +			case PTN5150_UFP_ATTACHED:
> > +				extcon_set_state_sync(info->edev, EXTCON_USB,
> > +						      false);
> 
> ditto.
> 
noted.

> > +				vbus = ((reg_data &
> > +					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
> > +					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
> > +				if (vbus)
> > +					gpiod_set_value(info->vbus_gpiod, 0);
> > +				else
> > +					gpiod_set_value(info->vbus_gpiod, 1);
> > +
> > +				extcon_set_state_sync(info->edev,
> > +						      EXTCON_USB_HOST, true);
> 
> ditto.
> 
noted.

> > +				break;
> > +			default:
> > +				dev_err(info->dev,
> > +					"Unknown Port status : %x\n",
> > +					port_status);
> > +				break;
> > +			}
> > +		} else {
> > +			extcon_set_state_sync(info->edev,
> > +					      EXTCON_USB_HOST, false);
> 
> ditto.
> 
noted.

> > +			extcon_set_state_sync(info->edev,
> > +					      EXTCON_USB, false);
> 
> ditto.
> 
noted.

> > +			gpiod_set_value(info->vbus_gpiod, 0);
> > +		}
> > +	}
> > +
> > +	/* Clear interrupt. Read would clear the register */
> > +	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
> > +				&int_status);
> > +	if (ret) {
> > +		dev_err(info->dev,
> > +			"failed to read INT REG STATUS %d\n", ret);
> > +		mutex_unlock(&info->mutex);
> > +		return;
> > +	}
> > +
> > +
> 
> Remove redundant blank line.
> 
ok.

> > +	mutex_unlock(&info->mutex);
> > +}
> > +
> > +
> 
> Remove redundant blank line.
> 
ok.

> > +static irqreturn_t ptn5150_irq_handler(int irq, void *data)
> > +{
> > +	struct ptn5150_info *info = data;
> > +
> > +	schedule_work(&info->irq_work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int ptn5150_init_dev_type(struct ptn5150_info *info)
> > +{
> > +	unsigned int reg_data, vendor_id, version_id;
> > +	int ret;
> > +
> > +	ret = regmap_read(info->regmap, PTN5150_REG_DEVICE_ID, &reg_data);
> > +	if (ret) {
> > +		dev_err(info->dev, "failed to read DEVICE_ID %d\n", ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
> > +				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
> > +	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
> > +				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
> > +
> > +	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
> > +			    version_id, vendor_id);
> > +
> > +	/* Clear any existing interrupts */
> > +	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
> > +	if (ret) {
> > +		dev_err(info->dev,
> > +			"failed to read PTN5150_REG_INT_STATUS %d\n",
> > +			ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS, &reg_data);
> > +	if (ret) {
> > +		dev_err(info->dev,
> > +			"failed to read PTN5150_REG_INT_REG_STATUS %d\n", ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ptn5150_i2c_probe(struct i2c_client *i2c,
> > +				 const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &i2c->dev;
> > +	struct device_node *np = i2c->dev.of_node;
> > +	struct ptn5150_info *info;
> > +	int ret;
> > +
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +	i2c_set_clientdata(i2c, info);
> > +
> > +	info->dev = &i2c->dev;
> > +	info->i2c = i2c;
> > +	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
> > +	if (!info->int_gpiod) {
> > +		dev_err(dev, "failed to get INT GPIO\n");
> > +		return -EINVAL;
> > +	}
> > +	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
> > +	if (!info->vbus_gpiod) {
> > +		dev_err(dev, "failed to get VBUS GPIO\n");
> > +		return -EINVAL;
> > +	}
> > +	ret = gpiod_direction_output(info->vbus_gpiod, 0);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set VBUS GPIO direction\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_init(&info->mutex);
> > +
> > +	INIT_WORK(&info->irq_work, ptn5150_irq_work);
> > +
> > +	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
> > +	if (IS_ERR(info->regmap)) {
> > +		ret = PTR_ERR(info->regmap);
> > +		dev_err(info->dev, "failed to allocate register map: %d\n",
> > +				   ret);
> > +		return ret;
> > +	}
> > +
> > +	if (info->int_gpiod) {
> > +		info->irq = gpiod_to_irq(info->int_gpiod);
> > +		if (info->irq < 0) {
> > +			dev_err(dev, "failed to get INTB IRQ\n");
> > +			return info->irq;
> > +		}
> > +
> > +		ret = devm_request_threaded_irq(dev, info->irq, NULL,
> > +						ptn5150_irq_handler,
> > +						IRQF_TRIGGER_FALLING |
> > +						IRQF_ONESHOT,
> > +						i2c->name, info);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to request handler for INTB IRQ\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* Allocate extcon device */
> > +	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
> > +	if (IS_ERR(info->edev)) {
> > +		dev_err(info->dev, "failed to allocate memory for extcon\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Register extcon device */
> > +	ret = devm_extcon_dev_register(info->dev, info->edev);
> > +	if (ret) {
> > +		dev_err(info->dev, "failed to register extcon device\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Initialize PTN5150 device and print vendor id and version id */
> > +	ret = ptn5150_init_dev_type(info);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ptn5150_i2c_remove(struct i2c_client *i2c)
> > +{
> > +	return 0;
> > +}
> 
> Please remove dummy ptn5150_i2c_remove() defintions.
> If the remove function on later, you can add it. 
> 
ok.

> > +
> > +static const struct of_device_id ptn5150_dt_match[] = {
> > +	{ .compatible = "nxp,ptn5150" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int ptn5150_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int ptn5150_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +#endif
> 
> Please remove dummy functions (_suspend, _resume). You can add it on later. 
> 
> 
ok.

> > +
> > +static SIMPLE_DEV_PM_OPS(ptn5150_pm_ops,
> > +			 ptn5150_suspend, ptn5150_resume);
> 
> Remove it.
> 
ok.

> > +
> > +static const struct i2c_device_id ptn5150_i2c_id[] = {
> > +	{ "ptn5150", TYPE_PTN5150A },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
> > +
> > +static struct i2c_driver ptn5150_i2c_driver = {
> > +	.driver		= {
> > +		.name	= "ptn5150",
> > +		.pm	= &ptn5150_pm_ops,
> 
> Remove it.
> 
ok.

> > +		.of_match_table = ptn5150_dt_match,
> > +	},
> > +	.probe	= ptn5150_i2c_probe,
> > +	.remove	= ptn5150_i2c_remove,
> 
> Remove it.
> 
ok.

> > +	.id_table = ptn5150_i2c_id,
> > +};
> > +
> > +static int __init ptn5150_i2c_init(void)
> > +{
> > +	return i2c_add_driver(&ptn5150_i2c_driver);
> > +}
> > +subsys_initcall(ptn5150_i2c_init);
> > +
> > +MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
> > +MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
> > +MODULE_LICENSE("GPL");
> 
> If you use SPDX license format, you dont' need to add module information.
> Please remove MODULE_*() macro.
> 
ok. Will update to SPDX license format and will remove these.

> > diff --git a/drivers/extcon/extcon-ptn5150.h b/drivers/extcon/extcon-ptn5150.h
> 
> As I already commented, you have to move all definitiosn of extcon-ptn5150.h
> to extcon-ptn5150.c and remove extcon-ptn5150.h.
> 
sure.

> > new file mode 100644
> > index 0000000..217dab0
> > --- /dev/null
> > +++ b/drivers/extcon/extcon-ptn5150.h
> > @@ -0,0 +1,51 @@
> > +/*
> > + * extcon-ptn5150.h
> > + *
> > + * Copyright (c) 2018-2019 by Vijai Kumar K
> > + * Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#ifndef __LINUX_EXTCON_PTN5150_H
> > +#define __LINUX_EXTCON_PTN5150_H
> > +
> > +enum ptn5150_types {
> > +	TYPE_PTN5150A,
> 
> Do you have additional plan to suppor other type for extcon-ptn5150.c driver?
> If extcon-ptn5150.c supports only one driver, you don't need to this enumeration.
> 
Right now, I donot have plans, as I dont have means to test them. I will remove this.
BTW, This driver is for ptn5150A.

> > +};
> > +
> > +/* PTN5150 registers */
> > +enum ptn5150_reg {
> > +	PTN5150_REG_DEVICE_ID = 0x01,
> > +	PTN5150_REG_CONTROL,
> > +	PTN5150_REG_INT_STATUS,
> > +	PTN5150_REG_CC_STATUS,
> > +	PTN5150_REG_CON_DET = 0x09,
> > +	PTN5150_REG_VCONN_STATUS,
> > +	PTN5150_REG_RESET,
> > +	PTN5150_REG_INT_MASK = 0x18,
> > +	PTN5150_REG_INT_REG_STATUS,
> > +	PTN5150_REG_END,
> > +};
> > +
> > +#define PTN5150_DFP_ATTACHED			0x1
> > +#define PTN5150_UFP_ATTACHED			0x2
> > +
> > +/* Define PTN5150 MASK/SHIFT constant */
> > +#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
> > +#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
> > +#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
> > +#define PTN5150_REG_DEVICE_ID_VERSION_MASK	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
> > +
> > +#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
> > +#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
> > +#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
> > +#define PTN5150_REG_CC_VBUS_DETECTION_MASK	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
> > +#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
> > +#define PTN5150_REG_INT_CABLE_ATTACH_MASK	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
> > +#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
> > +#define PTN5150_REG_INT_CABLE_DETACH_MASK	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
> > +#endif /*  __LINUX_EXTCON_PTN5150_H */
> > 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
Thanks,
Vijai Kumar K
