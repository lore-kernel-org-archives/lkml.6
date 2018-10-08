Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201FAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CE620878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KuDnEfE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CE620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJHPNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:13:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f0Z2MSGqIn5pk2KJ0GqZtlNn51ct0DesVW2XhhwWBe4=; b=KuDnEfE9abrB3PWKSNC34425+j
        t4gA4gBOoJ0Ln9wbk+5BO5QoITLpSC7WTguQ4BH/v/iY5LRPSZRlrpEMAfC8nQM58822cmpp90Mx5
        XGEs8NkWTlt5i2eZZMpsud0AQnbU5naQ+k2doDIFL17PkhCibnNY883nNmRQyFy3rElxQW2+D6PqO
        MVwQoxdq7fRJc9wAyfQG4Du/N06agh8DOrQWzQqVHnJBtOg7IPwsf4fRpTy3jTplLFbstTc0C5yYL
        b/lUKRtiHc5z+POsbZIN0faQUMsKF6I8vgamiI19aVH82ipOJ3ArgJKZNp9nnJYW3fDeFMQr/LbGo
        S8rtRjJQ==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9QVC-00027w-QD; Mon, 08 Oct 2018 08:02:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] swiotlb: remove a pointless comment
Date:   Mon,  8 Oct 2018 10:02:37 +0200
Message-Id: <20181008080246.20543-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008080246.20543-1-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comments describes an aspect of the map_sg interface that isn't
even exploited by swiotlb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6dbf0b60..9062b14bc7f4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -925,12 +925,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * appropriate dma address and length.  They are obtained via
  * sg_dma_{address,length}(SG).
  *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
  * Device ownership issues as mentioned above for swiotlb_map_page are the
  * same here.
  */
-- 
2.19.0

