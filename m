Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ABBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1D12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NACUYsVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1D12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeGRKzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:55:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43288 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeGRKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:55:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so1793225pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6oX/T2aqZ5QjmuziHOCFzAVK0PvgKTIm0p6fB9pnTE0=;
        b=NACUYsVXSgG5RbwevoxhsAWQHHaxPqiiQu+7bRKVWtPf7DVvHSpZ/C2Ju+v17b1gh1
         7n7rB/S7xU/N9HE+p+asJuX6CEWL+qjDqPv0ZnEOtMEnzrpaR0hdP7LLBx5fO6N39NVL
         F+EnKD3RAGDFt5CEYXXqOBlgVlWoSoBIZqLm8oKhMhnBLnc8uvBSEBHoKGmRhsh3RlF/
         X6kJzXifxCf8FatzVjb95SAPSxAcel4IPFLwDwM2zUGQb3xQVOob2bRugVICeh7Rx5CM
         RNZf6s5pYdrOb+70qxf/0ia31dbjxcPTgXgzCoof6o7UOsarARIEhtgxrqw7ptmcCgcr
         135Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6oX/T2aqZ5QjmuziHOCFzAVK0PvgKTIm0p6fB9pnTE0=;
        b=qdbv1guTf/Rh02TdYfnvIRb/XrY0inP0uxLezV2lhqA9Ws4fHH+MUCbMqzLew0PNXH
         nD/6IgF4Q0zzTIvWK/9R+hFqrQx4TqdCG9DxBvC2wJ0WpLpoLBBY6g9AEITJInozStNN
         k1iLzlC5ge5lx9lUN//XjQ6yaG/OSvZt8H51fMJ0mHDMSVhfoCUuIOwXIx4dw7YvMBPj
         CX944MV/nJxgmNSacBFER7TPAUv/rFZ228pfBwyEVFh18gGs6PsjzLxBoBoeClrGnCH+
         IgJ1/wjBlDM9deXhwRBd1pk4M+0OVFxutfNxU9gAo5H//wPtH7jENq25Ylx7kx2WweOc
         UtLg==
X-Gm-Message-State: AOUpUlHeGszm91r4kaF4Cv8OTIroI3jXCF5vIGc07bObQTxiDcdSOtVt
        EFk/y6rKflzFXaQj45HCdg871A==
X-Google-Smtp-Source: AAOMgpd8CwNmT0P3XWTLyXKS0gj7cKGvFbJyCvMClWdHXCalaJARGqQ49H6L6yfHZ7pwuXwGRX721w==
X-Received: by 2002:a63:2043:: with SMTP id r3-v6mr5288083pgm.105.1531909083211;
        Wed, 18 Jul 2018 03:18:03 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id x2-v6sm6899518pgq.33.2018.07.18.03.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:18:02 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 3/6] arm64/mm: Create initial page tables in
Date:   Wed, 18 Jul 2018 18:17:24 +0800
Message-Id: <20180718101727.10787-4-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create initial page tables in init_pg_dir and then create final
page tables in swapper_pg_dir directly.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h |  2 ++
 arch/arm64/kernel/head.S         |  9 ++++++---
 arch/arm64/mm/mmu.c              | 27 ++++++++-------------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1bdeca8918a6..46ef21ebfe47 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -712,6 +712,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c3e4b1886cde..ede2e964592b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -376,7 +376,7 @@ __create_page_tables:
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
-	adrp	x0, swapper_pg_dir
+	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	mov	x4, PTRS_PER_PGD
@@ -402,7 +402,6 @@ __create_page_tables:
 	adrp	x1, init_pg_end
 	sub	x1, x1, x0
 	bl	__inval_dcache_area
-
 	ret	x28
 ENDPROC(__create_page_tables)
 	.ltorg
@@ -439,6 +438,9 @@ __primary_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+	adrp	x0, init_pg_dir
+	bl	set_init_mm_pgd
+
 #ifdef CONFIG_KASAN
 	bl	kasan_early_init
 #endif
@@ -833,8 +835,9 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adrp	x1, swapper_pg_dir
+	adrp	x1, init_pg_dir
 	bl	__enable_mmu
+
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
 #ifdef CONFIG_RANDOMIZE_BASE
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..088a591e4ea4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -629,26 +629,10 @@ static void __init map_kernel(pgd_t *pgdp)
  */
 void __init paging_init(void)
 {
-	phys_addr_t pgd_phys = early_pgtable_alloc();
-	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
-
-	map_kernel(pgdp);
-	map_mem(pgdp);
-
-	/*
-	 * We want to reuse the original swapper_pg_dir so we don't have to
-	 * communicate the new address to non-coherent secondaries in
-	 * secondary_entry, and so cpu_switch_mm can generate the address with
-	 * adrp+add rather than a load from some global variable.
-	 *
-	 * To do this we need to go via a temporary pgd.
-	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
+	map_kernel(swapper_pg_dir);
+	map_mem(swapper_pg_dir);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
-
-	pgd_clear_fixmap();
-	memblock_free(pgd_phys, PAGE_SIZE);
+	init_mm.pgd = swapper_pg_dir;
 
 	/*
 	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
@@ -659,6 +643,11 @@ void __init paging_init(void)
 		      - PAGE_SIZE);
 }
 
+void __init set_init_mm_pgd(pgd_t *pgd)
+{
+	init_mm.pgd = pgd;
+}
+
 /*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
-- 
2.17.1

