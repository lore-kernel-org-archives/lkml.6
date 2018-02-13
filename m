Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514543-2-15118071721673665422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514543; b=iEAyL86R2U4PU3daJGc5ROm0fRDqp8BPFHmdT0hxVooyAXE
    viCNViA96hyX/eobBPG/i5Yi1a+1Nxs19ORBHXDnyhj6sLaes/WQspHLctIoutJB
    I9aJVZ316np3n8OeIiqf9/tL7r4uHnMX6VC/kAtPJqSAQXd8/8Zor6yCIbQP2BEV
    hdOOdnH/JQLOBfZS/ZfZsB6JNACUK9DRgB7B03Db9ZtfzLCO8xs3eeoyL9uLN67d
    lIwbsZY4/Yy6QhcDTUopSJh8noRSfhIK7e/a7PHoANiuDnynUcIDHUnXGHSo+LYD
    5D8OJ33TieZHAtC+LecPfilYLrOis1ZJyqNlCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514543;
    bh=BNKp5OBI55w1X/RuA/RsKhGlKBEWsAtaeL3eni4El7k=; b=lHYRQzwQUFJ/
    sj1CR8hsiXab7zxFiVJL+82gHIi9ZREug0WmvPazuQQFbSDIHKkW3/fMZDfRpJ16
    /4eB2xFls9e/2wq919jg3ZJUKTkBMkbCwQqEVy5yIevEgP4NNfLqI1DQuTyFg35i
    9IDEwZ7gguoZsv+6WgEOjajwH6KoGru/HUPJjsWkejUVZCAllLh4dmwj5ymAMV0J
    ciss2oBrYd95x7HB15abHyS6cREur6w8BC9+1knRj3e4eUxKcesJZHSBzwAKtNYe
    xrylJg1XFrblcH7UlrfQYBlhZfxLWS/WHfaoVOkZhEfMOhtrD0Bjd4x/GpZ5gJ7N
    RnfWt5HhZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbeBMJfh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:35:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:27121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934119AbeBMJfe (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889530"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v4 08/24] fpga: add FPGA DFL PCIe device driver
Date: Tue, 13 Feb 2018 17:24:37 +0800
Message-Id: <1518513893-4719-9-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Zhang Yi <yi.z.zhang@intel.com>

This patch implements the basic framework of the driver for FPGA PCIe
device which implements the Device Feature List (DFL) in its MMIO space.
This driver is verified on Intel(R) PCIe based FPGA DFL devices, including
both integrated (e.g Intel Server Platform with In-package FPGA) and
discrete (e.g Intel FPGA PCIe Acceleration Cards) solutions.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: move the code to drivers/fpga folder as suggested by Alan Tull.
    switch to GPLv2 license.
    fix comments from Moritz Fischer.
v3: switch to pci_set_dma_mask/consistent_dma_mask() function.
    remove pci_save_state() in probe function.
    rename driver to INTEL_FPGA_DFL_PCI and intel-dfl-pci.c to indicate
    this driver supports Intel FPGA PCI devices which implement DFL.
    improve Kconfig description for INTEL_FPGA_DFL_PCI
v4: rename to FPGA_DFL_PCI (dfl-pci.c) for better reuse.
    fix SPDX license issue.
---
 drivers/fpga/Kconfig   |  15 ++++++
 drivers/fpga/Makefile  |   3 ++
 drivers/fpga/dfl-pci.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/fpga/dfl-pci.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 01ad31f..87f3d44 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -140,4 +140,19 @@ config FPGA_DFL
 	  Gate Array (FPGA) solutions which implement Device Feature List.
 	  It provides enumeration APIs, and feature device infrastructure.
 
+config FPGA_DFL_PCI
+	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
+	depends on PCI && FPGA_DFL
+	help
+	  Select this option to enable PCIe driver for PCIe based
+	  Field-Programmable Gate Array (FPGA) solutions which implemented
+	  the Device Feature List (DFL). This driver provides interfaces
+	  for userspace applications to configure, enumerate, open and access
+	  FPGA accelerators on the FPGA DFL devices, enables system level
+	  management functions such as FPGA partial reconfiguration, power
+	  management, and virtualization with DFL framework and DFL feature
+	  device drivers.
+
+	  To compile this as a module, choose M here.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index c4c62b9..4375630 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -30,3 +30,6 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
 # FPGA Device Feature List Support
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
+
+# Drivers for FPGAs which implement DFL
+obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
new file mode 100644
index 0000000..d91ea42
--- /dev/null
+++ b/drivers/fpga/dfl-pci.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Device Feature List (DFL) PCIe device
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Zhang Yi <Yi.Z.Zhang@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/errno.h>
+#include <linux/aer.h>
+
+#define DRV_VERSION	"0.8"
+#define DRV_NAME	"dfl-pci"
+
+/* PCI Device ID */
+#define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
+#define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
+#define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
+/* VF Device */
+#define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
+#define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
+#define PCIE_DEVICE_ID_VF_DSC_1_X	0x09C5
+
+static struct pci_device_id cci_pcie_id_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_5_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_6_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_6_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
+
+static
+int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
+{
+	int ret;
+
+	ret = pci_enable_device(pcidev);
+	if (ret < 0) {
+		dev_err(&pcidev->dev, "Failed to enable device %d.\n", ret);
+		return ret;
+	}
+
+	ret = pci_enable_pcie_error_reporting(pcidev);
+	if (ret && ret != -EINVAL)
+		dev_info(&pcidev->dev, "PCIE AER unavailable %d.\n", ret);
+
+	ret = pci_request_regions(pcidev, DRV_NAME);
+	if (ret) {
+		dev_err(&pcidev->dev, "Failed to request regions.\n");
+		goto disable_error_report_exit;
+	}
+
+	pci_set_master(pcidev);
+
+	if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(64))) {
+		ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(64));
+		if (ret)
+			goto release_region_exit;
+	} else if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(32))) {
+		ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(32));
+		if (ret)
+			goto release_region_exit;
+	} else {
+		ret = -EIO;
+		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
+		goto release_region_exit;
+	}
+
+	/* TODO: create and add the platform device per feature list */
+	return 0;
+
+release_region_exit:
+	pci_release_regions(pcidev);
+disable_error_report_exit:
+	pci_disable_pcie_error_reporting(pcidev);
+	pci_disable_device(pcidev);
+	return ret;
+}
+
+static void cci_pci_remove(struct pci_dev *pcidev)
+{
+	pci_release_regions(pcidev);
+	pci_disable_pcie_error_reporting(pcidev);
+	pci_disable_device(pcidev);
+}
+
+static struct pci_driver cci_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = cci_pcie_id_tbl,
+	.probe = cci_pci_probe,
+	.remove = cci_pci_remove,
+};
+
+static int __init ccidrv_init(void)
+{
+	pr_info("FPGA DFL PCIe Driver: Version %s\n", DRV_VERSION);
+
+	return pci_register_driver(&cci_pci_driver);
+}
+
+static void __exit ccidrv_exit(void)
+{
+	pci_unregister_driver(&cci_pci_driver);
+}
+
+module_init(ccidrv_init);
+module_exit(ccidrv_exit);
+
+MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

