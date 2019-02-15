Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE692222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="AYblONMb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AqcjlNuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393341AbfBOWJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:26 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38681 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393247AbfBOWJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AF61C328F;
        Fri, 15 Feb 2019 17:09:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=TKkr6F+pcQWOH
        jR1WyLSliHQNu6t5AXNp24XvGYdLBs=; b=AYblONMbNmEVoXDrndoP5hiaC7BxH
        if8PValgurwRTWKMwStlOQlHgFz12nYs8gjBmaxY4KEM7asJGnAvXpD24jL0OfCl
        sVMk0tjTf/wEJ5wOkTRVVIVVL65o1nYeV3IW57dEYTpi3W/6Ngp019RFTukKaVCO
        wUTsRKrojwvQl7HzZq+P3Yd7pDn+WVgRlugOEgYVlzYzSLSwPN1P3tWEVgFhi27V
        hkbCZ0SbB+tbcuu3Oau0ThbO+FeNjEwkcEDeGh+CE3lHVhoD+HTTMJ66GWhg4nib
        w2qApPqUhsTNf2WZReocjnMKGlGvoHn/FZPNCsaj4PYA/NxIe/3eSobPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=TKkr6F+pcQWOHjR1WyLSliHQNu6t5AXNp24XvGYdLBs=; b=AqcjlNuy
        xcXQy0AfD6UJGUFVV2Qode5Ko3w0XsnPltynvlKlr+tV60C4P33rkCP0ttnaCk2A
        mErF0rSZXutipuZMwcuIavwzayInHGuFlY3wrzeJuIhfXABlUeZhlvoudnsuR8i6
        5bwvOStiD21N9oe8SCrn4bCPCL5EGoIRaxvINy/5EO25rpLo2vN4/QsVoiCXKJQQ
        8erINEI7KWACOjsIrLXoSLIlP6YRoUqmmP0aZwCdy5YpqBSV2KziZwT8ShhSpl1v
        7ft2c/SNmHjpkSf0xfjOP3bqXUHjWKco/rcIt1pFA0AU2ll6BItBz+UXA45ZLc46
        29JD3OXLsrLEBg==
X-ME-Sender: <xms:kThnXK-5A1JrnVKXO6sNFjThTopVp-2DhMxnE-HBpkoRGAS3QSS2_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedufe
X-ME-Proxy: <xmx:kThnXFzwsZmcSJRn19uf1flDo0v1F26l-WKVgGNzKU9kWQ9um00-xQ>
    <xmx:kThnXIGOCoVkzPauthtn_YdeKr45iq8cnYaSII_uCjQUKWjiWVGSvg>
    <xmx:kThnXEvM2gpt0WlnqyB69wAenVhltEpDeWmlKEFOcnbCoXvzZD_nqw>
    <xmx:kThnXDWr71QphxZ_Z7m8VeM_SrqHTpXjsF0eJnAhOkavk1U2NEhsGQ>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD1A9E46AE;
        Fri, 15 Feb 2019 17:09:19 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 14/31] mm: thp: handling 1GB THP reference bit.
Date:   Fri, 15 Feb 2019 14:08:39 -0800
Message-Id: <20190215220856.29749-15-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215220856.29749-1-zi.yan@sent.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Add PUD-level TLB flush ops and teach page_vma_mapped_talk about 1GB
THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgtable.h |  3 +++
 arch/x86/mm/pgtable.c          | 13 +++++++++++++
 include/asm-generic/pgtable.h  | 14 ++++++++++++++
 include/linux/mmu_notifier.h   | 13 +++++++++++++
 include/linux/rmap.h           |  1 +
 mm/page_vma_mapped.c           | 33 +++++++++++++++++++++++++++++----
 mm/rmap.c                      | 12 +++++++++---
 7 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ae3ac49c32ad..f99ce657d282 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1151,6 +1151,9 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 
+#define __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
+extern int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp);
 
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0a5008690d7c..0edcfa8007cb 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -643,6 +643,19 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 	return young;
 }
+int pudp_clear_flush_young(struct vm_area_struct *vma,
+			   unsigned long address, pud_t *pudp)
+{
+	int young;
+
+	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
+
+	young = pudp_test_and_clear_young(vma, address, pudp);
+	if (young)
+		flush_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+
+	return young;
+}
 #endif
 
 /**
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 0f626d6177c3..682531e0d55c 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -121,6 +121,20 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+extern int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp);
+#else
+int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp)
+{
+	BUILD_BUG();
+	return 0;
+}
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD  */
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 4050ec1c3b45..6850b9e9b2cb 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -353,6 +353,19 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
 	__young;							\
 })
 
+#define pudp_clear_flush_young_notify(__vma, __address, __pudp)		\
+({									\
+	int __young;							\
+	struct vm_area_struct *___vma = __vma;				\
+	unsigned long ___address = __address;				\
+	__young = pudp_clear_flush_young(___vma, ___address, __pudp);	\
+	__young |= mmu_notifier_clear_flush_young(___vma->vm_mm,	\
+						  ___address,		\
+						  ___address +		\
+							PUD_SIZE);	\
+	__young;							\
+})
+
 #define ptep_clear_young_notify(__vma, __address, __ptep)		\
 ({									\
 	int __young;							\
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 988d176472df..2b566736e3c2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -206,6 +206,7 @@ struct page_vma_mapped_walk {
 	struct page *page;
 	struct vm_area_struct *vma;
 	unsigned long address;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 11df03e71288..a473553aa9a5 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -141,9 +141,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	struct page *page = pvmw->page;
 	pgd_t *pgd;
 	p4d_t *p4d;
-	pud_t *pud;
+	pud_t pude;
 	pmd_t pmde;
 
+	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
+		return not_found(pvmw);
+
 	/* The only possible pmd mapping has been handled on last iteration */
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
@@ -171,10 +174,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	p4d = p4d_offset(pgd, pvmw->address);
 	if (!p4d_present(*p4d))
 		return false;
-	pud = pud_offset(p4d, pvmw->address);
-	if (!pud_present(*pud))
+	pvmw->pud = pud_offset(p4d, pvmw->address);
+
+	/*
+	 * Make sure the pud value isn't cached in a register by the
+	 * compiler and used as a stale value after we've observed a
+	 * subsequent update.
+	 */
+	pude = READ_ONCE(*pvmw->pud);
+	if (pud_trans_huge(pude)) {
+		pvmw->ptl = pud_lock(mm, pvmw->pud);
+		if (likely(pud_trans_huge(*pvmw->pud))) {
+			if (pvmw->flags & PVMW_MIGRATION)
+				return not_found(pvmw);
+			if (pud_page(*pvmw->pud) != page)
+				return not_found(pvmw);
+			return true;
+		} else {
+			/* THP pud was split under us: handle on pmd level */
+			spin_unlock(pvmw->ptl);
+			pvmw->ptl = NULL;
+		}
+	} else if (!pud_present(pude))
 		return false;
-	pvmw->pmd = pmd_offset(pud, pvmw->address);
+
+	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
 	/*
 	 * Make sure the pmd value isn't cached in a register by the
 	 * compiler and used as a stale value after we've observed a
@@ -210,6 +234,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	} else if (!pmd_present(pmde)) {
 		return false;
 	}
+
 	if (!map_pte(pvmw))
 		goto next_pte;
 	while (1) {
diff --git a/mm/rmap.c b/mm/rmap.c
index dae66a4329ea..f69d81d4a956 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -789,9 +789,15 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 					referenced++;
 			}
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			if (pmdp_clear_flush_young_notify(vma, address,
-						pvmw.pmd))
-				referenced++;
+			if (pvmw.pmd) {
+				if (pmdp_clear_flush_young_notify(vma, address,
+							pvmw.pmd))
+					referenced++;
+			} else if (pvmw.pud) {
+				if (pudp_clear_flush_young_notify(vma, address,
+							pvmw.pud))
+					referenced++;
+			}
 		} else {
 			/* unexpected pmd-mapped page? */
 			WARN_ON_ONCE(1);
-- 
2.20.1

