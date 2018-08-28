Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8512086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwRKkOpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8512086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeH1PMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:12:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeH1PMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:12:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so592929plq.5;
        Tue, 28 Aug 2018 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5LLVwzqsd0W3khip77eczbmhBS8m0M7MliDfum5fbo=;
        b=JwRKkOpxwjV2ovQ7J2Ho5+UlDBygiVUre+hfgsY9ifuXf7lMftdoyq0EjG5Y4wV9jI
         edNRMwartMVSqXKLDu9KmlMzCUzsjm1SEnGMe2GKjqwu5rEkfsiRHxxqwBpQMsqp84uM
         61qFr8Q4SUNZ52mt4/gmik+I7401vIvRBgcknLsZKC4trEXjn7k+zwZSc1V1G9+jFkyv
         BoW03rpPR4WSm6aaQuOxSQqpT2H0MJDPANu/Bs7ctr23p5f5jUTAAiVEgXGHIM0Ktpv1
         1j6HNaUmy1Rnx0kpiaEMO7Ut3drfbl2yP3OpVKcWN5uUo30RDYFEChjPVH3nS0A+Qxzg
         7TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5LLVwzqsd0W3khip77eczbmhBS8m0M7MliDfum5fbo=;
        b=TJ/ntPND7E8ovbwtdJymlsKtLNWfe2xAv16fDyokxtJTWZR8tbF0oanE5Vt8Q5BUcp
         Fc7jOCOoLvApw4yjO98qYGK3lStHROoB1EsYkiUAR6YBuL54pUAi2lwU8TAY4wJvrRzI
         BMRQKAwYrv/qZXNfQQEWKOAgzhnCDgU5M6O/LJw3sZL/k6k+93YMtFULNJbkrt9TW/n3
         voV9FN9TYTiZ9yBjeSAuZSFz+UltsJaPV8rrvLEuqQ5iizGK29PoxsmqPS6uWdswyGZI
         xdqAcaqF81NSAUHumuDveM1f3/SgcxSOt8gtG4tNGgTWyDCiU6MFnIMvnCFn88BJnyff
         MpBg==
X-Gm-Message-State: APzg51Aq5yFoc4z73fSF7V+ly8xudVd9wnqCBp3UrWwXsjL/zt4S8ksT
        8vv9Hzs2VGS8WMPyf5o9ERZY6bcK
X-Google-Smtp-Source: ANB0VdYR8Iq6a5/JlwAWF9iIuyrZ3FY50H+M9B7BfYKPAMTl0ScSRzxrBp5pb47wFpOFK+WGxxiTKg==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr1121540pln.17.1535455257066;
        Tue, 28 Aug 2018 04:20:57 -0700 (PDT)
Received: from roar.au.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3287917pgj.84.2018.08.28.04.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 04:20:56 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by demand based pte insertion
Date:   Tue, 28 Aug 2018 21:20:34 +1000
Message-Id: <20180828112034.30875-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828112034.30875-1-npiggin@gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the previous patch, this tries to optimise dirty/accessed
bits in ptes to avoid access costs of hardware setting them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 12 +++++++-----
 mm/memory.c      |  8 +++++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5fb1a43e12e0..2c169041317f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1197,6 +1197,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
 		pte_t entry;
 		entry = mk_pte(pages[i], vma->vm_page_prot);
+		entry = pte_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		memcg = (void *)page_private(pages[i]);
 		set_page_private(pages[i], 0);
@@ -2067,7 +2068,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
-	bool young, write, soft_dirty, pmd_migration = false;
+	bool young, write, dirty, soft_dirty, pmd_migration = false;
 	unsigned long addr;
 	int i;
 
@@ -2145,8 +2146,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		page = pmd_page(old_pmd);
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	page_ref_add(page, HPAGE_PMD_NR - 1);
-	if (pmd_dirty(old_pmd))
-		SetPageDirty(page);
+	dirty = pmd_dirty(old_pmd);
 	write = pmd_write(old_pmd);
 	young = pmd_young(old_pmd);
 	soft_dirty = pmd_soft_dirty(old_pmd);
@@ -2176,8 +2176,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = maybe_mkwrite(entry, vma);
 			if (!write)
 				entry = pte_wrprotect(entry);
-			if (!young)
-				entry = pte_mkold(entry);
+			if (young)
+				entry = pte_mkyoung(entry);
+			if (dirty)
+				entry = pte_mkdirty(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 		}
diff --git a/mm/memory.c b/mm/memory.c
index 3d8bf8220bd0..d205ba69918c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1830,10 +1830,9 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 out_mkwrite:
-	if (mkwrite) {
-		entry = pte_mkyoung(entry);
+	entry = pte_mkyoung(entry);
+	if (mkwrite)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-	}
 
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
@@ -2560,6 +2559,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
+		entry = pte_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3069,6 +3069,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
+	pte = pte_mkyoung(pte);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
@@ -3479,6 +3480,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
+	entry = pte_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
2.18.0

