Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4373BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8D22184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999284;
	bh=r1toWqNUpUj65PgkwWpmepcO2egSPI0Y6wBlsxkXcZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pNrWWg6nmI1KD+/I3VIHT9d/jRqqr4Bzm8a7AnJVbYNwZrv//tZAmnvu5L6bZh2k+
	 F7baCWEEkUBHvOKRjR5XNbQGQjoWKsyGcp80/TBdGPi01SDtSYvXOyEuz8pvaUAVKO
	 IpMzcqjjX4Zkkh/8htv0DQLP6wCu9uSeF8VHlLL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeL1MOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731111AbeL1MOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF4A218FE;
        Fri, 28 Dec 2018 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999276;
        bh=r1toWqNUpUj65PgkwWpmepcO2egSPI0Y6wBlsxkXcZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZhwkoCVEtSeylB+eWy8DIaqJGX4JXYDm65EzOuG/pEUB8jirzj28oToKENQfv/SV
         /xtF/bboQaoI9DZGjxook4Y2jpteY3PLMmoTLrfF+TLvcCdL9zYI/b2JiJMF0a1JAF
         3rVstFpmqR626biupKgAM1lthNbSuBjZS2HJZ8fY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/46] mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
Date:   Fri, 28 Dec 2018 12:52:26 +0100
Message-Id: <20181228113126.700810998@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a8874e7e8a8896f2b6c641f4b8e2473eafd35204 ]

Change the currently empty defines for __PAGETABLE_PMD_FOLDED,
__PAGETABLE_PUD_FOLDED and __PAGETABLE_P4D_FOLDED to return 1.
This makes it possible to use __is_defined() to test if the
preprocessor define exists.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/pgtable-2level.h    | 2 +-
 arch/m68k/include/asm/pgtable_mm.h       | 4 ++--
 arch/microblaze/include/asm/pgtable.h    | 2 +-
 arch/nds32/include/asm/pgtable.h         | 2 +-
 arch/parisc/include/asm/pgtable.h        | 2 +-
 include/asm-generic/4level-fixup.h       | 2 +-
 include/asm-generic/5level-fixup.h       | 2 +-
 include/asm-generic/pgtable-nop4d-hack.h | 2 +-
 include/asm-generic/pgtable-nop4d.h      | 2 +-
 include/asm-generic/pgtable-nopmd.h      | 2 +-
 include/asm-generic/pgtable-nopud.h      | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8a9af0..12659ce5c1f3 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -10,7 +10,7 @@
 #ifndef _ASM_PGTABLE_2LEVEL_H
 #define _ASM_PGTABLE_2LEVEL_H
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 /*
  * Hardware-wise, we have a two level page table structure, where the first
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 6181e4134483..fe3ddd73a0cc 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -55,12 +55,12 @@
  */
 #ifdef CONFIG_SUN3
 #define PTRS_PER_PTE   16
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define PTRS_PER_PMD   1
 #define PTRS_PER_PGD   2048
 #elif defined(CONFIG_COLDFIRE)
 #define PTRS_PER_PTE	512
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #else
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 7b650ab14fa0..2ca598534cc7 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -63,7 +63,7 @@ extern int mem_init_done;
 
 #include <asm-generic/4level-fixup.h>
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index d3e19a55cf53..9f52db930c00 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -4,7 +4,7 @@
 #ifndef _ASMNDS32_PGTABLE_H
 #define _ASMNDS32_PGTABLE_H
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #include <asm-generic/4level-fixup.h>
 #include <asm-generic/sizes.h>
 
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index fa6b7c78f18a..ff0860b2b21a 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -117,7 +117,7 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 #if CONFIG_PGTABLE_LEVELS == 3
 #define BITS_PER_PMD	(PAGE_SHIFT + PMD_ORDER - BITS_PER_PMD_ENTRY)
 #else
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define BITS_PER_PMD	0
 #endif
 #define PTRS_PER_PMD    (1UL << BITS_PER_PMD)
diff --git a/include/asm-generic/4level-fixup.h b/include/asm-generic/4level-fixup.h
index 89f3b03b1445..e3667c9a33a5 100644
--- a/include/asm-generic/4level-fixup.h
+++ b/include/asm-generic/4level-fixup.h
@@ -3,7 +3,7 @@
 #define _4LEVEL_FIXUP_H
 
 #define __ARCH_HAS_4LEVEL_HACK
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 #define PUD_SHIFT			PGDIR_SHIFT
 #define PUD_SIZE			PGDIR_SIZE
diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index 9c2e0708eb82..73474bb52344 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -3,7 +3,7 @@
 #define _5LEVEL_FIXUP_H
 
 #define __ARCH_HAS_5LEVEL_HACK
-#define __PAGETABLE_P4D_FOLDED
+#define __PAGETABLE_P4D_FOLDED 1
 
 #define P4D_SHIFT			PGDIR_SHIFT
 #define P4D_SIZE			PGDIR_SIZE
diff --git a/include/asm-generic/pgtable-nop4d-hack.h b/include/asm-generic/pgtable-nop4d-hack.h
index 0c34215263b8..1d6dd38c0e5e 100644
--- a/include/asm-generic/pgtable-nop4d-hack.h
+++ b/include/asm-generic/pgtable-nop4d-hack.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLY__
 #include <asm-generic/5level-fixup.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 /*
  * Having the pud type consist of a pgd gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 1a29b2a0282b..04cb913797bc 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -4,7 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define __PAGETABLE_P4D_FOLDED
+#define __PAGETABLE_P4D_FOLDED 1
 
 typedef struct { pgd_t pgd; } p4d_t;
 
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index f35f6e8149e4..b85b8271a73d 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -8,7 +8,7 @@
 
 struct mm_struct;
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index e950b9c50f34..9bef475db6fe 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -9,7 +9,7 @@
 #else
 #include <asm-generic/pgtable-nop4d.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 /*
  * Having the pud type consist of a p4d gets the size right, and allows
-- 
2.19.1



