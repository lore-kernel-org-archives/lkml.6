Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeB1SVu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:21:50 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:2322 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeB1SVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:21:47 -0500
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/dma: remove unnecessary BUG()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180228182145.AD1C76F114@po15720vm.idsi0.si.c-s.fr>
Date: Wed, 28 Feb 2018 19:21:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direction is already checked in all calling functions in
include/linux/dma-mapping.h and also in called function __dma_sync()

So really no need to check it once more here.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index da20569de9d4..e1cd6e979348 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -235,8 +235,6 @@ static inline dma_addr_t dma_nommu_map_page(struct device *dev,
 					     enum dma_data_direction dir,
 					     unsigned long attrs)
 {
-	BUG_ON(dir == DMA_NONE);
-
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync_page(page, offset, size, dir);
 
-- 
2.13.3
