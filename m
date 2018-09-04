Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7D2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39C62086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4gKMDwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39C62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeIDUzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:55:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38901 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:55:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so1955070pfh.5;
        Tue, 04 Sep 2018 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BShs/B7WbmjGF339oaZcnn6uTeYWtvRJSOdxcgoD9c4=;
        b=e4gKMDwmkaESgOEOlqil9MwG44rpi+ReeeVZMvRQVUTaalant3g37UPg/9ZFbDkiPV
         jr3Lr0PHB0p0Xt7fQLIzCNjau59nCZE+Hk1+XG1NaIsO1KwKe6bG0ClT36DZR/GflPTx
         E1GUGe6cUSt8/T1+c1S02FoV/nzmvtivzMrNBs5BzvGrdp/OQ1gAdGd7/s/O/Wl3GEQ1
         Iecei+U9M0sYTE871s9KzwJOrS8h+ijsSyf+AvkZMFTOus3DPA6Qad3n6WcESIncWLjZ
         1jd1eW2TzSCmsQKlDzU+qbhxQXUNflxyjNrZw1ALX0p2daaJPURiasWIsGPosCuBBnUG
         yZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BShs/B7WbmjGF339oaZcnn6uTeYWtvRJSOdxcgoD9c4=;
        b=kfmwtCgkrp1wYw+oZUqsURqBMndGuXUGhwq9S9cCDcasDzsoQ0m3gfH0bfC2QXuxUt
         kdCQKapCIzyVgKGO5Sm49+YnL9GYIrvPH74cJa9TvuLtQPtnWawRdqCGgs7oaVp2o0BN
         MSHEnowV4w/5DJ89niUAEzvT5ajZBQBFjToq8szSdwZVNncG4Fte0XMe5e2sI9q9b7pD
         mE8ia7L2tMg2lLpzNhEOugClwSh9qR2TkPjqYwvcLvbpgoIJmY5l+Kgm3QlQ3OHlohgQ
         g186vC2RXl24EEkmwmYobC/Ue2jedHrv+I+6ldIoGbuThUym98Fhc0pQ3WJIUGHiQiRQ
         V4Sw==
X-Gm-Message-State: APzg51BletLmXjb5koB0Zj3tZ9FuiDtixYt9NYh8b904j3MAgPR+da+7
        U2nL4VyjYrhoUU6vSdO1Zh+5N0IR
X-Google-Smtp-Source: ANB0VdamhIOU/vVDidtHA2IGycSKLhEggiicYOGY1ussbUXaHV38/g//IsbZA0M4aYv9LKmIFwGilA==
X-Received: by 2002:a63:6183:: with SMTP id v125-v6mr32566152pgb.242.1536078572892;
        Tue, 04 Sep 2018 09:29:32 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:29:32 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v3 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
Date:   Tue,  4 Sep 2018 21:58:40 +0530
Message-Id: <1536078525-31534-11-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
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

