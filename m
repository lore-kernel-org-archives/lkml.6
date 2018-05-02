Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230415-2-3555018656578706363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230414; b=FT934oDEt9CRsaJCvr1J9wIV/o8dcxB9I6n0ZW9mlpZHs/n3I4
    LVC34sb8a/cfHiITcuGCxHJ4RrD9bMTMqgRZMkOS+wIJ49LW4tJYum3AfyyQAqcU
    UPxUDaAtmVIZJuvMUHBQq8Xm3ue43VhvdwcsrPS1YPYdCOqemaeV/pHyKOvWpnA5
    OMpmehg6RgFXk8xGmoJAwUL5KkE3VolTt8SfRm8B1BNss3GDKqkhIoPwG14hWH71
    1fah/gnLRUf29rWjCUMmxCXBkCTI0BjE1DKzS9PJ7tPuXvNZjDUpbdamQOSx+dGA
    mIlhD1wHLZpcp9IHN4GzCbQDE0SPsMOmtsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230414; bh=
    fzVmxnLKp940w6Zj8wognNpDLHqhCwJQMrP7uV1ZqTU=; b=CtqYR322MnYl46t1
    0e1tvs5Rp1zTlzXEIukZnjVJqSlVyVLfYDWtusyF4ukAQNfgpoJS+2byVAJ0oeDL
    lEA5Oo3/4BuQBV7whkwEnvvZvAu/2baNccU4aE3WMUoyxy0pNMcVqLE4WGWK5OWB
    tcZXZLttGdL1zfVPo26FxQ2ksWnbBJK4M16czze1w/xKx4Sv4AhSSrgqIu+00epK
    bKPEmG7I0qbCiumeFAun9LoSc/rIrwUBiA54W0UMaiuN8karo3z/Xnc68WQhqI9D
    2bn1vor7MefmOGp95mVy8JmsaHa+dTjcab/d/vVKG5bGl77a+k36LkVmiCEWLFw0
    Vxg78Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMV4wVcpsdBMTGh15BZwRu2DusX7+5m5aNoespsZif3CpwI/bS03tk4d7SvHe7MZP4Q54H/aXSJfUSsifxNujvomlvHCUM5ylaSSqzWdgWbcEBAPjL//
    YfrKehf/wQCXwhu8EqnLzK5j9Ih1oEgypcKClSmv2UWcs9vXRlgXIQ2ZmF7hkvsz5JBfIhEZlo4NWqNO0KSnHqUCzsEElZRHXusSCVX0ANb7M1xnOLjTcV0b
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=ZGQVYahPIi7ew5MI3R0A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEBDCS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:63837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeEBDCN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058382"
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
Subject: [PATCH v5 12/28] fpga: add FPGA DFL PCIe device driver
Date: Wed,  2 May 2018 10:50:15 +0800
Message-Id: <1525229431-3087-13-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
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
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
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
v5: use module_pci_driver() instead.
    add Acked-by from Alan and Moritz.
---
 drivers/fpga/Kconfig   |  15 +++++++
 drivers/fpga/Makefile  |   3 ++
 drivers/fpga/dfl-pci.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 0000000..92e1779
--- /dev/null
+++ b/drivers/fpga/dfl-pci.c
@@ -0,0 +1,114 @@
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
+module_pci_driver(cci_pci_driver);
+
+MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

