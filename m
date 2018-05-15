Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeEOSFu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:05:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753188AbeEOSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:46 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] swiotlb: mark is_swiotlb_buffer static
Date: Tue, 15 May 2018 20:05:21 +0200
Message-Id: <20180515180523.3038-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515180523.3038-1-hch@lst.de>
References: <20180515180523.3038-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 1 -
 lib/swiotlb.c           | 2 +-
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
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 2ebbc7204061..8333277d1cd1 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -431,7 +431,7 @@ void __init swiotlb_exit(void)
 	max_segment = 0;
 }
 
-int is_swiotlb_buffer(phys_addr_t paddr)
+static int is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
-- 
2.17.0
