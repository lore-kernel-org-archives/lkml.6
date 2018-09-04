Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65913C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9162075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ3sSvAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9162075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIDQUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:50 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:42347 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:49 -0400
Received: by mail-pg1-f176.google.com with SMTP id y4-v6so1546312pgp.9;
        Tue, 04 Sep 2018 04:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ok46glfscrXvgjfbbqedbFJKNjJSsbbGdiWMymO54ZE=;
        b=DJ3sSvALHjJtwdbyUvGUn8/yZI014ru/Vv7lx97yaukAUQmHYnUNhSU7WEU+SGyCbv
         MfGfdmhW3ZDWYzWac6KRue8fg+NAZdhT+YJM8dc137XgIj/WNPcdJLw/Y5LCh0z9ticG
         C5bzGCZxvUAk91QeCFQJkrPz549jxzTTUv0gmINO39B8V8D/35nOcP3E9bp4+nd9x9p0
         9iWVgsP2VnrQ8Nyxy4b14xo/ojdSzwZnwCIfhTwmS6x/BZeJ+L7mW5BGtrwsTTcmIzrx
         roF6M1bw/UBggJQJb3C/4K3jnpa5DsiuvRtjquWwRqhtOaOXcfwgh2awayyqaE1E39Ck
         GtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ok46glfscrXvgjfbbqedbFJKNjJSsbbGdiWMymO54ZE=;
        b=CeaQ4dEzUuJ7cNhxFlpFaRNpOm4mG80NHFTOIvVgU1Uuevkjieeh1jjAE4WW8ELxOC
         AAjIu3pcRb3Rxc5KMIGvstc0YzFVAkVWE0LmnJnvKIu/+lFiVfoOPqQ9YJSboHw84U2F
         NLvOQ8r9VN/noqDVcULEOMcZvrWAGvCUodjkQLH6SBgEHtSy8O1vtjXMaYgoYasV9YBP
         v2ipV4jL1MOVQ+wcKezBcx+wyCKr5aphtlPPdIeCHrBx3+DGFZj9Ogwoag3Zf1LUx6RE
         iG7ZUv/mvDlWV1/9P2HdfUel98JiAY6BhMcTgnExjNUUYW3k8Tl0SzB7Kysm7Ks8o6Mv
         Xp+g==
X-Gm-Message-State: APzg51CCRNqXk7ZqZNlKjjKgPiR7uCE8IwBHaxwdySWIDX2C3mO4A4yV
        ar613Cr4pA5Zg0pECE47eVlW/ZDg
X-Google-Smtp-Source: ANB0VdbmRC4XGJt/Iry2hdPSeB5jGNxl4RC+qbuCv32NO/EE5DLmeZVTKoYDn1thNlHcsK6QKPr/Dw==
X-Received: by 2002:a62:2a48:: with SMTP id q69-v6mr34333427pfq.86.1536062159505;
        Tue, 04 Sep 2018 04:55:59 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:55:58 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>
Subject: [PATCH v2 12/15] soc: octeontx2: Set RVU PFs to CGX LMACs mapping
Date:   Tue,  4 Sep 2018 17:24:47 +0530
Message-Id: <1536062090-30446-13-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linu Cherian <lcherian@marvell.com>

Each of the enabled CGX LMAC is considered a physical
interface and RVU PFs are mapped to these. VFs of these
SRIOV PFs will be virtual interfaces and share CGX LMAC
along with PF.

This mapping info will be used later on for Rx/Tx pkt steering.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/soc/marvell/octeontx2/Makefile  |  2 +-
 drivers/soc/marvell/octeontx2/cgx.c     | 59 ++++++++++++++++++++
 drivers/soc/marvell/octeontx2/cgx.h     | 15 ++++-
 drivers/soc/marvell/octeontx2/rvu.c     |  4 ++
 drivers/soc/marvell/octeontx2/rvu.h     | 12 ++++
 drivers/soc/marvell/octeontx2/rvu_cgx.c | 97 +++++++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_cgx.c

diff --git a/drivers/soc/marvell/octeontx2/Makefile b/drivers/soc/marvell/octeontx2/Makefile
index 8646421..eaac264 100644
--- a/drivers/soc/marvell/octeontx2/Makefile
+++ b/drivers/soc/marvell/octeontx2/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_OCTEONTX2_MBOX) += octeontx2_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += octeontx2_af.o
 
 octeontx2_mbox-y := mbox.o
-octeontx2_af-y := cgx.o rvu.o
+octeontx2_af-y := cgx.o rvu.o rvu_cgx.o
diff --git a/drivers/soc/marvell/octeontx2/cgx.c b/drivers/soc/marvell/octeontx2/cgx.c
index 47aa4cb..c5e0ebb 100644
--- a/drivers/soc/marvell/octeontx2/cgx.c
+++ b/drivers/soc/marvell/octeontx2/cgx.c
@@ -29,8 +29,12 @@ struct cgx {
 	void __iomem		*reg_base;
 	struct pci_dev		*pdev;
 	u8			cgx_id;
+	u8			lmac_count;
+	struct list_head	cgx_list;
 };
 
+static LIST_HEAD(cgx_list);
+
 /* Supported devices */
 static const struct pci_device_id cgx_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
@@ -43,6 +47,53 @@ MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 MODULE_DEVICE_TABLE(pci, cgx_id_table);
 
+static u64 cgx_read(struct cgx *cgx, u64 lmac, u64 offset)
+{
+	return readq(cgx->reg_base + (lmac << 18) + offset);
+}
+
+int cgx_get_cgx_cnt(void)
+{
+	struct cgx *cgx_dev;
+	int count = 0;
+
+	list_for_each_entry(cgx_dev, &cgx_list, cgx_list)
+		count++;
+
+	return count;
+}
+EXPORT_SYMBOL(cgx_get_cgx_cnt);
+
+int cgx_get_lmac_cnt(void *cgxd)
+{
+	struct cgx *cgx = cgxd;
+
+	if (!cgx)
+		return -ENODEV;
+
+	return cgx->lmac_count;
+}
+EXPORT_SYMBOL(cgx_get_lmac_cnt);
+
+void *cgx_get_pdata(int cgx_id)
+{
+	struct cgx *cgx_dev;
+
+	list_for_each_entry(cgx_dev, &cgx_list, cgx_list) {
+		if (cgx_dev->cgx_id == cgx_id)
+			return cgx_dev;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(cgx_get_pdata);
+
+static void cgx_lmac_init(struct cgx *cgx)
+{
+	cgx->lmac_count = cgx_read(cgx, 0, CGXX_CMRX_RX_LMACS) & 0x7;
+	if (cgx->lmac_count > MAX_LMAC_PER_CGX)
+		cgx->lmac_count = MAX_LMAC_PER_CGX;
+}
+
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int err;
@@ -77,9 +128,14 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_release_regions;
 	}
 
+	list_add(&cgx->cgx_list, &cgx_list);
+	cgx->cgx_id = cgx_get_cgx_cnt() - 1;
+	cgx_lmac_init(cgx);
+
 	return 0;
 
 err_release_regions:
+	list_del(&cgx->cgx_list);
 	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
@@ -89,6 +145,9 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void cgx_remove(struct pci_dev *pdev)
 {
+	struct cgx *cgx = pci_get_drvdata(pdev);
+
+	list_del(&cgx->cgx_list);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
diff --git a/drivers/soc/marvell/octeontx2/cgx.h b/drivers/soc/marvell/octeontx2/cgx.h
index a7d4b39..acdc16e 100644
--- a/drivers/soc/marvell/octeontx2/cgx.h
+++ b/drivers/soc/marvell/octeontx2/cgx.h
@@ -12,11 +12,22 @@
 #define CGX_H
 
  /* PCI device IDs */
-#define	PCI_DEVID_OCTEONTX2_CGX			0xA059
+#define	PCI_DEVID_OCTEONTX2_CGX		0xA059
 
 /* PCI BAR nos */
-#define PCI_CFG_REG_BAR_NUM			0
+#define PCI_CFG_REG_BAR_NUM		0
+
+#define MAX_CGX				3
+#define MAX_LMAC_PER_CGX		4
+#define CGX_OFFSET(x)			((x) * MAX_LMAC_PER_CGX)
+
+/* Registers */
+#define CGXX_CMRX_RX_ID_MAP		0x060
+#define CGXX_CMRX_RX_LMACS		0x128
 
 extern struct pci_driver cgx_driver;
 
+int cgx_get_cgx_cnt(void);
+int cgx_get_lmac_cnt(void *cgxd);
+void *cgx_get_pdata(int cgx_id);
 #endif /* CGX_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index daa6fd3..faf7d0f 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -1558,6 +1558,10 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_hwsetup;
 
+	err = rvu_cgx_probe(rvu);
+	if (err)
+		goto err_mbox;
+
 	err = rvu_register_interrupts(rvu);
 	if (err)
 		goto err_mbox;
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
index 92c2022..385f597 100644
--- a/drivers/soc/marvell/octeontx2/rvu.h
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -100,6 +100,16 @@ struct rvu {
 	char			*irq_name;
 	bool			*irq_allocated;
 	dma_addr_t		msix_base_iova;
+
+	/* CGX */
+#define PF_CGXMAP_BASE		1 /* PF 0 is reserved for RVU PF */
+	u8			cgx_mapped_pfs;
+	u8			cgx_cnt; /* available cgx ports */
+	u8			*pf2cgxlmac_map; /* pf to cgx_lmac map */
+	u16			*cgxlmac2pf_map; /* bitmap of mapped pfs for
+						  * every cgx lmac port
+						  */
+	void			**cgx_idmap; /* cgx id to cgx data map table */
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -138,4 +148,6 @@ int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_get_blkaddr(struct rvu *rvu, int blktype, u16 pcifunc);
 int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero);
 
+/* CGX APIs */
+int rvu_cgx_probe(struct rvu *rvu);
 #endif /* RVU_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu_cgx.c b/drivers/soc/marvell/octeontx2/rvu_cgx.c
new file mode 100644
index 0000000..bf81507
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/rvu_cgx.c
@@ -0,0 +1,97 @@
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
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "rvu.h"
+#include "cgx.h"
+
+static inline u8 cgxlmac_id_to_bmap(u8 cgx_id, u8 lmac_id)
+{
+	return ((cgx_id & 0xF) << 4) | (lmac_id & 0xF);
+}
+
+static void *rvu_cgx_pdata(u8 cgx_id, struct rvu *rvu)
+{
+	if (cgx_id >= rvu->cgx_cnt)
+		return NULL;
+
+	return rvu->cgx_idmap[cgx_id];
+}
+
+static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
+{
+	int cgx_cnt = rvu->cgx_cnt;
+	int cgx, lmac_cnt, lmac;
+	int pf = PF_CGXMAP_BASE;
+	int size;
+
+	if (!cgx_cnt)
+		return 0;
+
+	if (cgx_cnt > 0xF || MAX_LMAC_PER_CGX > 0xF)
+		return -EINVAL;
+
+	/* Alloc map table
+	 * An additional entry is required since PF id starts from 1 and
+	 * hence entry at offset 0 is invalid.
+	 */
+	size = (cgx_cnt * MAX_LMAC_PER_CGX + 1) * sizeof(u8);
+	rvu->pf2cgxlmac_map = devm_kzalloc(rvu->dev, size, GFP_KERNEL);
+	if (!rvu->pf2cgxlmac_map)
+		return -ENOMEM;
+
+	/* Initialize offset 0 with an invalid cgx and lmac id */
+	rvu->pf2cgxlmac_map[0] = 0xFF;
+
+	/* Reverse map table */
+	rvu->cgxlmac2pf_map = devm_kzalloc(rvu->dev,
+				  cgx_cnt * MAX_LMAC_PER_CGX * sizeof(u16),
+				  GFP_KERNEL);
+	if (!rvu->cgxlmac2pf_map)
+		return -ENOMEM;
+
+	rvu->cgx_mapped_pfs = 0;
+	for (cgx = 0; cgx < cgx_cnt; cgx++) {
+		lmac_cnt = cgx_get_lmac_cnt(rvu_cgx_pdata(cgx, rvu));
+		for (lmac = 0; lmac < lmac_cnt; lmac++, pf++) {
+			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
+			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
+			rvu->cgx_mapped_pfs++;
+		}
+	}
+	return 0;
+}
+
+int rvu_cgx_probe(struct rvu *rvu)
+{
+	int i;
+
+	/* find available cgx ports */
+	rvu->cgx_cnt = cgx_get_cgx_cnt();
+	if (!rvu->cgx_cnt) {
+		dev_info(rvu->dev, "No CGX devices found!\n");
+		return -ENODEV;
+	}
+
+	rvu->cgx_idmap = devm_kzalloc(rvu->dev, rvu->cgx_cnt * sizeof(void *),
+				      GFP_KERNEL);
+	if (!rvu->cgx_idmap)
+		return -ENOMEM;
+
+	/* Initialize the cgxdata table */
+	for (i = 0; i < rvu->cgx_cnt; i++)
+		rvu->cgx_idmap[i] = cgx_get_pdata(i);
+
+	/* Map CGX LMAC interfaces to RVU PFs */
+	return rvu_map_cgx_lmac_pf(rvu);
+}
-- 
2.7.4

