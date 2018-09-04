Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78A72075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSpbN5Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeIDQUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46104 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so1563762pfn.13;
        Tue, 04 Sep 2018 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sh7WgnBkNpjBKi7k7Mnms1wYXtEZwZu4p6CKItdpI0g=;
        b=CSpbN5DdzGG5OSbwGKyKZHplfe5OHOYg6/2oAEYtXCOiMZTrK5skl2fSMiEmviIDNU
         RZNZNrEcxlpsh6fkzF/5NljpC5KJNV/cKx2QM9eHc0nhDJKcz13WUI+mfUir9qm+id70
         XKn0S2J0yEDs0zBPNsQG/AgEVpMc1QC1VsrQZtXwEgBcBYRK5E/FzLlvWJVm/a20C8Og
         qSxbKf0Q4gqy2djrfn33GI1DJkNMX5ET1Ds4rAYJNoGpzkZZuP5XtD6hyiuCNbl/vPDX
         p7Ong7e2LD0G0+cINMbkFGz6E4SvrLLBjHJD/93S88aL2ykC7k+5yQSrnvexXESNFN75
         paGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sh7WgnBkNpjBKi7k7Mnms1wYXtEZwZu4p6CKItdpI0g=;
        b=PpQFF9zkUY55eCtpJuQzGqVukIbNH40wle6WWDhVuna5Ka1YlrCwzzFw5HdX9D6BK9
         0V4FmEQEpqLjDK7+NnV46p46qsuNZcmC8PmcGe/amSrsPpuk5yTE05NKg0NOplRHR0sy
         Un8OQ1W2d57sUwvz7dwp+Z2gd9uPGaGl32CSrt1/sjfBeV4ZcDN9p/dfVa58b74WeIJk
         O/mucJ4hF9XGsHolXMG9hqwbiEeywHw1oIxGx1pza+jXEGMV8tUqT1QqG26m0dZgyZvC
         CboOoVBJjeZ+YfXUyCt8TlBkJZb3e/3lp4txb69ruCw1hLyb2WK6fc/umVqf1L+9orTU
         iU2g==
X-Gm-Message-State: APzg51COLBjJFAo1/SezpGZSEZ1eDIWy3SLAbg1++MsgkNEVvdllgBrG
        GsBZH+5UMyqHGfEV4l2KC613jzdi
X-Google-Smtp-Source: ANB0Vda/kxqy3kHQIsTdLYuEkk5XEWwmpBDl9eKvIOwcheDULz1V/oXMAmOgI7jth3RhfQ/NtSUrRg==
X-Received: by 2002:a62:e813:: with SMTP id c19-v6mr34618929pfi.124.1536062140770;
        Tue, 04 Sep 2018 04:55:40 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:55:39 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v2 07/15] soc: octeontx2: Scan blocks for LFs provisioned to PF/VF
Date:   Tue,  4 Sep 2018 17:24:42 +0530
Message-Id: <1536062090-30446-8-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

Scan all RVU blocks to find any 'LF to RVU PF/VF' mapping done by
low level firmware. If found any, mark them as used in respective
block's LF bitmap and also save mapped PF/VF's PF_FUNC info.

This is done to avoid reattaching a block LF to a different RVU PF/VF.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/octeontx2/rvu.c        | 148 ++++++++++++++++++++++++++++-
 drivers/soc/marvell/octeontx2/rvu.h        |  16 ++++
 drivers/soc/marvell/octeontx2/rvu_struct.h |  18 ++++
 3 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index 25f79bf..9539ab9 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -22,6 +22,8 @@
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
 #define DRV_VERSION	"1.0"
 
+static int rvu_get_hwvf(struct rvu *rvu, int pcifunc);
+
 /* Supported devices */
 static const struct pci_device_id rvu_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_RVU_AF) },
@@ -66,6 +68,91 @@ int rvu_alloc_bitmap(struct rsrc_bmap *rsrc)
 	return 0;
 }
 
+static void rvu_update_rsrc_map(struct rvu *rvu, struct rvu_pfvf *pfvf,
+				struct rvu_block *block, u16 pcifunc,
+				u16 lf, bool attach)
+{
+	int devnum, num_lfs = 0;
+	bool is_pf;
+	u64 reg;
+
+	if (lf >= block->lf.max) {
+		dev_err(&rvu->pdev->dev,
+			"%s: FATAL: LF %d is >= %s's max lfs i.e %d\n",
+			__func__, lf, block->name, block->lf.max);
+		return;
+	}
+
+	/* Check if this is for a RVU PF or VF */
+	if (pcifunc & RVU_PFVF_FUNC_MASK) {
+		is_pf = false;
+		devnum = rvu_get_hwvf(rvu, pcifunc);
+	} else {
+		is_pf = true;
+		devnum = rvu_get_pf(pcifunc);
+	}
+
+	block->fn_map[lf] = attach ? pcifunc : 0;
+
+	switch (block->type) {
+	case BLKTYPE_NPA:
+		pfvf->npalf = attach ? true : false;
+		num_lfs = pfvf->npalf;
+		break;
+	case BLKTYPE_NIX:
+		pfvf->nixlf = attach ? true : false;
+		num_lfs = pfvf->nixlf;
+		break;
+	case BLKTYPE_SSO:
+		attach ? pfvf->sso++ : pfvf->sso--;
+		num_lfs = pfvf->sso;
+		break;
+	case BLKTYPE_SSOW:
+		attach ? pfvf->ssow++ : pfvf->ssow--;
+		num_lfs = pfvf->ssow;
+		break;
+	case BLKTYPE_TIM:
+		attach ? pfvf->timlfs++ : pfvf->timlfs--;
+		num_lfs = pfvf->timlfs;
+		break;
+	case BLKTYPE_CPT:
+		attach ? pfvf->cptlfs++ : pfvf->cptlfs--;
+		num_lfs = pfvf->cptlfs;
+		break;
+	}
+
+	reg = is_pf ? block->pf_lfcnt_reg : block->vf_lfcnt_reg;
+	rvu_write64(rvu, BLKADDR_RVUM, reg | (devnum << 16), num_lfs);
+}
+
+inline int rvu_get_pf(u16 pcifunc)
+{
+	return (pcifunc >> RVU_PFVF_PF_SHIFT) & RVU_PFVF_PF_MASK;
+}
+
+static int rvu_get_hwvf(struct rvu *rvu, int pcifunc)
+{
+	int pf, func;
+	u64 cfg;
+
+	pf = rvu_get_pf(pcifunc);
+	func = pcifunc & RVU_PFVF_FUNC_MASK;
+
+	/* Get first HWVF attached to this PF */
+	cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf));
+
+	return ((cfg & 0xFFF) + func - 1);
+}
+
+struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
+{
+	/* Check if it is a PF or VF */
+	if (pcifunc & RVU_PFVF_FUNC_MASK)
+		return &rvu->hwvf[rvu_get_hwvf(rvu, pcifunc)];
+	else
+		return &rvu->pf[rvu_get_pf(pcifunc)];
+}
+
 static void rvu_check_block_implemented(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -107,6 +194,28 @@ static void rvu_reset_all_blocks(struct rvu *rvu)
 	rvu_block_reset(rvu, BLKADDR_NDC2, NDC_AF_BLK_RST);
 }
 
+static void rvu_scan_block(struct rvu *rvu, struct rvu_block *block)
+{
+	struct rvu_pfvf *pfvf;
+	u64 cfg;
+	int lf;
+
+	for (lf = 0; lf < block->lf.max; lf++) {
+		cfg = rvu_read64(rvu, block->addr,
+				 block->lfcfg_reg | (lf << block->lfshift));
+		if (!(cfg & BIT_ULL(63)))
+			continue;
+
+		/* Set this resource as being used */
+		__set_bit(lf, block->lf.bmap);
+
+		/* Get, to whom this LF is attached */
+		pfvf = rvu_get_pfvf(rvu, (cfg >> 8) & 0xFFFF);
+		rvu_update_rsrc_map(rvu, pfvf, block,
+				    (cfg >> 8) & 0xFFFF, lf, true);
+	}
+}
+
 static void rvu_free_hw_resources(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -124,7 +233,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	struct rvu_block *block;
-	int err;
+	int blkid, err;
 	u64 cfg;
 
 	/* Get HW supported max RVU PF & VF count */
@@ -140,6 +249,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	cfg = rvu_read64(rvu, BLKADDR_NPA, NPA_AF_CONST);
 	block->lf.max = (cfg >> 16) & 0xFFF;
 	block->addr = BLKADDR_NPA;
+	block->type = BLKTYPE_NPA;
 	block->lfshift = 8;
 	block->lookup_reg = NPA_AF_RVU_LF_CFG_DEBUG;
 	block->pf_lfcnt_reg = RVU_PRIV_PFX_NPA_CFG;
@@ -160,6 +270,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	cfg = rvu_read64(rvu, BLKADDR_NIX0, NIX_AF_CONST2);
 	block->lf.max = cfg & 0xFFF;
 	block->addr = BLKADDR_NIX0;
+	block->type = BLKTYPE_NIX;
 	block->lfshift = 8;
 	block->lookup_reg = NIX_AF_RVU_LF_CFG_DEBUG;
 	block->pf_lfcnt_reg = RVU_PRIV_PFX_NIX_CFG;
@@ -180,6 +291,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	cfg = rvu_read64(rvu, BLKADDR_SSO, SSO_AF_CONST);
 	block->lf.max = cfg & 0xFFFF;
 	block->addr = BLKADDR_SSO;
+	block->type = BLKTYPE_SSO;
 	block->multislot = true;
 	block->lfshift = 3;
 	block->lookup_reg = SSO_AF_RVU_LF_CFG_DEBUG;
@@ -200,6 +312,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 		goto tim;
 	block->lf.max = (cfg >> 56) & 0xFF;
 	block->addr = BLKADDR_SSOW;
+	block->type = BLKTYPE_SSOW;
 	block->multislot = true;
 	block->lfshift = 3;
 	block->lookup_reg = SSOW_AF_RVU_LF_HWS_CFG_DEBUG;
@@ -221,6 +334,7 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	cfg = rvu_read64(rvu, BLKADDR_TIM, TIM_AF_CONST);
 	block->lf.max = cfg & 0xFFFF;
 	block->addr = BLKADDR_TIM;
+	block->type = BLKTYPE_TIM;
 	block->multislot = true;
 	block->lfshift = 3;
 	block->lookup_reg = TIM_AF_RVU_LF_CFG_DEBUG;
@@ -238,10 +352,11 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	/* Init CPT LF's bitmap */
 	block = &hw->block[BLKADDR_CPT0];
 	if (!block->implemented)
-		return 0;
+		goto init;
 	cfg = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_CONSTANTS0);
 	block->lf.max = cfg & 0xFF;
 	block->addr = BLKADDR_CPT0;
+	block->type = BLKTYPE_CPT;
 	block->multislot = true;
 	block->lfshift = 3;
 	block->lookup_reg = CPT_AF_RVU_LF_CFG_DEBUG;
@@ -255,6 +370,35 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	if (err)
 		return err;
 
+init:
+	/* Allocate memory for PFVF data */
+	rvu->pf = devm_kcalloc(rvu->dev, hw->total_pfs,
+			       sizeof(struct rvu_pfvf), GFP_KERNEL);
+	if (!rvu->pf)
+		return -ENOMEM;
+
+	rvu->hwvf = devm_kcalloc(rvu->dev, hw->total_vfs,
+				 sizeof(struct rvu_pfvf), GFP_KERNEL);
+	if (!rvu->hwvf)
+		return -ENOMEM;
+
+	for (blkid = 0; blkid < BLK_COUNT; blkid++) {
+		block = &hw->block[blkid];
+		if (!block->lf.bmap)
+			continue;
+
+		/* Allocate memory for block LF/slot to pcifunc mapping info */
+		block->fn_map = devm_kcalloc(rvu->dev, block->lf.max,
+					     sizeof(u16), GFP_KERNEL);
+		if (!block->fn_map)
+			return -ENOMEM;
+
+		/* Scan all blocks to check if low level firmware has
+		 * already provisioned any of the resources to a PF/VF.
+		 */
+		rvu_scan_block(rvu, block);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
index 2fb9407..ce9897b 100644
--- a/drivers/soc/marvell/octeontx2/rvu.h
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -42,9 +42,11 @@ struct rsrc_bmap {
 
 struct rvu_block {
 	struct rsrc_bmap lf;
+	u16  *fn_map; /* LF to pcifunc mapping */
 	bool multislot;
 	bool implemented;
 	u8   addr;  /* RVU_BLOCK_ADDR_E */
+	u8   type;  /* RVU_BLOCK_TYPE_E */
 	u8   lfshift;
 	u64  lookup_reg;
 	u64  pf_lfcnt_reg;
@@ -55,6 +57,16 @@ struct rvu_block {
 	unsigned char name[NAME_SIZE];
 };
 
+/* Structure for per RVU func info ie PF/VF */
+struct rvu_pfvf {
+	bool		npalf; /* Only one NPALF per RVU_FUNC */
+	bool		nixlf; /* Only one NIXLF per RVU_FUNC */
+	u16		sso;
+	u16		ssow;
+	u16		cptlfs;
+	u16		timlfs;
+};
+
 struct rvu_hwinfo {
 	u8	total_pfs;   /* MAX RVU PFs HW supports */
 	u16	total_vfs;   /* Max RVU VFs HW supports */
@@ -69,6 +81,8 @@ struct rvu {
 	struct pci_dev		*pdev;
 	struct device		*dev;
 	struct rvu_hwinfo       *hw;
+	struct rvu_pfvf		*pf;
+	struct rvu_pfvf		*hwvf;
 
 	/* Mbox */
 	struct otx2_mbox	mbox;
@@ -107,5 +121,7 @@ static inline u64 rvupf_read64(struct rvu *rvu, u64 offset)
 
 int rvu_alloc_bitmap(struct rsrc_bmap *rsrc);
 int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero);
+int rvu_get_pf(u16 pcifunc);
+struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 
 #endif /* RVU_H */
diff --git a/drivers/soc/marvell/octeontx2/rvu_struct.h b/drivers/soc/marvell/octeontx2/rvu_struct.h
index 1dc1518..77ac751 100644
--- a/drivers/soc/marvell/octeontx2/rvu_struct.h
+++ b/drivers/soc/marvell/octeontx2/rvu_struct.h
@@ -33,6 +33,24 @@ enum rvu_block_addr_e {
 	BLK_COUNT	= 0xfULL,
 };
 
+/*
+ * RVU Block Type Enumeration
+ */
+enum rvu_block_type_e {
+	BLKTYPE_RVUM = 0x0,
+	BLKTYPE_MSIX = 0x1,
+	BLKTYPE_LMT  = 0x2,
+	BLKTYPE_NIX  = 0x3,
+	BLKTYPE_NPA  = 0x4,
+	BLKTYPE_NPC  = 0x5,
+	BLKTYPE_SSO  = 0x6,
+	BLKTYPE_SSOW = 0x7,
+	BLKTYPE_TIM  = 0x8,
+	BLKTYPE_CPT  = 0x9,
+	BLKTYPE_NDC  = 0xa,
+	BLKTYPE_MAX  = 0xa,
+};
+
 /* RVU Admin function Interrupt Vector Enumeration */
 enum rvu_af_int_vec_e {
 	RVU_AF_INT_VEC_POISON = 0x0,
-- 
2.7.4

