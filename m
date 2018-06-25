Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE653C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBAA25832
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik+VDWm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBAA25832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeFYLj5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:39:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50867 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbeFYLjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:39:53 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so11931699itg.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2lFn7USDatSKo+34aMjecwPwvfdgnz8msfCvGg8K2Y=;
        b=Ik+VDWm0KZlMSquL4CJZrTCHNLqWPscQs/ig3uZug28/1EbsWlEYq/sg47dH5tcHdE
         hNW1Ug0e+KRCPSOQV0QDD+OmaDdjO+R7spmXEsJ1uzQtTCsKICXJRQ2k55nbMOv/hTUV
         /Wp3n17VxmUovG5lFmztA6dyECOAOdnvoPBYHe4qL6SG7gikm5KDOh/7UlVL2MSMfviu
         gvenoPifJZDb9BLaVFN0YcDKvqN9T8LFV6aotvsRuIarJQap724Wphuz0qammEnKosSW
         zy06peQctUUirMX138fGnQQSOXbpIZARlJR2Ra9iFnQ8fEAh5Wa0EoNS1n0dnPw/E1PQ
         aIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2lFn7USDatSKo+34aMjecwPwvfdgnz8msfCvGg8K2Y=;
        b=EdxpLxYESMVOLAeHzNOfxU0G+rW5reMAtnHUa4HRAZBhkTnY0lTExFsak7rW22iJ74
         DRUH/xI6ARLRw2Y63pIj2X9UchRLvFcPvxBDo1KkToAfHHGT0dxYLJFUoslW6dzefvXo
         1GloZ9zu1/SD9cynvQb2HX0XdX3iUuy3vw7Lg0eozbPiFvDSTJAY0iQ/LPoLLdN5U9dV
         ygw6x4a2P2DTF68HY55B2FdGUoRS1pSJOz4ZJtzXhHjQ1fWjN5+vtQQYydan5u8OZ3K+
         cvQltcWyAe58KXAY1X5FucdPGNDtpDXxmzaMt3z6J9ZTvpwUn1qgeFCYj1BIE2UMcVqN
         IQng==
X-Gm-Message-State: APt69E1u7k0VoaVnMs2EVdTeIpYwgudKimOpviyXZccnrmitgq094GfG
        YzkJTcWn5r1Q89P5QBejQng=
X-Google-Smtp-Source: ADUXVKKO/fAv+GKaOKLGOFp6WtTo8ZwSxB6/Tw1x/nHQhBuf7m8tqYWjSx2IS1XOeMTcq4Pk1fTX0w==
X-Received: by 2002:a02:7157:: with SMTP id n23-v6mr9058231jaf.94.1529926792497;
        Mon, 25 Jun 2018 04:39:52 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id 200-v6sm3719207itw.4.2018.06.25.04.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 04:39:52 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v2 2/2] arm64/mm: Move {tramp_pg_dir, swapper_pg_dir} to .rodata section
Date:   Mon, 25 Jun 2018 19:39:21 +0800
Message-Id: <20180625113921.21854-3-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625113921.21854-1-yaojun8558363@gmail.com>
References: <20180625113921.21854-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ARM64_VA_BITS_36/CONFIG_ARM64_VA_BITS_39/
CONFIG_ARM64_VA_BITS_42 are selected, a block-mapping can be
written to swapper_pg_dir. To defend 'KSMA', we move swapper_pg_dir
to .rodata section when these configurations are selected. At the
same time, we update swapper_pg_dir by fixmap.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/fixmap.h  |  1 +
 arch/arm64/include/asm/pgalloc.h | 33 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h |  5 +++++
 arch/arm64/kernel/head.S         |  6 +++---
 arch/arm64/kernel/vmlinux.lds.S  | 23 ++++++++++++++++++++++
 arch/arm64/mm/mmu.c              |  6 ++++++
 6 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 62908eeedcdc..881784b43965 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -83,6 +83,7 @@ enum fixed_addresses {
 	FIX_PTE,
 	FIX_PMD,
 	FIX_PUD,
+	FIX_SWAPPER,
 
 	__end_of_fixed_addresses
 };
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2e05bcd944c8..62512ad9c310 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -49,6 +49,22 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 {
+#ifdef CONFIG_ARM64_VA_BITS_39
+	if (mm == &init_mm) {
+		pud_t *pud;
+		unsigned long offset;
+		extern spinlock_t pgdir_lock;
+
+		spin_lock(&pgdir_lock);
+		pud = (pud_t *)swapper_set_fixmap();
+		offset = (unsigned long)pudp - (unsigned long)swapper_pg_dir;
+		pud = (pud_t *)((unsigned long)pud + offset);
+		__pud_populate(pud, __pa(pmdp), PMD_TYPE_TABLE);
+		swapper_clear_fixmap();
+		spin_unlock(&pgdir_lock);
+		return;
+	}
+#endif
 	__pud_populate(pudp, __pa(pmdp), PMD_TYPE_TABLE);
 }
 #else
@@ -142,6 +158,23 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 	/*
 	 * The pmd must be loaded with the physical address of the PTE table
 	 */
+#if defined(CONFIG_ARM64_VA_BITS_42) || \
+	defined(CONFIG_ARM64_VA_BITS_36)
+	if (mm == &init_mm) {
+		pmd_t *pmd;
+		unsigned long offset;
+		extern spinlock_t pgdir_lock;
+
+		spin_lock(&pgdir_lock);
+		pmd = (pmd_t *)swapper_set_fixmap();
+		offset = (unsigned long)pmdp - (unsigned long)swapper_pg_dir;
+		pmd = (pmd_t *)((unsigned long)pmd + offset);
+		__pmd_populate(pmd, __pa(ptep), PMD_TYPE_TABLE);
+		swapper_clear_fixmap();
+		spin_unlock(&pgdir_lock);
+		return;
+	}
+#endif
 	__pmd_populate(pmdp, __pa(ptep), PMD_TYPE_TABLE);
 }
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b2435e8b975b..85743ea0709b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -592,6 +592,11 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
+#define swapper_set_fixmap() \
+	set_fixmap_offset(FIX_SWAPPER, __pa_symbol(swapper_pg_dir))
+
+#define swapper_clear_fixmap()	clear_fixmap(FIX_SWAPPER)
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9677deb7b6c7..9db187024b44 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -300,7 +300,7 @@ __create_page_tables:
 	 * dirty cache lines being evicted.
 	 */
 	adrp	x0, idmap_pg_dir
-	adrp	x1, swapper_pg_end
+	adrp	x1, idmap_pg_end
 	sub	x1, x1, x0
 	bl	__inval_dcache_area
 
@@ -313,7 +313,7 @@ __create_page_tables:
 	 * Clear the idmap and init page tables.
 	 */
 	adrp	x0, idmap_pg_dir
-	adrp	x1, swapper_pg_end
+	adrp	x1, idmap_pg_end
 	sub	x1, x1, x0
 	clear_pages x0, x1
 
@@ -404,7 +404,7 @@ __create_page_tables:
 	 * tables again to remove any speculatively loaded cache lines.
 	 */
 	adrp	x0, idmap_pg_dir
-	adrp	x1, swapper_pg_end
+	adrp	x1, idmap_pg_end
 	sub	x1, x1, x0
 	dmb	sy
 	bl	__inval_dcache_area
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b0e4255fcba4..db72c4680f1d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -219,6 +219,28 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
+	idmap_pg_end = .;
+
+#if defined(CONFIG_ARM64_VA_BITS_39) || \
+	defined(CONFIG_ARM64_VA_BITS_36) || \
+	defined(CONFIG_ARM64_VA_BITS_42)
+	.rodata : {
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+		. = ALIGN(PAGE_SIZE);
+		tramp_pg_dir = .;
+		. += PAGE_SIZE;
+#endif
+
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+		reserved_ttbr0 = .;
+		. += RESERVED_TTBR0_SIZE;
+#endif
+		swapper_pg_dir = .;
+		. += PAGE_SIZE;
+		swapper_pg_end = .;
+	}
+
+#else
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
@@ -232,6 +254,7 @@ SECTIONS
 	swapper_pg_dir = .;
 	. += PAGE_SIZE;
 	swapper_pg_end = .;
+#endif
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a3b5f1dffb84..fbaf3e9b4a43 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -66,6 +66,12 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+#if defined(CONFIG_ARM64_VA_BITS_39) || \
+	defined(CONFIG_ARM64_VA_BITS_36) || \
+	defined(CONFIG_ARM64_VA_BITS_42)
+DEFINE_SPINLOCK(pgdir_lock);
+#endif
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-- 
2.17.1

