Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB5DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBE2208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="cT+58nzu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chJs1nyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBE2208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeGKFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:34:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42723 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbeGKFe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:34:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F3E321B76;
        Wed, 11 Jul 2018 01:32:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 11 Jul 2018 01:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SZWIoOsGDDb9rHcda
        RFj4qbA2OBbrK+EQfGsJHOfRFs=; b=cT+58nzutr8jqNcm5FkJCpRuEfbwzsBLM
        ldmtmRnq2grHuZL0DPyNSviWN6S2gD7MjdK6Qt6DK55XFd1yl2+Bq2Qjbfm2ERVY
        db+WrIERDMfZmR0PN3TQudXQREXrrxWHYUQNi2KHzTNyoul4CTnMclRyklaNP6b0
        RanezTOoP27kRVxNrehvcvDkh0sGNEEJBzQAYJcYvtFrfKhwyUq/7bLSluKYqXid
        ywEAkUsOROdlFzkpaH22XWu058XT3kFh1iYXNeyM2VN82cu/D/fSNwILBmOVqlq3
        rJQ4RHZWgA2XcZ8ckL9RPLxyuMCBIE+HcSH3puInwkSBZxOnA7SQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SZWIoOsGDDb9rHcdaRFj4qbA2OBbrK+EQfGsJHOfRFs=; b=chJs1nyh
        PO50i1M2fxYOEIRvQw5ndiZQ62cusBUAE7AtI7qzS3aphXtYpTiIlg1Z1gzRV+hU
        VQ7Jdj1UsB8074/bfdw42USQvLN8qtnjD49ImEe6FETwXD6H2KqgbVag25BlT5Vh
        LZ2P6MoIMk52sJRHX3HCMSdlInqyonpKFfI/yVjRQtB5QVJwebVnfFy5iROJPhoW
        Qhb9RT0B+9Mxvsm6xM8ZjcdRQKgVXPV+n+bB56W3UuCXonT4ZXxdS98lqtI8vLbz
        kQcpP945x0ayR9HYODyD65RcBx0Y2HdXFUWOHRhbtkGVnaAfEcLSVgHBtKBK63Su
        R5KMC+p8T4C1HQ==
X-ME-Proxy: <xmx:apZFW1LBDceqzfxCRvRuY83VNqQOl-Xrce3Uow4-zbBaRlnDgasTpA>
    <xmx:apZFWzGqPMrZAbryAUBIodPYuzEx_C5AZmI6Nnf3K_CoEX5r-IFSnw>
    <xmx:apZFW4Fwbq_3GIB_8s0M05Qpguo9ZvXsS0MgNCaNopuqh6-CrnVYPg>
    <xmx:apZFWzvzd2M2YMRLO8ZcEtbnBjB8EwObN-r88GDeIEVEvGYJeg7MXQ>
    <xmx:apZFW7aTkHzRQiyOPcWdtcNEMotqG_muMoPsY6iiUMdqNP0A4-NiZg>
    <xmx:apZFW4MwvG9YvAE9oFvWFttG7JvMe8LWXeutG1HGDaHJ45xNtL4ABQ>
X-ME-Sender: <xms:apZFWxTZaMempATLsmdlBJdosub6zMuJpNBnzfwQfuAQ5E28wCq4fg>
Received: from localhost.localdomain (ppp118-210-173-37.bras2.adl6.internode.on.net [118.210.173.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 547C1E45C9;
        Wed, 11 Jul 2018 01:32:21 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 3/4] misc: Add bmc-misc-ctrl
Date:   Wed, 11 Jul 2018 15:01:21 +0930
Message-Id: <20180711053122.30773-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711053122.30773-1-andrew@aj.id.au>
References: <20180711053122.30773-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bmc-misc-ctrl platform driver stitches together the associated
devicetree bindings and the sysfs-devices-platform-field ABI to expose
fields described in the devicetree to userspace via sysfs.

While the userspace interface does not provide an abstraction over the
hardware, it does provide some improvements over devmem:

1. Removal of read-modify-write races, as register access is atomic
2. Reduced foot-gun, as only the defined field is accessible
3. Improved discoverability, as the fields are named

Userspace is expected to use its own means to discover fields of
interest in /sys/devices/platform, either via udev events or search.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since RFC v1:

* Fix issues pointed out by Greg
* Drop the device class

 MAINTAINERS                  |   1 +
 drivers/misc/Kconfig         |  11 +
 drivers/misc/Makefile        |   1 +
 drivers/misc/bmc-misc-ctrl.c | 446 +++++++++++++++++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 drivers/misc/bmc-misc-ctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d167f0340c11..c29136614cb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2742,6 +2742,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
 F:	Documentation/ABI/testing/sysfs-devices-platform-field
+F:	drivers/misc/bmc-misc-ctrl.c
 
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eacdf65d..914f8d37645d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,6 +513,17 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
+config BMC_MISC_CTRL
+	tristate "Miscellaneous BMC Control Interfaces"
+	depends on REGMAP && MFD_SYSCON
+	help
+	  Say yes to expose scratch registers used to communicate between the
+	  host and BMC along with other miscellaneous control interfaces
+	  provided by BMC SoCs.
+
+	  Attributes for controlling the fields are exposed in sysfs according
+	  to the sysfs-devices-platform-field ABI.
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
index 000000000000..93e1412f7087
--- /dev/null
+++ b/drivers/misc/bmc-misc-ctrl.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp.
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct bmc_misc_label {
+	const char *label;
+	struct device_attribute label_attr;
+};
+
+struct bmc_misc_field {
+	u32 shift;
+	u32 mask;
+	struct device_attribute mask_attr;
+};
+
+struct bmc_misc_type {
+	const char *type;
+	struct device_attribute type_attr;
+};
+
+struct bmc_misc_rw {
+	struct regmap *map;
+
+	struct bmc_misc_field field;
+	struct bmc_misc_label label;
+	struct bmc_misc_type type;
+
+	u32 value;
+	struct device_attribute value_attr;
+
+	struct attribute_group attr_grp;
+	struct attribute *attrs[5];
+};
+
+struct bmc_misc_sc {
+	struct regmap *map;
+
+	struct bmc_misc_field field;
+	struct bmc_misc_label label;
+	struct bmc_misc_type type;
+
+	u32 read;
+	u32 set;
+	u32 clear;
+
+	struct device_attribute read_attr;
+	struct device_attribute set_attr;
+	struct device_attribute clear_attr;
+
+	struct attribute_group attr_grp;
+	struct attribute *attrs[7];
+};
+
+static ssize_t bmc_misc_label_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct bmc_misc_label *priv;
+
+	priv = container_of(attr, struct bmc_misc_label, label_attr);
+
+	return sprintf(buf, "%s\n", priv->label);
+}
+
+static int bmc_misc_label_init(struct device_node *node,
+			       struct bmc_misc_label *priv)
+{
+	int rc;
+
+	rc = of_property_read_string(node, "label", &priv->label);
+	if (rc < 0)
+		return rc;
+
+	sysfs_attr_init(&priv->label_attr.attr);
+	priv->label_attr.attr.name = "label";
+	priv->label_attr.attr.mode = 0440;
+	priv->label_attr.show = bmc_misc_label_show;
+
+	return 0;
+}
+
+static ssize_t bmc_misc_mask_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct bmc_misc_field *priv;
+
+	priv = container_of(attr, struct bmc_misc_field, mask_attr);
+
+	return sprintf(buf, "0x%x\n", priv->mask >> priv->shift);
+}
+
+static int bmc_misc_field_init(struct device_node *node,
+			       struct bmc_misc_field *priv)
+{
+	int rc;
+
+	rc = of_property_read_u32(node, "mask", &priv->mask);
+	if (rc < 0)
+		return rc;
+
+	priv->shift = __ffs(priv->mask);
+
+	sysfs_attr_init(&priv->mask_attr.attr);
+	priv->mask_attr.attr.name = "mask";
+	priv->mask_attr.attr.mode = 0440;
+	priv->mask_attr.show = bmc_misc_mask_show;
+
+	return 0;
+}
+
+static ssize_t bmc_misc_type_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct bmc_misc_type *priv;
+
+	priv = container_of(attr, struct bmc_misc_type, type_attr);
+
+	return sprintf(buf, "%s\n", priv->type);
+}
+
+static int bmc_misc_type_init(struct device_node *node,
+			      struct bmc_misc_type *priv)
+{
+	bool ro, w1sc;
+
+	ro = of_property_read_bool(node, "read-only");
+	w1sc = of_property_read_bool(node, "set-clear");
+
+	if (ro && !w1sc)
+		priv->type = "ro";
+	else if (!ro && w1sc)
+		priv->type = "w1sc";
+	else if (!ro && !w1sc)
+		priv->type = "rw";
+	else
+		return -EINVAL;
+
+	sysfs_attr_init(&priv->type_attr.attr);
+	priv->type_attr.attr.name = "type";
+	priv->type_attr.attr.mode = 0440;
+	priv->type_attr.show = bmc_misc_type_show;
+
+	return 0;
+}
+
+static ssize_t bmc_misc_rw_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct bmc_misc_rw *rw;
+	unsigned int val;
+	int rc;
+
+	rw = container_of(attr, struct bmc_misc_rw, value_attr);
+	rc = regmap_read(rw->map, rw->value, &val);
+	if (rc)
+		return rc;
+
+	val = (val & rw->field.mask) >> rw->field.shift;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t bmc_misc_rw_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct bmc_misc_rw *rw;
+	long val;
+	int rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	rw = container_of(attr, struct bmc_misc_rw, value_attr);
+	val <<= rw->field.shift;
+	if (val & ~rw->field.mask)
+		return -EINVAL;
+	rc = regmap_update_bits(rw->map, rw->value, rw->field.mask,
+				val);
+
+	return rc < 0 ? rc : count;
+}
+
+static int bmc_misc_rw_init(struct platform_device *pdev)
+{
+	struct device_node *node;
+	struct bmc_misc_rw *priv;
+	u32 val;
+	int rc;
+
+	node = pdev->dev.of_node;
+
+	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+
+	rc = of_property_read_u32(node, "offset", &priv->value);
+	if (rc < 0)
+		return rc;
+
+	rc = bmc_misc_label_init(node, &priv->label);
+	if (rc < 0)
+		return rc;
+
+	rc = bmc_misc_field_init(node, &priv->field);
+	if (rc < 0)
+		return rc;
+
+	rc = bmc_misc_type_init(node, &priv->type);
+	if (rc < 0)
+		return rc;
+
+	if (!of_property_read_u32(node, "default-value", &val)) {
+		val <<= priv->field.shift;
+		if (val & ~priv->field.mask)
+			return -EINVAL;
+		val &= priv->field.mask;
+		regmap_update_bits(priv->map, priv->value, priv->field.mask,
+				   val);
+	}
+
+	sysfs_attr_init(&priv->value_attr.attr);
+	priv->value_attr.attr.name = "value";
+	priv->value_attr.attr.mode = 0440;
+	if (!of_property_read_bool(node, "read-only"))
+		priv->value_attr.attr.mode |= 0220;
+	priv->value_attr.show = bmc_misc_rw_show;
+	priv->value_attr.store = bmc_misc_rw_store;
+
+	priv->attrs[0] = &priv->label.label_attr.attr;
+	priv->attrs[1] = &priv->field.mask_attr.attr;
+	priv->attrs[2] = &priv->type.type_attr.attr;
+	priv->attrs[3] = &priv->value_attr.attr;
+	priv->attrs[4] = NULL;
+
+	memset(&priv->attr_grp, 0, sizeof(priv->attr_grp));
+	priv->attr_grp.name = priv->label.label;
+	priv->attr_grp.attrs = priv->attrs;
+
+
+	rc = sysfs_create_group(&pdev->dev.kobj, &priv->attr_grp);
+	if (rc < 0)
+		return rc;
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_info(&pdev->dev, "%s field %s\n", priv->type.type,
+		 priv->label.label);
+
+	return 0;
+}
+
+static ssize_t bmc_misc_sc_read_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct bmc_misc_sc *priv;
+	unsigned int val;
+	int rc;
+
+	priv = container_of(attr, struct bmc_misc_sc, read_attr);
+	rc = regmap_read(priv->map, priv->read, &val);
+	if (rc)
+		return rc;
+
+	val = (val & priv->field.mask) >> priv->field.shift;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t bmc_misc_sc_set_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct bmc_misc_sc *priv;
+	long val;
+	int rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	priv = container_of(attr, struct bmc_misc_sc, set_attr);
+	val <<= priv->field.shift;
+	if (val & ~priv->field.mask)
+		return -EINVAL;
+	val &= priv->field.mask;
+	rc = regmap_write(priv->map, priv->set, val);
+
+	return rc < 0 ? rc : count;
+}
+
+static ssize_t bmc_misc_sc_clear_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct bmc_misc_sc *priv;
+	long val;
+	int rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	priv = container_of(attr, struct bmc_misc_sc, clear_attr);
+	val <<= priv->field.shift;
+	if (val & ~priv->field.mask)
+		return -EINVAL;
+	val &= priv->field.mask;
+	rc = regmap_write(priv->map, priv->clear, val);
+
+	return rc < 0 ? rc : count;
+}
+
+static int bmc_misc_sc_init(struct platform_device *pdev)
+{
+	struct device_node *node;
+	struct bmc_misc_sc *priv;
+	int rc;
+
+	node = pdev->dev.of_node;
+
+	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+
+	rc = of_property_read_u32_array(node, "offset", &priv->read, 3);
+	if (rc < 0)
+		return rc;
+
+	rc = bmc_misc_label_init(node, &priv->label);
+	if (rc < 0)
+		return rc;
+
+	rc = bmc_misc_field_init(node, &priv->field);
+	if (rc < 0)
+		return rc;
+
+	rc = bmc_misc_type_init(node, &priv->type);
+	if (rc < 0)
+		return rc;
+
+	if (of_property_read_bool(node, "default-set"))
+		regmap_write(priv->map, priv->set, priv->field.mask);
+	else if (of_property_read_bool(node, "default-clear"))
+		regmap_write(priv->map, priv->clear, priv->field.mask);
+
+	sysfs_attr_init(&priv->read_attr.attr);
+	priv->read_attr.attr.name = "value";
+	priv->read_attr.attr.mode = 0440;
+	priv->read_attr.show = bmc_misc_sc_read_show;
+
+	sysfs_attr_init(&priv->set_attr.attr);
+	priv->set_attr.attr.name = "set";
+	priv->set_attr.attr.mode = 0220;
+	priv->set_attr.store = bmc_misc_sc_set_store;
+
+	sysfs_attr_init(&priv->clear_attr.attr);
+	priv->clear_attr.attr.name = "clear";
+	priv->clear_attr.attr.mode = 0220;
+	priv->clear_attr.store = bmc_misc_sc_clear_store;
+
+	priv->attrs[0] = &priv->label.label_attr.attr;
+	priv->attrs[1] = &priv->field.mask_attr.attr;
+	priv->attrs[2] = &priv->type.type_attr.attr;
+	priv->attrs[3] = &priv->read_attr.attr;
+	priv->attrs[4] = &priv->set_attr.attr;
+	priv->attrs[5] = &priv->clear_attr.attr;
+	priv->attrs[6] = NULL;
+
+	memset(&priv->attr_grp, 0, sizeof(priv->attr_grp));
+	priv->attr_grp.name = priv->label.label;
+	priv->attr_grp.attrs = priv->attrs;
+
+	rc = sysfs_create_group(&pdev->dev.kobj, &priv->attr_grp);
+	if (rc < 0)
+		return rc;
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_info(&pdev->dev, "%s field %s\n", priv->type.type,
+		 priv->label.label);
+
+	return 0;
+}
+
+static int bmc_misc_probe(struct platform_device *pdev)
+{
+	if (of_property_read_bool(pdev->dev.of_node, "set-clear"))
+		return bmc_misc_sc_init(pdev);
+
+	return bmc_misc_rw_init(pdev);
+}
+
+static void bmc_misc_sc_del(struct platform_device *pdev)
+{
+	struct bmc_misc_sc *priv = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &priv->attr_grp);
+}
+
+static void bmc_misc_rw_del(struct platform_device *pdev)
+{
+	struct bmc_misc_rw *priv = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &priv->attr_grp);
+}
+
+static int bmc_misc_remove(struct platform_device *pdev)
+{
+	if (of_property_read_bool(pdev->dev.of_node, "set-clear"))
+		bmc_misc_sc_del(pdev);
+	else
+		bmc_misc_rw_del(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id bmc_misc_ctrl_match[] = {
+	{ .compatible = "bmc-misc-ctrl", },
+	{ },
+};
+
+static struct platform_driver bmc_misc_ctrl = {
+	.driver = {
+		.name		=  "bmc-misc-ctrl",
+		.of_match_table = bmc_misc_ctrl_match,
+	},
+	.probe = bmc_misc_probe,
+	.remove = bmc_misc_remove,
+};
+
+module_platform_driver(bmc_misc_ctrl);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-- 
2.17.1

