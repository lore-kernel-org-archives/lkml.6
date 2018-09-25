Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7950ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B822086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B822086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeIYW73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:59:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57843 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbeIYW72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:59:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KRsj3RDYz9ttFq;
        Tue, 25 Sep 2018 18:51:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GJsjTz42dZdC; Tue, 25 Sep 2018 18:51:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KRsj2y4hz9ttCN;
        Tue, 25 Sep 2018 18:51:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BF0C8B7E5;
        Tue, 25 Sep 2018 18:51:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f0ZW0LjMiW-C; Tue, 25 Sep 2018 18:51:05 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FEC88B7C8;
        Tue, 25 Sep 2018 18:51:05 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B067270AFE; Tue, 25 Sep 2018 16:51:04 +0000 (UTC)
Message-Id: <7b393295aae97b22763e01e559f2b582a92ec672.1537892499.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 13/22] powerpc/book3s32: Remove CONFIG_BOOKE dependent code
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Sep 2018 16:51:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BOOK3S/32 cannot be BOOKE, so remove useless code

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 18 ------------------
 arch/powerpc/include/asm/book3s/32/pgtable.h | 14 --------------
 2 files changed, 32 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index a4cf0de10931..711a8b84e3ee 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -48,8 +48,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #define __pmd_free_tlb(tlb,x,a)		do { } while (0)
 /* #define pgd_populate(mm, pmd, pte)      BUG() */
 
-#ifndef CONFIG_BOOKE
-
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 				       pte_t *pte)
 {
@@ -63,22 +61,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 }
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
-#else
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
-				       pte_t *pte)
-{
-	*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
-}
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pte_page)
-{
-	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
-}
-
-#define pmd_pgtable(pmd) pmd_page(pmd)
-#endif
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 5ffb7e3b211f..7a8a590f6b4c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -334,24 +334,10 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
-/*
- * Note that on Book E processors, the pmd contains the kernel virtual
- * (lowmem) address of the pte page.  The physical address is less useful
- * because everything runs with translation enabled (even the TLB miss
- * handler).  On everything else the pmd contains the physical address
- * of the pte page.  -- paulus
- */
-#ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
-#else
-#define pmd_page_vaddr(pmd)	\
-	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
-#define pmd_page(pmd)		\
-	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
-#endif
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
-- 
2.13.3

