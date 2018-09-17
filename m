Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF7DECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070FF214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5dlnXEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070FF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeIQKJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43579 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id 38-v6so1088688plc.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkoFmZF2SG37NQlyPtlxWTYmb6CPaLuv+Ifc2lHamuQ=;
        b=u5dlnXEvuPdLKQYDx1Fy1v2T9txUV53MTr1s4xpVLVY2tYO4gzKD375m478F7AIz/F
         bvMWQ+HR0B7X2Vd5dpOg2RRgVZaqLK+ZEuE0uXENvGzyWrW0jB6UvNbGal4jA/5wWKkB
         cKmUkA2kbIG9E/OPTCSLs8hEG0XJE3k6sbildQA6/jvcLVgC6m+ZRARIShJI2hZlwqoB
         BUVkTnZ4ZOPHFHsMaKmIvW5l5q/ddV9AXwOZgfyJaQRpd0IIn1OBZtN6ZZ5bymQVUf8f
         USzVyyu4KMxl5LE9b+2aXdBuS9nUix7v1NXHG7vU7yenArHV4VYYF0mMDgUlWc86F8Fu
         TFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkoFmZF2SG37NQlyPtlxWTYmb6CPaLuv+Ifc2lHamuQ=;
        b=EmQB8eO6ktOASKuhj5IByNY5e4siRnmVWwRKO9RKZOA56OPFovplaKBfHMwTChEBzN
         sQwDbmiPmO5EEif6lhBhSb6ovlEh17OYsj5u3kVIi8UUnuCa+YtQupF31Ssdo9e3Qv7L
         IrDQafMnuM9IchOZ5hHHK1F9Ib2RV5tZBohagjRhGc03Z0+0LKT5t/pbnwQ93bzuuiUE
         GskNfhZTXpDusYEePR8xmgcDp1etajMBF8G4xkDUQjE/xMi+rdxEHYD4/67UPB50APDN
         ojf/OP7I9Iu1MsVeOBY0lyjsUORl1hfHeNz0jGjoo2VD7MDzkwuqeVV4ObOSgiC1ZXfS
         O0Ow==
X-Gm-Message-State: APzg51AkD57hgVmYTfq6VSsTq5aQk/Xfyz3uXkZq0evlqxNduwJ0Ucs7
        zjEvLswPC8sESq2rZzzXTPbbN0Lcmgg=
X-Google-Smtp-Source: ANB0VdbOn+gSELpN+SYaa6MkPPP0frbIVmDOjJ1mVkpreE3+/GnNFXsUsSEQU7NuERR++56wgV7tpw==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr22888038plo.4.1537159443141;
        Sun, 16 Sep 2018 21:44:03 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:44:02 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] arm64/mm: Create the initial page table in the init_pg_dir.
Date:   Mon, 17 Sep 2018 12:43:30 +0800
Message-Id: <20180917044333.30051-4-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the initial page table in the init_pg_dir. And update the
init_mm.pgd to make sure that pgd_offset_k() works correctly. When
the final page table is created, we redirect the init_mm.pgd to the
swapper_pg_dir.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 arch/arm64/kernel/asm-offsets.c  | 1 +
 arch/arm64/kernel/head.S         | 9 +++++++--
 arch/arm64/mm/mmu.c              | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2ab2031b778c..b11d6fc62a62 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -718,6 +718,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..43f52cfdfad4 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -82,6 +82,7 @@ int main(void)
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
+  DEFINE(MM_PGD,		offsetof(struct mm_struct, pgd));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
   DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags));
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index de2aaea00bd2..cf8a58211b80 100644
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
@@ -439,6 +439,11 @@ __primary_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+	// Update init_mm.pgd
+	adrp	x0, init_pg_dir
+	adr_l	x1, init_mm
+	str	x0, [x1, #MM_PGD]
+
 #ifdef CONFIG_KASAN
 	bl	kasan_early_init
 #endif
@@ -833,7 +838,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adrp	x1, swapper_pg_dir
+	adrp	x1, init_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..af80dca335ce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -646,6 +646,7 @@ void __init paging_init(void)
 	cpu_replace_ttbr1(__va(pgd_phys));
 	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	init_mm.pgd = swapper_pg_dir;
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.17.1

