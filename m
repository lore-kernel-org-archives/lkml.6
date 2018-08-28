Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917D7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2DE2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmOazeFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2DE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeH1OtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:49:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39596 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeH1OtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:49:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so571920plp.6;
        Tue, 28 Aug 2018 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=weOadS4lpPoQPgGDTcJ/9TW9J6/Vv9yYEu24IdrbEIs=;
        b=gmOazeFNGG6maF0uWq9wPRzHK4UEYJEk+KWMJ8BAuy8WswTvgxmEDFX+gSY1cN91Gk
         NVmvvl+L1+nh+pEk0T7ixyo47f2Z2+YkoNVpnjMn11SGIg4Tq/LwgMNPcKZMLcaVNJsa
         3RRq7pW2cjMxuYpEit9HeZzJD1hXo6v3meKQunNXd7YNcYutEqseYFn+aYrNUltUnBTg
         JALlkwVMcv/CYw2qeImLapk/twz9P1L21bGlb0X47eJA6JVNt0GR21Z7i6ViGPuEpP7D
         ZK6MdIgop53nYE/hdenptl6JyX5YzrB8VPvT9sLij0iydsfJsmXgzHwCOWDE6gI/kGu+
         ur7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=weOadS4lpPoQPgGDTcJ/9TW9J6/Vv9yYEu24IdrbEIs=;
        b=Z0MwYTc/WougEKEhAQlXF1lmyCRuQspE1431HEOTsGzv+myLtMKGyQavhZJl83iWk8
         W/SidOUT893kpIy3FVIixJ2kN5wiISwLyYWSp2Xw1a/SnjiK3Teu4KlMNF0NKCs5w7gy
         hAqDWCBnstFhwHJz6wDWGa1WKJ2/ixp/Vvmxc5vCfpg7tB7iWzcM6jPukzROB5REKo0n
         W1jMZIEtmRaowP79SJ/4SQeBgmi1YX+H38hGKVVsE3sI/1/qp+XOdOyNd3ph4EO0O/Pw
         UOWpiGPah/A8+GFuxXnpRHPyDdOi2OQCBSzJMVXGWqK75GYCDQpff72hFCUu/r5EUj+w
         j9Uw==
X-Gm-Message-State: APzg51DLnX3+qMDGrD1wUrsaZ5DLEPifMYhNF5xHEP9Xmq95bqDdsM0k
        zs7bYqziBu42Q0RBTeVxlkxG80eO
X-Google-Smtp-Source: ANB0Vdbm8irCtA95hsW10VfU/AhyZ6AiGunYnFTXEK9OJJ+D+CGDWHL0znorJRs2pok36FsLfF4qkg==
X-Received: by 2002:a17:902:8ec7:: with SMTP id x7-v6mr1033603plo.336.1535453894058;
        Tue, 28 Aug 2018 03:58:14 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:58:13 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
Date:   Tue, 28 Aug 2018 16:27:14 +0530
Message-Id: <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

This patch adds basic template for Marvell OcteonTX2's
CGX ethernet interface driver. Just the probe.
RVU AF driver will use APIs exported by this driver
for various things like PF to physical interface mapping,
loopback mode, interface stats etc.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/Kconfig            |  10 +++
 drivers/soc/marvell/octeontx2/Makefile |   2 +
 drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.h

diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
index 4499caf..73c8f8d 100644
--- a/drivers/soc/marvell/Kconfig
+++ b/drivers/soc/marvell/Kconfig
@@ -7,7 +7,17 @@ menu "Marvell SoC drivers"
 config OCTEONTX2_AF
 	tristate "OcteonTX2 RVU Admin Function driver"
 	depends on ARM64 && PCI
+	select OCTEONTX2_CGX
 	help
 	  This driver supports Marvell's OcteonTX2 Resource Virtualization
 	  Unit's admin function manager which manages all RVU HW resources.
+
+config OCTEONTX2_CGX
+	tristate "OcteonTX2 MAC interface (CGX) driver"
+	depends on ARM64 && PCI
+	select PHYLIB
+	help
+	  This driver supports programming and controlling of MAC
+	  interfaces from RVU Admin Function driver.
+
 endmenu
diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
index 8737ec3..50b8f74 100644
--- a/drivers/soc/marvell/octeontx2/Makefile
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -3,6 +3,8 @@
 # Makefile for Marvell's OcteonTX2 RVU Admin Function driver
 #
 
+obj-$(CONFIG_OCTEONTX2_CGX) += octeontx2_cgx.o
 obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
 
+octeontx2_cgx-y := cgx.o
 octeontx2_af-y := rvu.o mbox.o
diff --git a/drivers/soc/marvell/octeontx2/cgx.c b/drivers/soc/marvell/octeontx2/cgx.c
new file mode 100644
index 0000000..6f0b6f4
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx2 CGX driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/phy.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+
+#include "cgx.h"
+
+#define DRV_NAME	"octeontx2-cgx"
+#define DRV_STRING      "Marvell OcteonTX2 CGX/MAC Driver"
+#define DRV_VERSION	"1.0"
+
+struct cgx {
+	void __iomem		*reg_base;
+	struct pci_dev		*pdev;
+	u8			cgx_id;
+};
+
+/* Supported devices */
+static const struct pci_device_id cgx_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
+	{ 0, }  /* end of table */
+};
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION(DRV_STRING);
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, cgx_id_table);
+
+static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int err;
+	struct device *dev = &pdev->dev;
+	struct cgx *cgx;
+
+	cgx = devm_kzalloc(dev, sizeof(*cgx), GFP_KERNEL);
+	if (!cgx)
+		return -ENOMEM;
+	cgx->pdev = pdev;
+
+	pci_set_drvdata(pdev, cgx);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		pci_set_drvdata(pdev, NULL);
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto err_disable_device;
+	}
+
+	/* MAP configuration registers */
+	cgx->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
+	if (!cgx->reg_base) {
+		dev_err(dev, "CGX: Cannot map CSR memory space, aborting\n");
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
+	pci_set_drvdata(pdev, NULL);
+	return err;
+}
+
+static void cgx_remove(struct pci_dev *pdev)
+{
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static struct pci_driver cgx_driver = {
+	.name = DRV_NAME,
+	.id_table = cgx_id_table,
+	.probe = cgx_probe,
+	.remove = cgx_remove,
+};
+
+static int __init cgx_init_module(void)
+{
+	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
+
+	return pci_register_driver(&cgx_driver);
+}
+
+static void __exit cgx_cleanup_module(void)
+{
+	pci_unregister_driver(&cgx_driver);
+}
+
+module_init(cgx_init_module);
+module_exit(cgx_cleanup_module);
diff --git a/drivers/soc/marvell/octeontx2/cgx.h b/drivers/soc/marvell/octeontx2/cgx.h
new file mode 100644
index 0000000..8056264
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTx2 CGX driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef CGX_H
+#define CGX_H
+
+ /* PCI device IDs */
+#define	PCI_DEVID_OCTEONTX2_CGX			0xA059
+
+/* PCI BAR nos */
+#define PCI_CFG_REG_BAR_NUM			0
+
+#endif /* CGX_H */
-- 
2.7.4

