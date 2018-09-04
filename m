Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D53DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F186020659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiYpANy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F186020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIDQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so1517167plb.11;
        Tue, 04 Sep 2018 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amDUWHx9CIuzOcKbTAVVhSov5p8oHO7SGU2wtf8SFSk=;
        b=IiYpANy5zDIcNvocZEHJEEXJ88IulOnmCgGbMD/BlVfJld9U4rk58Ts8W7jt90mPDX
         NyMFRVkt5joAsufYcORy2ddK+Qh8q9nR4/0YHe3PtYj23A/iAvabKnw4hI9Ycpt5PqxA
         sm3NRbNwdsHSXIUFOUaoL2mdTiMGxubnZIqaiGXDAroRX3KdDDCr3wQ9XZog87DSMCTH
         DmHcMA/eDa/2XhB+zFH1HJMVwlErbyVqSPO8evkjipYDbCED1DMqurmAhY2hHp668eqE
         xWUD0Hac0bdOfS8ejss+d5NAK298ralij5TbMLbWrzTDj/xJ1xsDN154EpBPIifNr0UV
         o44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amDUWHx9CIuzOcKbTAVVhSov5p8oHO7SGU2wtf8SFSk=;
        b=TLZ/yexKM9ExJgnrBnXfcYbctKWg4l+NtsB3Aq+grQc0lJbDO2pv8ydWfwPAS00PKg
         Fw5nrowkIXp5QelnT3ld2FZA9+0k6tQt+pHGR30Pu5De6wjVkCLsXPmNyhPqBkp+BuXG
         e+UYUekrbIjABTsyTyManvdso6gRjneY/Uz7n47SKX1w8eHEEc+sCZjqdD/fmzXk0mDk
         cCsdNRloZ9z6LRjOPwkugD8QoSB+Vpa9ygmMoapa++0peKakOGtCvKxyva7cSJsortm3
         ej0MDcQYmyBsuMrTXfVnwXdVQVNqT64wETqmHgg9J6HEaltU6maxGHJ6Xx2ERynRindB
         ZiOA==
X-Gm-Message-State: APzg51AT7KEXPdyDJavkrSVQ93oKiH+8wJ7INFaVfBE4g7bL33Rn3EVN
        j42IFSUeMxEtVafoSwip+ABkOEkD
X-Google-Smtp-Source: ANB0VdZZsRbpfzlHGOIbfyRPI13LVIjrLOKYq6fxWbvR+DbF+Pw4OY+yRmFlFNcMVS64BY+vKrGpEA==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10-v6mr33533514plt.260.1536062155756;
        Tue, 04 Sep 2018 04:55:55 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:55:54 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v2 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
Date:   Tue,  4 Sep 2018 17:24:46 +0530
Message-Id: <1536062090-30446-12-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

This patch adds basic template for Marvell OcteonTX2's
CGX ethernet interface driver. Just the probe.
RVU AF driver will use APIs exported by this driver
for various things like PF to physical interface mapping,
loopback mode, interface stats etc. Hence marged both
drivers into a single module.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/Kconfig            |   3 +-
 drivers/soc/marvell/octeontx2/Makefile |   2 +-
 drivers/soc/marvell/octeontx2/cgx.c    | 102 +++++++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/cgx.h    |  22 +++++++
 drivers/soc/marvell/octeontx2/rvu.c    |  14 ++++-
 5 files changed, 140 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.h

diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
index 428d22e..8f36f3a 100644
--- a/drivers/soc/marvell/Kconfig
+++ b/drivers/soc/marvell/Kconfig
@@ -11,7 +11,8 @@ config OCTEONTX2_AF
 	tristate "OcteonTX2 RVU Admin Function driver"
 	select OCTEONTX2_MBOX
 	depends on ARM64 && PCI
-	help
+	---help---
 	  This driver supports Marvell's OcteonTX2 Resource Virtualization
 	  Unit's admin function manager which manages all RVU HW resources.
+
 endmenu
diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
index ac17cb9..8646421 100644
--- a/drivers/soc/marvell/octeontx2/Makefile
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_OCTEONTX2_MBOX) += octeontx2_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
 
 octeontx2_mbox-y := mbox.o
-octeontx2_af-y := rvu.o
+octeontx2_af-y := cgx.o rvu.o
diff --git a/drivers/soc/marvell/octeontx2/cgx.c b/drivers/soc/marvell/octeontx2/cgx.c
new file mode 100644
index 0000000..47aa4cb
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.c
@@ -0,0 +1,102 @@
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
+struct pci_driver cgx_driver = {
+	.name = DRV_NAME,
+	.id_table = cgx_id_table,
+	.probe = cgx_probe,
+	.remove = cgx_remove,
+};
diff --git a/drivers/soc/marvell/octeontx2/cgx.h b/drivers/soc/marvell/octeontx2/cgx.h
new file mode 100644
index 0000000..a7d4b39
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx.h
@@ -0,0 +1,22 @@
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
+extern struct pci_driver cgx_driver;
+
+#endif /* CGX_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index 40684c9..daa6fd3 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/sysfs.h>
 
+#include "cgx.h"
 #include "rvu.h"
 #include "rvu_reg.h"
 
@@ -1605,14 +1606,25 @@ static struct pci_driver rvu_driver = {
 
 static int __init rvu_init_module(void)
 {
+	int err;
+
 	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
 
-	return pci_register_driver(&rvu_driver);
+	err = pci_register_driver(&cgx_driver);
+	if (err < 0)
+		return err;
+
+	err =  pci_register_driver(&rvu_driver);
+	if (err < 0)
+		pci_unregister_driver(&cgx_driver);
+
+	return err;
 }
 
 static void __exit rvu_cleanup_module(void)
 {
 	pci_unregister_driver(&rvu_driver);
+	pci_unregister_driver(&cgx_driver);
 }
 
 module_init(rvu_init_module);
-- 
2.7.4

