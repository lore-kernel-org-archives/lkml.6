Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04C020844
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu2xRABh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfAWMs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:48:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46285 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:48:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so1125668ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vk9u8c8xX7TJgwJbcF6i1RgSsjNaq5cZSgrp7d0oZY4=;
        b=Hu2xRABhyXBmz+9VjQP+PzKZBJZnCj9u8Yn0+/V3chVa1LY8bxEyJqQkmziEQF0Gzf
         +FhbIS1WA8lRdVydZKb8vkHIW4FiWEIcTh4DZ2UMh3zER17ixaaR2DdFu8vliRq0AOjH
         41SdMygKeDWuQv652Ww4hXNCws9gMf6ZoWhbPRZvK+LXgysxmXtlol+WjhnR8pVNpg98
         hN6O1VmuBwD8TRYF4o4zKd059udp9Zrnb9QCgFUiLxcX1HvrwFrZ7ZeyhQWNu7Cj2MYg
         MyvoKVclqhmUH4g+8K3aK2OvHZJCujwu5mKrbwx8MCmJZYfvo+ppdLSYrwicVvYHQEry
         CN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vk9u8c8xX7TJgwJbcF6i1RgSsjNaq5cZSgrp7d0oZY4=;
        b=JjpUivEOzdjNZh4qaBvwgB0xxUl/Qlloh/ndM9WnfshxeiBt0L/JSYLLdeaCuNDhlr
         sFb+VF/YGjBfq3DMDfy6+8H7Qmd1ddzQTGcXNsfo1/UKoLwYgo3xjOmQWhipzkQdoAde
         rKO6fUUrUfbUJjdTbGh4G+RP54C4Uyusd1dZnzh63aeYvH/6L9sf/8lzeS0PSraIsLSb
         mSKsQrCX9382uvoHYhikn1ORdYdkeIPv4TxvGTsV+k7SC733jGBQoHND4AfVH5QI2nVy
         5iNyJkWE6vYk2Ey2Lf9HMG+Mlgu8tL8Q/CFEiXm1kMvPH8B8Y1XCsnoscTOmy1SR/RSN
         WmDw==
X-Gm-Message-State: AJcUukcyDG2/I5XMxrjbn1EIE0CnPT8J1nk1OnOeGf3E2TMn/hhHFlnk
        UyBRB058EbRn65blYb3s950=
X-Google-Smtp-Source: ALg8bN56TOkD3828yVU974OaXrf57UbYau1rBBzm4GJjbccI+URtR8NuaRV+7SE7hl4ZH8MmRUyjUw==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr2115403pll.265.1548247735200;
        Wed, 23 Jan 2019 04:48:55 -0800 (PST)
Received: from chikyu.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id u87sm48842609pfi.2.2019.01.23.04.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 04:48:54 -0800 (PST)
From:   Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
To:     cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Subject: [PATCH V2] drivers: extcon: Add support for ptn5150
Date:   Wed, 23 Jan 2019 18:16:56 +0530
Message-Id: <1548247616-6709-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190122075548.GA30388@chikyu>
References: <20190122075548.GA30388@chikyu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTN5150A is a small thin low power CC Logic chip supporting
the USB Type-C connector application with Configurationn Channel(CC)
control logic detection and indication functions.

Add driver, Kconfig and Makefile entries.

Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
---
Hi Chanwoo,

I have implemented the review comments and below is the updated patchset.
Can you please review it?

Highlights:
 - extcon.h -> extcon-provider.h
 - Remove dummy implementations for .remove, _suspend/_resume
 - Change license format to SPDX
 - remove extcon-ptn5150.h and collapse definitions to extcon-ptn5150.c
 - Replace tabs with spaces
 - Update Documentation
 - Fix coding style issues 

Thanks
Vijai Kumar K

 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  27 ++
 drivers/extcon/Kconfig                             |   8 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-ptn5150.c                    | 335 +++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 drivers/extcon/extcon-ptn5150.c

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
new file mode 100644
index 0000000..e772d42
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
@@ -0,0 +1,27 @@
+
+* PTN5150 CC (Configuration Channel) Logic device
+PTN5150A is a small thin low power CC logic chip supporting the USB Type-C
+connector application with Configuration Channel (CC) control logic detection and
+indication functions. It is interfaced to the host controller using an I2C interface.
+
+Required properties:
+- compatible: Should be "nxp,ptn5150"
+- reg: Specifies the I2C slave address of the device
+- int-gpio: should contain a phandle and GPIO specifier for the GPIO pin
+	    connected to the PTN5150's INTB pin.
+- vbus-gpio: should contain a phandle and GPIO specifier for the GPIO pin which
+	     is used to control VBUS.
+- pinctrl-names : a pinctrl state named "default" must be defined.
+- pinctrl-0 : phandle referencing pin configuration of interrupt and vbus control.
+
+Example:
+
+	ptn5150@1d  {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
+		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ptn5150_default>;
+		status = "okay";
+	};
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index de15bf5..405cd76 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -114,6 +114,14 @@ config EXTCON_PALMAS
 	  Say Y here to enable support for USB peripheral and USB host
 	  detection by palmas usb.
 
+config EXTCON_PTN5150
+	tristate "PTN5150 CC (Configuration Channel) LOGIC USB EXTCON support"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for USB peripheral and USB host
+	  detection by ptn5150 CC (Configuration Channel) logic chip.
+
 config EXTCON_QCOM_SPMI_MISC
 	tristate "Qualcomm USB extcon support"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 0888fde..261ce4c 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
 obj-$(CONFIG_EXTCON_MAX77843)	+= extcon-max77843.o
 obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
 obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
+obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
 obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
 obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
 obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
new file mode 100644
index 0000000..155620b
--- /dev/null
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// extcon-ptn5150.c - PTN5150 CC logic extcon driver to support USB detection
+//
+// Based on extcon-sm5502.c driver
+// Copyright (c) 2018-2019 by Vijai Kumar K
+// Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/extcon-provider.h>
+#include <linux/gpio.h>
+
+/* PTN5150 registers */
+enum ptn5150_reg {
+	PTN5150_REG_DEVICE_ID = 0x01,
+	PTN5150_REG_CONTROL,
+	PTN5150_REG_INT_STATUS,
+	PTN5150_REG_CC_STATUS,
+	PTN5150_REG_CON_DET = 0x09,
+	PTN5150_REG_VCONN_STATUS,
+	PTN5150_REG_RESET,
+	PTN5150_REG_INT_MASK = 0x18,
+	PTN5150_REG_INT_REG_STATUS,
+	PTN5150_REG_END,
+};
+
+#define PTN5150_DFP_ATTACHED			0x1
+#define PTN5150_UFP_ATTACHED			0x2
+
+/* Define PTN5150 MASK/SHIFT constant */
+#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
+#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	\
+	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
+
+#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
+#define PTN5150_REG_DEVICE_ID_VERSION_MASK	\
+	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
+
+#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
+#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
+	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
+
+#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
+#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
+	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
+
+#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
+#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
+	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
+
+#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
+#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
+	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
+
+struct ptn5150_info {
+	struct device *dev;
+	struct extcon_dev *edev;
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	struct gpio_desc *int_gpiod;
+	struct gpio_desc *vbus_gpiod;
+	int irq;
+	struct work_struct irq_work;
+	struct mutex mutex;
+};
+
+/* List of detectable cables */
+static const unsigned int ptn5150_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_NONE,
+};
+
+static const struct regmap_config ptn5150_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= PTN5150_REG_END,
+};
+
+static void ptn5150_irq_work(struct work_struct *work)
+{
+	struct ptn5150_info *info = container_of(work,
+			struct ptn5150_info, irq_work);
+	int ret = 0;
+	unsigned int reg_data;
+	unsigned int int_status;
+
+	if (!info->edev)
+		return;
+
+	mutex_lock(&info->mutex);
+
+	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	/* Clear interrupt. Read would clear the register */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
+	if (ret) {
+		dev_err(info->dev, "failed to read INT STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	if (int_status) {
+		unsigned int cable_attach;
+
+		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
+		if (cable_attach) {
+			unsigned int port_status;
+			unsigned int vbus;
+
+			port_status = ((reg_data &
+					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
+					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
+
+			switch (port_status) {
+			case PTN5150_DFP_ATTACHED:
+				extcon_set_state_sync(info->edev,
+						EXTCON_USB_HOST, false);
+				gpiod_set_value(info->vbus_gpiod, 0);
+				extcon_set_state_sync(info->edev, EXTCON_USB,
+						true);
+				break;
+			case PTN5150_UFP_ATTACHED:
+				extcon_set_state_sync(info->edev, EXTCON_USB,
+						false);
+				vbus = ((reg_data &
+					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
+					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
+				if (vbus)
+					gpiod_set_value(info->vbus_gpiod, 0);
+				else
+					gpiod_set_value(info->vbus_gpiod, 1);
+
+				extcon_set_state_sync(info->edev,
+						EXTCON_USB_HOST, true);
+				break;
+			default:
+				dev_err(info->dev,
+					"Unknown Port status : %x\n",
+					port_status);
+				break;
+			}
+		} else {
+			extcon_set_state_sync(info->edev,
+					EXTCON_USB_HOST, false);
+			extcon_set_state_sync(info->edev,
+					EXTCON_USB, false);
+			gpiod_set_value(info->vbus_gpiod, 0);
+		}
+	}
+
+	/* Clear interrupt. Read would clear the register */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
+			&int_status);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read INT REG STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	mutex_unlock(&info->mutex);
+}
+
+
+static irqreturn_t ptn5150_irq_handler(int irq, void *data)
+{
+	struct ptn5150_info *info = data;
+
+	schedule_work(&info->irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static int ptn5150_init_dev_type(struct ptn5150_info *info)
+{
+	unsigned int reg_data, vendor_id, version_id;
+	int ret;
+
+	ret = regmap_read(info->regmap, PTN5150_REG_DEVICE_ID, &reg_data);
+	if (ret) {
+		dev_err(info->dev, "failed to read DEVICE_ID %d\n", ret);
+		return -EINVAL;
+	}
+
+	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
+				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
+	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
+				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
+
+	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
+			    version_id, vendor_id);
+
+	/* Clear any existing interrupts */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read PTN5150_REG_INT_STATUS %d\n",
+			ret);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read PTN5150_REG_INT_REG_STATUS %d\n", ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ptn5150_i2c_probe(struct i2c_client *i2c,
+				 const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct device_node *np = i2c->dev.of_node;
+	struct ptn5150_info *info;
+	int ret;
+
+	if (!np)
+		return -EINVAL;
+
+	info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	i2c_set_clientdata(i2c, info);
+
+	info->dev = &i2c->dev;
+	info->i2c = i2c;
+	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
+	if (!info->int_gpiod) {
+		dev_err(dev, "failed to get INT GPIO\n");
+		return -EINVAL;
+	}
+	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
+	if (!info->vbus_gpiod) {
+		dev_err(dev, "failed to get VBUS GPIO\n");
+		return -EINVAL;
+	}
+	ret = gpiod_direction_output(info->vbus_gpiod, 0);
+	if (ret) {
+		dev_err(dev, "failed to set VBUS GPIO direction\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&info->mutex);
+
+	INIT_WORK(&info->irq_work, ptn5150_irq_work);
+
+	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		ret = PTR_ERR(info->regmap);
+		dev_err(info->dev, "failed to allocate register map: %d\n",
+				   ret);
+		return ret;
+	}
+
+	if (info->int_gpiod) {
+		info->irq = gpiod_to_irq(info->int_gpiod);
+		if (info->irq < 0) {
+			dev_err(dev, "failed to get INTB IRQ\n");
+			return info->irq;
+		}
+
+		ret = devm_request_threaded_irq(dev, info->irq, NULL,
+						ptn5150_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						i2c->name, info);
+		if (ret < 0) {
+			dev_err(dev, "failed to request handler for INTB IRQ\n");
+			return ret;
+		}
+	}
+
+	/* Allocate extcon device */
+	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
+	if (IS_ERR(info->edev)) {
+		dev_err(info->dev, "failed to allocate memory for extcon\n");
+		return -ENOMEM;
+	}
+
+	/* Register extcon device */
+	ret = devm_extcon_dev_register(info->dev, info->edev);
+	if (ret) {
+		dev_err(info->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
+	/* Initialize PTN5150 device and print vendor id and version id */
+	ret = ptn5150_init_dev_type(info);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id ptn5150_dt_match[] = {
+	{ .compatible = "nxp,ptn5150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
+
+static const struct i2c_device_id ptn5150_i2c_id[] = {
+	{ "ptn5150", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
+
+static struct i2c_driver ptn5150_i2c_driver = {
+	.driver		= {
+		.name	= "ptn5150",
+		.of_match_table = ptn5150_dt_match,
+	},
+	.probe	= ptn5150_i2c_probe,
+	.id_table = ptn5150_i2c_id,
+};
+
+static int __init ptn5150_i2c_init(void)
+{
+	return i2c_add_driver(&ptn5150_i2c_driver);
+}
+subsys_initcall(ptn5150_i2c_init);
-- 
2.7.4

