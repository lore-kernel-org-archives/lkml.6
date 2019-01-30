Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6352C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A620881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na9Ojj0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfA3XD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:03:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33257 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA3XDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:03:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id p7so1310435wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PYnXMLVmwxkZCLSmRp9VLe1B9hoxSbKa+o67/4TAdSk=;
        b=Na9Ojj0iW8HhpXlu7ZTV2lzv4GSLnUhUeU3qoJDjq2dCPz1lggL/emSykgEAP5WI+4
         h3goUUZ6roDJICoPr1LjAalcIyH0sdiYh1qqExn07swBwFjcXunQx+mt+ck6ElQbZm3x
         /youoL4zMzk/QZF+s4hEA7IKvuVw/m8SRG0n6Wl8rBNa3fp1+AV0gKCbZi/IOzLTGnS9
         S6N9LTFZDCu0a5+9t4UEMu0BvXkGlMJ+rn5R1QUOAriH0FOZ488kxs4AwQlbiEK5lQjj
         EeZvBnQRf+Ps2r46lIeuN8PoaufXuo2tQZPrLrxt27/Q9qII3HSjt5iD0WlsSQfIDvGu
         VKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PYnXMLVmwxkZCLSmRp9VLe1B9hoxSbKa+o67/4TAdSk=;
        b=oQkrJimBygcG5qi2mvJLmFdnm7fiDaOHZSginwQnYz+Tff+bvFD+ilqlI0EMFHPbVT
         RldjlxU1bJpc5wUJt/KGWSdjpYLWYPfYkkme8Vu5UX3n2QmXu4dzs92DnI4bJqBsIktr
         3052bNpBCxKq5lj2YOVkhIY0rNxbkKtyfVSNP60WyxMg6NSYqhCQUmufn7Hc1cuhod8W
         y5BMD8/bL1+auprz55L6Wl4YXfSEO0ZzZQANmwWSY033zjNeH1e9syqJ6VP5A/DhZdN9
         Yzec31c2nY10FEWUEPpHtCIPDt41W7ui2lhXJ8A0t2PikCF8F6eTAFCAQ0zmmIc81Iyd
         Pm0A==
X-Gm-Message-State: AHQUAuYPHjFGxUi+C/ebFGmGSyIN804/3I7G40Sc6pLsg+Jr+SITucqz
        Ps6y8B/ONjF7e6PEceMqQY9EplNI
X-Google-Smtp-Source: AHgI3IasrWfiBeWGAkZWhWhJUDAilk1JEEFEXgRAocQi99MDR5Dbb27OXhk6HgL7GpKsGi27k13dnw==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr11299877wrp.92.1548885983494;
        Wed, 30 Jan 2019 14:06:23 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:06:22 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 01/15] habanalabs: add skeleton driver
Date:   Thu, 31 Jan 2019 00:06:03 +0200
Message-Id: <20190130220617.4862-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the habanalabs skeleton driver. The driver does nothing at
this stage except very basic operations. It contains the minimal code to
insmod and rmmod the driver and to create a /dev/hlX file per PCI device.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Add newline in Makefile
  - Use kasprintf to allocate device file name
  - Define pr_fmt
  - Use strlcpy instead of sprintf
  - Don't use camelcase
  - Add static keyword to pci_device_id array definition
  - Remove print on memory allocation failure
  - Change /** to /* in all functions
  - Don't use three exclamation marks
  - Remove extra spaces in habanalabs.h
  - Change get_asic_type() to return asic type instead of doing it by
    reference
  - Check return value of idr_replace
  - Remove habanalabs_device_if.h from this patch as it is not needed here
  - Remove Author: from comment at head of files
 
 drivers/misc/Kconfig                     |   1 +
 drivers/misc/Makefile                    |   1 +
 drivers/misc/habanalabs/Kconfig          |  22 ++
 drivers/misc/habanalabs/Makefile         |   7 +
 drivers/misc/habanalabs/device.c         | 336 +++++++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h     | 138 +++++++++
 drivers/misc/habanalabs/habanalabs_drv.c | 362 +++++++++++++++++++++++
 7 files changed, 867 insertions(+)
 create mode 100644 drivers/misc/habanalabs/Kconfig
 create mode 100644 drivers/misc/habanalabs/Makefile
 create mode 100644 drivers/misc/habanalabs/device.c
 create mode 100644 drivers/misc/habanalabs/habanalabs.h
 create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f417b06e11c5..fecab53c4f21 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -535,4 +535,5 @@ source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
+source "drivers/misc/habanalabs/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e39ccbbc1b3a..ae77dfd790a4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
+obj-$(CONFIG_HABANA_AI)		+= habanalabs/
diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kconfig
new file mode 100644
index 000000000000..b7f38a14caf5
--- /dev/null
+++ b/drivers/misc/habanalabs/Kconfig
@@ -0,0 +1,22 @@
+#
+# HabanaLabs AI accelerators driver
+#
+
+config HABANA_AI
+	tristate "HabanaAI accelerators (habanalabs)"
+	depends on PCI
+	select FRAME_VECTOR
+	help
+	  Enables PCIe card driver for Habana's AI Processors (AIP) that are
+	  designed to accelerate Deep Learning inference and training workloads.
+
+	  The driver manages the PCIe devices and provides IOCTL interface for
+	  the user to submit workloads to the devices.
+
+	  The user-space interface is described in
+	  include/uapi/misc/habanalabs.h
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called habanalabs.
diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
new file mode 100644
index 000000000000..0910f7fa34ec
--- /dev/null
+++ b/drivers/misc/habanalabs/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for HabanaLabs AI accelerators driver
+#
+
+obj-m	:= habanalabs.o
+
+habanalabs-y := habanalabs_drv.o device.o
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
new file mode 100644
index 000000000000..3797a4281974
--- /dev/null
+++ b/drivers/misc/habanalabs/device.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/fs.h>
+#include <linux/kthread.h>
+#include <linux/sched/signal.h>
+
+static void hpriv_release(struct kref *ref)
+{
+	struct hl_fpriv *hpriv;
+	struct hl_device *hdev;
+
+	hpriv = container_of(ref, struct hl_fpriv, refcount);
+
+	hdev = hpriv->hdev;
+
+	put_pid(hpriv->taskpid);
+
+	kfree(hpriv);
+}
+
+void hl_hpriv_get(struct hl_fpriv *hpriv)
+{
+	kref_get(&hpriv->refcount);
+}
+
+void hl_hpriv_put(struct hl_fpriv *hpriv)
+{
+	kref_put(&hpriv->refcount, hpriv_release);
+}
+
+/*
+ * hl_device_release - release function for habanalabs device
+ *
+ * @inode: pointer to inode structure
+ * @filp: pointer to file structure
+ *
+ * Called when process closes an habanalabs device
+ */
+static int hl_device_release(struct inode *inode, struct file *filp)
+{
+	struct hl_fpriv *hpriv = filp->private_data;
+
+	filp->private_data = NULL;
+
+	hl_hpriv_put(hpriv);
+
+	return 0;
+}
+
+static const struct file_operations hl_ops = {
+	.owner = THIS_MODULE,
+	.open = hl_device_open,
+	.release = hl_device_release
+};
+
+/*
+ * device_setup_cdev - setup cdev and device for habanalabs device
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @hclass: pointer to the class object of the device
+ * @minor: minor number of the specific device
+ * @fpos : file operations to install for this device
+ *
+ * Create a cdev and a Linux device for habanalabs's device. Need to be
+ * called at the end of the habanalabs device initialization process,
+ * because this function exposes the device to the user
+ */
+static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
+				int minor, const struct file_operations *fops)
+{
+	int err, devno = MKDEV(hdev->major, minor);
+	struct cdev *hdev_cdev = &hdev->cdev;
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "hl%d", hdev->id);
+	if (!name)
+		return -ENOMEM;
+
+	cdev_init(hdev_cdev, fops);
+	hdev_cdev->owner = THIS_MODULE;
+	err = cdev_add(hdev_cdev, devno, 1);
+	if (err) {
+		pr_err("Failed to add char device %s\n", name);
+		goto err_cdev_add;
+	}
+
+	hdev->dev = device_create(hclass, NULL, devno, NULL, "%s", name);
+	if (IS_ERR(hdev->dev)) {
+		pr_err("Failed to create device %s\n", name);
+		err = PTR_ERR(hdev->dev);
+		goto err_device_create;
+	}
+
+	dev_set_drvdata(hdev->dev, hdev);
+
+	kfree(name);
+
+	return 0;
+
+err_device_create:
+	cdev_del(hdev_cdev);
+err_cdev_add:
+	kfree(name);
+	return err;
+}
+
+/*
+ * device_early_init - do some early initialization for the habanalabs device
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Install the relevant function pointers and call the early_init function,
+ * if such a function exists
+ */
+static int device_early_init(struct hl_device *hdev)
+{
+	switch (hdev->asic_type) {
+	case ASIC_GOYA:
+		strlcpy(hdev->asic_name, "GOYA", sizeof(hdev->asic_name));
+		break;
+	default:
+		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
+			hdev->asic_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * device_early_fini - finalize all that was done in device_early_init
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ */
+static void device_early_fini(struct hl_device *hdev)
+{
+}
+
+/*
+ * hl_device_suspend - initiate device suspend
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Puts the hw in the suspend state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver suspend.
+ */
+int hl_device_suspend(struct hl_device *hdev)
+{
+	pci_save_state(hdev->pdev);
+
+	/* Shut down the device */
+	pci_disable_device(hdev->pdev);
+	pci_set_power_state(hdev->pdev, PCI_D3hot);
+
+	return 0;
+}
+
+/*
+ * hl_device_resume - initiate device resume
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Bring the hw back to operating state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver resume.
+ */
+int hl_device_resume(struct hl_device *hdev)
+{
+	int rc;
+
+	pci_set_power_state(hdev->pdev, PCI_D0);
+	pci_restore_state(hdev->pdev);
+	rc = pci_enable_device(hdev->pdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to enable PCI device in resume\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * hl_device_init - main initialization function for habanalabs device
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Allocate an id for the device, do early initialization and then call the
+ * ASIC specific initialization functions. Finally, create the cdev and the
+ * Linux device to expose it to the user
+ */
+int hl_device_init(struct hl_device *hdev, struct class *hclass)
+{
+	int rc;
+
+	/* Create device */
+	rc = device_setup_cdev(hdev, hclass, hdev->id, &hl_ops);
+
+	if (rc)
+		goto out_disabled;
+
+	/* Initialize ASIC function pointers and perform early init */
+	rc = device_early_init(hdev);
+	if (rc)
+		goto release_device;
+
+	dev_notice(hdev->dev,
+		"Successfully added device to habanalabs driver\n");
+
+	return 0;
+
+release_device:
+	device_destroy(hclass, hdev->dev->devt);
+	cdev_del(&hdev->cdev);
+out_disabled:
+	hdev->disabled = true;
+	if (hdev->pdev)
+		dev_err(&hdev->pdev->dev,
+			"Failed to initialize hl%d. Device is NOT usable !\n",
+			hdev->id);
+	else
+		pr_err("Failed to initialize hl%d. Device is NOT usable !\n",
+			hdev->id);
+
+	return rc;
+}
+
+/*
+ * hl_device_fini - main tear-down function for habanalabs device
+ *
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Destroy the device, call ASIC fini functions and release the id
+ */
+void hl_device_fini(struct hl_device *hdev)
+{
+	dev_info(hdev->dev, "Removing device\n");
+
+	/* Mark device as disabled */
+	hdev->disabled = true;
+
+	device_early_fini(hdev);
+
+	/* Hide device from user */
+	device_destroy(hdev->dev->class, hdev->dev->devt);
+	cdev_del(&hdev->cdev);
+
+	pr_info("removed device successfully\n");
+}
+
+/*
+ * hl_poll_timeout_memory - Periodically poll a host memory address
+ *                              until it is not zero or a timeout occurs
+ * @hdev: pointer to habanalabs device structure
+ * @addr: Address to poll
+ * @timeout_us: timeout in us
+ * @val: Variable to read the value into
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ *
+ * The function sleeps for 100us with timeout value of
+ * timeout_us
+ */
+int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr,
+				u32 timeout_us, u32 *val)
+{
+	/*
+	 * paddr is defined as volatile because it points to HOST memory,
+	 * which is being written to by the device. Therefore, we can't use
+	 * locks to synchronize it and it is not a memory-mapped register space
+	 */
+	volatile u32 *paddr = (volatile u32 *) addr;
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
+
+	might_sleep();
+
+	for (;;) {
+		*val = *paddr;
+		if (*val)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			*val = *paddr;
+			break;
+		}
+		usleep_range((100 >> 2) + 1, 100);
+	}
+
+	return *val ? 0 : -ETIMEDOUT;
+}
+
+/*
+ * hl_poll_timeout_devicememory - Periodically poll a device memory address
+ *                                until it is not zero or a timeout occurs
+ * @hdev: pointer to habanalabs device structure
+ * @addr: Device address to poll
+ * @timeout_us: timeout in us
+ * @val: Variable to read the value into
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ *
+ * The function sleeps for 100us with timeout value of
+ * timeout_us
+ */
+int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
+				u32 timeout_us, u32 *val)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
+
+	might_sleep();
+
+	for (;;) {
+		*val = readl(addr);
+		if (*val)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			*val = readl(addr);
+			break;
+		}
+		usleep_range((100 >> 2) + 1, 100);
+	}
+
+	return *val ? 0 : -ETIMEDOUT;
+}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
new file mode 100644
index 000000000000..02386dcaa3a3
--- /dev/null
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef HABANALABSP_H_
+#define HABANALABSP_H_
+
+#define pr_fmt(fmt)			"habanalabs: " fmt
+
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/dma-fence.h>
+#include <linux/hashtable.h>
+#include <linux/hwmon.h>
+
+#define HL_NAME				"habanalabs"
+
+struct hl_device;
+
+
+/*
+ * ASICs
+ */
+
+/**
+ * enum hl_asic_type - supported ASIC types.
+ * @ASIC_AUTO_DETECT: ASIC type will be automatically set.
+ * @ASIC_GOYA: Goya device.
+ * @ASIC_INVALID: Invalid ASIC type.
+ */
+enum hl_asic_type {
+	ASIC_AUTO_DETECT,
+	ASIC_GOYA,
+	ASIC_INVALID
+};
+
+
+/*
+ * FILE PRIVATE STRUCTURE
+ */
+
+/**
+ * struct hl_fpriv - process information stored in FD private data.
+ * @hdev: habanalabs device structure.
+ * @filp: pointer to the given file structure.
+ * @taskpid: current process ID.
+ * @refcount: number of related contexts.
+ */
+struct hl_fpriv {
+	struct hl_device	*hdev;
+	struct file		*filp;
+	struct pid		*taskpid;
+	struct kref		refcount;
+};
+
+
+/*
+ * DEVICES
+ */
+
+/* Theoretical limit only. A single host can only contain up to 4 or 8 PCIe
+ * x16 cards. In extereme cases, there are hosts that can accommodate 16 cards
+ */
+#define HL_MAX_MINORS	256
+
+/**
+ * struct hl_device - habanalabs device structure.
+ * @pdev: pointer to PCI device, can be NULL in case of simulator device.
+ * @cdev: related char device.
+ * @dev: realted kernel basic device structure.
+ * @asic_name: ASIC specific nmae.
+ * @asic_type: ASIC specific type.
+ * @major: habanalabs KMD major.
+ * @id: device minor.
+ * @disabled: is device disabled.
+ */
+struct hl_device {
+	struct pci_dev			*pdev;
+	struct cdev			cdev;
+	struct device			*dev;
+	char				asic_name[16];
+	enum hl_asic_type		asic_type;
+	u32				major;
+	u16				id;
+	u8				disabled;
+};
+
+
+/*
+ * IOCTLs
+ */
+
+/**
+ * typedef hl_ioctl_t - typedef for ioctl function in the driver
+ * @hpriv: pointer to the FD's private data, which contains state of
+ *		user process
+ * @data: pointer to the input/output arguments structure of the IOCTL
+ *
+ * Return: 0 for success, negative value for error
+ */
+typedef int hl_ioctl_t(struct hl_fpriv *hpriv, void *data);
+
+/**
+ * struct hl_ioctl_desc - describes an IOCTL entry of the driver.
+ * @cmd: the IOCTL code as created by the kernel macros.
+ * @func: pointer to the driver's function that should be called for this IOCTL.
+ */
+struct hl_ioctl_desc {
+	unsigned int cmd;
+	hl_ioctl_t *func;
+};
+
+
+/*
+ * Kernel module functions that can be accessed by entire module
+ */
+
+int hl_device_open(struct inode *inode, struct file *filp);
+int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
+		enum hl_asic_type asic_type, int minor);
+void destroy_hdev(struct hl_device *hdev);
+int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr, u32 timeout_us,
+				u32 *val);
+int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
+				u32 timeout_us, u32 *val);
+
+int hl_device_init(struct hl_device *hdev, struct class *hclass);
+void hl_device_fini(struct hl_device *hdev);
+int hl_device_suspend(struct hl_device *hdev);
+int hl_device_resume(struct hl_device *hdev);
+
+#endif /* HABANALABSP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
new file mode 100644
index 000000000000..573349eedce4
--- /dev/null
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#include "habanalabs.h"
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+
+#include <linux/fs.h>
+
+#define HL_DRIVER_AUTHOR	"HabanaLabs Kernel Driver Team"
+
+#define HL_DRIVER_DESC		"Driver for HabanaLabs's AI Accelerators"
+
+MODULE_AUTHOR(HL_DRIVER_AUTHOR);
+MODULE_DESCRIPTION(HL_DRIVER_DESC);
+MODULE_LICENSE("GPL v2");
+
+static int hl_major;
+static struct class *hl_class;
+DEFINE_IDR(hl_devs_idr);
+DEFINE_MUTEX(hl_devs_idr_lock);
+
+#define PCI_VENDOR_ID_HABANALABS	0x1da3
+
+#define PCI_IDS_GOYA			0x0001
+
+static const struct pci_device_id ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, ids);
+
+/*
+ * get_asic_type - translate device id to asic type
+ *
+ * @device: id of the PCI device
+ *
+ * Translate device id to asic type.
+ * In case of unidentified device, return -1
+ */
+static enum hl_asic_type get_asic_type(u16 device)
+{
+	enum hl_asic_type asic_type;
+
+	switch (device) {
+	case PCI_IDS_GOYA:
+		asic_type = ASIC_GOYA;
+		break;
+	default:
+		asic_type = ASIC_INVALID;
+		break;
+	}
+
+	return asic_type;
+}
+
+/*
+ * hl_device_open - open function for habanalabs device
+ *
+ * @inode: pointer to inode structure
+ * @filp: pointer to file structure
+ *
+ * Called when process opens an habanalabs device.
+ */
+int hl_device_open(struct inode *inode, struct file *filp)
+{
+	struct hl_device *hdev;
+	struct hl_fpriv *hpriv;
+
+	mutex_lock(&hl_devs_idr_lock);
+	hdev = idr_find(&hl_devs_idr, iminor(inode));
+	mutex_unlock(&hl_devs_idr_lock);
+
+	if (!hdev) {
+		pr_err("Couldn't find device %d:%d\n",
+			imajor(inode), iminor(inode));
+		return -ENXIO;
+	}
+
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
+	hpriv->hdev = hdev;
+	filp->private_data = hpriv;
+	hpriv->filp = filp;
+	kref_init(&hpriv->refcount);
+	nonseekable_open(inode, filp);
+
+	hpriv->taskpid = find_get_pid(current->pid);
+
+	return 0;
+}
+
+/*
+ * create_hdev - create habanalabs device instance
+ *
+ * @dev: will hold the pointer to the new habanalabs device structure
+ * @pdev: pointer to the pci device
+ * @asic_type: in case of simulator device, which device is it
+ * @minor: in case of simulator device, the minor of the device
+ *
+ * Allocate memory for habanalabs device and initialize basic fields
+ * Identify the ASIC type
+ * Allocate ID (minor) for the device (only for real devices)
+ */
+int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
+		enum hl_asic_type asic_type, int minor)
+{
+	struct hl_device *hdev;
+	int rc;
+
+	*dev = NULL;
+
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	hdev->major = hl_major;
+
+	hdev->disabled = true;
+	hdev->pdev = pdev; /* can be NULL in case of simulator device */
+
+	if (asic_type == ASIC_AUTO_DETECT) {
+		hdev->asic_type = get_asic_type(pdev->device);
+		if (hdev->asic_type == ASIC_INVALID) {
+			dev_err(&pdev->dev, "Unsupported ASIC\n");
+			rc = -ENODEV;
+			goto free_hdev;
+		}
+	} else {
+		hdev->asic_type = asic_type;
+	}
+
+	mutex_lock(&hl_devs_idr_lock);
+
+	if (minor == -1) {
+		rc = idr_alloc(&hl_devs_idr, hdev, 0, HL_MAX_MINORS,
+				GFP_KERNEL);
+	} else {
+		void *old_idr = idr_replace(&hl_devs_idr, hdev, minor);
+
+		if (IS_ERR_VALUE(old_idr)) {
+			rc = PTR_ERR(old_idr);
+			pr_err("Error %d when trying to replace minor %d\n",
+				rc, minor);
+			mutex_unlock(&hl_devs_idr_lock);
+			goto free_hdev;
+		}
+		rc = minor;
+	}
+
+	mutex_unlock(&hl_devs_idr_lock);
+
+	if (rc < 0) {
+		if (rc == -ENOSPC) {
+			pr_err("too many devices in the system\n");
+			rc = -EBUSY;
+		}
+		goto free_hdev;
+	}
+
+	hdev->id = rc;
+
+	*dev = hdev;
+
+	return 0;
+
+free_hdev:
+	kfree(hdev);
+	return rc;
+}
+
+/*
+ * destroy_hdev - destroy habanalabs device instance
+ *
+ * @dev: pointer to the habanalabs device structure
+ *
+ */
+void destroy_hdev(struct hl_device *hdev)
+{
+	/* Remove device from the device list */
+	mutex_lock(&hl_devs_idr_lock);
+	idr_remove(&hl_devs_idr, hdev->id);
+	mutex_unlock(&hl_devs_idr_lock);
+
+	kfree(hdev);
+}
+
+static int hl_pmops_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct hl_device *hdev = pci_get_drvdata(pdev);
+
+	pr_debug("Going to suspend PCI device\n");
+
+	if (!hdev) {
+		pr_err("device pointer is NULL in suspend\n");
+		return 0;
+	}
+
+	return hl_device_suspend(hdev);
+}
+
+static int hl_pmops_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct hl_device *hdev = pci_get_drvdata(pdev);
+
+	pr_debug("Going to resume PCI device\n");
+
+	if (!hdev) {
+		pr_err("device pointer is NULL in resume\n");
+		return 0;
+	}
+
+	return hl_device_resume(hdev);
+}
+
+/*
+ * hl_pci_probe - probe PCI habanalabs devices
+ *
+ * @pdev: pointer to pci device
+ * @id: pointer to pci device id structure
+ *
+ * Standard PCI probe function for habanalabs device.
+ * Create a new habanalabs device and initialize it according to the
+ * device's type
+ */
+static int hl_pci_probe(struct pci_dev *pdev,
+				const struct pci_device_id *id)
+{
+	struct hl_device *hdev;
+	int rc;
+
+	dev_info(&pdev->dev, HL_NAME
+		 " device found [%04x:%04x] (rev %x)\n",
+		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
+
+	rc = create_hdev(&hdev, pdev, ASIC_AUTO_DETECT, -1);
+	if (rc)
+		return rc;
+
+	pci_set_drvdata(pdev, hdev);
+
+	rc = hl_device_init(hdev, hl_class);
+	if (rc) {
+		dev_err(&pdev->dev, "Fatal error during habanalabs device init\n");
+		rc = -ENODEV;
+		goto disable_device;
+	}
+
+	return 0;
+
+disable_device:
+	pci_set_drvdata(pdev, NULL);
+	destroy_hdev(hdev);
+
+	return rc;
+}
+
+/*
+ * hl_pci_remove - remove PCI habanalabs devices
+ *
+ * @pdev: pointer to pci device
+ *
+ * Standard PCI remove function for habanalabs device
+ */
+static void hl_pci_remove(struct pci_dev *pdev)
+{
+	struct hl_device *hdev;
+
+	hdev = pci_get_drvdata(pdev);
+	if (!hdev)
+		return;
+
+	hl_device_fini(hdev);
+	pci_set_drvdata(pdev, NULL);
+
+	destroy_hdev(hdev);
+}
+
+static const struct dev_pm_ops hl_pm_ops = {
+	.suspend = hl_pmops_suspend,
+	.resume = hl_pmops_resume,
+};
+
+static struct pci_driver hl_pci_driver = {
+	.name = HL_NAME,
+	.id_table = ids,
+	.probe = hl_pci_probe,
+	.remove = hl_pci_remove,
+	.driver.pm = &hl_pm_ops,
+};
+
+/*
+ * hl_init - Initialize the habanalabs kernel driver
+ */
+static int __init hl_init(void)
+{
+	int rc;
+	dev_t dev;
+
+	pr_info("loading driver\n");
+
+	rc = alloc_chrdev_region(&dev, 0, HL_MAX_MINORS, HL_NAME);
+	if (rc < 0) {
+		pr_err("unable to get major\n");
+		return rc;
+	}
+
+	hl_major = MAJOR(dev);
+
+	hl_class = class_create(THIS_MODULE, HL_NAME);
+	if (IS_ERR(hl_class)) {
+		pr_err("failed to allocate class\n");
+		rc = PTR_ERR(hl_class);
+		goto remove_major;
+	}
+
+	rc = pci_register_driver(&hl_pci_driver);
+	if (rc) {
+		pr_err("failed to register pci device\n");
+		goto remove_class;
+	}
+
+	pr_debug("driver loaded\n");
+
+	return 0;
+
+remove_class:
+	class_destroy(hl_class);
+remove_major:
+	unregister_chrdev_region(MKDEV(hl_major, 0), HL_MAX_MINORS);
+	return rc;
+}
+
+/*
+ * hl_exit - Release all resources of the habanalabs kernel driver
+ */
+static void __exit hl_exit(void)
+{
+	pci_unregister_driver(&hl_pci_driver);
+
+	class_destroy(hl_class);
+	unregister_chrdev_region(MKDEV(hl_major, 0), HL_MAX_MINORS);
+
+	idr_destroy(&hl_devs_idr);
+
+	pr_debug("driver removed\n");
+}
+
+module_init(hl_init);
+module_exit(hl_exit);
-- 
2.17.1

