Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF90C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303EB20891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzVPb+Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303EB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeH1OtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:49:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45329 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeH1OtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:49:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4-v6so567470pgv.12;
        Tue, 28 Aug 2018 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BShs/B7WbmjGF339oaZcnn6uTeYWtvRJSOdxcgoD9c4=;
        b=AzVPb+GvYrITOgWhPr3GMeSUDIHQ0oS0z8Mlb+FS2keNEI8KQ8Q2I2+qT6uHAUWNve
         kO1eOe9mj24wbWUyRMaQot3EYRnFpK2U5Gjk5BYZrUqqCIPG7apguPPd8KRRqJ+Twrk/
         AcPc5WDeXq6mC8dMkfAU7TGOk/NZuePwOjTnMKgIT9DHHEMq8eeMF1hx6G5qqhnillX/
         D0NeQrMct7OsBQqfod8AJRYyGce4SBkjlm2WXdpx1IuHZRbl97TMhuJxCBY6Kj5rXVwa
         GzlklquWRz+YP4kIseo9dDPHUtfqRCxR/FVxjigerbeV+swAWmUtTrOUEDkeDlrn2Qjy
         crAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BShs/B7WbmjGF339oaZcnn6uTeYWtvRJSOdxcgoD9c4=;
        b=hbXlGYkaaivQ9Ffy+ZbYcuLMsNh4LRxXA1y01OoFOzTy+kfb3H6Dl2eCe6u29n7RAp
         W3eAILoWhTyfUldSPH8F2znqYfzieBjIrrTXldoIm/uC1ANdscr9KTa4Jtz7+Hj/1vns
         ZzYXAs3mCbMqwyGW22D+o4sYvaCRKbeX9TsYksyXTnwBSrPg8RE1xLRYa9DFCiqh0i3T
         buggsaKIzC/AKW+2f2X19gJ8uEPUu3rMiv7o7/fZdUTnSXGDyMcRV+lYQiZ0RmFy2TGt
         GBnRRAJlOmT4wGvvxYXE/Oo4cAfdCEoDTm3lCuW2OKxDvYw/MbAye6yoUIGFW0KLGbQb
         3ukw==
X-Gm-Message-State: APzg51BuEDsYxDGATPKxzYGRl3vLoD5CgAeQOfBPjv4NvesDkhcw/Ywt
        kbTnyPY7a2bk6GpqEfVNiCtchsN9
X-Google-Smtp-Source: ANB0VdYe4r9tGq4w9Y0MBdvDYvrBSBr+pYf5wwSWubBePElqxHXUNyvD/9P4T6BeVOyNJ7yIP2oZtA==
X-Received: by 2002:a65:420c:: with SMTP id c12-v6mr996031pgq.405.1535453890964;
        Tue, 28 Aug 2018 03:58:10 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:58:10 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
Date:   Tue, 28 Aug 2018 16:27:13 +0530
Message-Id: <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geetha sowjanya <gakula@marvell.com>

HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
create a IOMMU mapping for the physcial address configured by
firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/soc/marvell/octeontx2/rvu.c | 33 ++++++++++++++++++++++++++++++---
 drivers/soc/marvell/octeontx2/rvu.h |  1 +
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index 8ac3524..40684c9 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -442,9 +442,10 @@ static int rvu_setup_msix_resources(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf, vf, numvfs, hwvf, err;
+	int nvecs, offset, max_msix;
 	struct rvu_pfvf *pfvf;
-	int nvecs, offset;
-	u64 cfg;
+	u64 cfg, phy_addr;
+	dma_addr_t iova;
 
 	for (pf = 0; pf < hw->total_pfs; pf++) {
 		cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf));
@@ -523,6 +524,22 @@ static int rvu_setup_msix_resources(struct rvu *rvu)
 		}
 	}
 
+	/* HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
+	 * create a IOMMU mapping for the physcial address configured by
+	 * firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
+	 */
+	cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_CONST);
+	max_msix = cfg & 0xFFFFF;
+	phy_addr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_MSIXTR_BASE);
+	iova = dma_map_single(rvu->dev, (void *)phy_addr,
+			      max_msix * PCI_MSIX_ENTRY_SIZE,
+			      DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(rvu->dev, iova))
+		return -ENOMEM;
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_MSIXTR_BASE, (u64)iova);
+	rvu->msix_base_iova = iova;
+
 	return 0;
 }
 
@@ -531,7 +548,8 @@ static void rvu_free_hw_resources(struct rvu *rvu)
 	struct rvu_hwinfo *hw = rvu->hw;
 	struct rvu_block *block;
 	struct rvu_pfvf  *pfvf;
-	int id;
+	int id, max_msix;
+	u64 cfg;
 
 	/* Free block LF bitmaps */
 	for (id = 0; id < BLK_COUNT; id++) {
@@ -549,6 +567,15 @@ static void rvu_free_hw_resources(struct rvu *rvu)
 		pfvf = &rvu->hwvf[id];
 		kfree(pfvf->msix.bmap);
 	}
+
+	/* Unmap MSIX vector base IOVA mapping */
+	if (!rvu->msix_base_iova)
+		return;
+	cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_CONST);
+	max_msix = cfg & 0xFFFFF;
+	dma_unmap_single(rvu->dev, rvu->msix_base_iova,
+			 max_msix * PCI_MSIX_ENTRY_SIZE,
+			 DMA_BIDIRECTIONAL);
 }
 
 static int rvu_setup_hw_resources(struct rvu *rvu)
diff --git a/drivers/soc/marvell/octeontx2/rvu.h b/drivers/soc/marvell/octeontx2/rvu.h
index 7435e83..92c2022 100644
--- a/drivers/soc/marvell/octeontx2/rvu.h
+++ b/drivers/soc/marvell/octeontx2/rvu.h
@@ -99,6 +99,7 @@ struct rvu {
 	u16			num_vec;
 	char			*irq_name;
 	bool			*irq_allocated;
+	dma_addr_t		msix_base_iova;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
-- 
2.7.4

