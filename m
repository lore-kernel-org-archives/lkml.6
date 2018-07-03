Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED536C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9213F24D7D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="RUpJXO8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F622E5Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9213F24D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeGCHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37001 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754599AbeGCHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C8FE621EAB;
        Tue,  3 Jul 2018 03:04:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Jul 2018 03:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mG9ZoWf3Pi2VjwBRx
        Wg1JILyaVDsQsuqvKyguZ2y6YQ=; b=RUpJXO8O4Pli7A82x6BiiLwl/XTy4Q744
        +PPmdNINRGvQc9ILB6jySP9dGorxEi45oazsZPbUdCaPX+P22mLjBEeo+DNsVCfO
        EWIrMEWgMKVrIkF3vqxUdJqxtsTKwHKKlDvvmZhspMsxQvW+NaXYFyaxC6lKvGk/
        IwvLGTRQXxmicAbFy1ByDjHlIWn8NgT6DhSTqzfvH9ft3qaHtc373dQLn/Sr/qzn
        V7yJnM0KLh5XROptCIpHAq/VK1Da4whEX4N5A2qayzKRBGfs+bcHHwqOFXg3MfFi
        Nd4ljD8Xa30BEPoIjgY/ucrEAV65vyowFlwCCLsaT+okyO+lyc51w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=mG9ZoWf3Pi2VjwBRxWg1JILyaVDsQsuqvKyguZ2y6YQ=; b=F622E5Ql
        /LvdNsIv1YpG5ZHMLe5Yt8zW4U1DsMQ4GugI9wLd+RiPk8Dv56dFP1bbldKHSCm7
        WuoHX0ETP8QyYg1Jxy+vS2g7ppQY/2Vccqx0EyMcfOVYL+uuJU01vOSfcOYmzlJY
        oI5HFLpCM4rFPViD3EBNoEhSlAUEqAZk2jPmeGZe1T/2itIje6WClVKWtTD3blBs
        gO8JZ+OH3zWRYM4oplqUi/Af7Zbx3DQ5eG8ttXywmao0mci7BMr9he8+OpRHCnq+
        wcHZN0EeYOQMNkwZrMV6Tm4goGsRNYMS59gcai93ihJYH61E0GxtU0fq6Wq2TPi9
        e4HOPGJKlwzKvA==
X-ME-Proxy: <xmx:ESA7W1XcbV5LDRq1jNXeQXZFXHnjjaJzo_i3UQCc0B-rb9GCzgzmEA>
    <xmx:ESA7W1wkYPErcIsZ_Z6po0D2TG0rHkmlYyPg4YIxVefsdbUgDrfS5Q>
    <xmx:ESA7WzNsRJvsNDtbea12_qUpMBtGfC7B_1vIVTUJfgdISfOBFeNowA>
    <xmx:ESA7W25hInhJ9b35MrGfbrIH-iYz1Yl8gBgjlMJ9Gk6rrvS5RP4IWQ>
    <xmx:ESA7W0M7LN1gzZjYJIku8AIjdPiW1uU-L4i-ECD-zPI_pKaBSyy5jg>
    <xmx:ESA7W_RyLR4vjJOtwB8XHzD0MsW1cKlWGMJmB3rlPgM84GwwNedm8Q>
X-ME-Sender: <xms:ESA7W3CfvAEi-4kgXYSejMRH1gc7DirSJ7RucWc9AMonSQEJuS78ng>
Received: from dave.bha-au.ibmmobiledemo.com (unknown [202.81.18.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id C83EC1026E;
        Tue,  3 Jul 2018 03:04:44 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/4] misc: Add bmc-misc-ctrl
Date:   Tue,  3 Jul 2018 17:04:12 +1000
Message-Id: <20180703070413.28756-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703070413.28756-1-andrew@aj.id.au>
References: <20180703070413.28756-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bmc-misc-ctrl is used to expose miscellaneous Baseboard
Management Controller (BMC) hardware features described in the devicetree
to userspace.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 MAINTAINERS                  |   1 +
 drivers/misc/Kconfig         |   8 +
 drivers/misc/Makefile        |   1 +
 drivers/misc/bmc-misc-ctrl.c | 363 +++++++++++++++++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 drivers/misc/bmc-misc-ctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9766d7832d8b..30d39440b6f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2741,6 +2741,7 @@ R:	Andrew Jeffery <andrew@aj.id.au>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
+F:	drivers/misc/bmc-misc-ctrl.c
 
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eacdf65d..f46bc8208b50 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,6 +513,14 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
+config BMC_MISC_CTRL
+	tristate "Miscellaneous BMC Control Interfaces"
+	depends on REGMAP && MFD_SYSCON
+	help
+	  Say yes to expose scratch registers used to communicate between the
+	  host and BMC along with other miscellaneous control interfaces
+	  provided by BMC SoCs
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index af22bbc3d00c..4fb2fac7a486 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_BMC_MISC_CTRL)     += bmc-misc-ctrl.o
diff --git a/drivers/misc/bmc-misc-ctrl.c b/drivers/misc/bmc-misc-ctrl.c
new file mode 100644
index 000000000000..ff907029163f
--- /dev/null
+++ b/drivers/misc/bmc-misc-ctrl.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp.
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/kobject.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct bmc_ctrl {
+	struct device *dev;
+	struct regmap *map;
+	bool ro;
+	u32 shift;
+	u32 mask;
+	struct kobj_attribute mask_attr;
+	const char *label;
+	struct kobj_attribute label_attr;
+	union {
+		struct {
+			u32 value;
+			struct kobj_attribute value_attr;
+		};
+		struct {
+			u32 read;
+			u32 set;
+			u32 clear;
+			struct kobj_attribute read_attr;
+			struct kobj_attribute set_attr;
+			struct kobj_attribute clear_attr;
+		};
+	};
+};
+
+static ssize_t bmc_misc_rmw_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct bmc_ctrl *ctrl;
+	unsigned int val;
+	int rc;
+
+	ctrl = container_of(attr, struct bmc_ctrl, value_attr);
+	rc = regmap_read(ctrl->map, ctrl->value, &val);
+	if (rc)
+		return rc;
+
+	val = (val & ctrl->mask) >> ctrl->shift;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t bmc_misc_rmw_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct bmc_ctrl *ctrl;
+	long val;
+	int rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ctrl = container_of(attr, struct bmc_ctrl, value_attr);
+	val <<= ctrl->shift;
+	if (val & ~ctrl->mask)
+		return -EINVAL;
+	rc = regmap_update_bits(ctrl->map, ctrl->value, ctrl->mask, val);
+
+	return rc < 0 ? rc : count;
+}
+
+static void bmc_misc_add_rmw_attrs(struct bmc_ctrl *ctrl,
+				   struct attribute *attrs[6])
+{
+	sysfs_attr_init(&ctrl->attr.attr);
+	ctrl->value_attr.attr.name = "value";
+	ctrl->value_attr.attr.mode = 0664;
+	ctrl->value_attr.show = bmc_misc_rmw_show;
+	ctrl->value_attr.store = bmc_misc_rmw_store;
+	attrs[2] = &ctrl->value_attr.attr;
+	attrs[3] = NULL;
+}
+
+static int bmc_misc_init_rmw(struct bmc_ctrl *ctrl, struct device_node *node,
+			     struct attribute *attrs[6])
+{
+	u32 val;
+	int rc;
+
+	rc = of_property_read_u32(node, "offset", &ctrl->value);
+	if (rc < 0)
+		return rc;
+
+	if (!of_property_read_u32(node, "default-value", &val)) {
+		val <<= ctrl->shift;
+		if (val & ~ctrl->mask)
+			return -EINVAL;
+		val &= ctrl->mask;
+		regmap_update_bits(ctrl->map, ctrl->value, ctrl->mask, val);
+	}
+
+	bmc_misc_add_rmw_attrs(ctrl, attrs);
+
+	return 0;
+}
+
+static ssize_t bmc_misc_sc_read_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct bmc_ctrl *ctrl;
+	unsigned int val;
+	int rc;
+
+	ctrl = container_of(attr, struct bmc_ctrl, read_attr);
+	rc = regmap_read(ctrl->map, ctrl->read, &val);
+	if (rc)
+		return rc;
+
+	val = (val & ctrl->mask) >> ctrl->shift;
+
+	return sprintf(buf, "%u\n", val);
+
+}
+
+static ssize_t bmc_misc_sc_set_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct bmc_ctrl *ctrl;
+	long val;
+	int rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ctrl = container_of(attr, struct bmc_ctrl, set_attr);
+	val <<= ctrl->shift;
+	if (val & ~ctrl->mask)
+		return -EINVAL;
+	val &= ctrl->mask;
+	rc = regmap_write(ctrl->map, ctrl->set, val);
+
+	return rc < 0 ? rc : count;
+}
+
+static ssize_t bmc_misc_sc_clear_store(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct bmc_ctrl *ctrl;
+	long val;
+	int rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ctrl = container_of(attr, struct bmc_ctrl, clear_attr);
+	val <<= ctrl->shift;
+	if (val & ~ctrl->mask)
+		return -EINVAL;
+	val &= ctrl->mask;
+	rc = regmap_write(ctrl->map, ctrl->clear, val);
+
+	return rc < 0 ? rc : count;
+}
+
+static void bmc_misc_add_sc_attrs(struct bmc_ctrl *ctrl,
+				  struct attribute *attrs[6])
+{
+	sysfs_attr_init(&ctrl->read_attr.attr);
+	ctrl->read_attr.attr.name = "value";
+	ctrl->read_attr.attr.mode = 0444;
+	ctrl->read_attr.show = bmc_misc_sc_read_show;
+	attrs[2] = &ctrl->read_attr.attr;
+
+	sysfs_attr_init(&ctrl->set_attr.attr);
+	ctrl->set_attr.attr.name = "set";
+	ctrl->set_attr.attr.mode = 0200;
+	ctrl->set_attr.store = bmc_misc_sc_set_store;
+	attrs[3] = &ctrl->set_attr.attr;
+
+	sysfs_attr_init(&ctrl->clear_attr.attr);
+	ctrl->clear_attr.attr.name = "clear";
+	ctrl->clear_attr.attr.mode = 0200;
+	ctrl->clear_attr.store = bmc_misc_sc_clear_store;
+	attrs[4] = &ctrl->clear_attr.attr;
+
+	attrs[5] = NULL;
+}
+
+static int bmc_misc_init_sc(struct bmc_ctrl *ctrl, struct device_node *node,
+			    struct attribute *attrs[6])
+{
+	int rc;
+
+	rc = of_property_read_u32_array(node, "offset", &ctrl->read, 3);
+	if (rc < 0)
+		return rc;
+
+	if (of_property_read_bool(node, "default-set"))
+		regmap_write(ctrl->map, ctrl->set, ctrl->mask);
+	else if (of_property_read_bool(node, "default-clear"))
+		regmap_write(ctrl->map, ctrl->clear, ctrl->mask);
+
+	bmc_misc_add_sc_attrs(ctrl, attrs);
+
+	return 0;
+}
+
+static ssize_t bmc_misc_label_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	struct bmc_ctrl *ctrl = container_of(attr, struct bmc_ctrl, label_attr);
+
+	return sprintf(buf, "%s\n", ctrl->label);
+}
+
+static ssize_t bmc_misc_mask_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	struct bmc_ctrl *ctrl = container_of(attr, struct bmc_ctrl, mask_attr);
+
+	return sprintf(buf, "0x%x\n", ctrl->mask >> ctrl->shift);
+}
+
+static int bmc_misc_init_dt(struct bmc_ctrl *ctrl, struct device_node *node,
+			    struct attribute *attrs[6])
+{
+	int rc;
+
+	/* Example children:
+	 *
+	 * field@80.6 {
+	 *      compatible = "bmc-misc-control";
+	 *      reg = <0x80>;
+	 *      bit-mask = <0x1>;
+	 *      bit-shift = <6>;
+	 *      label = "ilpc2ahb-disable";
+	 * };
+	 *
+	 * field@70.6 {
+	 *      compatible = "bmc-misc-control";
+	 *      // Write-1-set/Write-1-clear semantics
+	 *      set-clear;
+	 *      default-set;
+	 *      reg = <0x70 0x70 0x7c>
+	 *      bit-mask = <0x1>;
+	 *      bit-shift = <6>;
+	 *      label = "lpc-sio-decode-disable";
+	 * };
+	 *
+	 * field@50.0 {
+	 *	compatible = "bmc-misc-control";
+	 *	read-only;
+	 *	reg = <0x50>;
+	 *	bit-mask = <0xffffffff>;
+	 *	bit-shift = <0>;
+	 *	label = "vga-scratch-1";
+	 * };
+	 */
+	rc = of_property_read_u32(node, "mask", &ctrl->mask);
+	if (rc < 0)
+		return rc;
+
+	ctrl->shift = __ffs(ctrl->mask);
+	ctrl->ro = of_property_read_bool(node, "read-only");
+
+	rc = of_property_read_string(node, "label", &ctrl->label);
+	if (rc < 0)
+		return rc;
+
+	ctrl->label_attr.attr.name = "label";
+	ctrl->label_attr.attr.mode = 0444;
+	ctrl->label_attr.show = bmc_misc_label_show;
+	attrs[0] = &ctrl->label_attr.attr;
+
+	ctrl->mask_attr.attr.name = "mask";
+	ctrl->mask_attr.attr.mode = 0444;
+	ctrl->mask_attr.show = bmc_misc_mask_show;
+	attrs[1] = &ctrl->mask_attr.attr;
+
+	if (of_property_read_bool(node, "set-clear"))
+		return bmc_misc_init_sc(ctrl, node, attrs);
+
+	return bmc_misc_init_rmw(ctrl, node, attrs);
+}
+
+static struct class bmc_class = {
+	.name =		"bmc",
+};
+
+static int bmc_misc_probe(struct platform_device *pdev)
+{
+	struct attribute *attrs[6];
+	struct attribute **attr;
+	struct bmc_ctrl *ctrl;
+	int rc;
+
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+
+	rc = bmc_misc_init_dt(ctrl, pdev->dev.of_node, attrs);
+	if (rc < 0)
+		return rc;
+
+	ctrl->dev = device_create(&bmc_class, &pdev->dev, 0, ctrl, "%s",
+			     ctrl->label);
+	if (IS_ERR(ctrl->dev))
+		return PTR_ERR(ctrl->dev);
+
+	for (attr = &attrs[0]; *attr; attr++) {
+		rc = sysfs_create_file(&ctrl->dev->kobj, *attr);
+		if (rc < 0)
+			/* FIXME: Cleanup */
+			return rc;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id bmc_misc_match[] = {
+	{ .compatible = "bmc-misc-ctrl" },
+	{ },
+};
+
+static struct platform_driver bmc_misc = {
+	.driver = {
+		.name		=  "bmc-misc-ctrl",
+		.of_match_table = bmc_misc_match,
+	},
+	.probe = bmc_misc_probe,
+};
+
+static int bmc_misc_ctrl_init(void)
+{
+	int rc;
+
+	rc = class_register(&bmc_class);
+	if (rc < 0)
+		return rc;
+
+	return platform_driver_register(&bmc_misc);
+}
+module_init(bmc_misc_ctrl_init);
+
+static void bmc_misc_ctrl_exit(void)
+{
+	platform_driver_unregister(&bmc_misc);
+	class_unregister(&bmc_class);
+}
+module_exit(bmc_misc_ctrl_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-- 
2.17.1

