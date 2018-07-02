Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91515C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E025A96
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkjP2AUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E025A96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965232AbeGBLR5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:17:57 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33651 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeGBLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:17:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so7015689pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dGe2hRi0AlnT2aT6NqRt4w2LRwijmcObRQv6royeZnQ=;
        b=CkjP2AUgPfGrvxrWm7mJSZx0nohRb/ngFDdbfGhkEk9zXiWX/l9tqWaVKj3kkVn06/
         KL6h+ankTFM+u1YpQjHOlTgRam90qITNtaNMdO/r8QhwdHnO2L2wnBTqNEG+dg5MfW0X
         +sFeSJa1otKH51RuBMyJAmX9+9KQ6wyhBP+c9SQI7y39vo7TeVbJWvm9Pn++RTYj+2IM
         E1wMNQg96lBRNr1RFeiuFz4ca1ERxCnfujI5HjQR3CNKCXNc0cajdS6ESjmmldvZYyY6
         xg/Coq6AtsXwpSHZ1azgt15WyqDmokjpJ4qfDXyRyNRbsULcoUfHpKJN3wxtInSKjaST
         HLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dGe2hRi0AlnT2aT6NqRt4w2LRwijmcObRQv6royeZnQ=;
        b=Dh0N0d0ewkSYUU+nfQruTqgChH73Fv4hQtzD6lh0DQZFEhWBjohZ9ZHkigvRQaeHrq
         fmZhzN8HWQzqKixFTpf1AdHZ11qPWCoPy/gfsYZdX4iM4SipGdmJZ9x2f7l9b6NUKSBh
         eCO6aQ0O+AYItQ2RgRtk2Sf+w7FqI3sJngGc77SbyuJW6dLfxySPGALuA/qMlFSGw2TG
         3nvSPIOcWlpM6b99UdfhHBevmIueD3nb1N15ytJnMPyBD4EHuYjKz27As6VdXIc4fKus
         C5fq87Saa08o51B+DwKPrV5vdSpTGv4SWZgxmy3YR+M3Qv7d/GwQ0sFu7ezLMi0iNNwd
         F2Fw==
X-Gm-Message-State: APt69E3pZSDX0j0zVmm36zM1o8VPAZgrrT9dlflgWdpxNl8B7CDbWC3O
        n7e74DluBeahCz+Av1CppFyGIQ==
X-Google-Smtp-Source: AAOMgpfiWU6wgUbM5gl16k9iT72VU+H4NuTbpUafDFkV/FJbsm9dKjnAD5bLq16CQ4JuwFjcIuUVig==
X-Received: by 2002:a62:e413:: with SMTP id r19-v6mr6887048pfh.25.1530530270019;
        Mon, 02 Jul 2018 04:17:50 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s2-v6sm11262150pfh.186.2018.07.02.04.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:17:49 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section
Date:   Mon,  2 Jul 2018 19:16:59 +0800
Message-Id: <20180702111659.25570-6-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move {idmap_pg_dir, swapper_pg_dir} to .rodata section and
populate swapper_pg_dir by fixmap.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgalloc.h | 48 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h | 15 +++++-----
 arch/arm64/kernel/vmlinux.lds.S  | 22 +++++++++------
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2e05bcd944c8..a0ce7d0f81c5 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -29,6 +29,23 @@
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
+static inline int in_swapper_dir(void *addr)
+{
+	if ((unsigned long)addr >= (unsigned long)swapper_pg_dir &&
+		(unsigned long)addr < (unsigned long)swapper_pg_end) {
+		return 1;
+	}
+	return 0;
+}
+
+static inline void *swapper_mirror_addr(void *start, void *addr)
+{
+	unsigned long offset;
+
+	offset = (unsigned long)addr - (unsigned long)swapper_pg_dir;
+	return start + offset;
+}
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -49,6 +66,17 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 {
+#ifdef __PAGETABLE_PUD_FOLDED
+	if ((mm == &init_mm) && in_swapper_dir(pudp)) {
+		pud_t *pud;
+
+		pud = pud_set_fixmap(__pa_symbol(swapper_pg_dir));
+		pud = (pud_t *)swapper_mirror_addr(pud, pudp);
+		__pud_populate(pud, __pa(pmdp), PMD_TYPE_TABLE);
+		pud_clear_fixmap();
+		return;
+	}
+#endif
 	__pud_populate(pudp, __pa(pmdp), PMD_TYPE_TABLE);
 }
 #else
@@ -78,6 +106,15 @@ static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, pud_t *pudp)
 {
+	if ((mm == &init_mm) && in_swapper_dir(pgdp)) {
+		pgd_t *pgd;
+
+		pgd = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+		pgd = (pgd_t *)swapper_mirror_addr(pgd, pgdp);
+		__pgd_populate(pgd, __pa(pudp), PUD_TYPE_TABLE);
+		pgd_clear_fixmap();
+		return;
+	}
 	__pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
 }
 #else
@@ -139,6 +176,17 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 {
+#ifdef __PAGETABLE_PMD_FOLDED
+	if (in_swapper_dir(pmdp)) {
+		pmd_t *pmd;
+
+		pmd = pmd_set_fixmap(__pa_symbol(swapper_pg_dir));
+		pmd = (pmd_t *)swapper_mirror_addr(pmd, pmdp);
+		__pmd_populate(pmd, __pa(ptep), PMD_TYPE_TABLE);
+		pmd_clear_fixmap();
+		return;
+	}
+#endif
 	/*
 	 * The pmd must be loaded with the physical address of the PTE table
 	 */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3b408f21fe2e..b479d1b997c2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -475,6 +475,9 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
  */
 #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
 
+#define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
+#define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
@@ -506,11 +509,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #define pmd_offset_phys(dir, addr)	(pud_page_paddr(READ_ONCE(*(dir))) + pmd_index(addr) * sizeof(pmd_t))
 #define pmd_offset(dir, addr)		((pmd_t *)__va(pmd_offset_phys((dir), (addr))))
 
-#define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
 #define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(pud, addr))
-#define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
 
 #define pud_page(pud)		pfn_to_page(__phys_to_pfn(__pud_to_phys(pud)))
+#define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
+#define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
 
 /* use ONLY for statically allocated translation tables */
 #define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
@@ -518,11 +521,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #else
 
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
+#define pud_set_fixmap(addr)		NULL
+#define pud_clear_fixmap()
 
 /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
-#define pmd_set_fixmap(addr)		NULL
 #define pmd_set_fixmap_offset(pudp, addr)	((pmd_t *)pudp)
-#define pmd_clear_fixmap()
 
 #define pmd_offset_kimg(dir,addr)	((pmd_t *)dir)
 
@@ -558,9 +561,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pud_offset_phys(dir, addr)	(pgd_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
 #define pud_offset(dir, addr)		((pud_t *)__va(pud_offset_phys((dir), (addr))))
 
-#define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
 #define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
-#define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
 
 #define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
 
@@ -572,9 +573,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
 
 /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
-#define pud_set_fixmap(addr)		NULL
 #define pud_set_fixmap_offset(pgdp, addr)	((pud_t *)pgdp)
-#define pud_clear_fixmap()
 
 #define pud_offset_kimg(dir,addr)	((pud_t *)dir)
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index d69e11ad92e3..beff018bf0f9 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -223,21 +223,25 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
+
+	.rodata : {
+		. = ALIGN(PAGE_SIZE);
+		idmap_pg_dir = .;
+		. += IDMAP_DIR_SIZE;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
+		tramp_pg_dir = .;
+		. += PAGE_SIZE;
 #endif
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
+		reserved_ttbr0 = .;
+		. += RESERVED_TTBR0_SIZE;
 #endif
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-	swapper_pg_end = .;
+		swapper_pg_dir = .;
+		. += PAGE_SIZE;
+		swapper_pg_end = .;
+	}
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.17.1

