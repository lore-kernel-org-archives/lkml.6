Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0255C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF3721480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1tazlfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF3721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeHVNTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:19:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45732 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeHVNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:19:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4-v6so173877pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gedi0Iu1aBcxJqNX97aA3bWPY2S3OoJ67xo3yFH8mUU=;
        b=C1tazlfMJxvL2YDYIcp3AFZGuDp8l5wspBxBCmf/MtdT18JTYHRhmww+4nCrspEam6
         Za67r+JEMiwly/1V6KIBKuYFVxRn+R/0QZbMDO/EkcZCs07G4HMJzQ0nZJUE+1oKwa5K
         nJIAN6UtA6vO/+otKdc4Fc0cI1g7m6f/bbd2yJW14nUBF3vavT1iaeS2b4aYqW6dzwHi
         sA+A33O5HPh7XAe+tUtlWShUHbB64nzWceA/zzohJmfR6OEtxXd9XRevwDSgvnSZqche
         vqK09hYBPqZPzN0EpZA7gpxXu3HLudhX+Ea+yQm1Qk81ZEQ04221Catkv6KxYIDB567t
         xX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gedi0Iu1aBcxJqNX97aA3bWPY2S3OoJ67xo3yFH8mUU=;
        b=O9ALGU6vTkVs7Ep8jK/IX2lca3vHhDssu3Mp1s1/KsYny4bmTU4K20GHxO1yqkZPig
         K6nyB2EnaV2nScVhyUOypqZgKVkqbyOxiAL36lQoIBIzZHGKT6Bb8Iu/M6wKvENMS4Df
         +DsDwhfITGUp7Z/6XIEC7sn983ddCco+Bd1Kq3q71bKQpt3Sme9Dcbz44O1DPKCQr/4l
         mCo/Tz/2T2Ylo8TUzCe4bE4xBirVVObkr6yTsGuACb79BRSFlPPEKu2X8tEv2zCiRIK2
         dWpSgWXEraWtoQ/wVwL1fJjTH8175W8wP00xfVCPi7ebhG4/CT5X+bSnBMY+7pcK0k9Q
         87AQ==
X-Gm-Message-State: AOUpUlGZH8j0KToopZVFXKGZ8Ny/rWg8YCM8looLoJdKoN+qojGB1e+p
        V5ajfKzAv21iqeFR/WBSFYk=
X-Google-Smtp-Source: AA+uWPyj5eDaH60i0VEEJGStJBjsSgS7IgmetdbhVYaWgQQotVND2LaQfSJ6U2yhC16g+xC7XcEPrg==
X-Received: by 2002:a63:5d4b:: with SMTP id o11-v6mr14305643pgm.349.1534931693727;
        Wed, 22 Aug 2018 02:54:53 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:53 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
Date:   Wed, 22 Aug 2018 17:54:31 +0800
Message-Id: <20180822095432.12125-6-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
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
index b7f9afb628ac..691a05bbf87b 100644
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

