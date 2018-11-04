Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E0C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4FF2081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvRo2DpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4FF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbeKEBKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:10:41 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40024 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbeKEBKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:10:41 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so6028432itl.5;
        Sun, 04 Nov 2018 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RP0KgY54imk+V4oRMOamplFgULpoIXMa2rUnEY+raiA=;
        b=RvRo2DpY9jk5t7yVAO4ih2PPKtTTx4HiEyp77ekPZHKpK0ei/Bu5siqJhJs0w+Eip7
         ktVPogA4rl7cb6sVq4/PRQ0lo7j25PWOp578pS1vCCh3IHDkwnydC+5GaKrdWUZ45lyy
         ICd//wnVm4Bu72L7HkswXSFsfHwWnraHMXVTybODPPpaVNkLHd7G7C8Hb1GVv0EeYNqR
         p5wgwENGxl3r5VT4qYyzspKS8dra6c5Dp3kvYzY7P/5MOw1JXAWdw6Xe4EHzGuZFeDGY
         QTi2S8y+ucIymllmv3msygyUxlzRZkZccF6ZTuyYaBV8aY0XYIar4wxf0xyl/clw86wf
         DPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RP0KgY54imk+V4oRMOamplFgULpoIXMa2rUnEY+raiA=;
        b=mvL3fHqwShdJnVKeuAbWBYiUBm+zlpMkpUtdz8VVO0WymK+v8KTghQ9v3FU3yeVI+5
         e5QpL6PQrS2JVKZ40ULhs9aaDGPj50do3kBbMVzb+XqVixae3rDsHQy5MesE7wSyUyYH
         dyeYySBTjNL2ZVgyszMoLf9khKFvfCd4YlcwCobbfT8z4h8iOsHzNtLom7xa5K8m983E
         MAok75QMuxlczzC7QYdtyPLfQm/yxLB7bR3jNBLUVMEXPbkuhJLDycWwpspFH9lC8fCP
         CxkFyuxVjO6b5BwfHmsPLJ6VB2KWW/tRTEWFEEjZZHRu17ZweN6Ebyi8/WGtGp6EqKAX
         YYDw==
X-Gm-Message-State: AGRZ1gI5u4GrNy/uZFuNF0+EJrrHO7rIKmLdS2NdLiuxoHwtzg6z5KnC
        gd605mnO/nExlSbnulUzkrE=
X-Google-Smtp-Source: AJdET5egPqV+cAkXgSMzyvUobHwFhYxdqB9I9K1LydHQWrTZwJzt+RJz2W9BpshskW1X1Fzfk7qDfg==
X-Received: by 2002:a05:660c:4cc:: with SMTP id v12mr3821249itk.116.1541346914145;
        Sun, 04 Nov 2018 07:55:14 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2887482ita.27.2018.11.04.07.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 07:55:13 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
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
Subject: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
Date:   Sun,  4 Nov 2018 10:54:56 -0500
Message-Id: <20181104155501.14767-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104155501.14767-1-TheSven73@googlemail.com>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

Add a driver for the Arcx anybus bridge.

This chip embeds up to two Anybus-S application connectors
(slots), and connects to the SoC via a parallel memory bus.
There is also a CAN power readout, unrelated to the Anybus,
modelled as a regulator.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/bus/Kconfig         |  10 ++
 drivers/bus/Makefile        |   1 +
 drivers/bus/anybus-bridge.c | 321 ++++++++++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/bus/anybus-bridge.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..f29131529ddb 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -173,6 +173,16 @@ config VEXPRESS_CONFIG
 	  Platform configuration infrastructure for the ARM Ltd.
 	  Versatile Express.
 
+config ARCX_ANYBUS_BRIDGE
+	tristate "Arcx Anybus-S Bridge"
+	depends on OF && GPIOLIB
+	help
+	  Select this to get support for the Arcx Anybus bridge.
+	  It connects to the SoC via a parallel memory bus, and
+	  embeds up to two Anybus-S application connectors (slots).
+	  There is also a CAN power readout, unrelated to the Anybus,
+	  modelled as a regulator.
+
 config DA8XX_MSTPRI
 	bool "TI da8xx master peripheral priority driver"
 	depends on ARCH_DAVINCI_DA8XX
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ca300b1914ce..24fa2cde0692 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -30,5 +30,6 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
+obj-$(CONFIG_ARCX_ANYBUS_BRIDGE)	+= anybus-bridge.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
diff --git a/drivers/bus/anybus-bridge.c b/drivers/bus/anybus-bridge.c
new file mode 100644
index 000000000000..9eee39efc3aa
--- /dev/null
+++ b/drivers/bus/anybus-bridge.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arcx Anybus Bridge driver
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
+#include <linux/reset-controller.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
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
+struct bridge_priv {
+	struct device *class_dev;
+	struct reset_controller_dev rcdev;
+	bool common_reset;
+	struct gpio_desc *reset_gpiod;
+	void __iomem *cpld_base;
+	spinlock_t regs_lock;
+	u8 control_reg;
+	char version[3];
+	u16 design_no;
+};
+
+static void do_reset(struct bridge_priv *cd, u8 rst_bit, bool reset)
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
+static int anybuss_reset(struct bridge_priv *cd,
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
+static int anybuss_reset_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct bridge_priv *cd = container_of(rcdev, struct bridge_priv, rcdev);
+
+	return anybuss_reset(cd, id, true);
+}
+
+static int anybuss_reset_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct bridge_priv *cd = container_of(rcdev, struct bridge_priv, rcdev);
+
+	return anybuss_reset(cd, id, false);
+}
+
+static const struct reset_control_ops anybuss_reset_ops = {
+	.assert		= anybuss_reset_assert,
+	.deassert	= anybuss_reset_deassert,
+};
+
+static ssize_t version_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", cd->version);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t design_number_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", cd->design_no);
+}
+static DEVICE_ATTR_RO(design_number);
+
+static struct attribute *bridge_attributes[] = {
+	&dev_attr_version.attr,
+	&dev_attr_design_number.attr,
+	NULL,
+};
+
+static struct attribute_group bridge_attribute_group = {
+	.attrs = bridge_attributes,
+};
+
+static const struct attribute_group *bridge_attribute_groups[] = {
+	&bridge_attribute_group,
+	NULL,
+};
+
+static void bridge_device_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static int can_power_is_enabled(struct regulator_dev *rdev)
+{
+	struct bridge_priv *cd = rdev_get_drvdata(rdev);
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
+static struct class *bridge_class;
+static DEFINE_IDA(bridge_index_ida);
+
+static int bridge_probe(struct platform_device *pdev)
+{
+	struct bridge_priv *cd;
+	struct device *dev = &pdev->dev;
+	struct regulator_config config = { };
+	struct regulator_dev *regulator;
+	int err, id;
+	struct resource *res;
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
+	dev_info(dev, "Bridge is design number %d, revision %s\n",
+		cd->design_no,
+		cd->version);
+	cap = readb(cd->cpld_base + CPLD_CAP);
+	if (!(cap & CPLD_CAP_COMPAT)) {
+		dev_err(dev, "unsupported bridge [cap=0x%02X]", cap);
+		err = -ENODEV;
+		goto out_reset;
+	}
+
+	if (status1 & CPLD_STATUS1_AB) {
+		dev_info(dev, "Bridge has anybus-S slot(s)");
+		cd->common_reset = !(cap & CPLD_CAP_SEP_RESETS);
+		dev_info(dev, "Bridge supports %s", cd->common_reset ?
+			"a common reset" : "separate resets");
+		cd->rcdev.owner	= THIS_MODULE;
+		cd->rcdev.nr_resets = 2;
+		cd->rcdev.ops = &anybuss_reset_ops;
+		cd->rcdev.of_node = dev->of_node;
+		err = devm_reset_controller_register(dev, &cd->rcdev);
+		if (err)
+			goto out_reset;
+	}
+
+	id = ida_simple_get(&bridge_index_ida, 0, 0, GFP_KERNEL);
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
+	/* make bridge info visible to userspace */
+	cd->class_dev = kzalloc(sizeof(*cd->class_dev), GFP_KERNEL);
+	if (!cd->class_dev) {
+		err = -ENOMEM;
+		goto out_ida;
+	}
+	cd->class_dev->class = bridge_class;
+	cd->class_dev->groups = bridge_attribute_groups;
+	cd->class_dev->parent = dev;
+	cd->class_dev->id = id;
+	cd->class_dev->release = bridge_device_release;
+	dev_set_name(cd->class_dev, "bridge%d", cd->class_dev->id);
+	dev_set_drvdata(cd->class_dev, cd);
+	err = device_register(cd->class_dev);
+	if (err)
+		goto out_dev;
+	return 0;
+out_dev:
+	put_device(cd->class_dev);
+out_ida:
+	ida_simple_remove(&bridge_index_ida, id);
+out_reset:
+	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
+	return err;
+}
+
+static int bridge_remove(struct platform_device *pdev)
+{
+	struct bridge_priv *cd = platform_get_drvdata(pdev);
+	int id = cd->class_dev->id;
+
+	device_unregister(cd->class_dev);
+	ida_simple_remove(&bridge_index_ida, id);
+	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
+	return 0;
+}
+
+static const struct of_device_id bridge_of_match[] = {
+	{ .compatible = "arcx,anybus-bridge" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, bridge_of_match);
+
+static struct platform_driver bridge_driver = {
+	.probe = bridge_probe,
+	.remove = bridge_remove,
+	.driver		= {
+		.name   = "arcx-anybus-bridge",
+		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(bridge_of_match),
+	},
+};
+
+static int __init bridge_init(void)
+{
+	int err;
+
+	bridge_class = class_create(THIS_MODULE, "arcx_anybus_bridge");
+	if (!IS_ERR(bridge_class)) {
+		err = platform_driver_register(&bridge_driver);
+		if (err)
+			class_destroy(bridge_class);
+	} else
+		err = PTR_ERR(bridge_class);
+	return err;
+}
+
+static void __exit bridge_exit(void)
+{
+	platform_driver_unregister(&bridge_driver);
+	class_destroy(bridge_class);
+}
+
+module_init(bridge_init);
+module_exit(bridge_exit);
+
+MODULE_DESCRIPTION("Arcx Anybus Bridge driver");
+MODULE_AUTHOR("Sven Van Asbroeck <svendev@arcx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

