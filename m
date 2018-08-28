Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E4CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9048B2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVlISQgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9048B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeH1Oss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:48:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42737 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH1Osr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:48:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so532587pff.9;
        Tue, 28 Aug 2018 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SUiWKDqC4hWvkutgrkP5c4aNIcliM098bsz0enCsLE=;
        b=DVlISQgbKgrCjRvjGoxFV470jZ1wAYlaQWHLfQxl/WXb/y4BLPDDMJogSDWQD46mSy
         Rd+moasLY9eHi2TD2UgCKdllFI0DtHkZJeb5E4FZZ/9NgHXkmqdLyMPwLo8JGLt7xUiY
         ct5uPAvKF/W3N4CEedgfKgOZXQObUF76p8UC4+vI30j00/ou/SyKvietNgE+9R1Z1jjb
         vxrUy3oVamNoX1XI9IrznCtL0O7DfA2QTCPKG8eEws1c6GZAL24sG2JSy/zLIhZVMBS6
         dYIzrVqZksrpLQWU5+CWlDkQOYMWeod0dzlmQfa4as7hDCufsVghOZhwP5M+Qmv7jEFp
         sOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4SUiWKDqC4hWvkutgrkP5c4aNIcliM098bsz0enCsLE=;
        b=d1acTidrP3I61oZxZlelO24u2CXS82v9AVx+kGnTGSEhUb36jxMgRpi+ys5BI08yEe
         vKrvxr3VMxtd77SsetE35EF/pKOKNVqLAtWTzcp0fv/eqNqQGCvAsR4P0W9yZ0q8Qw1+
         5PUxmwsaTv2mqUTQfuoi8i2zftnNCBLtiBRAwKWd4VVfH8FG8PY2GZtXGdqQCB9uKobh
         xVs+LyjfXCLCmOz2tl/VI2YMJ0Qf4ysTt8p+zz9qFIJY9Z0//4Z94A1WYMgpvgAi64HH
         iiTvd5XB/Cd492XiCU6uR3aI2Aj/rrMfA0mBFd/kz4M/xkBAhptYcH24ZHMkgdB7xDWm
         pS1w==
X-Gm-Message-State: APzg51BcnIzTk21OQjsd4SqWeWuBvDyOF3p813+Y32CQjMsxQrgRfQlA
        Px/o8bPVpIx5omKViKThixi/V00H
X-Google-Smtp-Source: ANB0VdbTy7nAsw9p+G6go90y2HbtGy4EE+SJEKCizWSlbabVMlP4W/pxDyTxxrHAfHU7tpr+duY60A==
X-Received: by 2002:a63:de4c:: with SMTP id y12-v6mr975419pgi.435.1535453861717;
        Tue, 28 Aug 2018 03:57:41 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:57:40 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 01/15] soc: octeontx2: Add Marvell OcteonTX2 RVU AF driver
Date:   Tue, 28 Aug 2018 16:27:04 +0530
Message-Id: <1535453838-12154-2-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

This patch adds basic template for Marvell OcteonTX2's
resource virtualization unit (RVU) admin function (AF)
driver. Just the driver registration and probe.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   1 +
 drivers/soc/marvell/Kconfig            |  13 ++++
 drivers/soc/marvell/Makefile           |   2 +
 drivers/soc/marvell/octeontx2/Makefile |   8 +++
 drivers/soc/marvell/octeontx2/rvu.c    | 126 +++++++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/rvu.h    |  31 ++++++++
 7 files changed, 182 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2/rvu.c
 create mode 100644 drivers/soc/marvell/octeontx2/rvu.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c07b4a8..42f2d0b 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -6,6 +6,7 @@ source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
+source "drivers/soc/marvell/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 113e884..5e18cbb 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -12,6 +12,7 @@ obj-y				+= fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
+obj-y				+= marvell/
 obj-y				+= mediatek/
 obj-$(CONFIG_ARCH_MESON)	+= amlogic/
 obj-y				+= qcom/
diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
new file mode 100644
index 0000000..4499caf
--- /dev/null
+++ b/drivers/soc/marvell/Kconfig
@@ -0,0 +1,13 @@
+#
+# MARVELL SoC drivers
+#
+
+menu "Marvell SoC drivers"
+
+config OCTEONTX2_AF
+	tristate "OcteonTX2 RVU Admin Function driver"
+	depends on ARM64 && PCI
+	help
+	  This driver supports Marvell's OcteonTX2 Resource Virtualization
+	  Unit's admin function manager which manages all RVU HW resources.
+endmenu
diff --git a/drivers/soc/marvell/Makefile b/drivers/soc/marvell/Makefile
new file mode 100644
index 0000000..16e0ca0
--- /dev/null
+++ b/drivers/soc/marvell/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		+= octeontx2/
diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
new file mode 100644
index 0000000..dacbd16
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Marvell's OcteonTX2 RVU Admin Function driver
+#
+
+obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
+
+octeontx2_af-y := rvu.o
diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
new file mode 100644
index 0000000..5af4da6
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx2 RVU Admin Function driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+
+#include "rvu.h"
+
+#define DRV_NAME	"octeontx2-af"
+#define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
+#define DRV_VERSION	"1.0"
+
+/* Supported devices */
+static const struct pci_device_id rvu_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_RVU_AF) },
+	{ 0, }  /* end of table */
+};
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION(DRV_STRING);
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, rvu_id_table);
+
+static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct rvu *rvu;
+	int    err;
+
+	rvu = devm_kzalloc(dev, sizeof(*rvu), GFP_KERNEL);
+	if (!rvu)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, rvu);
+	rvu->pdev = pdev;
+	rvu->dev = &pdev->dev;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto err_freemem;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto err_disable_device;
+	}
+
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to set DMA mask\n");
+		goto err_release_regions;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to set consistent DMA mask\n");
+		goto err_release_regions;
+	}
+
+	/* Map Admin function CSRs */
+	rvu->afreg_base = pcim_iomap(pdev, PCI_AF_REG_BAR_NUM, 0);
+	rvu->pfreg_base = pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
+	if (!rvu->afreg_base || !rvu->pfreg_base) {
+		dev_err(dev, "Unable to map admin function CSRs, aborting\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	return 0;
+
+err_release_regions:
+	pci_release_regions(pdev);
+err_disable_device:
+	pci_disable_device(pdev);
+err_freemem:
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, rvu);
+	return err;
+}
+
+static void rvu_remove(struct pci_dev *pdev)
+{
+	struct rvu *rvu = pci_get_drvdata(pdev);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+
+	devm_kfree(&pdev->dev, rvu);
+}
+
+static struct pci_driver rvu_driver = {
+	.name = DRV_NAME,
+	.id_table = rvu_id_table,
+	.probe = rvu_probe,
+	.remove = rvu_remove,
+};
+
+static int __init rvu_init_module(void)
+{
+	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
+
+	return pci_register_driver(&rvu_driver);
+}
+
+static void __exit rvu_cleanup_module(void)
+{
+	pci_unregister_driver(&rvu_driver);
+}
+
+module_init(rvu_init_module);
+module_exit(rvu_cleanup_module);
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
new file mode 100644
index 0000000..4a4b0ad
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTx2 RVU Admin Function driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef RVU_H
+#define RVU_H
+
+/* PCI device IDs */
+#define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
+
+/* PCI BAR nos */
+#define	PCI_AF_REG_BAR_NUM			0
+#define	PCI_PF_REG_BAR_NUM			2
+#define	PCI_MBOX_BAR_NUM			4
+
+#define NAME_SIZE				32
+
+struct rvu {
+	void __iomem		*afreg_base;
+	void __iomem		*pfreg_base;
+	struct pci_dev		*pdev;
+	struct device		*dev;
+};
+
+#endif /* RVU_H */
-- 
2.7.4

