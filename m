Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0A20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRnJzdBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC0A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIDUyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:54:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46500 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:54:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so1904067pga.13;
        Tue, 04 Sep 2018 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tz7EXMRCLNE4Q1a1uk0TzX8yxNperzmq/A51ccPZafM=;
        b=lRnJzdBZd0jqvH1wsrcHhUickA74fgEk/hWnfTw12CvIKJlXtEY744IieTy4/nMsfn
         f/NBdHQqY1lOqMnLMzoz4yrJQ8jff5y67OeFz901O+AMrBxRfVjHh/LI8yeMyp+qtlTk
         v18ZTQGdUamCOb6Ao/83k9k0NOF6KFGdybPBPiD1Gz1NHnvZoYaRKPbswb7H59y5MVPV
         rsYH8yMDkTXXZmQB0XUMYBiVAT3eDBmYPfzwpXOyxFqkSCLnYoasvqy75cawXpF4VrtR
         ti4UGg9PRsper5iUQQCej8rBc3WY22VbO4MNiuWEIJsLEREEHY35vUuCnbWngQnvT2vH
         KaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tz7EXMRCLNE4Q1a1uk0TzX8yxNperzmq/A51ccPZafM=;
        b=SDsdG419P/prXVypp9mmTJ4Q0cWyzm6LKIBpgYXOC2XJXDyOMv01nFQYc7KNGdKurQ
         Lcl6ijaNEzdWLIAt+A0Dk1U0HN8uTJqoHsAxA6T69Dd4N6UvFMVPH6F0F5P7e8DjYp1R
         ZCcCxLvPGX1R2FxDSH0e5RstNcmJRkowetp2gazQl6VgFsV5LQ2LF55CBBBQYBjz4VHD
         LD3WN8hoLhF9lwcuKpQk+KJUUJ4CHoylsG9B6XJeo91KmOgGLbqYHIuh9gc1KS7hqkoR
         W80XGlEYmhAoKuPD1f7yNg/AXO4d9RVeJBu2LQDOMvr2ofXMlZ6npFJuJ//FGZeEGnJw
         9f8Q==
X-Gm-Message-State: APzg51BJQIt7vT/n1lxJqVeVx+bdoDLHCkHdA/wOTrV8s2GPJtkH7JUL
        t5mSg++N5Mzuyk2UGdyCPjrchpcE
X-Google-Smtp-Source: ANB0VdYeOeb4+Oi4litQQfs0elMpXD4CP4SMrciI3ZWCFLhsZs+xpkfhjUzJrre/Vx8j64jYirWFsA==
X-Received: by 2002:a63:4e5f:: with SMTP id o31-v6mr31931477pgl.256.1536078541712;
        Tue, 04 Sep 2018 09:29:01 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:29:00 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v3 02/15] soc: octeontx2: Reset all RVU blocks
Date:   Tue,  4 Sep 2018 21:58:32 +0530
Message-Id: <1536078525-31534-3-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

Go through all BLKADDRs and check which ones are implemented
on this silicon and do a HW reset of each implemented block.
Also added all RVU AF and PF register offsets.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/octeontx2/rvu.c        |  78 ++++++++++++++++++++
 drivers/soc/marvell/octeontx2/rvu.h        |  37 ++++++++++
 drivers/soc/marvell/octeontx2/rvu_reg.h    | 113 +++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/rvu_struct.h |  36 +++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_reg.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_struct.h

diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index 5af4da6..d40fabf 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -16,6 +16,7 @@
 #include <linux/sysfs.h>
 
 #include "rvu.h"
+#include "rvu_reg.h"
 
 #define DRV_NAME	"octeontx2-af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -33,6 +34,70 @@ MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 MODULE_DEVICE_TABLE(pci, rvu_id_table);
 
+/* Poll a RVU block's register 'offset', for a 'zero'
+ * or 'nonzero' at bits specified by 'mask'
+ */
+int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero)
+{
+	void __iomem *reg;
+	int timeout = 100;
+	u64 reg_val;
+
+	reg = rvu->afreg_base + ((block << 28) | offset);
+	while (timeout) {
+		reg_val = readq(reg);
+		if (zero && !(reg_val & mask))
+			return 0;
+		if (!zero && (reg_val & mask))
+			return 0;
+		udelay(1);
+		cpu_relax();
+		timeout--;
+	}
+	return -EBUSY;
+}
+
+static void rvu_check_block_implemented(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	struct rvu_block *block;
+	int blkid;
+	u64 cfg;
+
+	/* For each block check if 'implemented' bit is set */
+	for (blkid = 0; blkid < BLK_COUNT; blkid++) {
+		block = &hw->block[blkid];
+		cfg = rvupf_read64(rvu, RVU_PF_BLOCK_ADDRX_DISC(blkid));
+		if (cfg & BIT_ULL(11))
+			block->implemented = true;
+	}
+}
+
+static void rvu_block_reset(struct rvu *rvu, int blkaddr, u64 rst_reg)
+{
+	struct rvu_block *block = &rvu->hw->block[blkaddr];
+
+	if (!block->implemented)
+		return;
+
+	rvu_write64(rvu, blkaddr, rst_reg, BIT_ULL(0));
+	rvu_poll_reg(rvu, blkaddr, rst_reg, BIT_ULL(63), true);
+}
+
+static void rvu_reset_all_blocks(struct rvu *rvu)
+{
+	/* Do a HW reset of all RVU blocks */
+	rvu_block_reset(rvu, BLKADDR_NPA, NPA_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_NIX0, NIX_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_NPC, NPC_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_SSO, SSO_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_TIM, TIM_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_CPT0, CPT_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_NDC0, NDC_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_NDC1, NDC_AF_BLK_RST);
+	rvu_block_reset(rvu, BLKADDR_NDC2, NDC_AF_BLK_RST);
+}
+
 static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -43,6 +108,12 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!rvu)
 		return -ENOMEM;
 
+	rvu->hw = devm_kzalloc(dev, sizeof(struct rvu_hwinfo), GFP_KERNEL);
+	if (!rvu->hw) {
+		devm_kfree(dev, rvu);
+		return -ENOMEM;
+	}
+
 	pci_set_drvdata(pdev, rvu);
 	rvu->pdev = pdev;
 	rvu->dev = &pdev->dev;
@@ -80,6 +151,11 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_release_regions;
 	}
 
+	/* Check which blocks the HW supports */
+	rvu_check_block_implemented(rvu);
+
+	rvu_reset_all_blocks(rvu);
+
 	return 0;
 
 err_release_regions:
@@ -88,6 +164,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_disable_device(pdev);
 err_freemem:
 	pci_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, rvu->hw);
 	devm_kfree(dev, rvu);
 	return err;
 }
@@ -100,6 +177,7 @@ static void rvu_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 
+	devm_kfree(&pdev->dev, rvu->hw);
 	devm_kfree(&pdev->dev, rvu);
 }
 
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
index 4a4b0ad..e2c54d0 100644
--- a/drivers/soc/marvell/octeontx2/rvu.h
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -11,6 +11,8 @@
 #ifndef RVU_H
 #define RVU_H
 
+#include "rvu_struct.h"
+
 /* PCI device IDs */
 #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
 
@@ -21,11 +23,46 @@
 
 #define NAME_SIZE				32
 
+struct rvu_block {
+	bool implemented;
+};
+
+struct rvu_hwinfo {
+	struct rvu_block block[BLK_COUNT]; /* Block info */
+};
+
 struct rvu {
 	void __iomem		*afreg_base;
 	void __iomem		*pfreg_base;
 	struct pci_dev		*pdev;
 	struct device		*dev;
+	struct rvu_hwinfo       *hw;
 };
 
+static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
+{
+	writeq(val, rvu->afreg_base + ((block << 28) | offset));
+}
+
+static inline u64 rvu_read64(struct rvu *rvu, u64 block, u64 offset)
+{
+	return readq(rvu->afreg_base + ((block << 28) | offset));
+}
+
+static inline void rvupf_write64(struct rvu *rvu, u64 offset, u64 val)
+{
+	writeq(val, rvu->pfreg_base + offset);
+}
+
+static inline u64 rvupf_read64(struct rvu *rvu, u64 offset)
+{
+	return readq(rvu->pfreg_base + offset);
+}
+
+/* Function Prototypes
+ * RVU
+ */
+
+int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero);
+
 #endif /* RVU_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu_reg.h b/drivers/soc/marvell/octeontx2/rvu_reg.h
new file mode 100644
index 0000000..e7abd7e
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/rvu_reg.h
@@ -0,0 +1,113 @@
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
+#ifndef RVU_REG_H
+#define RVU_REG_H
+
+/* Admin function registers */
+#define RVU_AF_MSIXTR_BASE                  (0x10)
+#define RVU_AF_ECO                          (0x20)
+#define RVU_AF_BLK_RST                      (0x30)
+#define RVU_AF_PF_BAR4_ADDR                 (0x40)
+#define RVU_AF_RAS                          (0x100)
+#define RVU_AF_RAS_W1S                      (0x108)
+#define RVU_AF_RAS_ENA_W1S                  (0x110)
+#define RVU_AF_RAS_ENA_W1C                  (0x118)
+#define RVU_AF_GEN_INT                      (0x120)
+#define RVU_AF_GEN_INT_W1S                  (0x128)
+#define RVU_AF_GEN_INT_ENA_W1S              (0x130)
+#define RVU_AF_GEN_INT_ENA_W1C              (0x138)
+#define	RVU_AF_AFPF_MBOX0		    (0x02000)
+#define	RVU_AF_AFPF_MBOX1		    (0x02008)
+#define RVU_AF_AFPFX_MBOXX(a, b)            (0x2000 | (a) << 4 | (b) << 3)
+#define RVU_AF_PFME_STATUS                  (0x2800)
+#define RVU_AF_PFTRPEND                     (0x2810)
+#define RVU_AF_PFTRPEND_W1S                 (0x2820)
+#define RVU_AF_PF_RST                       (0x2840)
+#define RVU_AF_HWVF_RST                     (0x2850)
+#define RVU_AF_PFAF_MBOX_INT                (0x2880)
+#define RVU_AF_PFAF_MBOX_INT_W1S            (0x2888)
+#define RVU_AF_PFAF_MBOX_INT_ENA_W1S        (0x2890)
+#define RVU_AF_PFAF_MBOX_INT_ENA_W1C        (0x2898)
+#define RVU_AF_PFFLR_INT                    (0x28a0)
+#define RVU_AF_PFFLR_INT_W1S                (0x28a8)
+#define RVU_AF_PFFLR_INT_ENA_W1S            (0x28b0)
+#define RVU_AF_PFFLR_INT_ENA_W1C            (0x28b8)
+#define RVU_AF_PFME_INT                     (0x28c0)
+#define RVU_AF_PFME_INT_W1S                 (0x28c8)
+#define RVU_AF_PFME_INT_ENA_W1S             (0x28d0)
+#define RVU_AF_PFME_INT_ENA_W1C             (0x28d8)
+
+/* Admin function's privileged PF/VF registers */
+#define RVU_PRIV_CONST                      (0x8000000)
+#define RVU_PRIV_GEN_CFG                    (0x8000010)
+#define RVU_PRIV_CLK_CFG                    (0x8000020)
+#define RVU_PRIV_ACTIVE_PC                  (0x8000030)
+#define RVU_PRIV_PFX_CFG(a)                 (0x8000100 | (a) << 16)
+#define RVU_PRIV_PFX_MSIX_CFG(a)            (0x8000110 | (a) << 16)
+#define RVU_PRIV_PFX_ID_CFG(a)              (0x8000120 | (a) << 16)
+#define RVU_PRIV_PFX_INT_CFG(a)             (0x8000200 | (a) << 16)
+#define RVU_PRIV_PFX_NIX_CFG                (0x8000300)
+#define RVU_PRIV_PFX_NPA_CFG		    (0x8000310)
+#define RVU_PRIV_PFX_SSO_CFG                (0x8000320)
+#define RVU_PRIV_PFX_SSOW_CFG               (0x8000330)
+#define RVU_PRIV_PFX_TIM_CFG                (0x8000340)
+#define RVU_PRIV_PFX_CPT_CFG                (0x8000350)
+#define RVU_PRIV_BLOCK_TYPEX_REV(a)         (0x8000400 | (a) << 3)
+#define RVU_PRIV_HWVFX_INT_CFG(a)           (0x8001280 | (a) << 16)
+#define RVU_PRIV_HWVFX_NIX_CFG              (0x8001300)
+#define RVU_PRIV_HWVFX_NPA_CFG              (0x8001310)
+#define RVU_PRIV_HWVFX_SSO_CFG              (0x8001320)
+#define RVU_PRIV_HWVFX_SSOW_CFG             (0x8001330)
+#define RVU_PRIV_HWVFX_TIM_CFG              (0x8001340)
+#define RVU_PRIV_HWVFX_CPT_CFG              (0x8001350)
+
+/* RVU PF registers */
+#define	RVU_PF_VFX_PFVF_MBOX0		    (0x00000)
+#define	RVU_PF_VFX_PFVF_MBOX1		    (0x00008)
+#define RVU_PF_VFX_PFVF_MBOXX(a, b)         (0x0 | (a) << 12 | (b) << 3)
+#define RVU_PF_VF_BAR4_ADDR                 (0x10)
+#define RVU_PF_BLOCK_ADDRX_DISC(a)          (0x200 | (a) << 3)
+#define RVU_PF_VFME_STATUSX(a)              (0x800 | (a) << 3)
+#define RVU_PF_VFTRPENDX(a)                 (0x820 | (a) << 3)
+#define RVU_PF_VFTRPEND_W1SX(a)             (0x840 | (a) << 3)
+#define RVU_PF_VFPF_MBOX_INTX(a)            (0x880 | (a) << 3)
+#define RVU_PF_VFPF_MBOX_INT_W1SX(a)        (0x8A0 | (a) << 3)
+#define RVU_PF_VFPF_MBOX_INT_ENA_W1SX(a)    (0x8C0 | (a) << 3)
+#define RVU_PF_VFPF_MBOX_INT_ENA_W1CX(a)    (0x8E0 | (a) << 3)
+#define RVU_PF_VFFLR_INTX(a)                (0x900 | (a) << 3)
+#define RVU_PF_VFFLR_INT_W1SX(a)            (0x920 | (a) << 3)
+#define RVU_PF_VFFLR_INT_ENA_W1SX(a)        (0x940 | (a) << 3)
+#define RVU_PF_VFFLR_INT_ENA_W1CX(a)        (0x960 | (a) << 3)
+#define RVU_PF_VFME_INTX(a)                 (0x980 | (a) << 3)
+#define RVU_PF_VFME_INT_W1SX(a)             (0x9A0 | (a) << 3)
+#define RVU_PF_VFME_INT_ENA_W1SX(a)         (0x9C0 | (a) << 3)
+#define RVU_PF_VFME_INT_ENA_W1CX(a)         (0x9E0 | (a) << 3)
+#define RVU_PF_PFAF_MBOX0                   (0xC00)
+#define RVU_PF_PFAF_MBOX1                   (0xC08)
+#define RVU_PF_PFAF_MBOXX(a)                (0xC00 | (a) << 3)
+#define RVU_PF_INT                          (0xc20)
+#define RVU_PF_INT_W1S                      (0xc28)
+#define RVU_PF_INT_ENA_W1S                  (0xc30)
+#define RVU_PF_INT_ENA_W1C                  (0xc38)
+#define RVU_PF_MSIX_VECX_ADDR(a)            (0x000 | (a) << 4)
+#define RVU_PF_MSIX_VECX_CTL(a)             (0x008 | (a) << 4)
+#define RVU_PF_MSIX_PBAX(a)                 (0xF0000 | (a) << 3)
+
+
+#define NPA_AF_BLK_RST                  (0x0000)
+#define NIX_AF_BLK_RST                  (0x00B0)
+#define SSO_AF_BLK_RST                  (0x10f8)
+#define TIM_AF_BLK_RST                  (0x10)
+#define CPT_AF_BLK_RST                  (0x46000)
+#define NDC_AF_BLK_RST                  (0x002F0)
+#define NPC_AF_BLK_RST                  (0x00040)
+
+#endif /* RVU_REG_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu_struct.h b/drivers/soc/marvell/octeontx2/rvu_struct.h
new file mode 100644
index 0000000..4122559
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/rvu_struct.h
@@ -0,0 +1,36 @@
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
+#ifndef RVU_STRUCT_H
+#define RVU_STRUCT_H
+
+/*
+ * RVU Block Address Enumeration
+ */
+enum rvu_block_addr_e {
+	BLKADDR_RVUM    = 0x0ULL,
+	BLKADDR_LMT     = 0x1ULL,
+	BLKADDR_MSIX    = 0x2ULL,
+	BLKADDR_NPA     = 0x3ULL,
+	BLKADDR_NIX0    = 0x4ULL,
+	BLKADDR_NIX1    = 0x5ULL,
+	BLKADDR_NPC     = 0x6ULL,
+	BLKADDR_SSO     = 0x7ULL,
+	BLKADDR_SSOW    = 0x8ULL,
+	BLKADDR_TIM     = 0x9ULL,
+	BLKADDR_CPT0    = 0xaULL,
+	BLKADDR_CPT1    = 0xbULL,
+	BLKADDR_NDC0    = 0xcULL,
+	BLKADDR_NDC1    = 0xdULL,
+	BLKADDR_NDC2    = 0xeULL,
+	BLK_COUNT	= 0xfULL,
+};
+
+#endif /* RVU_STRUCT_H */
-- 
2.7.4

