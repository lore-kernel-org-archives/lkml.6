Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeBLQsd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:48:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56014 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754017AbeBLQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:30 -0500
X-Google-Smtp-Source: AH8x225roOr7PclMEcxqdX7/dj1k4eAlo4OraJs5gAAm0+5i7SLbGvSWZmhnoaL5l+Bvig8GNr2TqQ==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 2/6] iommu/intel: Clean/document fault status flags
Date: Mon, 12 Feb 2018 16:48:21 +0000
Message-Id: <20180212164825.22421-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So one could decode them without opening the specification.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/intel-iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8dad3dd26eae..ef169d67df92 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -209,12 +209,12 @@
 #define DMA_FECTL_IM (((u32)1) << 31)
 
 /* FSTS_REG */
-#define DMA_FSTS_PPF ((u32)2)
-#define DMA_FSTS_PFO ((u32)1)
-#define DMA_FSTS_IQE (1 << 4)
-#define DMA_FSTS_ICE (1 << 5)
-#define DMA_FSTS_ITE (1 << 6)
-#define DMA_FSTS_PRO (1 << 7)
+#define DMA_FSTS_PFO (1 << 0) /* Primary Fault Overflow */
+#define DMA_FSTS_PPF (1 << 1) /* Primary Pending Fault */
+#define DMA_FSTS_IQE (1 << 4) /* Invalidation Queue Error */
+#define DMA_FSTS_ICE (1 << 5) /* Invalidation Completion Error */
+#define DMA_FSTS_ITE (1 << 6) /* Invalidation Time-out Error */
+#define DMA_FSTS_PRO (1 << 7) /* Page Request Overflow */
 #define dma_fsts_fault_record_index(s) (((s) >> 8) & 0xff)
 
 /* FRCD_REG, 32 bits access */
-- 
2.13.6
