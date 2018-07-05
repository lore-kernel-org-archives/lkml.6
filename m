Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68ED24095
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68ED24095
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeGEQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:25:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53965 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754008AbeGEQZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39p2Bzhz9tvMZ;
        Thu,  5 Jul 2018 18:25:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8pjrhVuzzfOo; Thu,  5 Jul 2018 18:25:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39p1hM0z9ttwg;
        Thu,  5 Jul 2018 18:25:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 140098B8CF;
        Thu,  5 Jul 2018 18:25:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dTpIlxRG_WS5; Thu,  5 Jul 2018 18:25:19 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E03988B8BC;
        Thu,  5 Jul 2018 18:25:19 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AF75A711E2; Thu,  5 Jul 2018 16:25:19 +0000 (UTC)
Message-Id: <2940336694008357af53e183791f1d7abff4d757.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 15/16] powerpc: remove unnecessary inclusion of
 asm/tlbflush.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:25:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/tlbflush.h is only needed for:
- using functions xxx_flush_tlb_xxx()
- using MMU_NO_CONTEXT
- including asm-generic/pgtable.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/highmem.h    | 2 +-
 arch/powerpc/include/asm/tlb.h        | 1 -
 arch/powerpc/kvm/book3s.c             | 1 -
 arch/powerpc/kvm/book3s_32_mmu.c      | 1 -
 arch/powerpc/kvm/book3s_64_mmu.c      | 1 -
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 1 -
 arch/powerpc/kvm/book3s_64_vio.c      | 1 -
 arch/powerpc/kvm/book3s_64_vio_hv.c   | 1 -
 arch/powerpc/kvm/book3s_hv.c          | 1 -
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   | 1 -
 arch/powerpc/kvm/book3s_pr.c          | 1 -
 arch/powerpc/kvm/e500.c               | 1 -
 arch/powerpc/kvm/e500mc.c             | 1 -
 arch/powerpc/kvm/powerpc.c            | 1 -
 arch/powerpc/mm/fault.c               | 1 -
 arch/powerpc/mm/hash_native_64.c      | 1 -
 arch/powerpc/mm/hash_utils_64.c       | 1 -
 arch/powerpc/mm/mmu_context_hash32.c  | 1 -
 arch/powerpc/mm/mmu_decl.h            | 1 -
 arch/powerpc/mm/subpage-prot.c        | 1 -
 arch/powerpc/platforms/pseries/lpar.c | 1 -
 arch/powerpc/sysdev/cpm1.c            | 1 -
 22 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index cec820f961da..a4b65b186ec6 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -25,7 +25,7 @@
 
 #include <linux/interrupt.h>
 #include <asm/kmap_types.h>
-#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/fixmap.h>
 
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 9138baccebb0..6d2ba7c779dc 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -17,7 +17,6 @@
 #include <asm/pgtable.h>
 #endif
 #include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
 #ifndef __powerpc64__
 #include <asm/page.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index edaf4720d156..87348e498c89 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -28,7 +28,6 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 45c8ea4a0487..612169988a3d 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -23,7 +23,6 @@
 #include <linux/kvm_host.h>
 #include <linux/highmem.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index cf9d686e8162..c92dd25bed23 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -23,7 +23,6 @@
 #include <linux/kvm_host.h>
 #include <linux/highmem.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 7f3a8cf5d66f..3c0e8fb2b773 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -29,7 +29,6 @@
 #include <linux/file.h>
 #include <linux/debugfs.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index d066e37551ec..b3c1935229b0 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -31,7 +31,6 @@
 #include <linux/iommu.h>
 #include <linux/file.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 80d50d67b8c5..3315a56b6737 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -28,7 +28,6 @@
 #include <linux/list.h>
 #include <linux/stringify.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de686b340f4a..b4a5cc8525a0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -53,7 +53,6 @@
 #include <asm/disassemble.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1f22d9e977d4..a67cf1cdeda4 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/log2.h>
 
-#include <asm/tlbflush.h>
 #include <asm/trace.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index c3b8006f0eac..47ee43bbd696 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -27,7 +27,6 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index f9f6468f4171..afd3c255a427 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -21,7 +21,6 @@
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 
 #include "../mm/mmu_decl.h"
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index d0b6b5788afc..d31645491a93 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -21,7 +21,6 @@
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/dbell.h>
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 0e8c20c5eaac..3ccc386b380d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -33,7 +33,6 @@
 #include <asm/cputable.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_ppc.h>
-#include <asm/tlbflush.h>
 #include <asm/cputhreads.h>
 #include <asm/irqflags.h>
 #include <asm/iommu.h>
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b1ca7a0974e3..7d262c6437c4 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -42,7 +42,6 @@
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
-#include <asm/tlbflush.h>
 #include <asm/siginfo.h>
 #include <asm/debug.h>
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 1baabc74c4ae..4958f2a4f1d5 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -23,7 +23,6 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
-#include <asm/tlbflush.h>
 #include <asm/trace.h>
 #include <asm/tlb.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8318716e5075..af6c70dfe140 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -48,7 +48,6 @@
 #include <linux/uaccess.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
-#include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/eeh.h>
 #include <asm/tlb.h>
diff --git a/arch/powerpc/mm/mmu_context_hash32.c b/arch/powerpc/mm/mmu_context_hash32.c
index aa5a7fd89461..921c1e33e941 100644
--- a/arch/powerpc/mm/mmu_context_hash32.c
+++ b/arch/powerpc/mm/mmu_context_hash32.c
@@ -27,7 +27,6 @@
 #include <linux/export.h>
 
 #include <asm/mmu_context.h>
-#include <asm/tlbflush.h>
 
 /*
  * On 32-bit PowerPC 6xx/7xx/7xxx CPUs, we use a set of 16 VSIDs
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index c4c0a09a7775..e5d779eed181 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -19,7 +19,6 @@
  *
  */
 #include <linux/mm.h>
-#include <asm/tlbflush.h>
 #include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_MMU_NOHASH
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 9d16ee251fc0..3327551c8b47 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -17,7 +17,6 @@
 
 #include <asm/pgtable.h>
 #include <linux/uaccess.h>
-#include <asm/tlbflush.h>
 
 /*
  * Free all pages allocated for subpage protection maps and pointers.
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5a392e40f3d2..bc50f1dcc430 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -36,7 +36,6 @@
 #include <asm/machdep.h>
 #include <asm/mmu_context.h>
 #include <asm/iommu.h>
-#include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 5240d3a74a10..4f8dcf124828 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -38,7 +38,6 @@
 #include <asm/8xx_immap.h>
 #include <asm/cpm1.h>
 #include <asm/io.h>
-#include <asm/tlbflush.h>
 #include <asm/rheap.h>
 #include <asm/prom.h>
 #include <asm/cpm.h>
-- 
2.13.3

