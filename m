Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B7DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812B120883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQiyH5Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812B120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbeIQVGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:06:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f0Z/qwk5aasGSqS5N0umEd3apHQoe6SWTGncnlJmryw=; b=oQiyH5Q9H0QWEAK5MQnijJDCw
        aS/jpIja5VW0RLsJUZsphdkpEjU7rrneoFVK30eenzKed3cC0E/aa6ql4H0lXbXXvZfS1B35sWtig
        rOrDLRV9lnyLPzPOa20/jvTSronjtkn3/F5TBocSPdNNAjlKbnWzTMPrtiJkIhU5ZF8KynK6Z1TFF
        6kn4hVRKUuv5lEG2O+UT0VJKZpd/GqI31ye9egRhg4dIwZnbUo6vxM1n+JAnTm5Cn3/b7eA8qfjf2
        gM21p1o/QHwhENJiU0Il4S6UTjJrOHYfiYIQ9mQE+2+mboBzIwOFSiQO+P78l7gvt/rGf71lnvh/P
        4eSgnLnAA==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1vbf-00069o-Iu; Mon, 17 Sep 2018 15:38:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] swiotlb: mark is_swiotlb_buffer static
Date:   Mon, 17 Sep 2018 17:38:19 +0200
Message-Id: <20180917153826.28052-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 1 -
 kernel/dma/swiotlb.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 965be92c33b5..7ef541ce8f34 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
 #endif
 
 extern void swiotlb_print_info(void);
-extern int is_swiotlb_buffer(phys_addr_t paddr);
 extern void swiotlb_set_max_segment(unsigned int);
 
 extern const struct dma_map_ops swiotlb_dma_ops;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9062b14bc7f4..26d3af52956f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
 	max_segment = 0;
 }
 
-int is_swiotlb_buffer(phys_addr_t paddr)
+static int is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
-- 
2.18.0

