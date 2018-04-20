Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeDTIQ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:16:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754054AbeDTIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:04:07 -0400
From: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/22] alpha: simplify get_arch_dma_ops
Date: Fri, 20 Apr 2018 10:02:56 +0200
Message-Id: <20180420080313.18796-6-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
References: <20180420080313.18796-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dma_ops indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/dma-mapping.h | 4 ++--
 arch/alpha/kernel/pci_iommu.c        | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 76ce923ecca1..8beeafd4f68e 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -2,14 +2,14 @@
 #ifndef _ALPHA_DMA_MAPPING_H
 #define _ALPHA_DMA_MAPPING_H
 
-extern const struct dma_map_ops *dma_ops;
+extern const struct dma_map_ops alpha_pci_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_ALPHA_JENSEN
 	return &dma_direct_ops;
 #else
-	return dma_ops;
+	return &alpha_pci_ops;
 #endif
 }
 
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 83b34b9188ea..6923b0d9c1e1 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -950,6 +950,4 @@ const struct dma_map_ops alpha_pci_ops = {
 	.mapping_error		= alpha_pci_mapping_error,
 	.dma_supported		= alpha_pci_supported,
 };
-
-const struct dma_map_ops *dma_ops = &alpha_pci_ops;
-EXPORT_SYMBOL(dma_ops);
+EXPORT_SYMBOL(alpha_pci_ops);
-- 
2.17.0
