Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1BFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABF92081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4dIfWUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABF92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeLDWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:03:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43513 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeLDWCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:02:34 -0500
Received: by mail-io1-f68.google.com with SMTP id f10so9169948iop.10;
        Tue, 04 Dec 2018 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/e+60MGPDcJkrwSIhlmXLzMHvnweyKXlZKCT5AUMhnI=;
        b=c4dIfWUzdJTqjenWBFh6ubauQSiEl+FXAS5CSSrfPSX6xAImclk1qsKqZ1TSsn2KsO
         3vWmQn22mTY+hKjFN11trEXb7ZT6twvpo+0F9InD4WANjNJF+diZXSxtwU2XvjQMCNNE
         NfINu/i2CI5/mVtpOKYkzxBTer8/2CTbHOqWiAC8MtECpzzW5ffI0XhIp8Ou40Z+pkj6
         WmsDXYNe50kgec0+m+KLqBay+oMJnQcpzhPCEy2KBn3TSKJlIsQ49jLlKsurhIV7q8P5
         XqMC3LQwVNn4nu6yyA/F6i+ULDxBq/Appj0CMh0CNN27FpggiNU5Oaxd2n2P8IFNVwcj
         lTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/e+60MGPDcJkrwSIhlmXLzMHvnweyKXlZKCT5AUMhnI=;
        b=pUYVwkb/uYmTwwwKSfnZ2NLFyjUkpvls8FOeTnlT41+eyjvMNy0iJrmXbP9chGIrN9
         46jaRkCql3ng6le7vhU36HD76c0YyZYNnQA0N32ezGP7Bs+gNXhK+8LP/iX4Awk0Bvrq
         MfsSrsUZzZlx0O6n8Z8G4kG3hDLePuLuBWDlBqOVMryxv2WzXeC66qCFl6yIciJtFZtX
         rnanjuwfJ7y0Ae5hCHUY5BnBhCz2grrtsKmkmrHh4f1PlQrDghrdgLbmx91ZT75A7qNX
         meW2lbOO0y1uavwrl2RX/TgGtAzIKv4GQ3OYMbNw1NZJeoNkLLUpM6kP/9SB6fxTvzc7
         tX+A==
X-Gm-Message-State: AA+aEWbR5Zr4+ZdgjN46r9DzWTsLbadFx4TAZ8X4Uc80zTrrhJkbdw/f
        UQ/x19kmPW4D5wdjShDmSaw=
X-Google-Smtp-Source: AFSGD/Uonk/QESXOd25qm0oCIBuGNcbVmWDv5BF91u+WH8iV4L4zq7O8CoeB7v6UW0hpNYWNksJo+w==
X-Received: by 2002:a5e:d910:: with SMTP id n16mr20467032iop.58.1543960952845;
        Tue, 04 Dec 2018 14:02:32 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id m2sm4962544iol.75.2018.12.04.14.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:02:32 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 3/6] anybus-s: support the Arcx anybus controller
Date:   Tue,  4 Dec 2018 17:02:21 -0500
Message-Id: <20181204220224.27324-4-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204220224.27324-1-TheSven73@googlemail.com>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Arcx anybus controller.

This device implements two Anybus-S hosts (buses),
and connects to the SoC via a parallel memory bus.
There is also a CAN power readout, unrelated to the Anybus,
modelled as a regulator.

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/fieldbus/Makefile              |   1 -
 drivers/fieldbus/anybuss/Kconfig       |  14 +
 drivers/fieldbus/anybuss/Makefile      |   2 +
 drivers/fieldbus/anybuss/arcx-anybus.c | 399 +++++++++++++++++++++++++
 4 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fieldbus/anybuss/arcx-anybus.c

diff --git a/drivers/fieldbus/Makefile b/drivers/fieldbus/Makefile
index b9eee708374a..982dc6cede82 100644
--- a/drivers/fieldbus/Makefile
+++ b/drivers/fieldbus/Makefile
@@ -8,4 +8,3 @@ fieldbus_dev_core-y		:= dev_core.o
 
 # Anybus-S core and devices
 obj-$(CONFIG_HMS_ANYBUSS_BUS)	+= anybuss/
-
diff --git a/drivers/fieldbus/anybuss/Kconfig b/drivers/fieldbus/anybuss/Kconfig
index 5b495f25c11e..7e563a78be13 100644
--- a/drivers/fieldbus/anybuss/Kconfig
+++ b/drivers/fieldbus/anybuss/Kconfig
@@ -7,3 +7,17 @@ config HMS_ANYBUSS_BUS
 	  You can attach a single Anybus-S compatible card to it, which
 	  typically provides fieldbus and industrial ethernet
 	  functionality.
+
+if HMS_ANYBUSS_BUS
+
+config ARCX_ANYBUS_CONTROLLER
+	tristate "Arcx Anybus-S Controller"
+	depends on OF && GPIOLIB
+	help
+	  Select this to get support for the Arcx Anybus controller.
+	  It connects to the SoC via a parallel memory bus, and
+	  embeds up to two Anybus-S buses (slots).
+	  There is also a CAN power readout, unrelated to the Anybus,
+	  modelled as a regulator.
+
+endif
diff --git a/drivers/fieldbus/anybuss/Makefile b/drivers/fieldbus/anybuss/Makefile
index b1c386cb4ed2..815155f02700 100644
--- a/drivers/fieldbus/anybuss/Makefile
+++ b/drivers/fieldbus/anybuss/Makefile
@@ -5,3 +5,5 @@
 
 obj-y			+= anybuss_core.o
 anybuss_core-y		+= host.o
+
+obj-$(CONFIG_ARCX_ANYBUS_CONTROLLER) += arcx-anybus.o
diff --git a/drivers/fieldbus/anybuss/arcx-anybus.c b/drivers/fieldbus/anybuss/arcx-anybus.c
new file mode 100644
index 000000000000..fc5add11e026
--- /dev/null
+++ b/drivers/fieldbus/anybuss/arcx-anybus.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arcx Anybus-S Controller driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regmap.h>
+
+#include <linux/anybuss-controller.h>
+
+#define CPLD_STATUS1		0x80
+#define CPLD_CONTROL		0x80
+#define CPLD_CONTROL_CRST	0x40
+#define CPLD_CONTROL_RST1	0x04
+#define CPLD_CONTROL_RST2	0x80
+#define CPLD_STATUS1_AB		0x02
+#define CPLD_STATUS1_CAN_POWER	0x01
+#define CPLD_DESIGN_LO		0x81
+#define CPLD_DESIGN_HI		0x82
+#define CPLD_CAP		0x83
+#define CPLD_CAP_COMPAT		0x01
+#define CPLD_CAP_SEP_RESETS	0x02
+
+struct controller_priv {
+	struct device *class_dev;
+	bool common_reset;
+	struct gpio_desc *reset_gpiod;
+	void __iomem *cpld_base;
+	spinlock_t regs_lock;
+	u8 control_reg;
+	char version[3];
+	u16 design_no;
+};
+
+static void do_reset(struct controller_priv *cd, u8 rst_bit, bool reset)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cd->regs_lock, flags);
+	/*
+	 * CPLD_CONTROL is write-only, so cache its value in
+	 * cd->control_reg
+	 */
+	if (reset)
+		cd->control_reg &= ~rst_bit;
+	else
+		cd->control_reg |= rst_bit;
+	writeb(cd->control_reg, cd->cpld_base + CPLD_CONTROL);
+	/*
+	 * h/w work-around:
+	 * the hardware is 'too fast', so a reset followed by an immediate
+	 * not-reset will _not_ change the anybus reset line in any way,
+	 * losing the reset. to prevent this from happening, introduce
+	 * a minimum reset duration.
+	 * Verified minimum safe duration required using a scope
+	 * on 14-June-2018: 100 us.
+	 */
+	if (reset)
+		udelay(100);
+	spin_unlock_irqrestore(&cd->regs_lock, flags);
+}
+
+static int anybuss_reset(struct controller_priv *cd,
+			     unsigned long id, bool reset)
+{
+	if (id >= 2)
+		return -EINVAL;
+	if (cd->common_reset)
+		do_reset(cd, CPLD_CONTROL_CRST, reset);
+	else
+		do_reset(cd, id ? CPLD_CONTROL_RST2 : CPLD_CONTROL_RST1, reset);
+	return 0;
+}
+
+static void export_reset_0(struct device *dev, bool assert)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	anybuss_reset(cd, 0, assert);
+}
+
+static void export_reset_1(struct device *dev, bool assert)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	anybuss_reset(cd, 1, assert);
+}
+
+/*
+ * parallel bus limitation:
+ *
+ * the anybus is 8-bit wide. we can't assume that the hardware will translate
+ * word accesses on the parallel bus to multiple byte-accesses on the anybus.
+ *
+ * the imx WEIM bus does not provide this type of translation.
+ *
+ * to be safe, we will limit parallel bus accesses to a single byte
+ * at a time for now.
+ */
+
+static int read_reg_bus(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	void __iomem *base = context;
+
+	*val = readb(base + reg);
+	return 0;
+}
+
+static int write_reg_bus(void *context, unsigned int reg,
+				unsigned int val)
+{
+	void __iomem *base = context;
+
+	writeb(val, base + reg);
+	return 0;
+}
+
+static struct regmap *create_parallel_regmap(struct platform_device *pdev,
+					     int idx)
+{
+	struct regmap_config regmap_cfg = {
+		.reg_bits = 11,
+		.val_bits = 8,
+		/*
+		 * single-byte parallel bus accesses are atomic, so don't
+		 * require any synchronization.
+		 */
+		.disable_locking = true,
+		.reg_read = read_reg_bus,
+		.reg_write = write_reg_bus,
+	};
+	struct resource *res;
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, idx+1);
+	if (resource_size(res) < (1<<regmap_cfg.reg_bits))
+		return ERR_PTR(-EINVAL);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+	return devm_regmap_init(dev, NULL, base, &regmap_cfg);
+}
+
+static struct anybuss_host *
+create_anybus_host(struct platform_device *pdev, int idx)
+{
+	struct anybuss_ops ops = {};
+
+	switch (idx) {
+	case 0:
+		ops.reset = export_reset_0;
+		break;
+	case 1:
+		ops.reset = export_reset_1;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+	ops.host_idx = idx;
+	ops.regmap = create_parallel_regmap(pdev, idx);
+	if (IS_ERR(ops.regmap))
+		return ERR_CAST(ops.regmap);
+	ops.irq = platform_get_irq(pdev, idx);
+	if (ops.irq <= 0)
+		return ERR_PTR(-EINVAL);
+	return devm_anybuss_host_common_probe(&pdev->dev, &ops);
+}
+
+static ssize_t version_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", cd->version);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t design_number_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", cd->design_no);
+}
+static DEVICE_ATTR_RO(design_number);
+
+static struct attribute *controller_attributes[] = {
+	&dev_attr_version.attr,
+	&dev_attr_design_number.attr,
+	NULL,
+};
+
+static struct attribute_group controller_attribute_group = {
+	.attrs = controller_attributes,
+};
+
+static const struct attribute_group *controller_attribute_groups[] = {
+	&controller_attribute_group,
+	NULL,
+};
+
+static void controller_device_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static int can_power_is_enabled(struct regulator_dev *rdev)
+{
+	struct controller_priv *cd = rdev_get_drvdata(rdev);
+
+	return !(readb(cd->cpld_base + CPLD_STATUS1) & CPLD_STATUS1_CAN_POWER);
+}
+
+static struct regulator_ops can_power_ops = {
+	.is_enabled = can_power_is_enabled,
+};
+
+static const struct regulator_desc can_power_desc = {
+	.name = "regulator-can-power",
+	.id = -1,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &can_power_ops,
+};
+
+static struct class *controller_class;
+static DEFINE_IDA(controller_index_ida);
+
+static int controller_probe(struct platform_device *pdev)
+{
+	struct controller_priv *cd;
+	struct device *dev = &pdev->dev;
+	struct regulator_config config = { };
+	struct regulator_dev *regulator;
+	int err, id;
+	struct resource *res;
+	struct anybuss_host *host;
+	u8 status1, cap;
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+	dev_set_drvdata(dev, cd);
+	spin_lock_init(&cd->regs_lock);
+	cd->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cd->reset_gpiod))
+		return PTR_ERR(cd->reset_gpiod);
+
+	/* CPLD control memory, sits at index 0 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cd->cpld_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cd->cpld_base)) {
+		dev_err(dev,
+			"failed to map cpld base address\n");
+		err = PTR_ERR(cd->cpld_base);
+		goto out_reset;
+	}
+
+	/* identify cpld */
+	status1 = readb(cd->cpld_base + CPLD_STATUS1);
+	cd->design_no = (readb(cd->cpld_base + CPLD_DESIGN_HI) << 8) |
+				readb(cd->cpld_base + CPLD_DESIGN_LO);
+	snprintf(cd->version, sizeof(cd->version), "%c%d",
+			'A' + ((status1>>5) & 0x7),
+			(status1>>2) & 0x7);
+	dev_info(dev, "design number %d, revision %s\n",
+		cd->design_no,
+		cd->version);
+	cap = readb(cd->cpld_base + CPLD_CAP);
+	if (!(cap & CPLD_CAP_COMPAT)) {
+		dev_err(dev, "unsupported controller [cap=0x%02X]", cap);
+		err = -ENODEV;
+		goto out_reset;
+	}
+
+	if (status1 & CPLD_STATUS1_AB) {
+		dev_info(dev, "has anybus-S slot(s)");
+		cd->common_reset = !(cap & CPLD_CAP_SEP_RESETS);
+		dev_info(dev, "supports %s", cd->common_reset ?
+			"a common reset" : "separate resets");
+		for (id = 0; id < 2; id++) {
+			host = create_anybus_host(pdev, id);
+			if (!IS_ERR(host))
+				continue;
+			err = PTR_ERR(host);
+			/* -ENODEV is fine, it just means no card detected */
+			if (err != -ENODEV)
+				goto out_reset;
+		}
+	}
+
+	id = ida_simple_get(&controller_index_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		err = id;
+		goto out_reset;
+	}
+	/* export can power readout as a regulator */
+	config.dev = dev;
+	config.driver_data = cd;
+	regulator = devm_regulator_register(dev, &can_power_desc, &config);
+	if (IS_ERR(regulator)) {
+		err = PTR_ERR(regulator);
+		goto out_reset;
+	}
+	/* make controller info visible to userspace */
+	cd->class_dev = kzalloc(sizeof(*cd->class_dev), GFP_KERNEL);
+	if (!cd->class_dev) {
+		err = -ENOMEM;
+		goto out_ida;
+	}
+	cd->class_dev->class = controller_class;
+	cd->class_dev->groups = controller_attribute_groups;
+	cd->class_dev->parent = dev;
+	cd->class_dev->id = id;
+	cd->class_dev->release = controller_device_release;
+	dev_set_name(cd->class_dev, "controller%d", cd->class_dev->id);
+	dev_set_drvdata(cd->class_dev, cd);
+	err = device_register(cd->class_dev);
+	if (err)
+		goto out_dev;
+	return 0;
+out_dev:
+	put_device(cd->class_dev);
+out_ida:
+	ida_simple_remove(&controller_index_ida, id);
+out_reset:
+	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
+	return err;
+}
+
+static int controller_remove(struct platform_device *pdev)
+{
+	struct controller_priv *cd = platform_get_drvdata(pdev);
+	int id = cd->class_dev->id;
+
+	device_unregister(cd->class_dev);
+	ida_simple_remove(&controller_index_ida, id);
+	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
+	return 0;
+}
+
+static const struct of_device_id controller_of_match[] = {
+	{ .compatible = "arcx,anybus-controller" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, controller_of_match);
+
+static struct platform_driver controller_driver = {
+	.probe = controller_probe,
+	.remove = controller_remove,
+	.driver		= {
+		.name   = "arcx-anybus-controller",
+		.of_match_table	= of_match_ptr(controller_of_match),
+	},
+};
+
+static int __init controller_init(void)
+{
+	int err;
+
+	controller_class = class_create(THIS_MODULE, "arcx_anybus_controller");
+	if (!IS_ERR(controller_class)) {
+		err = platform_driver_register(&controller_driver);
+		if (err)
+			class_destroy(controller_class);
+	} else
+		err = PTR_ERR(controller_class);
+	return err;
+}
+
+static void __exit controller_exit(void)
+{
+	platform_driver_unregister(&controller_driver);
+	class_destroy(controller_class);
+}
+
+module_init(controller_init);
+module_exit(controller_exit);
+
+MODULE_DESCRIPTION("Arcx Anybus-S Controller driver");
+MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

