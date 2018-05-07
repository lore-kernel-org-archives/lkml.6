Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEGLRK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:17:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752055AbeEGLRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:17:05 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <konrad.wilk@oracle.com>, <mingo@kernel.org>, <hch@lst.de>
CC: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] swiotlb: Update the comment of swiotlb
Date: Mon, 7 May 2018 19:06:25 +0800
Message-ID: <1525691185-55657-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swiotlb use physical address of bounce buffer when do map and unmap,
therefore, related comment should be updated.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 lib/swiotlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index fece575..e3d9445 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -593,9 +593,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 }
 
 /*
- * Allocates bounce buffer and returns its kernel virtual address.
+ * Allocates bounce buffer and returns its physical address.
  */
-
 static phys_addr_t
 map_single(struct device *hwdev, phys_addr_t phys, size_t size,
 	   enum dma_data_direction dir, unsigned long attrs)
@@ -614,7 +613,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 }
 
 /*
- * dma_addr is the kernel virtual address of the bounce buffer to unmap.
+ * tlb_addr is the physical address of the bounce buffer to unmap.
  */
 void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t size, enum dma_data_direction dir,
-- 
1.7.12.4
