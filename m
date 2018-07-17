Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523FCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13D220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUfYIkVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13D220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeGQK2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35887 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbeGQK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so247422plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rqUBE3nrPJNxyUZbF34Jw1mGvRMmmgEO8LCR8BLin+s=;
        b=oUfYIkVePYNjPWuVFdvVNAUKvE9W5d9EeR63zDlZ1c+WzKvh7G7b6fP5cGKw4ArMib
         R988IoBOH/dZpDDC5GPfJmn0sHRHEKeL1ACM+s71a4PvSJYJW2cozdbiAuffvk+p/Cm6
         BZm6yG3RUHYd8s4UtqAeS+pn34PVmHt92WCknaf300eEHHvPY4xVsEMh/aXHXiz17FWw
         ZN8nnwXN2WyiMoYOwvPDlcxbIUuTNQAjwJvzNT1HaaKwvr2MKennMi8Oe/f+SV9SAxgy
         CtDSLDYe5C31OALm1Guuhs2o1WRL40wrJXsGtzYzsk+ATIwZYaAYjHqbe2+S4sggJi7L
         jp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rqUBE3nrPJNxyUZbF34Jw1mGvRMmmgEO8LCR8BLin+s=;
        b=PAhsUehyFIQ/F3Ka67vWF0D809wMvCm+NAXRKAA5gQ0bg5eIhKTQrWVC0H4jFQ+nDN
         I7/CGK9jl/r0peRi5qafGpBEALoldjky8j4f768kv/mzuR3qtPv+v734ywrF18aLZ6Pv
         m6XQ99QJ+0LJAufuO/l7Iou6MIDQvi/wDyKT2SA2hje7irXYrf31vH8NaHyOb+0GRlF9
         vBy+YkZ5ci1tyIlWNrHWQ78mFI0AvE6+KVygkfOt10Jbs9trDgb2gfAWnCaRkZdyfPB3
         j95k2r8isLAzhMoffStq6d1EVgp6zFz1x+Yi4GwonHB0Me1KS1hvnAwD2k015ah3VNnR
         4Ldw==
X-Gm-Message-State: AOUpUlG0cWZYkaP95bZbSo61s+FniPbAS4KRDBQhph/sC1zEJGrWVRiK
        VSh5uiii9uTbbeWvXbJSbsM=
X-Google-Smtp-Source: AAOMgpdx1um3Z4NSLrik0+DyeKgi1d4GwpH8gIxJF2JLaxB1ogLf4UHPpp4jlE0GPhXGwJT+1tHwSA==
X-Received: by 2002:a17:902:1682:: with SMTP id h2-v6mr932288plh.327.1531821396019;
        Tue, 17 Jul 2018 02:56:36 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id u2-v6sm1232542pfn.59.2018.07.17.02.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:56:35 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] arm64/mm: Populate swapper_pg_dir by fixmap
Date:   Tue, 17 Jul 2018 17:56:07 +0800
Message-Id: <20180717095608.11008-6-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move swapper_pg_dir to .rodata section, we populate it by
fixmap.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 68 ++++++++++++++++++++++++++------
 arch/arm64/mm/mmu.c              |  2 +
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 46ef21ebfe47..d5c3df99af7b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -45,6 +45,13 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern pgd_t swapper_pg_end[];
+extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
+
 extern void __pte_error(const char *file, int line, unsigned long val);
 extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pud_error(const char *file, int line, unsigned long val);
@@ -428,8 +435,32 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PUD_TYPE_TABLE)
 #endif
 
+extern spinlock_t swapper_pgdir_lock;
+
+#define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
+#define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
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
+		pmd_t *fixmap_pmdp;
+
+		spin_lock(&swapper_pgdir_lock);
+		fixmap_pmdp = (pmd_t *)pgd_set_fixmap(__pa(pmdp));
+		WRITE_ONCE(*fixmap_pmdp, pmd);
+		dsb(ishst);
+		pgd_clear_fixmap();
+		spin_unlock(&swapper_pgdir_lock);
+		return;
+	}
+#endif
 	WRITE_ONCE(*pmdp, pmd);
 	dsb(ishst);
 }
@@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
+#ifdef __PAGETABLE_PUD_FOLDED
+	if (in_swapper_pgdir(pudp)) {
+		pud_t *fixmap_pudp;
+
+		spin_lock(&swapper_pgdir_lock);
+		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));
+		WRITE_ONCE(*fixmap_pudp, pud);
+		dsb(ishst);
+		pgd_clear_fixmap();
+		spin_unlock(&swapper_pgdir_lock);
+		return;
+	}
+#endif
 	WRITE_ONCE(*pudp, pud);
 	dsb(ishst);
 }
@@ -532,8 +576,19 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	WRITE_ONCE(*pgdp, pgd);
-	dsb(ishst);
+	if (in_swapper_pgdir(pgdp)) {
+		pgd_t *fixmap_pgdp;
+
+		spin_lock(&swapper_pgdir_lock);
+		fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
+		WRITE_ONCE(*fixmap_pgdp, pgd);
+		dsb(ishst);
+		pgd_clear_fixmap();
+		spin_unlock(&swapper_pgdir_lock);
+	} else {
+		WRITE_ONCE(*pgdp, pgd);
+		dsb(ishst);
+	}
 }
 
 static inline void pgd_clear(pgd_t *pgdp)
@@ -586,8 +641,6 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
-#define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
-#define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -712,13 +765,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
index d24be05ec1d4..acaeb726bf6a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -67,6 +67,8 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+DEFINE_SPINLOCK(swapper_pgdir_lock);
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-- 
2.17.1

