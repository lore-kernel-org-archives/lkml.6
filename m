Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316EAC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14052085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtmQXHI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAUJKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:10:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44209 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAUJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:10:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so9509438plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YlEIKDLE+UQYKQpuI+4kyuoTG/E6E8bzre59iuQQ15M=;
        b=jtmQXHI5GabG6XKpLTid5JiTHtAlVAmKrkEc2e0EidSGz0O9tiAzHJ0N8I4opePg05
         0tefrkEGUmlKWp9jvknjUJtxUmILqA8FAqGhCq30bd+dheV4AQQfSpDJmRtNoNAr42WR
         /z/QLSoJAl0KUssRIYQqwu2mFmJM6U32uPaHeENo3wvCJGo0vb4dUOtVE+5hpwI9jihO
         hj4ikoqEqDJxgZvWb9ooaxxnrSZRLFV6xjx58l7IjapRJa/IxKHviIlmen4qVkbFoYZ0
         xq2VrwNUQEuojxS/9QjJ1joS6mud4KfY0p9m61CHnJpvhe2BI2tIoqNpLIHv8i8VOGPb
         8smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YlEIKDLE+UQYKQpuI+4kyuoTG/E6E8bzre59iuQQ15M=;
        b=KTjBccQXe8bZUmM19B0zpgvchLSyyA+lsDeZdyM68zhiXf5jHiGry7yEVus3EAOzIi
         BvHitvQAKwX6j/9fy+GBX+3bKALRxdZR+HK+V0J7/1yEAKXV97r9UmqOj3FhEbXOuuap
         QULHfTS/vO94dbGSvJzx5XwxzU1ErpF6AOJEZrRa8GAxPw3iimwlmET5dpts7Vbv4+5F
         Omyx71Pe3fz/XxgHZo8lgTRSzqd5EE/iT+FtI1KYR7ui19kEvwxa8BXBhktBR76ug6Lm
         mK1FmjnnyCuBNc3n6oGb8L6kuswMAQClycudQdMTvakGVxkqDjQpSI7E9ZFaMU8giHF7
         MD0w==
X-Gm-Message-State: AJcUukehizhwIjqinLh+e4A0lOEpWQiMhCUsa7OiM8zXBmzBXyMdCEOC
        HT/AZnxTUBq0e7N41jqp41GrUmNc
X-Google-Smtp-Source: ALg8bN5BQwygOo0CEa9nCq0HiDHGYgu94kgC2hsTGnyosKDM4TPib09QuFhCj+iKBTg4n/5JFNnVUg==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr29470525plg.61.1548061843489;
        Mon, 21 Jan 2019 01:10:43 -0800 (PST)
Received: from chikyu.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id u69sm16715245pfj.116.2019.01.21.01.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 01:10:43 -0800 (PST)
From:   Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Subject: [PATCH] drivers: extcon: Add support for ptn5150
Date:   Mon, 21 Jan 2019 14:39:09 +0530
Message-Id: <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTN5150A is a small thin low power CC Logic chip supporting
the USB Type-C connector application with Configurationn Channel(CC)
control logic detection and indication functions.

Add driver, Kconfig and Makefile entries.

Change-Id: I3b2da147a33b913b9ec60cd914b20acd955950c7
Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
---
 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  22 ++
 drivers/extcon/Kconfig                             |   8 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-ptn5150.c                    | 327 +++++++++++++++++++++
 drivers/extcon/extcon-ptn5150.h                    |  51 ++++
 5 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 drivers/extcon/extcon-ptn5150.c
 create mode 100644 drivers/extcon/extcon-ptn5150.h

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
new file mode 100644
index 0000000..8ea33bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
@@ -0,0 +1,22 @@
+
+* PTN5150 CC logic device
+PTN5150A is a small thin low power CC Logic chip supporting the USB Type-C
+connector application with Configuration Channel (CC) control logic detection and
+indication functions. It is Interfaced to the host controller using an I2C interface.
+
+Required properties:
+- compatible: Should be "nxp,ptn5150"
+- reg: Specifies the I2C slave address of the device
+- int-gpio: GPIO to which INTB is connected
+- vbus-gpio: GPIO which controls VBUS on/off
+
+Example:
+		ptn5150@1d  {
+			compatible = "nxp,ptn5150";
+			reg = <0x1d>;
+			int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
+			vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ptn5150_default>;
+			status = "okay";
+		};
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index a7bca42..6adc797 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -113,6 +113,14 @@ config EXTCON_PALMAS
 	  Say Y here to enable support for USB peripheral and USB host
 	  detection by palmas usb.
 
+config EXTCON_PTN5150
+	tristate "PTN5150 CC LOGIC USB EXTCON support"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for USB peripheral and USB host
+	  detection by ptn5150 cc logic chip.
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
index 0000000..bc00874
--- /dev/null
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -0,0 +1,327 @@
+/*
+ * extcon-ptn5150.c - PTN5150 CC logic extcon driver to support USB detection
+ *
+ * Copyright (c) 2018-2019 by Vijai Kumar K
+ * Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
+ *
+ * Based on extcon-sm5502.c driver
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/extcon.h>
+#include <linux/gpio.h>
+
+#include "extcon-ptn5150.h"
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
+	unsigned int port_status;
+	unsigned int vbus;
+	unsigned int cable_attach;
+	unsigned int int_status;
+
+	if (!info->edev)
+		return;
+
+	mutex_lock(&info->mutex);
+
+	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read CC STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+	/* Clear interrupt. Read would clear the register */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read INT STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	if (int_status) {
+		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
+		if (cable_attach) {
+			port_status = ((reg_data &
+					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
+					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
+
+			switch (port_status) {
+			case PTN5150_DFP_ATTACHED:
+				extcon_set_state_sync(info->edev,
+						      EXTCON_USB_HOST, false);
+				gpiod_set_value(info->vbus_gpiod, 0);
+				extcon_set_state_sync(info->edev, EXTCON_USB,
+						      true);
+				break;
+			case PTN5150_UFP_ATTACHED:
+				extcon_set_state_sync(info->edev, EXTCON_USB,
+						      false);
+				vbus = ((reg_data &
+					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
+					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
+				if (vbus)
+					gpiod_set_value(info->vbus_gpiod, 0);
+				else
+					gpiod_set_value(info->vbus_gpiod, 1);
+
+				extcon_set_state_sync(info->edev,
+						      EXTCON_USB_HOST, true);
+				break;
+			default:
+				dev_err(info->dev,
+					"Unknown Port status : %x\n",
+					port_status);
+				break;
+			}
+		} else {
+			extcon_set_state_sync(info->edev,
+					      EXTCON_USB_HOST, false);
+			extcon_set_state_sync(info->edev,
+					      EXTCON_USB, false);
+			gpiod_set_value(info->vbus_gpiod, 0);
+		}
+	}
+
+	/* Clear interrupt. Read would clear the register */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
+				&int_status);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read INT REG STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
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
+static int ptn5150_i2c_remove(struct i2c_client *i2c)
+{
+	return 0;
+}
+
+static const struct of_device_id ptn5150_dt_match[] = {
+	{ .compatible = "nxp,ptn5150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
+
+#ifdef CONFIG_PM_SLEEP
+static int ptn5150_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int ptn5150_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ptn5150_pm_ops,
+			 ptn5150_suspend, ptn5150_resume);
+
+static const struct i2c_device_id ptn5150_i2c_id[] = {
+	{ "ptn5150", TYPE_PTN5150A },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
+
+static struct i2c_driver ptn5150_i2c_driver = {
+	.driver		= {
+		.name	= "ptn5150",
+		.pm	= &ptn5150_pm_ops,
+		.of_match_table = ptn5150_dt_match,
+	},
+	.probe	= ptn5150_i2c_probe,
+	.remove	= ptn5150_i2c_remove,
+	.id_table = ptn5150_i2c_id,
+};
+
+static int __init ptn5150_i2c_init(void)
+{
+	return i2c_add_driver(&ptn5150_i2c_driver);
+}
+subsys_initcall(ptn5150_i2c_init);
+
+MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
+MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/extcon/extcon-ptn5150.h b/drivers/extcon/extcon-ptn5150.h
new file mode 100644
index 0000000..217dab0
--- /dev/null
+++ b/drivers/extcon/extcon-ptn5150.h
@@ -0,0 +1,51 @@
+/*
+ * extcon-ptn5150.h
+ *
+ * Copyright (c) 2018-2019 by Vijai Kumar K
+ * Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LINUX_EXTCON_PTN5150_H
+#define __LINUX_EXTCON_PTN5150_H
+
+enum ptn5150_types {
+	TYPE_PTN5150A,
+};
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
+#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
+#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
+#define PTN5150_REG_DEVICE_ID_VERSION_MASK	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
+
+#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
+#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
+#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
+#define PTN5150_REG_CC_VBUS_DETECTION_MASK	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
+#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
+#define PTN5150_REG_INT_CABLE_ATTACH_MASK	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
+#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
+#define PTN5150_REG_INT_CABLE_DETACH_MASK	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
+#endif /*  __LINUX_EXTCON_PTN5150_H */
-- 
2.7.4

