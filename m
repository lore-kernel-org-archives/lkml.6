Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A56DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AB721480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhj1GQyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AB721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeHVNTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:19:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36098 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeHVNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:19:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17-v6so702128pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhiRo5euohY0qRDPRlAachgxOwjWu91BdFVOTXvJo7c=;
        b=uhj1GQyKsUXQT91Y1UVp+ud+mRBMqyq9RSIrlKqj2JDR5tb/+lQl1myl2AkIL+VQ5m
         w/On/qBXHdLvwXi1plMnTy8lNyW91ii46345YGs15gJxyVFsn9WNG8WV4oceeyNormFo
         V6lmcs7TWj+BkxbVfBKzKnqBCnZjgcRKZfH8+7mNDocPUrdh0nEszLX8oFEIXPBuLylS
         Tu8Ss0LcOHnQ8PNl5i7eLtZR3Sld/fGBndjiiuSn1WJBp8uMHW+jIF+f6Ijl7xVJEpoj
         NDHy7ic8wjcPP4dSlb0fvbLWWqwLaqAXmJ5RBQRoRDsjVnfdVI4ogMBJS9KYrRtswHgl
         5GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhiRo5euohY0qRDPRlAachgxOwjWu91BdFVOTXvJo7c=;
        b=H/JpYfAb9TxiLh2/vjDle6XEJ9ThXjiA0R2i6TYR7Q+K+G9IBg5Ar/W6ht+jIblGAn
         xD2bP1aAN7BiwVcvYgzkupdOqjvfG0YxPqjzOeWWiORvtCmRUuwHyjuZEYYpI13ppp9C
         8pvgHbXH1EBVLYJ8y1GnVa9ha7frGEUqAsMdYGF6BziUH8hOva9Wt8MAOEe5QmgegL3C
         lwQqApyvs0ukaPEtruaYjDVKxn7uuXovsPyognYE2NZfVDJxPBtjSKegk8CDI997ujCi
         XrEKwvQRiRYjLSQrg5fHoDrLwYVFIp4hfpUPQvpElW/FNUiFoNnIMNLNOwgRyy2iOAmw
         wrWQ==
X-Gm-Message-State: AOUpUlF9ZyTwDocZ5wba52AZXZ4KnM2K93OJ7BkKtMeSqi+qIHXXNo1C
        yzqp69WE0dLKrNTA2QckI7w=
X-Google-Smtp-Source: AA+uWPxMQJYePJMeaGE2jLsATCS5z8/od7Oqb9LKbuyM7G0VU0pg4n4XXDrfdTJGSSblmK9d/4ABsw==
X-Received: by 2002:a62:20f:: with SMTP id 15-v6mr57415788pfc.100.1534931689449;
        Wed, 22 Aug 2018 02:54:49 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:49 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 3/6] arm64/mm: Create the initial page table in the init_pg_dir.
Date:   Wed, 22 Aug 2018 17:54:29 +0800
Message-Id: <20180822095432.12125-4-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the initial page table in the init_pg_dir. And before
calling kasan_early_init(), we update the init_mm.pgd by
introducing set_init_mm_pgd(). This will ensure that pgd_offset_k()
works correctly. When the final page table is created, we redirect
the init_mm.pgd to the swapper_pg_dir.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h |  2 ++
 arch/arm64/kernel/head.S         |  9 ++++++---
 arch/arm64/mm/mmu.c              | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

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
index 65f86271f02b..f7e544f6f3eb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -623,6 +623,19 @@ static void __init map_kernel(pgd_t *pgdp)
 	kasan_copy_shadow(pgdp);
 }
 
+/*
+ * set_init_mm_pgd() just updates init_mm.pgd. The purpose of using
+ * assembly is to prevent KASAN instrumentation, as KASAN has not
+ * been initialized when this function is called.
+ */
+void __init set_init_mm_pgd(pgd_t *pgd)
+{
+	pgd_t **addr = &(init_mm.pgd);
+
+	asm volatile("str %x0, [%1]\n"
+			: : "r" (pgd), "r" (addr) : "memory");
+}
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps and sets up the zero page.
@@ -646,6 +659,7 @@ void __init paging_init(void)
 	cpu_replace_ttbr1(__va(pgd_phys));
 	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	set_init_mm_pgd(swapper_pg_dir);
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.17.1

