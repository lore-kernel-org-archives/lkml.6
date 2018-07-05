Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84499C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436D924095
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436D924095
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbeGEQ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:26:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62928 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753992AbeGEQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39f0pNHz9ttrD;
        Thu,  5 Jul 2018 18:25:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z_VMHRpwUSUl; Thu,  5 Jul 2018 18:25:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39f0LPmz9ttr5;
        Thu,  5 Jul 2018 18:25:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D8CA08B8CF;
        Thu,  5 Jul 2018 18:25:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lJ2xkJo6RhJM; Thu,  5 Jul 2018 18:25:11 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB3A28B8BC;
        Thu,  5 Jul 2018 18:25:11 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 97076711E2; Thu,  5 Jul 2018 16:25:11 +0000 (UTC)
Message-Id: <a8fa6d397c3a4c45ba5663ee7048fb3fafebd92a.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 11/16] powerpc/nohash: fix hash related comments in
 pgtable.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:25:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  4 ----
 arch/powerpc/include/asm/nohash/64/pgtable.h | 18 ++++--------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 79805e0dad27..a507a65b0866 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -223,10 +223,6 @@ static inline unsigned long long pte_update(pte_t *p,
 }
 #endif /* CONFIG_PTE_64BIT */
 
-/*
- * 2.6 calls this without flushing the TLB entry; this is wrong
- * for our hash-based implementation, we fix that up here.
- */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index fe05b3e03cf1..7cd6809f4d33 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -3,7 +3,7 @@
 #define _ASM_POWERPC_NOHASH_64_PGTABLE_H
 /*
  * This file contains the functions and defines necessary to modify and use
- * the ppc64 hashed page table.
+ * the ppc64 non-hashed page table.
  */
 
 #include <asm/nohash/64/pgtable-4k.h>
@@ -38,7 +38,7 @@
 
 /*
  * The vmalloc space starts at the beginning of that region, and
- * occupies half of it on hash CPUs and a quarter of it on Book3E
+ * occupies a quarter of it on Book3E
  * (we keep a quarter for the virtual memmap)
  */
 #define VMALLOC_START	KERN_VIRT_START
@@ -78,7 +78,7 @@
 
 /*
  * Defines the address of the vmemap area, in its own region on
- * hash table CPUs and after the vmalloc space on Book3E
+ * after the vmalloc space on Book3E
  */
 #define VMEMMAP_BASE		VMALLOC_END
 #define VMEMMAP_END		KERN_IO_START
@@ -248,14 +248,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
 }
 
-/*
- * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty. The generic routines only flush if the
- * entry was young or dirty which is not good enough.
- *
- * We should be more intelligent about this but for the moment we override
- * these functions and force a tlb flush unconditionally
- */
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
@@ -279,9 +271,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 }
 
 
-/* Set the dirty and/or accessed bits atomically in a linux PTE, this
- * function doesn't need to flush the hash entry
- */
+/* Set the dirty and/or accessed bits atomically in a linux PTE */
 static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
 					   unsigned long address,
-- 
2.13.3

