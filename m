Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A58C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3FB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH5eozon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3FB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeFTI60 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:58:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34266 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753386AbeFTI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:58:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so1277653pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQMpU0Ug4DYvWW8+W0pAUfsBe+XZS6vBuJb34NysVCg=;
        b=IH5eozonxgGO5K+5XRQaC3IDyWMKcP74vKoNvWU+v7KjvdMFa8MOM7h20YxTiuBjEy
         ImCxT3f+La3kqicWVNev6YgHxlyZ5ysOeZMqu18ORiGoTYKEOUXglRVZvpwPLVDlaP0O
         5Y+LV1X8Z7n42RcBFeQVqNyHwCGaR42wXAXtcKX4wmgJTaXSbFGplJMFvUHxFuO+3e5C
         6HvM1zqN2AbiCp6XBw9k+fxNgw+BsRu5CwDWWY/7hwskNzM4dbVAWbfvPQ4dxoSCYlFB
         eEQ6Io5c3up+D0+KYCNjSg5xdbCilnqZTh6NktifjDwx+xusbfNx838OxddkoDHAyMrH
         RMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TQMpU0Ug4DYvWW8+W0pAUfsBe+XZS6vBuJb34NysVCg=;
        b=KpzqP6+XILbwBHr/1Wiu0MTyKtKdXmlbBBNzPY7YAP2Wh66dM0r/wiO4VJQ7tOZHZV
         kfxRSk6RsKOy+/A7iMJ6tfnDiPfjsTuHW3nOx3rtR1Xd+dojVF2VjqTtQuFIm6bRCrj1
         VpO41U90MRxhiGGYOe74uMy69DwY00fBfXv0nsPUpCRUQiYoG2QFq2qP41ApLUNkY8lV
         gnDhgo6OcSq7R0DwNlSpiuOKDtK/kT6C4FFR1JXDEVYn7iIJ9zxqLxBpNaffCXEBzaAY
         XKrw/vFC/8gYFDPDLqchS3PXDiBmJ1rSGxuQAO9r9Z3GnVXNCTaAiRh+9OMRxFhA0MRy
         oHcw==
X-Gm-Message-State: APt69E0YP683O+W6IEV7/hhwkveV6SgZPL5QoYWajag7N2bn/alNlFhj
        GVsui4+ID5NUc72xaMuIoI4=
X-Google-Smtp-Source: ADUXVKL0v3RJbIGyxvfsEkVVtqLPuOoO0+19aShfUhe1WsTmtbk6j1MEdm7WIcDUZUUKmmndVt2xdA==
X-Received: by 2002:a63:2c9:: with SMTP id 192-v6mr2273029pgc.354.1529485099957;
        Wed, 20 Jun 2018 01:58:19 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id i65-v6sm5350257pfd.17.2018.06.20.01.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:58:19 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 1/1] arm64/mm: move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata section
Date:   Wed, 20 Jun 2018 16:57:55 +0800
Message-Id: <20180620085755.20045-2-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620085755.20045-1-yaojun8558363@gmail.com>
References: <20180620085755.20045-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
section. And update the swapper_pg_dir by fixmap.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgalloc.h | 19 +++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S  | 32 ++++++++++++++++++--------------
 arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++----
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2e05bcd944c8..cc96a7e6957d 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -29,6 +29,10 @@
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
+#if CONFIG_STRICT_KERNEL_RWX
+extern spinlock_t pgdir_lock;
+#endif
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -78,6 +82,21 @@ static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, pud_t *pudp)
 {
+#if CONFIG_STRICT_KERNEL_RWX
+	if (mm == &init_mm) {
+		pgd_t *pgd;
+
+		spin_lock(&pgdir_lock);
+		pgd = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+
+		pgd = (pgd_t *)((unsigned long)pgd + pgdp - swapper_pg_dir);
+		__pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
+
+		pgd_clear_fixmap();
+		spin_unlock(&pgdir_lock);
+		return;
+	}
+#endif
 	__pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
 }
 #else
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..86532c57206a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -216,21 +216,25 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
-#endif
-	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
-	swapper_pg_end = .;
+	.rodata : {
+		. = ALIGN(PAGE_SIZE);
+		idmap_pg_dir = .;
+		. += IDMAP_DIR_SIZE;
+
+		#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+		tramp_pg_dir = .;
+		. += PAGE_SIZE;
+		#endif
+
+		#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+		reserved_ttbr0 = .;
+		. += RESERVED_TTBR0_SIZE;
+		#endif
+		swapper_pg_dir = .;
+		. += SWAPPER_DIR_SIZE;
+		swapper_pg_end = .;
+	}
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..c1aa85a6ada5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -66,6 +66,10 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+DEFINE_SPINLOCK(pgdir_lock);
+#endif
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -417,12 +421,22 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 
 void __init mark_linear_text_alias_ro(void)
 {
+	unsigned long size;
+
 	/*
 	 * Remove the write permissions from the linear alias of .text/.rodata
+	 *
+	 * We free some pages in .rodata at paging_init(), which generates a
+	 * hole. And the hole splits .rodata into two pieces.
 	 */
+	size = (unsigned long)swapper_pg_dir + PAGE_SIZE - (unsigned long)_text;
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
-			    (unsigned long)__init_begin - (unsigned long)_text,
-			    PAGE_KERNEL_RO);
+			    size, PAGE_KERNEL_RO);
+
+	size = (unsigned long)__init_begin - (unsigned long)swapper_pg_end;
+	update_mapping_prot(__pa_symbol(swapper_pg_end),
+			    (unsigned long)lm_alias(swapper_pg_end),
+			    size, PAGE_KERNEL_RO);
 }
 
 static void __init map_mem(pgd_t *pgdp)
@@ -587,8 +601,9 @@ static void __init map_kernel(pgd_t *pgdp)
 	 */
 	map_kernel_segment(pgdp, _text, _etext, text_prot, &vmlinux_text, 0,
 			   VM_NO_GUARD);
-	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
-			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
+	map_kernel_segment(pgdp, __start_rodata, __inittext_begin,
+			   PAGE_KERNEL, &vmlinux_rodata,
+			   NO_CONT_MAPPINGS | NO_BLOCK_MAPPINGS, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
 			   &vmlinux_inittext, 0, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
-- 
2.17.1

