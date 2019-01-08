Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3518C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49932087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMOdghjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfAHNHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:07:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfAHNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jco5PVbt6qSTlyxRQxZ8v+W/aMRUJ7YPOWwqOyxZhak=; b=GMOdghjsOstq+rhmshafaGR5po
        fyFJEMp4Pf4lbpmyHehUK4x/zKK7Y+K0AYL3rTNwXaCs0sYuQdmeFWrknNpE39H/xZi5vKA1/5scP
        rhXJ17xZGI2TlV5EAPpnwCXR4bzp69DMuQGwAb2Af+HkErN3KSliHwesYYqto0n93rM9Zu3EdlZ3e
        07ILd8uOtFOnAK6pu5M15q98ldasCABcJmnYaV1YmWu05KRZBuTPvbLv0uwabCkwGf4s74WJ1z/Tq
        zXyPpZtj7i6C02RBDhr3DxTxt3YDmBFE79HykDtSOdK0yeC3qcZq1LAICooQJMk/u12DmD+AGtVy6
        9wnqqagQ==;
Received: from rrcs-24-103-175-221.nys.biz.rr.com ([24.103.175.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggr63-0005bd-Dt; Tue, 08 Jan 2019 13:07:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cross-tree: phase out dma_zalloc_coherent() on headers
Date:   Tue,  8 Jan 2019 08:07:00 -0500
Message-Id: <20190108130701.14161-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
References: <20190108130701.14161-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The last few stragglers coccinelle doesn't pick up are on driver
specific header files. Phase those out as well as dma_alloc_coherent()
zeroes out the memory as well now too.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/common.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 5cd3135dfe30..03d131f777bc 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -2081,7 +2081,7 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
 			    bool is_pf);
 
 #define BNX2X_ILT_ZALLOC(x, y, size)					\
-	x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
+	x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
 
 #define BNX2X_ILT_FREE(x, y, size) \
 	do { \
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 142bc11b9fbb..2462e7aa0c5d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -52,7 +52,7 @@ extern int bnx2x_num_queues;
 
 #define BNX2X_PCI_ALLOC(y, size)					\
 ({									\
-	void *x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
+	void *x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
 	if (x)								\
 		DP(NETIF_MSG_HW,					\
 		   "BNX2X_PCI_ALLOC: Physical %Lx Virtual %p\n",	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index ec50a21c5aaf..e332e82fc066 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -64,7 +64,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_zalloc_coherent(dev, qmem->alloc_sz,
+	qmem->base = dma_alloc_coherent(dev, qmem->alloc_sz,
 					 &qmem->iova, GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
-- 
2.20.1

