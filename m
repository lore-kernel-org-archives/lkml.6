Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2826DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A084E20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmKVV5qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfA3XMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:12:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfA3XME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:12:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so1278781wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxi4iWWk5xVRlBPu7FwKZBrMq0qTRH8JKsz0xaahZ94=;
        b=PmKVV5qOFmRZVxK3qOCYKxo/hDB/oV1R0WCwhXuV6icHQ0Jf0jCur0vMAJk9kne5Dd
         yoFTIOjf8JdPUOYeN+uEuwZe8cgsBcdp6NKiDVD4XGprtVYbR46wUUMBcTUceqRMrXXF
         Z2frBNvFO9Sox66I2bRGgHi4+2JIvwv1MeUkbMRMdEKbh+KQ7HA+6bez7Ke/UaHU46id
         uh/1rS+UAmA2lnKginnJ+pW3jZZLfd3hwzzMI5uCihRd4hlUqb4eazQe1yLRFVFZQrBy
         H9KAC92dF+wR8Nig9QSNGK1iusK8ueSDl3APGw81iMKHWkhV4UTaK3J4IYKBFqpNoZUU
         YKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxi4iWWk5xVRlBPu7FwKZBrMq0qTRH8JKsz0xaahZ94=;
        b=PuGHjqKBDbkXk08iqoYSkA4C9CiA8rXaADr0C3zeMM4VGKU1cFTbw+sf9GenKKLL6Q
         3EQWW0/XlEnx87whtaYXGyHLorovXQRZT6ngR+Y0vgudTVrD9ZV7BBDL0grmRUNj0rVo
         mnCadDi9UdKqdn93HMSFsAj55S5xJJszR4/Oz0NrE7ZaDe8AssG7hEXGMNkunSfrcr3m
         Iy3KD/A9N+LukrGRNkkYtqZf+hNrC9eKvk7FV81NDhHTK5pYMq/qMUmm/9AM2soZwD/Q
         s9J36G+8gdDwQPrUUxHkWGKxK8Dq+SbVvs+ZhM9K3AWZ1BB/S6Deg82jiW8IPoDf+aIy
         glhw==
X-Gm-Message-State: AJcUukcry0h4d3VKP526JHfonx8B6pIqoH2MKLQpgegBOI3olIqhUleT
        syukp9kZ5uDVpn87R3GV+2Tt47ER
X-Google-Smtp-Source: ALg8bN52Dp1BD5hwSTyeISigyPegq13pdULVKV0RLnoaPCajtFtkOXgepGfwCSlldeMrpVAgT7bpoQ==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr31012699wrr.271.1548885990791;
        Wed, 30 Jan 2019 14:06:30 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:06:30 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 03/15] habanalabs: add basic Goya support
Date:   Thu, 31 Jan 2019 00:06:05 +0200
Message-Id: <20190130220617.4862-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a basic support for the Goya device. The code initializes
the device's PCI controller and PCI bars. It also initializes various S/W
structures and adds some basic helper functions.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Replace /** with /* in all functions
  - Add newline at end of goya makefile
  - Return -EIO instead of -1
  - Return -EIO instead of meaningless rc
  - Add comments on dma_alloc_coherent and dma_free_coherent
  - Add compile time check for DRAM reserved memory size
  - Remove Authors: from comment at head of files
  - Move S/W defines from goya.h to goyaP.h and uapi/misc/habanalabs.h
 
 drivers/misc/habanalabs/Makefile            |   4 +
 drivers/misc/habanalabs/device.c            |  71 +++
 drivers/misc/habanalabs/goya/Makefile       |   3 +
 drivers/misc/habanalabs/goya/goya.c         | 639 ++++++++++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h        | 155 +++++
 drivers/misc/habanalabs/habanalabs.h        | 137 +++++
 drivers/misc/habanalabs/habanalabs_drv.c    |   3 +
 drivers/misc/habanalabs/include/goya/goya.h |  41 ++
 include/uapi/misc/habanalabs.h              |  20 +
 9 files changed, 1073 insertions(+)
 create mode 100644 drivers/misc/habanalabs/goya/Makefile
 create mode 100644 drivers/misc/habanalabs/goya/goya.c
 create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
 create mode 100644 include/uapi/misc/habanalabs.h

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 0910f7fa34ec..64bad3ca21c6 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -5,3 +5,7 @@
 obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o
+
+include $(src)/goya/Makefile
+habanalabs-y += $(HL_GOYA_FILES)
+
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 3797a4281974..d77e070ae389 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -121,8 +121,11 @@ static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
  */
 static int device_early_init(struct hl_device *hdev)
 {
+	int rc;
+
 	switch (hdev->asic_type) {
 	case ASIC_GOYA:
+		goya_set_asic_funcs(hdev);
 		strlcpy(hdev->asic_name, "GOYA", sizeof(hdev->asic_name));
 		break;
 	default:
@@ -131,6 +134,10 @@ static int device_early_init(struct hl_device *hdev)
 		return -EINVAL;
 	}
 
+	rc = hdev->asic_funcs->early_init(hdev);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
@@ -142,6 +149,10 @@ static int device_early_init(struct hl_device *hdev)
  */
 static void device_early_fini(struct hl_device *hdev)
 {
+
+	if (hdev->asic_funcs->early_fini)
+		hdev->asic_funcs->early_fini(hdev);
+
 }
 
 /*
@@ -155,8 +166,15 @@ static void device_early_fini(struct hl_device *hdev)
  */
 int hl_device_suspend(struct hl_device *hdev)
 {
+	int rc;
+
 	pci_save_state(hdev->pdev);
 
+	rc = hdev->asic_funcs->suspend(hdev);
+	if (rc)
+		dev_err(hdev->dev,
+			"Failed to disable PCI access of device CPU\n");
+
 	/* Shut down the device */
 	pci_disable_device(hdev->pdev);
 	pci_set_power_state(hdev->pdev, PCI_D3hot);
@@ -186,6 +204,13 @@ int hl_device_resume(struct hl_device *hdev)
 		return rc;
 	}
 
+	rc = hdev->asic_funcs->resume(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to enable PCI access from device CPU\n");
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -213,11 +238,21 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto release_device;
 
+	/*
+	 * Start calling ASIC initialization. First S/W then H/W and finally
+	 * late init
+	 */
+	rc = hdev->asic_funcs->sw_init(hdev);
+	if (rc)
+		goto early_fini;
+
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
 	return 0;
 
+early_fini:
+	device_early_fini(hdev);
 release_device:
 	device_destroy(hclass, hdev->dev->devt);
 	cdev_del(&hdev->cdev);
@@ -248,6 +283,9 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
+	/* Call ASIC S/W finalize function */
+	hdev->asic_funcs->sw_fini(hdev);
+
 	device_early_fini(hdev);
 
 	/* Hide device from user */
@@ -334,3 +372,36 @@ int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
 
 	return *val ? 0 : -ETIMEDOUT;
 }
+
+/*
+ * MMIO register access helper functions.
+ */
+
+/*
+ * hl_rreg - Read an MMIO register
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @reg: MMIO register offset (in bytes)
+ *
+ * Returns the value of the MMIO register we are asked to read
+ *
+ */
+inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
+{
+	return readl(hdev->rmmio + reg);
+}
+
+/*
+ * hl_wreg - Write to an MMIO register
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @reg: MMIO register offset (in bytes)
+ * @val: 32-bit value
+ *
+ * Writes the 32-bit value into the MMIO register
+ *
+ */
+inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
+{
+	writel(val, hdev->rmmio + reg);
+}
diff --git a/drivers/misc/habanalabs/goya/Makefile b/drivers/misc/habanalabs/goya/Makefile
new file mode 100644
index 000000000000..38d43006386d
--- /dev/null
+++ b/drivers/misc/habanalabs/goya/Makefile
@@ -0,0 +1,3 @@
+subdir-ccflags-y += -I$(src)
+
+HL_GOYA_FILES :=  goya/goya.o
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
new file mode 100644
index 000000000000..47e7472b7472
--- /dev/null
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "goyaP.h"
+#include "include/goya/asic_reg/goya_masks.h"
+
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/vmalloc.h>
+#include <linux/sched.h>
+#include <linux/genalloc.h>
+#include <linux/sysfs.h>
+#include <linux/kfifo.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/log2.h>
+#include <linux/hwmon.h>
+#include <linux/string.h>
+#include <linux/io.h>
+
+/*
+ * GOYA security scheme:
+ *
+ * 1. Host is protected by:
+ *        - Range registers (When MMU is enabled, DMA RR does NOT protect host)
+ *        - MMU
+ *
+ * 2. DRAM is protected by:
+ *        - Range registers (protect the first 512MB)
+ *        - MMU (isolation between users)
+ *
+ * 3. Configuration is protected by:
+ *        - Range registers
+ *        - Protection bits
+ *
+ * When MMU is disabled:
+ *
+ * QMAN DMA: PQ, CQ, CP, DMA are secured.
+ * PQ, CB and the data are on the host.
+ *
+ * QMAN TPC/MME:
+ * PQ, CQ and CP are not secured.
+ * PQ, CB and the data are on the SRAM/DRAM.
+ *
+ * Since QMAN DMA is secured, KMD is parsing the DMA CB:
+ *     - KMD checks DMA pointer
+ *     - WREG, MSG_PROT are not allowed.
+ *     - MSG_LONG/SHORT are allowed.
+ *
+ * A read/write transaction by the QMAN to a protected area will succeed if
+ * and only if the QMAN's CP is secured and MSG_PROT is used
+ *
+ *
+ * When MMU is enabled:
+ *
+ * QMAN DMA: PQ, CQ and CP are secured.
+ * MMU is set to bypass on the Secure props register of the QMAN.
+ * The reasons we don't enable MMU for PQ, CQ and CP are:
+ *     - PQ entry is in kernel address space and KMD doesn't map it.
+ *     - CP writes to MSIX register and to kernel address space (completion
+ *       queue).
+ *
+ * DMA is not secured but because CP is secured, KMD still needs to parse the
+ * CB, but doesn't need to check the DMA addresses.
+ *
+ * For QMAN DMA 0, DMA is also secured because only KMD uses this DMA and KMD
+ * doesn't map memory in MMU.
+ *
+ * QMAN TPC/MME: PQ, CQ and CP aren't secured (no change from MMU disabled mode)
+ *
+ * DMA RR does NOT protect host because DMA is not secured
+ *
+ */
+
+#define GOYA_MMU_REGS_NUM		61
+
+#define GOYA_DMA_POOL_BLK_SIZE		0x100		/* 256 bytes */
+
+#define GOYA_RESET_TIMEOUT_MSEC		500		/* 500ms */
+#define GOYA_PLDM_RESET_TIMEOUT_MSEC	20000		/* 20s */
+#define GOYA_RESET_WAIT_MSEC		1		/* 1ms */
+#define GOYA_CPU_RESET_WAIT_MSEC	100		/* 100ms */
+#define GOYA_PLDM_RESET_WAIT_MSEC	1000		/* 1s */
+#define GOYA_CPU_TIMEOUT_USEC		10000000	/* 10s */
+#define GOYA_TEST_QUEUE_WAIT_USEC	100000		/* 100ms */
+
+#define GOYA_QMAN0_FENCE_VAL		0xD169B243
+
+#define GOYA_MAX_INITIATORS		20
+
+static void goya_get_fixed_properties(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
+
+	prop->dram_base_address = DRAM_PHYS_BASE;
+	prop->dram_size = DRAM_PHYS_DEFAULT_SIZE;
+	prop->dram_end_address = prop->dram_base_address + prop->dram_size;
+	prop->dram_user_base_address = DRAM_BASE_ADDR_USER;
+
+	prop->sram_base_address = SRAM_BASE_ADDR;
+	prop->sram_size = SRAM_SIZE;
+	prop->sram_end_address = prop->sram_base_address + prop->sram_size;
+	prop->sram_user_base_address = prop->sram_base_address +
+						SRAM_USER_BASE_OFFSET;
+
+	prop->host_phys_base_address = HOST_PHYS_BASE;
+	prop->va_space_host_start_address = VA_HOST_SPACE_START;
+	prop->va_space_host_end_address = VA_HOST_SPACE_END;
+	prop->va_space_dram_start_address = VA_DDR_SPACE_START;
+	prop->va_space_dram_end_address = VA_DDR_SPACE_END;
+	prop->cfg_size = CFG_SIZE;
+	prop->max_asid = MAX_ASID;
+	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
+
+	prop->high_pll = PLL_HIGH_DEFAULT;
+}
+
+/*
+ * goya_pci_bars_map - Map PCI BARS of Goya device
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Request PCI regions and map them to kernel virtual addresses.
+ * Returns 0 on success
+ *
+ */
+int goya_pci_bars_map(struct hl_device *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	int rc;
+
+	rc = pci_request_regions(pdev, HL_NAME);
+	if (rc) {
+		dev_err(hdev->dev, "Cannot obtain PCI resources\n");
+		return rc;
+	}
+
+	hdev->pcie_bar[SRAM_CFG_BAR_ID] =
+			pci_ioremap_bar(pdev, SRAM_CFG_BAR_ID);
+	if (!hdev->pcie_bar[SRAM_CFG_BAR_ID]) {
+		dev_err(hdev->dev, "pci_ioremap_bar failed for CFG\n");
+		rc = -ENODEV;
+		goto err_release_regions;
+	}
+
+	hdev->pcie_bar[MSIX_BAR_ID] = pci_ioremap_bar(pdev, MSIX_BAR_ID);
+	if (!hdev->pcie_bar[MSIX_BAR_ID]) {
+		dev_err(hdev->dev, "pci_ioremap_bar failed for MSIX\n");
+		rc = -ENODEV;
+		goto err_unmap_sram_cfg;
+	}
+
+	hdev->pcie_bar[DDR_BAR_ID] = pci_ioremap_wc_bar(pdev, DDR_BAR_ID);
+	if (!hdev->pcie_bar[DDR_BAR_ID]) {
+		dev_err(hdev->dev, "pci_ioremap_bar failed for DDR\n");
+		rc = -ENODEV;
+		goto err_unmap_msix;
+	}
+
+	hdev->rmmio = hdev->pcie_bar[SRAM_CFG_BAR_ID] +
+				(CFG_BASE - SRAM_BASE_ADDR);
+
+	return 0;
+
+err_unmap_msix:
+	iounmap(hdev->pcie_bar[MSIX_BAR_ID]);
+err_unmap_sram_cfg:
+	iounmap(hdev->pcie_bar[SRAM_CFG_BAR_ID]);
+err_release_regions:
+	pci_release_regions(pdev);
+
+	return rc;
+}
+
+/*
+ * goya_pci_bars_unmap - Unmap PCI BARS of Goya device
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Release all PCI BARS and unmap their virtual addresses
+ *
+ */
+static void goya_pci_bars_unmap(struct hl_device *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+
+	iounmap(hdev->pcie_bar[DDR_BAR_ID]);
+	iounmap(hdev->pcie_bar[MSIX_BAR_ID]);
+	iounmap(hdev->pcie_bar[SRAM_CFG_BAR_ID]);
+	pci_release_regions(pdev);
+}
+
+/*
+ * goya_elbi_write - Write through the ELBI interface
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * return 0 on success, -1 on failure
+ *
+ */
+static int goya_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	ktime_t timeout;
+	u32 val;
+
+	/* Clear previous status */
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, 0);
+
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_ADDR, (u32) addr);
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_CTRL,
+				PCI_CONFIG_ELBI_CTRL_WRITE);
+
+	timeout = ktime_add_ms(ktime_get(), 10);
+	for (;;) {
+		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, &val);
+		if (val & PCI_CONFIG_ELBI_STS_MASK)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS,
+						&val);
+			break;
+		}
+		usleep_range(300, 500);
+	}
+
+	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE)
+		return 0;
+
+	if (val & PCI_CONFIG_ELBI_STS_ERR) {
+		dev_err(hdev->dev, "Error writing to ELBI\n");
+		return -EIO;
+	}
+
+	if (!(val & PCI_CONFIG_ELBI_STS_MASK)) {
+		dev_err(hdev->dev, "ELBI write didn't finish in time\n");
+		return -EIO;
+	}
+
+	dev_err(hdev->dev, "ELBI write has undefined bits in status\n");
+	return -EIO;
+}
+
+/*
+ * goya_iatu_write - iatu write routine
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static int goya_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
+{
+	u32 dbi_offset;
+	int rc;
+
+	dbi_offset = addr & 0xFFF;
+
+	rc = goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI, 0x00300000);
+	rc |= goya_elbi_write(hdev, mmPCIE_DBI_BASE + dbi_offset, data);
+
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+
+void goya_reset_link_through_bridge(struct hl_device *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	struct pci_dev *parent_port;
+	u16 val;
+
+	parent_port = pdev->bus->self;
+	pci_read_config_word(parent_port, PCI_BRIDGE_CONTROL, &val);
+	val |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
+	ssleep(1);
+
+	val &= ~(PCI_BRIDGE_CTL_BUS_RESET);
+	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
+	ssleep(3);
+}
+
+/*
+ * goya_set_ddr_bar_base - set DDR bar to map specific device address
+ *
+ * @hdev: pointer to hl_device structure
+ * @addr: address in DDR. Must be aligned to DDR bar size
+ *
+ * This function configures the iATU so that the DDR bar will start at the
+ * specified addr.
+ *
+ */
+static int goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	int rc;
+
+	if ((goya) && (goya->ddr_bar_cur_addr == addr))
+		return 0;
+
+	/* Inbound Region 1 - Bar 4 - Point to DDR */
+	rc = goya_iatu_write(hdev, 0x314, lower_32_bits(addr));
+	rc |= goya_iatu_write(hdev, 0x318, upper_32_bits(addr));
+	rc |= goya_iatu_write(hdev, 0x300, 0);
+	/* Enable + Bar match + match enable + Bar 4 */
+	rc |= goya_iatu_write(hdev, 0x304, 0xC0080400);
+
+	/* Return the DBI window to the default location */
+	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI, 0);
+	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI_32, 0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to map DDR bar to 0x%08llx\n", addr);
+		return -EIO;
+	}
+
+	if (goya)
+		goya->ddr_bar_cur_addr = addr;
+
+	return 0;
+}
+
+/*
+ * goya_init_iatu - Initialize the iATU unit inside the PCI controller
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * This is needed in case the firmware doesn't initialize the iATU
+ *
+ */
+static int goya_init_iatu(struct hl_device *hdev)
+{
+	int rc;
+
+	/* Inbound Region 0 - Bar 0 - Point to SRAM_BASE_ADDR */
+	rc  = goya_iatu_write(hdev, 0x114, lower_32_bits(SRAM_BASE_ADDR));
+	rc |= goya_iatu_write(hdev, 0x118, upper_32_bits(SRAM_BASE_ADDR));
+	rc |= goya_iatu_write(hdev, 0x100, 0);
+	/* Enable + Bar match + match enable */
+	rc |= goya_iatu_write(hdev, 0x104, 0xC0080000);
+
+	/* Inbound Region 1 - Bar 4 - Point to DDR */
+	rc |= goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE);
+
+	/* Outbound Region 0 - Point to Host */
+	rc |= goya_iatu_write(hdev, 0x008, lower_32_bits(HOST_PHYS_BASE));
+	rc |= goya_iatu_write(hdev, 0x00C, upper_32_bits(HOST_PHYS_BASE));
+	rc |= goya_iatu_write(hdev, 0x010,
+		lower_32_bits(HOST_PHYS_BASE + HOST_PHYS_SIZE - 1));
+	rc |= goya_iatu_write(hdev, 0x014, 0);
+	rc |= goya_iatu_write(hdev, 0x018, 0);
+	rc |= goya_iatu_write(hdev, 0x020,
+		upper_32_bits(HOST_PHYS_BASE + HOST_PHYS_SIZE - 1));
+	/* Increase region size */
+	rc |= goya_iatu_write(hdev, 0x000, 0x00002000);
+	/* Enable */
+	rc |= goya_iatu_write(hdev, 0x004, 0x80000000);
+
+	/* Return the DBI window to the default location */
+	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI, 0);
+	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI_32, 0);
+
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * goya_early_init - GOYA early initialization code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Verify PCI bars
+ * Set DMA masks
+ * PCI controller initialization
+ * Map PCI bars
+ *
+ */
+static int goya_early_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct pci_dev *pdev = hdev->pdev;
+	u32 val;
+	int rc;
+
+	goya_get_fixed_properties(hdev);
+
+	/* Check BAR sizes */
+	if (pci_resource_len(pdev, SRAM_CFG_BAR_ID) != CFG_BAR_SIZE) {
+		dev_err(hdev->dev,
+			"Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
+			SRAM_CFG_BAR_ID,
+			pci_resource_len(pdev, SRAM_CFG_BAR_ID),
+			CFG_BAR_SIZE);
+		return -ENODEV;
+	}
+
+	if (pci_resource_len(pdev, MSIX_BAR_ID) != MSIX_BAR_SIZE) {
+		dev_err(hdev->dev,
+			"Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
+			MSIX_BAR_ID, pci_resource_len(pdev, MSIX_BAR_ID),
+			MSIX_BAR_SIZE);
+		return -ENODEV;
+	}
+
+	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
+
+	/* set DMA mask for GOYA */
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(39));
+	if (rc) {
+		dev_warn(hdev->dev, "Unable to set pci dma mask to 39 bits\n");
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Unable to set pci dma mask to 32 bits\n");
+			return rc;
+		}
+	}
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(39));
+	if (rc) {
+		dev_warn(hdev->dev,
+			"Unable to set pci consistent dma mask to 39 bits\n");
+		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Unable to set pci consistent dma mask to 32 bits\n");
+			return rc;
+		}
+	}
+
+	if (hdev->reset_pcilink)
+		goya_reset_link_through_bridge(hdev);
+
+	rc = pci_enable_device_mem(pdev);
+	if (rc) {
+		dev_err(hdev->dev, "can't enable PCI device\n");
+		return rc;
+	}
+
+	pci_set_master(pdev);
+
+	rc = goya_init_iatu(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize iATU\n");
+		goto disable_device;
+	}
+
+	rc = goya_pci_bars_map(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize PCI BARS\n");
+		goto disable_device;
+	}
+
+	val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
+	if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
+		dev_warn(hdev->dev,
+			"PCI strap is not configured correctly, PCI bus errors may occur\n");
+
+	return 0;
+
+disable_device:
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+
+	return rc;
+}
+
+/*
+ * goya_early_fini - GOYA early finalization code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Unmap PCI bars
+ *
+ */
+int goya_early_fini(struct hl_device *hdev)
+{
+	goya_pci_bars_unmap(hdev);
+
+	pci_clear_master(hdev->pdev);
+	pci_disable_device(hdev->pdev);
+
+	return 0;
+}
+
+/*
+ * goya_sw_init - Goya software initialization code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static int goya_sw_init(struct hl_device *hdev)
+{
+	struct goya_device *goya;
+	int rc;
+
+	/* Allocate device structure */
+	goya = kzalloc(sizeof(*goya), GFP_KERNEL);
+	if (!goya)
+		return -ENOMEM;
+
+	/* according to goya_init_iatu */
+	goya->ddr_bar_cur_addr = DRAM_PHYS_BASE;
+	hdev->asic_specific = goya;
+
+	/* Create DMA pool for small allocations */
+	hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
+			&hdev->pdev->dev, GOYA_DMA_POOL_BLK_SIZE, 8, 0);
+	if (!hdev->dma_pool) {
+		dev_err(hdev->dev, "failed to create DMA pool\n");
+		rc = -ENOMEM;
+		goto free_goya_device;
+	}
+
+	hdev->cpu_accessible_dma_mem =
+			hdev->asic_funcs->dma_alloc_coherent(hdev,
+					CPU_ACCESSIBLE_MEM_SIZE,
+					&hdev->cpu_accessible_dma_address,
+					GFP_KERNEL | __GFP_ZERO);
+
+	if (!hdev->cpu_accessible_dma_mem) {
+		dev_err(hdev->dev,
+			"failed to allocate %d of dma memory for CPU accessible memory space\n",
+			CPU_ACCESSIBLE_MEM_SIZE);
+		rc = -ENOMEM;
+		goto free_dma_pool;
+	}
+
+	hdev->cpu_accessible_dma_pool = gen_pool_create(CPU_PKT_SHIFT, -1);
+	if (!hdev->cpu_accessible_dma_pool) {
+		dev_err(hdev->dev,
+			"Failed to create CPU accessible DMA pool\n");
+		rc = -ENOMEM;
+		goto free_cpu_pq_dma_mem;
+	}
+
+	rc = gen_pool_add(hdev->cpu_accessible_dma_pool,
+				(u64) hdev->cpu_accessible_dma_mem,
+				CPU_ACCESSIBLE_MEM_SIZE, -1);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to add memory to CPU accessible DMA pool\n");
+		rc = -EFAULT;
+		goto free_cpu_pq_pool;
+	}
+
+	spin_lock_init(&goya->hw_queues_lock);
+
+	return 0;
+
+free_cpu_pq_pool:
+	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
+free_cpu_pq_dma_mem:
+	hdev->asic_funcs->dma_free_coherent(hdev, CPU_ACCESSIBLE_MEM_SIZE,
+			hdev->cpu_accessible_dma_mem,
+			hdev->cpu_accessible_dma_address);
+free_dma_pool:
+	dma_pool_destroy(hdev->dma_pool);
+free_goya_device:
+	kfree(goya);
+
+	return rc;
+}
+
+/*
+ * goya_sw_fini - Goya software tear-down code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+int goya_sw_fini(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
+
+	hdev->asic_funcs->dma_free_coherent(hdev, CPU_ACCESSIBLE_MEM_SIZE,
+			hdev->cpu_accessible_dma_mem,
+			hdev->cpu_accessible_dma_address);
+
+	dma_pool_destroy(hdev->dma_pool);
+
+	kfree(goya);
+
+	return 0;
+}
+
+int goya_suspend(struct hl_device *hdev)
+{
+	return 0;
+}
+
+int goya_resume(struct hl_device *hdev)
+{
+	return 0;
+}
+
+void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
+					dma_addr_t *dma_handle, gfp_t flags)
+{
+	return dma_alloc_coherent(&hdev->pdev->dev, size, dma_handle, flags);
+}
+
+void goya_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
+				dma_addr_t dma_handle)
+{
+	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
+}
+
+static const struct hl_asic_funcs goya_funcs = {
+	.early_init = goya_early_init,
+	.early_fini = goya_early_fini,
+	.sw_init = goya_sw_init,
+	.sw_fini = goya_sw_fini,
+	.suspend = goya_suspend,
+	.resume = goya_resume,
+	.dma_alloc_coherent = goya_dma_alloc_coherent,
+	.dma_free_coherent = goya_dma_free_coherent,
+};
+
+/*
+ * goya_set_asic_funcs - set Goya function pointers
+ *
+ * @*hdev: pointer to hl_device structure
+ *
+ */
+void goya_set_asic_funcs(struct hl_device *hdev)
+{
+	hdev->asic_funcs = &goya_funcs;
+}
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
new file mode 100644
index 000000000000..d65ac54ba89b
--- /dev/null
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GOYAP_H_
+#define GOYAP_H_
+
+#include <uapi/misc/habanalabs.h>
+#include "habanalabs.h"
+#include "include/goya/goya.h"
+
+#define NUMBER_OF_CMPLT_QUEUES		5
+#define NUMBER_OF_EXT_HW_QUEUES		5
+#define NUMBER_OF_CPU_HW_QUEUES		1
+#define NUMBER_OF_INT_HW_QUEUES		9
+#define NUMBER_OF_HW_QUEUES		(NUMBER_OF_EXT_HW_QUEUES + \
+					NUMBER_OF_CPU_HW_QUEUES + \
+					NUMBER_OF_INT_HW_QUEUES)
+
+/*
+ * Number of MSIX interrupts IDS:
+ * Each completion queue has 1 ID
+ * The event queue has 1 ID
+ */
+#define NUMBER_OF_INTERRUPTS		(NUMBER_OF_CMPLT_QUEUES + 1)
+
+#if (NUMBER_OF_HW_QUEUES >= HL_MAX_QUEUES)
+#error "Number of H/W queues must be smaller than HL_MAX_QUEUES"
+#endif
+
+#if (NUMBER_OF_INTERRUPTS > GOYA_MSIX_ENTRIES)
+#error "Number of MSIX interrupts must be smaller or equal to GOYA_MSIX_ENTRIES"
+#endif
+
+#define QMAN_FENCE_TIMEOUT_USEC		10000	/* 10 ms */
+
+#define QMAN_STOP_TIMEOUT_USEC		100000	/* 100 ms */
+
+#define TPC_MAX_NUM			8
+#define TPC_ENABLED_MASK		0xFF
+
+#define DMA_MAX_NUM			5
+
+#define PLL_HIGH_DEFAULT		1575000000	/* 1.575 GHz */
+
+#define GOYA_ARMCP_INFO_TIMEOUT		10000000	/* 10s */
+
+#define DRAM_PHYS_DEFAULT_SIZE		0x100000000ull	/* 4GB */
+
+/* DRAM Memory Map */
+
+#define CPU_FW_IMAGE_SIZE	0x10000000	/* 256MB */
+#define MMU_PAGE_TABLES_SIZE	0x0E000000	/* 224MB */
+#define MMU_CACHE_MNG_SIZE	0x00001000	/* 4KB */
+#define CPU_PQ_PKT_SIZE		0x00001000	/* 4KB */
+#define CPU_PQ_DATA_SIZE	0x01FFE000	/* 32MB - 8KB  */
+
+#define CPU_FW_IMAGE_ADDR	DRAM_PHYS_BASE
+#define MMU_PAGE_TABLES_ADDR	(CPU_FW_IMAGE_ADDR + CPU_FW_IMAGE_SIZE)
+#define MMU_CACHE_MNG_ADDR	(MMU_PAGE_TABLES_ADDR + MMU_PAGE_TABLES_SIZE)
+#define CPU_PQ_PKT_ADDR		(MMU_CACHE_MNG_ADDR + MMU_CACHE_MNG_SIZE)
+#define CPU_PQ_DATA_ADDR	(CPU_PQ_PKT_ADDR + CPU_PQ_PKT_SIZE)
+#define DRAM_BASE_ADDR_USER	(CPU_PQ_DATA_ADDR + CPU_PQ_DATA_SIZE)
+
+#if (DRAM_BASE_ADDR_USER != 0x20000000)
+#error "KMD must reserve 512MB"
+#endif
+
+/*
+ * SRAM Memory Map for KMD
+ *
+ * KMD occupies KMD_SRAM_SIZE bytes from the start of SRAM. It is used for
+ * MME/TPC QMANs
+ *
+ */
+
+#define MME_QMAN_BASE_OFFSET	0x000000	/* Must be 0 */
+#define MME_QMAN_LENGTH		64
+#define TPC_QMAN_LENGTH		64
+
+#define TPC0_QMAN_BASE_OFFSET	(MME_QMAN_BASE_OFFSET + \
+				(MME_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC1_QMAN_BASE_OFFSET	(TPC0_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC2_QMAN_BASE_OFFSET	(TPC1_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC3_QMAN_BASE_OFFSET	(TPC2_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC4_QMAN_BASE_OFFSET	(TPC3_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC5_QMAN_BASE_OFFSET	(TPC4_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC6_QMAN_BASE_OFFSET	(TPC5_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+#define TPC7_QMAN_BASE_OFFSET	(TPC6_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+
+#define SRAM_KMD_RES_OFFSET	(TPC7_QMAN_BASE_OFFSET + \
+				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
+
+#if (SRAM_KMD_RES_OFFSET >= GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START)
+#error "MME/TPC QMANs SRAM space exceeds limit"
+#endif
+
+#define SRAM_USER_BASE_OFFSET	GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START
+
+/* Virtual address space */
+#define VA_HOST_SPACE_START	0x1000000000000ull	/* 256TB */
+#define VA_HOST_SPACE_END	0x3FF8000000000ull	/* 1PB - 1TB */
+#define VA_HOST_SPACE_SIZE	(VA_HOST_SPACE_END - \
+					VA_HOST_SPACE_START) /* 767TB */
+
+#define VA_DDR_SPACE_START	0x800000000ull		/* 32GB */
+#define VA_DDR_SPACE_END	0x2000000000ull		/* 128GB */
+#define VA_DDR_SPACE_SIZE	(VA_DDR_SPACE_END - \
+					VA_DDR_SPACE_START)	/* 128GB */
+
+#define DMA_MAX_TRANSFER_SIZE	0xFFFFFFFF
+
+#define HW_CAP_PLL		0x00000001
+#define HW_CAP_DDR_0		0x00000002
+#define HW_CAP_DDR_1		0x00000004
+#define HW_CAP_MME		0x00000008
+#define HW_CAP_CPU		0x00000010
+#define HW_CAP_DMA		0x00000020
+#define HW_CAP_MSIX		0x00000040
+#define HW_CAP_CPU_Q		0x00000080
+#define HW_CAP_MMU		0x00000100
+#define HW_CAP_TPC_MBIST	0x00000200
+#define HW_CAP_GOLDEN		0x00000400
+#define HW_CAP_TPC		0x00000800
+
+#define CPU_PKT_SHIFT		5
+#define CPU_PKT_SIZE		(1 << CPU_PKT_SHIFT)
+#define CPU_PKT_MASK		(~((1 << CPU_PKT_SHIFT) - 1))
+#define CPU_MAX_PKTS_IN_CB	32
+#define CPU_CB_SIZE		(CPU_PKT_SIZE * CPU_MAX_PKTS_IN_CB)
+#define CPU_ACCESSIBLE_MEM_SIZE	(HL_QUEUE_LENGTH * CPU_CB_SIZE)
+
+enum goya_fw_component {
+	FW_COMP_UBOOT,
+	FW_COMP_PREBOOT
+};
+
+struct goya_device {
+	/* TODO: remove hw_queues_lock after moving to scheduler code */
+	spinlock_t	hw_queues_lock;
+	u64		ddr_bar_cur_addr;
+	u32		hw_cap_initialized;
+};
+
+#endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 02386dcaa3a3..644624fa378b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -21,9 +21,62 @@
 
 #define HL_NAME				"habanalabs"
 
+#define HL_MAX_QUEUES			128
+
 struct hl_device;
 
 
+/**
+ * struct asic_fixed_properties - ASIC specific immutable properties.
+ * @sram_base_address: SRAM physical start address.
+ * @sram_end_address: SRAM physical end address.
+ * @sram_user_base_address - SRAM physical start address for user access.
+ * @dram_base_address: DRAM physical start address.
+ * @dram_end_address: DRAM physical end address.
+ * @dram_user_base_address: DRAM physical start address for user access.
+ * @dram_size: DRAM total size.
+ * @dram_pci_bar_size: size of PCI bar towards DRAM.
+ * @host_phys_base_address: base physical address of host memory for
+ *				transactions that the device generates.
+ * @va_space_host_start_address: base address of virtual memory range for
+ *                               mapping host memory.
+ * @va_space_host_end_address: end address of virtual memory range for
+ *                             mapping host memory.
+ * @va_space_dram_start_address: base address of virtual memory range for
+ *                               mapping DRAM memory.
+ * @va_space_dram_end_address: end address of virtual memory range for
+ *                             mapping DRAM memory.
+ * @cfg_size: configuration space size on SRAM.
+ * @sram_size: total size of SRAM.
+ * @max_asid: maximum number of open contexts (ASIDs).
+ * @completion_queues_count: number of completion queues.
+ * @high_pll: high PLL frequency used by the device.
+ * @tpc_enabled_mask: which TPCs are enabled.
+ */
+struct asic_fixed_properties {
+	u64			sram_base_address;
+	u64			sram_end_address;
+	u64			sram_user_base_address;
+	u64			dram_base_address;
+	u64			dram_end_address;
+	u64			dram_user_base_address;
+	u64			dram_size;
+	u64			dram_pci_bar_size;
+	u64			host_phys_base_address;
+	u64			va_space_host_start_address;
+	u64			va_space_host_end_address;
+	u64			va_space_dram_start_address;
+	u64			va_space_dram_end_address;
+	u32			cfg_size;
+	u32			sram_size;
+	u32			max_asid;
+	u32			high_pll;
+	u8			completion_queues_count;
+	u8			tpc_enabled_mask;
+};
+
+
+#define HL_QUEUE_LENGTH			256
 /*
  * ASICs
  */
@@ -40,6 +93,36 @@ enum hl_asic_type {
 	ASIC_INVALID
 };
 
+/**
+ * struct hl_asic_funcs - ASIC specific functions that are can be called from
+ *                        common code.
+ * @early_init: sets up early driver state (pre sw_init), doesn't configure H/W.
+ * @early_fini: tears down what was done in early_init.
+ * @sw_init: sets up driver state, does not configure H/W.
+ * @sw_fini: tears down driver state, does not configure H/W.
+ * @suspend: handles IP specific H/W or SW changes for suspend.
+ * @resume: handles IP specific H/W or SW changes for resume.
+ * @dma_alloc_coherent: Allocate coherent DMA memory by calling
+ *                      dma_alloc_coherent(). This is ASIC function because its
+ *                      implementation is not trivial when the driver is loaded
+ *                      in simulation mode (not upstreamed).
+ * @dma_free_coherent: Free coherent DMA memory by calling dma_free_coherent().
+ *                     This is ASIC function because its implementation is not
+ *                     trivial when the driver is loaded in simulation mode
+ *                     (not upstreamed).
+ */
+struct hl_asic_funcs {
+	int (*early_init)(struct hl_device *hdev);
+	int (*early_fini)(struct hl_device *hdev);
+	int (*sw_init)(struct hl_device *hdev);
+	int (*sw_fini)(struct hl_device *hdev);
+	int (*suspend)(struct hl_device *hdev);
+	int (*resume)(struct hl_device *hdev);
+	void* (*dma_alloc_coherent)(struct hl_device *hdev, size_t size,
+					dma_addr_t *dma_handle, gfp_t flag);
+	void (*dma_free_coherent)(struct hl_device *hdev, size_t size,
+					void *cpu_addr, dma_addr_t dma_handle);
+};
 
 /*
  * FILE PRIVATE STRUCTURE
@@ -69,26 +152,78 @@ struct hl_fpriv {
  */
 #define HL_MAX_MINORS	256
 
+/*
+ * Registers read & write functions.
+ */
+
+u32 hl_rreg(struct hl_device *hdev, u32 reg);
+void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
+
+#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
+	readl_poll_timeout(hdev->rmmio + addr, val, cond, sleep_us, timeout_us)
+
+#define RREG32(reg) hl_rreg(hdev, (reg))
+#define WREG32(reg, v) hl_wreg(hdev, (reg), (v))
+#define DREG32(reg) pr_info("REGISTER: " #reg " : 0x%08X\n",	\
+				hl_rreg(hdev, (reg)))
+
+#define WREG32_P(reg, val, mask)				\
+	do {							\
+		u32 tmp_ = RREG32(reg);				\
+		tmp_ &= (mask);					\
+		tmp_ |= ((val) & ~(mask));			\
+		WREG32(reg, tmp_);				\
+	} while (0)
+#define WREG32_AND(reg, and) WREG32_P(reg, 0, and)
+#define WREG32_OR(reg, or) WREG32_P(reg, or, ~(or))
+
+#define REG_FIELD_SHIFT(reg, field) reg##_##field##_SHIFT
+#define REG_FIELD_MASK(reg, field) reg##_##field##_MASK
+#define WREG32_FIELD(reg, field, val)	\
+	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
+			(val) << REG_FIELD_SHIFT(reg, field))
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
+ * @pcie_bar: array of available PCIe bars.
+ * @rmmio: configuration area address on SRAM.
  * @cdev: related char device.
  * @dev: realted kernel basic device structure.
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
+ * @dma_pool: DMA pool for small allocations.
+ * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
+ * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
+ * @cpu_accessible_dma_pool: KMD <-> ArmCP shared memory pool.
+ * @asic_prop: ASIC specific immutable properties.
+ * @asic_funcs: ASIC specific functions.
+ * @asic_specific: ASIC specific information to use only from ASIC files.
  * @major: habanalabs KMD major.
  * @id: device minor.
  * @disabled: is device disabled.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
+	void __iomem			*pcie_bar[6];
+	void __iomem			*rmmio;
 	struct cdev			cdev;
 	struct device			*dev;
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
+	struct dma_pool			*dma_pool;
+	void				*cpu_accessible_dma_mem;
+	dma_addr_t			cpu_accessible_dma_address;
+	struct gen_pool			*cpu_accessible_dma_pool;
+	struct asic_fixed_properties	asic_prop;
+	const struct hl_asic_funcs	*asic_funcs;
+	void				*asic_specific;
 	u32				major;
 	u16				id;
 	u8				disabled;
+
+	/* Parameters for bring-up */
+	u8				reset_pcilink;
 };
 
 
@@ -135,4 +270,6 @@ void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
 
+void goya_set_asic_funcs(struct hl_device *hdev);
+
 #endif /* HABANALABSP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 573349eedce4..1596cf38f6c0 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -126,6 +126,9 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	hdev->major = hl_major;
 
+	/* Parameters for bring-up - set them to defaults */
+	hdev->reset_pcilink = 0;
+
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
diff --git a/drivers/misc/habanalabs/include/goya/goya.h b/drivers/misc/habanalabs/include/goya/goya.h
new file mode 100644
index 000000000000..76d8a9c376e2
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GOYA_H
+#define GOYA_H
+
+#include "asic_reg/goya_regs.h"
+
+#include <linux/types.h>
+
+#define SRAM_CFG_BAR_ID		0
+#define MSIX_BAR_ID		2
+#define DDR_BAR_ID		4
+
+#define CFG_BAR_SIZE		0x10000000ull		/* 256MB */
+#define MSIX_BAR_SIZE		0x1000ull		/* 4KB */
+
+#define CFG_BASE		0x7FFC000000ull
+#define CFG_SIZE		0x4000000		/* 32MB CFG + 32MB DBG*/
+
+#define SRAM_BASE_ADDR		0x7FF0000000ull
+#define SRAM_SIZE		0x32A0000		/* 50.625MB */
+
+#define DRAM_PHYS_BASE		0x0ull
+
+#define HOST_PHYS_BASE		0x8000000000ull		/* 0.5TB */
+#define HOST_PHYS_SIZE		0x1000000000000ull	/* 0.25PB (48 bits) */
+
+#define GOYA_MSIX_ENTRIES	8
+
+#define QMAN_PQ_ENTRY_SIZE	16			/* Bytes */
+
+#define MAX_ASID		1024
+
+#define PROT_BITS_OFFS		0xF80
+
+#endif /* GOYA_H */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
new file mode 100644
index 000000000000..a0ec23adf8f5
--- /dev/null
+++ b/include/uapi/misc/habanalabs.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef HABANALABS_H_
+#define HABANALABS_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * Defines that are asic-specific but constitutes as ABI between kernel driver
+ * and userspace
+ */
+#define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START	0x8000	/* 32KB */
+
+#endif /* HABANALABS_H_ */
-- 
2.17.1

