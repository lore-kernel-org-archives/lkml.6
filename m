Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE60C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3966F21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Txc7X7rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3966F21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbeITNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeITNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ciJ1FIMTTDW1iaJfE9+Ig7VrdPG5wljMFDf2JagdoNo=; b=Txc7X7rQKwhowqXHJlWXdNc8u
        vQj2+638WnNdppV4ZX5Vru70zVdJjpO+Hrii+QHN6WVAN4XTlObf3TSB2eWHcMPstY6lxrYhK1Cb7
        p4YkrBZ7a2COx0qwAJUhbEzUG9PNw4suH2O5vIenfcw36cEmAHgqTKXnuaf2Qe3/kXHdHawMdKG59
        VfM3pZUMxeVxOkErcJr7sv1lS5qYUux2fKXvehDh4f9HvjZ+Rsh48fxFrXxwTUp+/5tNmc6+5iMCk
        qnO27G7A3bAqr1++vp0cdrBjjejq1dNIn5ESO/uU7BlOGcrjYnSDuqLJqL7jAoNC7APrkaMQAHq+e
        7iv+mBdOg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tMk-0002dF-S8; Thu, 20 Sep 2018 07:27:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] ia64: remove the dead iommu_sac_force variable
Date:   Thu, 20 Sep 2018 09:26:53 +0200
Message-Id: <20180920072700.22396-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like copy and paste from x86 that never actually got used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index b5df084c0af4..50b6ad282a90 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -18,8 +18,6 @@
 dma_addr_t bad_dma_address __read_mostly;
 EXPORT_SYMBOL(bad_dma_address);
 
-static int iommu_sac_force __read_mostly;
-
 int no_iommu __read_mostly;
 #ifdef CONFIG_IOMMU_DEBUG
 int force_iommu __read_mostly = 1;
@@ -61,23 +59,6 @@ int iommu_dma_supported(struct device *dev, u64 mask)
 	if (mask < DMA_BIT_MASK(24))
 		return 0;
 
-	/* Tell the device to use SAC when IOMMU force is on.  This
-	   allows the driver to use cheaper accesses in some cases.
-
-	   Problem with this is that if we overflow the IOMMU area and
-	   return DAC as fallback address the device may not handle it
-	   correctly.
-
-	   As a special case some controllers have a 39bit address
-	   mode that is as efficient as 32bit (aic79xx). Don't force
-	   SAC for these.  Assume all masks <= 40 bits are of this
-	   type. Normally this doesn't make any difference, but gives
-	   more gentle handling of IOMMU overflow. */
-	if (iommu_sac_force && (mask >= DMA_BIT_MASK(40))) {
-		dev_info(dev, "Force SAC with mask %llx\n", mask);
-		return 0;
-	}
-
 	return 1;
 }
 EXPORT_SYMBOL(iommu_dma_supported);
-- 
2.18.0

