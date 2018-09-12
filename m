Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D11BC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B209D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B209D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeILVE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:04:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33681 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeILVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:04:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RKN5lryz9ttRy;
        Wed, 12 Sep 2018 17:58:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7rP6qBhfTkGr; Wed, 12 Sep 2018 17:58:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RKN56Ngz9ttRt;
        Wed, 12 Sep 2018 17:58:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A9108B858;
        Wed, 12 Sep 2018 17:58:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PEe_C3h7oSIK; Wed, 12 Sep 2018 17:58:47 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF1698B86F;
        Wed, 12 Sep 2018 17:58:46 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8378B71913; Wed, 12 Sep 2018 15:58:46 +0000 (UTC)
Message-Id: <a89ba07fd74532a151c247e15300d2e741059305.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 16/24] powerpc/book3s/32: do not include pte-common.h
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Wed, 12 Sep 2018 15:58:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done for book3s/64, add necessary flags/defines in
book3s/32/pgtable.h and do not include pte-common.h

It allows in the meantime to remove all related hash
definitions from pte-common.h and to also remove
_PAGE_EXEC default as _PAGE_EXEC is defined on all
platforms except book3s/32.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 97 ++++++++++++++++++++++++++--
 arch/powerpc/include/asm/pte-common.h        | 16 +----
 2 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index d4f2f396af70..5ffb7e3b211f 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -8,7 +8,97 @@
 #include <asm/book3s/32/hash.h>
 
 /* And here we include common definitions */
-#include <asm/pte-common.h>
+
+#define _PAGE_KERNEL_RO		0
+#define _PAGE_KERNEL_ROX	0
+#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
+#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW)
+
+#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
+
+#ifndef __ASSEMBLY__
+
+static inline bool pte_user(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_USER;
+}
+#endif /* __ASSEMBLY__ */
+
+/* Location of the PFN in the PTE. Most 32-bit platforms use the same
+ * as _PAGE_SHIFT here (ie, naturally aligned).
+ * Platform who don't just pre-define the value so we don't override it here
+ */
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+
+/* The mask covered by the RPN must be a ULL on 32-bit platforms with
+ * 64-bit PTEs
+ */
+#ifdef CONFIG_PTE_64BIT
+#define PTE_RPN_MASK	(~((1ULL << PTE_RPN_SHIFT) - 1))
+#else
+#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+#endif
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HASHPTE | _PAGE_DIRTY | \
+			 _PAGE_ACCESSED | _PAGE_SPECIAL)
+
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_DIRTY)
+
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+
+/* Permission masks used to generate the __P and __S table,
+ *
+ * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
+ *
+ * Write permissions imply read permissions for now.
+ */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
+
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | _PAGE_NO_CACHE)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
+#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
+
+/* Protection used for kernel text. We want the debuggers to be able to
+ * set breakpoints anywhere, so don't write protect the kernel text
+ * on platforms where such control is possible.
+ */
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
+	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
+#else
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
+#endif
+
+/* Make modules code happy. We don't set RO yet */
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+
+/* Advertise special mapping type for AGP */
+#define PAGE_AGP		(PAGE_KERNEL_NC)
+#define HAVE_PAGE_AGP
 
 #define PTE_INDEX_SIZE	PTE_SHIFT
 #define PMD_INDEX_SIZE	0
@@ -219,7 +309,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
+	pte_update(ptep, _PAGE_RW, 0);
 }
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
@@ -235,9 +325,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
-	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
-	pte_update(ptep, clr, set);
+	pte_update(ptep, 0, set);
 
 	flush_tlb_page(vma, address);
 }
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 4860dae76dae..3a8ec18ffd22 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -5,15 +5,9 @@
  * Some bits are only used on some cpu families... Make sure that all
  * the undefined gets a sensible default
  */
-#ifndef _PAGE_HASHPTE
-#define _PAGE_HASHPTE	0
-#endif
 #ifndef _PAGE_HWWRITE
 #define _PAGE_HWWRITE	0
 #endif
-#ifndef _PAGE_EXEC
-#define _PAGE_EXEC	0
-#endif
 #ifndef _PAGE_COHERENT
 #define _PAGE_COHERENT	0
 #endif
@@ -68,11 +62,8 @@
 #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_RW | \
 				 _PAGE_HWWRITE | _PAGE_EXEC)
 #endif
-#ifndef _PAGE_HPTEFLAGS
-#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
-#endif
 #ifndef _PTE_NONE_MASK
-#define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
+#define _PTE_NONE_MASK	0
 #endif
 
 #ifndef __ASSEMBLY__
@@ -108,7 +99,7 @@ static inline bool pte_user(pte_t pte)
 /* _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
  */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
                          _PAGE_ACCESSED | _PAGE_SPECIAL)
 
 /* Mask of bits returned by pte_pgprot() */
@@ -125,8 +116,7 @@ static inline bool pte_user(pte_t pte)
  * the processor might need it for DMA coherency.
  */
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU) || \
-	defined(CONFIG_PPC_E500MC)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
 #define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
 #else
 #define _PAGE_BASE	(_PAGE_BASE_NC)
-- 
2.13.3

