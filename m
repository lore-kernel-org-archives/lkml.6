Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A5E222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BuIzt3kF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbfBMHDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:03:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbfBMHDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p2xakRDcJsV2sQPDu55ZX94FTycx/51cxKv4YN7tM6s=; b=BuIzt3kFvV26v+ay2Odmf3LsFE
        JcUf8WZBpzfnJVIHFDTvpRZ+Ju3gJvHOYeODP97/UIMmleBSDntJEcYcEzce/fDctI/9Z32T4IS8I
        hDfmyVayFn43NfXlG3Q+TRsUOVlfl8Ry514/49L4PgietHURM5NMXEPZPBA/zUgptx5D8v1Q/KBqr
        c0FoPYAT9dHwHPhA0FyPF3MDhe2tjEy5ZmEGGgboykws93BGhJJ6tf132PmsTRTaUs40Z2l+qR0An
        TAf0JHybG6nSyugm3syFeZtbpC5R3M81S5vDGDoAM4kQNHCJzR++K7SCfyovgZ4zxJB8tlb80QH2t
        TGnasZ9Q==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoZH-0000nP-Dw; Wed, 13 Feb 2019 07:02:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 32/32] powerpc/dma: trim the fat from <asm/dma-mapping.h>
Date:   Wed, 13 Feb 2019 08:01:33 +0100
Message-Id: <20190213070133.11259-33-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to provide anything but get_arch_dma_ops to
<linux/dma-mapping.h>.  More the remaining declarations to <asm/iommu.h>
and drop all the includes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h        | 29 -------------------
 arch/powerpc/include/asm/iommu.h              | 10 +++++++
 arch/powerpc/platforms/44x/ppc476.c           |  1 +
 arch/powerpc/platforms/85xx/corenet_generic.c |  1 +
 arch/powerpc/platforms/85xx/qemu_e500.c       |  1 +
 arch/powerpc/sysdev/fsl_pci.c                 |  1 +
 6 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index a59c42879194..565d6f74b189 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -1,37 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2004 IBM
- *
- * Implements the generic device dma API for powerpc.
- * the pci and vio busses
  */
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-#include <linux/cache.h>
-/* need struct page definitions */
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <asm/io.h>
-#include <asm/swiotlb.h>
-
-static inline unsigned long device_to_mask(struct device *dev)
-{
-	if (dev->dma_mask && *dev->dma_mask)
-		return *dev->dma_mask;
-	/* Assume devices without mask can take 32 bit addresses */
-	return 0xfffffffful;
-}
-
-/*
- * Available generic sets of operations
- */
-#ifdef CONFIG_PPC64
-extern const struct dma_map_ops dma_iommu_ops;
-#endif
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
@@ -43,5 +15,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 6f00a892ebdf..0ac52392ed99 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -325,5 +325,15 @@ extern bool iommu_fixed_is_weak;
 #define iommu_fixed_is_weak false
 #endif
 
+extern const struct dma_map_ops dma_iommu_ops;
+
+static inline unsigned long device_to_mask(struct device *dev)
+{
+	if (dev->dma_mask && *dev->dma_mask)
+		return *dev->dma_mask;
+	/* Assume devices without mask can take 32 bit addresses */
+	return 0xfffffffful;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index e55933f9cd55..a5e61e5c16e2 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -34,6 +34,7 @@
 #include <asm/ppc4xx.h>
 #include <asm/mpic.h>
 #include <asm/mmu.h>
+#include <asm/swiotlb.h>
 
 #include <linux/pci.h>
 #include <linux/i2c.h>
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 808da1e9c0a7..785e9641220d 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -27,6 +27,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
+#include <asm/swiotlb.h>
 #include <soc/fsl/qe/qe_ic.h>
 
 #include <linux/of_platform.h>
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 27631c607f3d..c52c8f9e8385 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -22,6 +22,7 @@
 #include <asm/time.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/swiotlb.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include "smp.h"
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a04c6dde6ed0..f49aec251a5a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -40,6 +40,7 @@
 #include <asm/mpc85xx.h>
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
+#include <asm/swiotlb.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
-- 
2.20.1

