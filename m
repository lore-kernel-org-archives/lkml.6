Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872320-1520610548-2-10664370673507029803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520610548; b=Fwz+PvoKAMgmyv8ENdKfcEG/oVCpS0jMB5yaudHtaoWA4Ob
    TBZc6tPBNWxTFR4pC/lOnYs9lutapPy6PohNqJZo5cLhTMN0mmuT+XtApwHS3yzL
    jmy8cHlme8tYDG1jlE3J4YX68uCxoeouNZx0SMTv82u2ksk56FyQb745iZBVFiQE
    MIK6YXwglKCsdawHX9PugBRmRhCWLW5Pj6W3AVIpt/A/XdAbj2kYRoPzrTAxo99d
    Ep2EFbbGU1CkVKUCrN2eIuAq+qJu25twpCCvN/dgvPzwgZYtkFjwzkVIxjzjTlF9
    5dYpm+oayg9MvRfrqXgXngY+WQGx1ZVVTnyb2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :subject:to:cc:date:sender:list-id; s=arctest; t=1520610548; bh=
    E4otPcqur9usvkuT1qJAHL1mr5H+lW6/j+COR7KtkWg=; b=QHhiln3GBNhulTsa
    icnb96fXqSEsjRFby8qp9LpjRxkl6qCRB4r6pp0kdxMK3F1sYO8PnEqTuIMPWDWU
    MflHhmzCTDd5A2/on7NblcQja6PMiK6RrFlVFswmMQtKV9USFSWDq5B8MGe8CSLH
    82umoiAJM+EHkfps43M1vXct7SShZd31aW+aYFDHZbsUdcHAd6FjXyzLDyeUZRKM
    Es5cCGnGO1ZPU0x3ogCGYxVGndRGixvC2j/paUqAdZb6q1hF5Hup+CCdtc9G67yk
    OsSIZVfzsEIwe1Lla6mS625KGTNd3NoNWy0QriTIjQmvfQY9hLugMzY74MsmS1R/
    A3au0g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeCIPtF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:49:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55516 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932084AbeCIPtD (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 10:49:03 -0500
Message-Id: <0482505bb633dc9c709e3c4e03335ea5307a823f.1520468013.git.christophe.leroy@c-s.fr>
In-Reply-To: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14 2/4] powerpc/mm/slice: create header files dedicated to
 slices
To: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  9 Mar 2018 16:49:01 +0100 (CET)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream a3286f05bc5a5bc7fc73a9783ec89de78fcd07f8

In preparation for the following patch which will enhance 'slices'
for supporting PPC32 in order to fix an issue on hugepages on 8xx,
this patch takes out of page*.h all bits related to 'slices' and put
them into newly created slice.h header files.
While common parts go into asm/slice.h, subarch specific
parts go into respective books3s/64/slice.c and nohash/64/slice.c
'slices'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/slice.h | 27 ++++++++++++++
 arch/powerpc/include/asm/nohash/64/slice.h | 12 ++++++
 arch/powerpc/include/asm/page.h            |  1 +
 arch/powerpc/include/asm/page_64.h         | 59 ------------------------------
 arch/powerpc/include/asm/slice.h           | 40 ++++++++++++++++++++
 5 files changed, 80 insertions(+), 59 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/slice.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/slice.h
 create mode 100644 arch/powerpc/include/asm/slice.h

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
new file mode 100644
index 000000000000..db0dedab65ee
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_64_SLICE_H
+#define _ASM_POWERPC_BOOK3S_64_SLICE_H
+
+#ifdef CONFIG_PPC_MM_SLICES
+
+#define SLICE_LOW_SHIFT		28
+#define SLICE_LOW_TOP		(0x100000000ul)
+#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
+#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
+
+#define SLICE_HIGH_SHIFT	40
+#define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
+#define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
+
+#else /* CONFIG_PPC_MM_SLICES */
+
+#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
+#define slice_set_user_psize(mm, psize)		\
+do {						\
+	(mm)->context.user_psize = (psize);	\
+	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
+} while (0)
+
+#endif /* CONFIG_PPC_MM_SLICES */
+
+#endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/nohash/64/slice.h b/arch/powerpc/include/asm/nohash/64/slice.h
new file mode 100644
index 000000000000..ad0d6e3cc1c5
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/64/slice.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_64_SLICE_H
+#define _ASM_POWERPC_NOHASH_64_SLICE_H
+
+#ifdef CONFIG_PPC_64K_PAGES
+#define get_slice_psize(mm, addr)	MMU_PAGE_64K
+#else /* CONFIG_PPC_64K_PAGES */
+#define get_slice_psize(mm, addr)	MMU_PAGE_4K
+#endif /* !CONFIG_PPC_64K_PAGES */
+#define slice_set_user_psize(mm, psize)	do { BUG(); } while (0)
+
+#endif /* _ASM_POWERPC_NOHASH_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 8da5d4c1cab2..d5f1c41b7dba 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -344,5 +344,6 @@ typedef struct page *pgtable_t;
 
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
+#include <asm/slice.h>
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index c4d9654bd637..af04acdb873f 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -86,65 +86,6 @@ extern u64 ppc64_pft_size;
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_PPC_MM_SLICES
-
-#define SLICE_LOW_SHIFT		28
-#define SLICE_HIGH_SHIFT	40
-
-#define SLICE_LOW_TOP		(0x100000000ul)
-#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
-#define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
-
-#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
-#define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
-
-#ifndef __ASSEMBLY__
-struct mm_struct;
-
-extern unsigned long slice_get_unmapped_area(unsigned long addr,
-					     unsigned long len,
-					     unsigned long flags,
-					     unsigned int psize,
-					     int topdown);
-
-extern unsigned int get_slice_psize(struct mm_struct *mm,
-				    unsigned long addr);
-
-extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
-extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
-				  unsigned long len, unsigned int psize);
-
-#endif /* __ASSEMBLY__ */
-#else
-#define slice_init()
-#ifdef CONFIG_PPC_STD_MMU_64
-#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
-#define slice_set_user_psize(mm, psize)		\
-do {						\
-	(mm)->context.user_psize = (psize);	\
-	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
-} while (0)
-#else /* CONFIG_PPC_STD_MMU_64 */
-#ifdef CONFIG_PPC_64K_PAGES
-#define get_slice_psize(mm, addr)	MMU_PAGE_64K
-#else /* CONFIG_PPC_64K_PAGES */
-#define get_slice_psize(mm, addr)	MMU_PAGE_4K
-#endif /* !CONFIG_PPC_64K_PAGES */
-#define slice_set_user_psize(mm, psize)	do { BUG(); } while(0)
-#endif /* !CONFIG_PPC_STD_MMU_64 */
-
-#define slice_set_range_psize(mm, start, len, psize)	\
-	slice_set_user_psize((mm), (psize))
-#endif /* CONFIG_PPC_MM_SLICES */
-
-#ifdef CONFIG_HUGETLB_PAGE
-
-#ifdef CONFIG_PPC_MM_SLICES
-#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-#endif
-
-#endif /* !CONFIG_HUGETLB_PAGE */
-
 #define VM_DATA_DEFAULT_FLAGS \
 	(is_32bit_task() ? \
 	 VM_DATA_DEFAULT_FLAGS32 : VM_DATA_DEFAULT_FLAGS64)
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
new file mode 100644
index 000000000000..17c5a5d8c418
--- /dev/null
+++ b/arch/powerpc/include/asm/slice.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_SLICE_H
+#define _ASM_POWERPC_SLICE_H
+
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/book3s/64/slice.h>
+#else
+#include <asm/nohash/64/slice.h>
+#endif
+
+#ifdef CONFIG_PPC_MM_SLICES
+
+#ifdef CONFIG_HUGETLB_PAGE
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#endif
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+
+#ifndef __ASSEMBLY__
+
+struct mm_struct;
+
+unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
+				      unsigned long flags, unsigned int psize,
+				      int topdown);
+
+unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr);
+
+void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
+void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
+			   unsigned long len, unsigned int psize);
+#endif /* __ASSEMBLY__ */
+
+#else /* CONFIG_PPC_MM_SLICES */
+
+#define slice_set_range_psize(mm, start, len, psize)	\
+	slice_set_user_psize((mm), (psize))
+#endif /* CONFIG_PPC_MM_SLICES */
+
+#endif /* _ASM_POWERPC_SLICE_H */
-- 
2.13.3
