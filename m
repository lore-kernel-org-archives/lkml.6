Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7014ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D616214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjR02qgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D616214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeIQKJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36749 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so6806002plk.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Fk9fXe8ItB7NNQBZ1iOm5Lbgu5ADOF2jlgYHOeLcG8=;
        b=bjR02qgJSMUORwYWPHL/fgqnX8h5O7fGD+nu4Sf7K9nvXqYx7WJlflhY6dS+Vl+Tg5
         JSeM4XbOPk8kbW3NeoSKPDCO/aQBviQEJOnKlwoMlxTxSJzgv2j53QaAsJ3XyrXg+BZH
         W1qLKCPeM7TAtDiAp+eN6mGCTe31NNMd42HTFXS1n6+db/Znl6QP7M/QD5g40e81XvuG
         uwZQM3c4igNCtqLJnOojcQrAjgi5OZXuVEHvutHb69S0weuJY//PL3l9IDpfMGrT7Fnq
         fb7NbpMfU0gN0cCXkK32StB/Hkq+dd9eLyahx3f+IpdYwrcsmksUa3+SFcbLfuMoFDtR
         3eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Fk9fXe8ItB7NNQBZ1iOm5Lbgu5ADOF2jlgYHOeLcG8=;
        b=m2jI5i8OyqypdPTJVWLD4Vzr/VHuUd1bDNmF135NM1phVO1KvGMi0CLT2KPsIULE3n
         tTC8DbTEkZI616K19qPKrNJXp9Bss9LA0G60BABlXrygqVSs6X/CK6O94rAUfZfE6rJz
         5v8LD0hsZEqxCwHnk1M/BPvryBjfbtiivOnE8KGkdp9Hr7LCYcD+satUjt/THNK+pREb
         hQMSW9mOhOyJbwFNVvMgl4FmqqXSs+tOsO78kGv886CFtz72GJh2bCZhtuc3Cc1vkmrV
         mW+2OrelDyTDKJ66DoQiOAV/yhiMZsy0Y3Io/P905y8yMULgMvEk+RO6qkHX/7eF/3SO
         Ejjg==
X-Gm-Message-State: APzg51BYgSNFF9uX6wLRCFiIjBKjB/pNcKKdhqUsSlmLGFzcpO1OSxU1
        ZM3j4+f+mbbVreXV68Yx1a4=
X-Google-Smtp-Source: ANB0VdZJeosyys34BFt8zZJS9aamMqOU+xkZcS256aqjF16GhOI/we1xZFIwGXKS44OwEF8jNyAFvQ==
X-Received: by 2002:a17:902:d211:: with SMTP id t17-v6mr23260127ply.258.1537159451556;
        Sun, 16 Sep 2018 21:44:11 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:44:11 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
Date:   Mon, 17 Sep 2018 12:43:32 +0800
Message-Id: <20180917044333.30051-6-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will move the swapper_pg_dir to rodata section, we need a
way to update it. The fixmap can handle it. When the swapper_pg_dir
needs to be updated, we map it dynamically. The map will be
canceled after the update is complete. In this way, we can defend
against KSMA(Kernel Space Mirror Attack).

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 38 ++++++++++++++++++++++++++------
 arch/arm64/mm/mmu.c              | 25 +++++++++++++++++++--
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b11d6fc62a62..9e643fc2453d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -429,8 +429,29 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PUD_TYPE_TABLE)
 #endif
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern pgd_t swapper_pg_end[];
+extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
+
+extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
+
+static inline bool in_swapper_pgdir(void *addr)
+{
+	return ((unsigned long)addr & PAGE_MASK) ==
+		((unsigned long)swapper_pg_dir & PAGE_MASK);
+}
+
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+#ifdef __PAGETABLE_PMD_FOLDED
+	if (in_swapper_pgdir(pmdp)) {
+		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
+		return;
+	}
+#endif
 	WRITE_ONCE(*pmdp, pmd);
 
 	if (pmd_valid(pmd))
@@ -484,6 +505,12 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
+#ifdef __PAGETABLE_PUD_FOLDED
+	if (in_swapper_pgdir(pudp)) {
+		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
+		return;
+	}
+#endif
 	WRITE_ONCE(*pudp, pud);
 
 	if (pud_valid(pud))
@@ -538,6 +565,10 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
+	if (in_swapper_pgdir(pgdp)) {
+		set_swapper_pgd(pgdp, pgd);
+		return;
+	}
 	WRITE_ONCE(*pgdp, pgd);
 	dsb(ishst);
 }
@@ -718,13 +749,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
-extern pgd_t init_pg_dir[PTRS_PER_PGD];
-extern pgd_t init_pg_end[];
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern pgd_t swapper_pg_end[];
-extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
-extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
-
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 71532bcd76c1..a8a60927f716 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -67,6 +67,24 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+static DEFINE_SPINLOCK(swapper_pgdir_lock);
+
+void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	pgd_t *fixmap_pgdp;
+
+	spin_lock(&swapper_pgdir_lock);
+	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
+	WRITE_ONCE(*fixmap_pgdp, pgd);
+	/*
+	 * We need dsb(ishst) here to ensure the page-table-walker sees
+	 * our new entry before set_p?d() returns. The fixmap's
+	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
+	 */
+	pgd_clear_fixmap();
+	spin_unlock(&swapper_pgdir_lock);
+}
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -629,8 +647,11 @@ static void __init map_kernel(pgd_t *pgdp)
  */
 void __init paging_init(void)
 {
-	map_kernel(swapper_pg_dir);
-	map_mem(swapper_pg_dir);
+	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+
+	map_kernel(pgdp);
+	map_mem(pgdp);
+	pgd_clear_fixmap();
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 	init_mm.pgd = swapper_pg_dir;
 }
-- 
2.17.1

