Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl8HcERn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF1F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeKAEoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:44:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51789 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKAEoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:44:02 -0400
Received: by mail-it1-f194.google.com with SMTP id h13so7199355itl.1;
        Wed, 31 Oct 2018 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VQaXF5O6Z9CuQq2xJneL32hC9k55rG7ccBWfsUbeJtc=;
        b=Rl8HcERn2xLYnEf/ocwUphSsmapApDZlckUhd5UJq56JkHI/bbtqlNa8xGzEPazYKQ
         3VvDlzNPIgKOLXmhFDWX89DBNygRwyYT//FJ5whAUMgelNCZqyMDqeHe1UpCGeAx00N9
         gjr5uzDaN355MakwMjyrFaqdiUO5B/aLOdNh2IxeaO2B4W2a2r1l0fCCQ1edhda2LvBk
         /w92OU6jJs7Ed0kNLBA2npHpQrtLIpZM6Nu9cs8XCkSP4tcjbBX4MzJaLJKXtNYsILf7
         BSIU974gnJHIr29nFvndEx3zg6iQDPjoP529xsc1YtGtNGyh+GiawWBGrcufz1aBiyur
         aeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VQaXF5O6Z9CuQq2xJneL32hC9k55rG7ccBWfsUbeJtc=;
        b=SJTSlZO0oPnbYivnE4cuBg7sTfQJ/C9V47qsXQGn4UlOMlcGrUlAXuXTXZqh0smrg8
         pP1h22Cto1h5ViMWBRgXA47WrSyRXfEP9vWcDNq2Tmeor/ckadKzzdtKT64eOpQNiida
         KlyJQLRpzNr0zFTv1/rTgsEjh6T1/nPNqZE8uVOsp8m2skoQv5nhlB5tIExJwwpxCTae
         7Gy4arN0q4QYt8dAbHv8wcVT5ZLelme71LpoHd/lZmRadkh1zAHoe0wM6JOyvtXrTugD
         iwVYoZ/OpTuA6fdXCPmgA1hZ+rqKxiokN3C5InPgcwBs56twwNQdIbVEnlsABrXzUo+R
         bg+A==
X-Gm-Message-State: AGRZ1gLETNqVi0YXdrgDcamJyqIbFRV0K6ISjFWAwWaJTriFsy3Vnx9V
        IDDyJsqL+JursljRHu7Yl/o=
X-Google-Smtp-Source: AJdET5emaHU0nrcNfWrBvVb0jMSuzjVW/w247OCVNhk98DPAu2WWqxeVVXE/nIYkj+dTOUgWGTY5gw==
X-Received: by 2002:a24:16ca:: with SMTP id a193-v6mr3171484ita.134.1541015070953;
        Wed, 31 Oct 2018 12:44:30 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u142-v6sm7136606itb.13.2018.10.31.12.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:44:30 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v2 1/5] misc: support the Arcx anybus bridge.
Date:   Wed, 31 Oct 2018 15:44:21 -0400
Message-Id: <20181031194425.32132-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031194425.32132-1-TheSven73@googlemail.com>
References: <20181031194425.32132-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

Add a driver for the Arcx anybus bridge.

This chip embeds up to two Anybus-S application connectors
(slots), and connects to the SoC via a parallel memory bus.
There is also a CAN power readout, unrelated to the Anybus.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/misc/Kconfig         |   9 ++
 drivers/misc/Makefile        |   1 +
 drivers/misc/anybus-bridge.c | 301 +++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)
 create mode 100644 drivers/misc/anybus-bridge.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eacdf65d..dd7fdbf659b7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -509,6 +509,15 @@ config PCI_ENDPOINT_TEST
            Enable this configuration option to enable the host side test driver
            for PCI Endpoint.
 
+config ARCX_ANYBUS_BRIDGE
+	tristate "Arcx Anybus-S Bridge"
+	depends on OF
+	help
+	  Select this to get support for the Arcx Anybus bridge.
+	  It connects to the SoC via a parallel memory bus, and
+	  embeds up to two Anybus-S application connectors (slots).
+	  There is also a CAN power readout, unrelated to the Anybus.
+
 config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index af22bbc3d00c..20c9fbfb100b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,5 +56,6 @@ obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
+obj-$(CONFIG_ARCX_ANYBUS_BRIDGE)	+= anybus-bridge.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
diff --git a/drivers/misc/anybus-bridge.c b/drivers/misc/anybus-bridge.c
new file mode 100644
index 000000000000..6eb7b47dd5ee
--- /dev/null
+++ b/drivers/misc/anybus-bridge.c
@@ -0,0 +1,301 @@
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
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+#include <linux/reset-controller.h>
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
+	int reset_gpio;
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
+static ssize_t can_power_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n",
+		!(readb(cd->cpld_base + CPLD_STATUS1) &
+					CPLD_STATUS1_CAN_POWER));
+}
+static DEVICE_ATTR_RO(can_power);
+
+static struct attribute *bridge_attributes[] = {
+	&dev_attr_version.attr,
+	&dev_attr_design_number.attr,
+	&dev_attr_can_power.attr,
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
+static struct class *bridge_class;
+static DEFINE_IDA(bridge_index_ida);
+
+static int bridge_probe(struct platform_device *pdev)
+{
+	struct bridge_priv *cd;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int err, id;
+	struct resource *res;
+	u8 status1, cap;
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+	dev_set_drvdata(dev, cd);
+	spin_lock_init(&cd->regs_lock);
+	cd->reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
+	if (!gpio_is_valid(cd->reset_gpio)) {
+		dev_err(dev, "reset-gpios not found\n");
+		return -EINVAL;
+	}
+	devm_gpio_request(dev, cd->reset_gpio, NULL);
+	gpio_direction_output(cd->reset_gpio, 0);
+
+	/* CPLD control memory, sits at index 0 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cd->cpld_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cd->cpld_base)) {
+		dev_err(dev,
+			"failed to map cpld base address\n");
+		return PTR_ERR(cd->cpld_base);
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
+		return -ENODEV;
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
+			return err;
+	}
+
+	id = ida_simple_get(&bridge_index_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
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
+	gpio_direction_input(cd->reset_gpio);
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

