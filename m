Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22535218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsfGy1P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfBRXNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:13:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36591 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbfBRXN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:13:26 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so1953726itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V1IdqbYubtCixESl5TR0muUvkg/E2O8mQvzM202vMJY=;
        b=bsfGy1P+JAaNzK2xsZmC2Tj104zGh/lur1QTBqvenBJ2/qYq2g/zlrWxNZQtQfM35p
         SvHcbH51aav58mTv6SC3r+eXafQV/q2wT7dySMfLdYtqGwd3IU4BO5OncxK0Sc1m+fIj
         nQfKurxrxsrekUV5Engn2LJyRILWrYvwJyz5n0SWzgddARHKb325HaCw91Il4vDU1Zx/
         mk9/PYlyIFAHhkP2hr5znpaOUFZOUpl6KFCa/NcBzVtwHJoN4RB7/T7YpN2vbUZpYTCL
         LQgIbfhf2ht7PVFcOoXfG78S2gMcj0aiK0WoV3lEAuUhwncWxtNbknbhAN1dIFxSI790
         gxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V1IdqbYubtCixESl5TR0muUvkg/E2O8mQvzM202vMJY=;
        b=ix+/27a2sxe0Lzn+2iN5AZYN1ROeWhA2bMgthcuZFWOK5mY3oqMUEoUD/MhcQWrTA+
         S2BtF/viW78JDcPsk7PwVcuZP5iQCyGdlm6/UpKQ5Ob0c2BMmr4Fho6FgZfUPYl+5KId
         lSXlQe5eAt9zIEyq+aYt9UiwzgjFkHMQXcogFgooPHQWWheC58cppSamkm99sJu6d/Xx
         yS8zvkDuUxNfoJZ5vBxts+dMIItrwmLAQVON7MAUh2BCDMKX/SwKYd9dMIOcBcqphdI7
         FVj6IckJVzxwStZKN7c3dCjv7KMuKGt+Gsyl5c1BHt/13rEDjFtPXbgKC2acfYRYkzlG
         frlQ==
X-Gm-Message-State: AHQUAuapBi6WCXO6p6LGi7gJzJrqR5YKdI+rPHed7J6XYCqTly82Ws3D
        6JZdhtVdtP+EZhy7+q2ps9/rpQ==
X-Google-Smtp-Source: AHgI3IZT6Mu4hL5CdKV5I1EiL7aKLnA6dLePkX8jtfw/N38Liese0eXKCRasVCtk+AF0ZUvijxlkeQ==
X-Received: by 2002:a24:7d88:: with SMTP id b130mr796701itc.163.1550531606189;
        Mon, 18 Feb 2019 15:13:26 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id x23sm6541463ion.38.2019.02.18.15.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 15:13:25 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 2/3] arm64: mm: don't call page table ctors for init_mm
Date:   Mon, 18 Feb 2019 16:13:18 -0700
Message-Id: <20190218231319.178224-2-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_mm doesn't require page table lock to be initialized at
any level. Add a separate page table allocator for it, and the
new one skips page table ctors.

The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
calling them avoids memory leak in case we call pte_free_kernel()
on init_mm.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fa7351877af3..e8bf8a6300e8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
+static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
+{
+	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
+	BUG_ON(!ptr);
+
+	/* Ensure the zeroed page is visible to the page table walker */
+	dsb(ishst);
+	return __pa(ptr);
+}
+
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
@@ -591,7 +601,7 @@ static int __init map_entry_trampoline(void)
 	/* Map only the text into the trampoline page table */
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
-			     prot, pgd_pgtable_alloc, 0);
+			     prot, pgd_kernel_pgtable_alloc, 0);
 
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
@@ -1067,7 +1077,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
+			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
+			     flags);
 
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   altmap, want_memblock);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

