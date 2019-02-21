Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7780B20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNKrXj4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBUWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:25:45 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:53881 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:25:44 -0500
Received: by mail-vk1-f202.google.com with SMTP id 5so93830vkg.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u64E33NrAke7Ev3law4MbEFyAR7LNNdIxIlS4wFQq90=;
        b=TNKrXj4qgBXxK4dMtwWoygcfXncJxQ6KAIcLT+GR0euHObtGadXjGP8fmU7DBCSAGi
         ZBAL7F9jNsk97dp68Y7x1rRVozH7ZO/Y5hLXXlADrq8RLCNs7U999FK3jvD1FEDLAnNv
         0R0IjtFeutUVP9SZ3aTLFEqSwm4adnvQ5ey90OOVGVh6V4xoaP8smcpKZRzeRwTZvFxC
         nq2Uwt2VXOi8b5zO997ss3mH7sialDIGWE45NzgLUzhnCibLNRHDsgllZx2o6x4PIB4w
         KMrIB5KcSBTVDvf8F83iauMaNABhld9GImZTdWH+qcTJ9jPf5jc134LOAty6Wbz1E23d
         eVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u64E33NrAke7Ev3law4MbEFyAR7LNNdIxIlS4wFQq90=;
        b=LKq1EvITy3e/BWCRb2cNqp2uQCdZS054gQh9rUhZxOETzVizBKHbxwa7MtPP9maapu
         5Rw/AUCWcXSVerpiOUakJQ9a6Ir6CqlVlu75QQujHc7OftOzEruQUkxqHTinzSgkzHPQ
         0dO+5qhQpFB4WTvJ1n1ZS1Nw6YK9Hzz5qjZChMWKgOGPyVTvPdFk9kdyPXoDdEcSNYJl
         BHV9pX9FNY8PF00C/VPNqoFw3q9TBLpn66PxwMuhaGE4OPHZvUz1XtUkbk0MYc76E/bo
         VgvGPSYzAsarwIlrBuS5Kw1ex72wdOrC2cj8CIhWVmZWdr7nIqD6wzcg0bB3uuoi3F7+
         F27g==
X-Gm-Message-State: AHQUAuY01kW+xv5A8jM/S9ZaWFc0MCe8rz/isrxtXhMGwD/twNhlOzHo
        mlPX+w89Zw0RtEKiDlsjdJVbUl/lVvME
X-Google-Smtp-Source: AHgI3IYQ+qydWOdLlLOCII9Eam9SqjaNRFpgFHkeKevESEet62gpP+AzuoRj8u2cl7Mu90dNBv53M/RBrviT
X-Received: by 2002:a67:84cf:: with SMTP id g198mr601715vsd.10.1550787942021;
 Thu, 21 Feb 2019 14:25:42 -0800 (PST)
Date:   Thu, 21 Feb 2019 14:25:37 -0800
Message-Id: <20190221222537.137331-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        joel@jms.id.au, andrew@aj.id.au
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASPEED AST2400, and AST2500 in some configurations include a
PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
in the BMC's memory space.  This feature is especially useful when using
this bridge to send large files to the BMC.

The host may use this to send down a firmware image by staging data at a
specific memory address, and in a coordinated effort with the BMC's
software stack and kernel, transmit the bytes.

This driver enables the BMC to unlock the PCI bridge on demand, and
configure it via ioctl to allow the host to write bytes to an agreed
upon location.  In the primary use-case, the region to use is known
apriori on the BMC, and the host requests this information.  Once this
request is received, the BMC's software stack will enable the bridge and
the region and then using some software flow control (possibly via IPMI
packets), copy the bytes down.  Once the process is complete, the BMC
will disable the bridge and unset any region involved.

The default behavior of this bridge when present is: enabled and all
regions marked read-write.  This driver will fix the regions to be
read-only and then disable the bridge entirely.

Signed-off-by: Patrick Venture <venture@google.com>
---
 drivers/misc/Kconfig                 |   8 +
 drivers/misc/Makefile                |   1 +
 drivers/misc/aspeed-p2a-ctrl.c       | 498 +++++++++++++++++++++++++++
 include/uapi/linux/aspeed-p2a-ctrl.h |  46 +++
 4 files changed, 553 insertions(+)
 create mode 100644 drivers/misc/aspeed-p2a-ctrl.c
 create mode 100644 include/uapi/linux/aspeed-p2a-ctrl.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f417b06e11c5..54ed265a26f0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -485,6 +485,14 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
+config ASPEED_P2A_CTRL
+	depends on (ARCH_ASPEED || COMPILE_TEST)
+	tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
+	help
+	  Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings through
+	  ioctl()s, the driver also provides an interface for userspace mappings to
+	  a pre-defined region.
+
 config ASPEED_LPC_CTRL
 	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
 	tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e39ccbbc1b3a..57577aee354f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
+obj-$(CONFIG_ASPEED_P2A_CTRL)	+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
new file mode 100644
index 000000000000..a3cf00de9038
--- /dev/null
+++ b/drivers/misc/aspeed-p2a-ctrl.c
@@ -0,0 +1,498 @@
+/*
+ * Copyright 2019 Google Inc
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Provides a simple driver to control the ASPEED P2A interface which allows
+ * the host to read and write to various regions of the BMC's memory.
+ */
+
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/aspeed-p2a-ctrl.h>
+
+#define DEVICE_NAME	"aspeed-p2a-ctrl"
+
+#define SCU180_ENP2A BIT(0)
+
+/* The ast2400/2500 both have six ranges. */
+#define P2A_REGION_COUNT 6
+
+struct region {
+	u32 min;
+	u32 max;
+	u32 bit;
+};
+
+struct aspeed_p2a_model_data {
+	/* min, max, bit */
+	struct region regions[P2A_REGION_COUNT];
+};
+
+struct aspeed_p2a_ctrl {
+	struct miscdevice miscdev;
+
+	/* Lock access to the registers so they're is consistent. */
+	struct mutex lo_mutex;
+	void __iomem *loregs;
+	struct mutex hi_mutex;
+	void __iomem *hiregs;
+
+	const struct aspeed_p2a_model_data *config;
+
+	/* Access to these needs to be locked, held via probe, mapping ioctl,
+	 * and release, remove.
+	 */
+	struct mutex tracking;
+	u32 readers;
+	u32 readerwriters[P2A_REGION_COUNT];
+
+	phys_addr_t mem_base;
+	resource_size_t mem_size;
+	/* Because the memory_region is optional, this tracks whether it was
+	 * set.
+	 */
+	bool region_specified;
+};
+
+static inline u32 aspeed_p2a_read(void __iomem *base)
+{
+	return readl((void *)base);
+}
+
+static inline void aspeed_p2a_write(void __iomem *base, u32 val)
+{
+	writel(val, (void *)base);
+}
+
+struct aspeed_p2a_user {
+	struct file *file;
+	struct aspeed_p2a_ctrl *parent;
+
+	/** The entire memory space is opened for reading once the bridge is
+	 * enabled, therefore this needs only to be tracked once per user.
+	 * If any user has it open for read, the bridge must stay enabled.
+	 */
+	u32 read;
+
+	/** Each entry of the array corresponds to a P2A Region.  If the user
+	 * opens for read or readwrite, the reference goes up here.  On release,
+	 * this array is walked and references adjusted accordingly.
+	 */
+	u32 readwrite[P2A_REGION_COUNT];
+};
+
+static void aspeed_p2a_enable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
+{
+	u32 curr_value;
+
+	mutex_lock(&p2a_ctrl->hi_mutex);
+	curr_value = aspeed_p2a_read(p2a_ctrl->hiregs);
+	curr_value |= SCU180_ENP2A;
+	aspeed_p2a_write(p2a_ctrl->hiregs, curr_value);
+	mutex_unlock(&p2a_ctrl->hi_mutex);
+}
+
+/** The bridge is controlled by bit 0 of SCU180. */
+static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
+{
+	u32 curr_value;
+
+	mutex_lock(&p2a_ctrl->hi_mutex);
+	curr_value = aspeed_p2a_read(p2a_ctrl->hiregs);
+	curr_value &= ~SCU180_ENP2A;
+	aspeed_p2a_write(p2a_ctrl->hiregs, curr_value);
+	mutex_unlock(&p2a_ctrl->hi_mutex);
+}
+
+static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct aspeed_p2a_user *priv = file->private_data;
+	struct aspeed_p2a_ctrl *ctrl = priv->parent;
+
+	if (!ctrl->region_specified)
+		return -EINVAL;
+
+	unsigned long vsize = vma->vm_end - vma->vm_start;
+	pgprot_t prot = vma->vm_page_prot;
+
+	if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
+		return -EINVAL;
+
+	/* ast2400/2500 AHB accesses are not cache coherent */
+	prot = pgprot_noncached(prot);
+
+	if (remap_pfn_range(vma, vma->vm_start,
+		(ctrl->mem_base >> PAGE_SHIFT) + vma->vm_pgoff,
+		vsize, prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static void aspeed_p2a_region_search(struct aspeed_p2a_user *priv,
+		struct aspeed_p2a_ctrl *ctrl,
+		struct aspeed_p2a_ctrl_mapping *map)
+{
+	int i;
+	u32 base, end;
+	u32 value;
+
+	base = map->addr;
+	end = map->addr + (map->length - 1);
+
+	/* If the value is a legal u32, it will find a match. */
+	for (i = 0; i < P2A_REGION_COUNT; i++) {
+		const struct region *curr = &ctrl->config->regions[i];
+
+		/* If the top of this region is lower than your base, skip it.
+		 */
+		if (curr->max < base)
+			continue;
+
+		/* If the bottom of this region is higher than your end, bail.
+		 */
+		if (curr->min > end)
+			break;
+
+		/* Lock this and update it, therefore it someone else is
+		 * closing their file out, this'll preserve the increment.
+		 */
+		mutex_lock(&ctrl->tracking);
+		ctrl->readerwriters[i] += 1;
+		mutex_unlock(&ctrl->tracking);
+
+		/* Track with the user, so when they close their file, we can
+		 * decrement properly.
+		 */
+		priv->readwrite[i] += 1;
+
+		/* Enable the region as read-write. */
+		mutex_lock(&ctrl->lo_mutex);
+		value =	aspeed_p2a_read(ctrl->loregs);
+		value &= ~curr->bit;
+		aspeed_p2a_write(ctrl->loregs, value);
+		mutex_unlock(&ctrl->lo_mutex);
+	}
+}
+
+static long aspeed_p2a_ioctl(struct file *file, unsigned int cmd,
+		unsigned long data)
+{
+	struct aspeed_p2a_user *priv = file->private_data;
+	struct aspeed_p2a_ctrl *ctrl = priv->parent;
+	void __user *arg = (void __user *)data;
+	struct aspeed_p2a_ctrl_mapping map;
+	int i;
+
+	switch (cmd) {
+	case ASPEED_P2A_CTRL_IOCTL_SET_WINDOW:
+		if (copy_from_user(&map, arg, sizeof(map)))
+			return -EFAULT;
+
+		/* If they want a region to be read-only, since the entire
+		 * region is read-only once enabled, we just need to track this
+		 * user wants to read from the bridge, and if it's not enabled.
+		 * Enable it.
+		 */
+		if (map.flags == ASPEED_P2A_CTRL_READ_ONLY) {
+			mutex_lock(&ctrl->tracking);
+			ctrl->readers += 1;
+			mutex_unlock(&ctrl->tracking);
+
+			/* Track with the user, so when they close their file,
+			 * we can decrement properly.
+			 */
+			priv->read += 1;
+		} else if (map.flags == ASPEED_P2A_CTRL_READWRITE) {
+			aspeed_p2a_region_search(priv, ctrl, &map);
+		} else {
+			/* Invalid map flags. */
+			return -EINVAL;
+		}
+
+		aspeed_p2a_enable_bridge(ctrl);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+
+/**
+ * When a user opens this file, we create a structure to track their mappings.
+ *
+ * A user can map a region as read-only (bridge enabled), or read-write (bit
+ * flipped, and bridge enabled).  Either way, this tracking is used, s.t. when
+ * they release the device references are handled.
+ *
+ * The bridge is not enabled until a user calls an ioctl to map a region,
+ * simply opening the device does not enable it.
+ */
+static int aspeed_p2a_open(struct inode *inode, struct file *file)
+{
+	struct aspeed_p2a_user *priv;
+
+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->file = file;
+	priv->read = 0;
+	memset(priv->readwrite, 0, sizeof(priv->readwrite));
+
+	/* The file's private_data is initialized to the p2a_ctrl. */
+	priv->parent = file->private_data;
+
+	/* Set the file's private_data to the user's data. */
+	file->private_data = priv;
+
+	return 0;
+}
+
+/**
+ * This will close the users mappings.  It will go through what they had opened
+ * for readwrite, and decrement those counts.  If at the end, this is the last
+ * user, it'll close the bridge.
+ */
+static int aspeed_p2a_release(struct inode *inode, struct file *file)
+{
+	int i;
+	u32 value;
+	u32 bits = 0;
+	bool open_regions = false;
+	struct aspeed_p2a_user *priv = file->private_data;
+
+	mutex_lock(&priv->parent->tracking);
+	priv->parent->readers -= priv->read;
+
+	for (i = 0; i < P2A_REGION_COUNT; i++) {
+		priv->parent->readerwriters[i] -= priv->readwrite[i];
+
+		if (priv->parent->readerwriters[i] > 0)
+			open_regions = true;
+		else
+			bits |= priv->parent->config->regions[i].bit;
+	}
+
+	/* Setting a bit to 1 disables the region, so let's just OR with the
+	 * above to disable any.
+	 */
+
+	/* Note, if another user is trying to ioctl, they can't grab tracking,
+	 * and therefore can't grab either register mutex.
+	 * If another user is trying to close, they can't grab tracking either.
+	 */
+	mutex_lock(&priv->parent->lo_mutex);
+	value = aspeed_p2a_read(priv->parent->loregs);
+	value |= bits;
+	aspeed_p2a_write(priv->parent->loregs, value);
+	mutex_unlock(&priv->parent->lo_mutex);
+
+	/* If parent->readers is zero and open windows is 0, disable the
+	 * bridge.
+	 */
+	if (!open_regions && priv->parent->readers == 0)
+		aspeed_p2a_disable_bridge(priv->parent);
+
+	mutex_unlock(&priv->parent->tracking);
+
+	kfree(priv);
+
+	return 0;
+}
+
+static const struct file_operations aspeed_p2a_ctrl_fops = {
+	.owner = THIS_MODULE,
+	.mmap = aspeed_p2a_mmap,
+	.unlocked_ioctl = aspeed_p2a_ioctl,
+	.open = aspeed_p2a_open,
+	.release = aspeed_p2a_release,
+};
+
+/** The regions are controlled by SCU2C */
+static void aspeed_p2a_disable_all(struct aspeed_p2a_ctrl *p2a_ctrl)
+{
+	int i;
+	u32 value = 0;
+	u32 curr_value;
+
+	for (i = 0; i < P2A_REGION_COUNT; i++)
+		value |= p2a_ctrl->config->regions[i].bit;
+
+	mutex_lock(&p2a_ctrl->lo_mutex);
+	curr_value = aspeed_p2a_read(p2a_ctrl->loregs);
+	curr_value |= value;
+	aspeed_p2a_write(p2a_ctrl->loregs, curr_value);
+	mutex_unlock(&p2a_ctrl->lo_mutex);
+
+	/* Disable the bridge. */
+	aspeed_p2a_disable_bridge(p2a_ctrl);
+}
+
+static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
+{
+	struct aspeed_p2a_ctrl *p2a_ctrl;
+	struct device *dev;
+	struct resource *res, resm;
+	struct device_node *node;
+	int rc = 0;
+	u32 twosee, oneeighty;
+
+	dev = &pdev->dev;
+
+	p2a_ctrl = devm_kzalloc(dev, sizeof(*p2a_ctrl), GFP_KERNEL);
+	if (!p2a_ctrl)
+		return -ENOMEM;
+
+	mutex_init(&p2a_ctrl->tracking);
+	p2a_ctrl->readers = 0;
+	memset(p2a_ctrl->readerwriters, 0, sizeof(p2a_ctrl->readerwriters));
+
+	p2a_ctrl->mem_size = 0;
+	p2a_ctrl->mem_base = 0;
+	p2a_ctrl->region_specified = false;
+
+	/* optional. */
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (node) {
+		rc = of_address_to_resource(node, 0, &resm);
+		of_node_put(node);
+		if (rc) {
+			dev_err(dev, "Couldn't address to resource for reserved memory\n");
+			return -ENOMEM;
+		}
+
+		p2a_ctrl->mem_size = resource_size(&resm);
+		p2a_ctrl->mem_base = resm.start;
+		p2a_ctrl->region_specified = true;
+	}
+
+	p2a_ctrl->config = of_device_get_match_data(dev);
+
+	/* This is the SCU2C handle. */
+	mutex_init(&p2a_ctrl->lo_mutex);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	p2a_ctrl->loregs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(p2a_ctrl->loregs)) {
+		dev_err(dev, "Unable to remap resource 0\n");
+		return PTR_ERR(p2a_ctrl->loregs);
+	}
+
+	twosee = aspeed_p2a_read(p2a_ctrl->loregs);
+
+	/* This is the SCU180 handle. */
+	mutex_init(&p2a_ctrl->hi_mutex);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	p2a_ctrl->hiregs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(p2a_ctrl->hiregs)) {
+		dev_err(dev, "Unable to remap resource 1\n");
+		return PTR_ERR(p2a_ctrl->hiregs);
+	}
+
+	oneeighty = aspeed_p2a_read(p2a_ctrl->hiregs);
+
+	dev_set_drvdata(&pdev->dev, p2a_ctrl);
+
+	p2a_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
+	p2a_ctrl->miscdev.name = DEVICE_NAME;
+	p2a_ctrl->miscdev.fops = &aspeed_p2a_ctrl_fops;
+	p2a_ctrl->miscdev.parent = dev;
+	rc = misc_register(&p2a_ctrl->miscdev);
+	if (rc) {
+		dev_err(dev, "Unable to register device\n");
+		goto err;
+	}
+
+	aspeed_p2a_disable_all(p2a_ctrl);
+
+err:
+	return rc;
+}
+
+static int aspeed_p2a_ctrl_remove(struct platform_device *pdev)
+{
+	struct aspeed_p2a_ctrl *p2a_ctrl = dev_get_drvdata(&pdev->dev);
+
+	misc_deregister(&p2a_ctrl->miscdev);
+
+	return 0;
+}
+
+/*
+ * bit | SCU2C | ast2400
+ *  25 | DRAM  | 0x40000000 - 0x5FFFFFFF
+ *  24 | SPI   | 0x30000000 - 0x3FFFFFFF
+ *  23 | SOC   | 0x18000000 - 0x1FFFFFFF, 0x60000000 - 0xFFFFFFFF
+ *  22 | FLASH | 0x00000000 - 0x17FFFFFF, 0x20000000 - 0x2FFFFFFF
+ *
+ * bit | SCU2C | ast2500
+ *  25 | DRAM  | 0x80000000 - 0xFFFFFFFF
+ *  24 | SPI   | 0x60000000 - 0x7FFFFFFF
+ *  23 | SOC   | 0x10000000 - 0x1FFFFFFF, 0x40000000 - 0x5FFFFFFF
+ *  22 | FLASH | 0x00000000 - 0x0FFFFFFF, 0x20000000 - 0x3FFFFFFF
+ */
+
+#define SCU2C_DRAM	BIT(25)
+#define SCU2C_SPI	BIT(24)
+#define SCU2C_SOC	BIT(23)
+#define SCU2C_FLASH	BIT(22)
+
+static const struct aspeed_p2a_model_data ast2400_model_data = {
+	.regions = {
+		{0x00000000, 0x17FFFFFF, SCU2C_FLASH},
+		{0x18000000, 0x1FFFFFFF, SCU2C_SOC},
+		{0x20000000, 0x2FFFFFFF, SCU2C_FLASH},
+		{0x30000000, 0x3FFFFFFF, SCU2C_SPI},
+		{0x40000000, 0x5FFFFFFF, SCU2C_DRAM},
+		{0x60000000, 0xFFFFFFFF, SCU2C_SOC},
+	}
+};
+
+static const struct aspeed_p2a_model_data ast2500_model_data = {
+	.regions = {
+		{0x00000000, 0x0FFFFFFF, SCU2C_FLASH},
+		{0x10000000, 0x1FFFFFFF, SCU2C_SOC},
+		{0x20000000, 0x3FFFFFFF, SCU2C_FLASH},
+		{0x40000000, 0x5FFFFFFF, SCU2C_SOC},
+		{0x60000000, 0x7FFFFFFF, SCU2C_SPI},
+		{0x80000000, 0xFFFFFFFF, SCU2C_DRAM},
+	}
+};
+
+static const struct of_device_id aspeed_p2a_ctrl_match[] = {
+	{ .compatible = "aspeed,ast2400-p2a-ctrl",
+	  .data = &ast2400_model_data },
+	{ .compatible = "aspeed,ast2500-p2a-ctrl",
+	  .data = &ast2500_model_data },
+	{ },
+};
+
+static struct platform_driver aspeed_p2a_ctrl_driver = {
+	.driver = {
+		.name		= DEVICE_NAME,
+		.of_match_table = aspeed_p2a_ctrl_match,
+	},
+	.probe = aspeed_p2a_ctrl_probe,
+	.remove = aspeed_p2a_ctrl_remove,
+};
+
+module_platform_driver(aspeed_p2a_ctrl_driver);
+
+MODULE_DEVICE_TABLE(of, aspeed_p2a_ctrl_match);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Patrick Venture <venture@google.com>");
+MODULE_DESCRIPTION("Control for aspeed 2400/2500 P2A VGA HOST to BMC mappings");
diff --git a/include/uapi/linux/aspeed-p2a-ctrl.h b/include/uapi/linux/aspeed-p2a-ctrl.h
new file mode 100644
index 000000000000..473b62efb94c
--- /dev/null
+++ b/include/uapi/linux/aspeed-p2a-ctrl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Copyright 2019 Google Inc
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Provides a simple driver to control the ASPEED P2A interface which allows
+ * the host to read and write to various regions of the BMC's memory.
+ */
+
+#ifndef _UAPI_LINUX_ASPEED_P2A_CTRL_H
+#define _UAPI_LINUX_ASPEED_P2A_CTRL_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define ASPEED_P2A_CTRL_READ_ONLY 0
+#define ASPEED_P2A_CTRL_READWRITE 1
+
+/*
+ * This driver provides a mechanism for enabling or disabling the read-write
+ * property of specific windows into the ASPEED BMC's memory.
+ *
+ * A user can map a region of the BMC's memory as read-only or read-write, with
+ * the caveat that once any region is mapped, all regions are unlocked for
+ * reading.
+ */
+
+/**
+ * Unlock a region of BMC physical memory for access from the host.
+ */
+struct aspeed_p2a_ctrl_mapping {
+	__u32 addr;
+	__u32 length;
+	__u32 flags;
+};
+
+#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
+
+#define ASPEED_P2A_CTRL_IOCTL_SET_WINDOW _IOW(__ASPEED_P2A_CTRL_IOCTL_MAGIC, \
+		0x00, struct aspeed_p2a_ctrl_mapping)
+
+#endif /* _UAPI_LINUX_ASPEED_P2A_CTRL_H */
-- 
2.21.0.rc0.258.g878e2cd30e-goog

