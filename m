Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7569CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4247E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="iheGcVmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfAGQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:11:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:11:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so348745pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CSYWd6VeFZK8P72VO6QNWHyKLKv+RHglMAIawF/x8uk=;
        b=iheGcVmBnGNRZU3bCLq2c45+BKRGm2ge/n6wBqlJo88S5ApAC2vyibvQG/BZ+uKJau
         7MZECl+8mdL7EfUkhZbf+l061G3Rez+3xIM6q4a7uudhIiV2gMhB4LvYEkyBlymkxDz+
         YFWVJx07s/+MT1XD4yX0rsCwzOl3JWzGlr/v1WKkjCgzHjGesRZng/VUkSikdIJV5t1L
         r7zJe+AnWwNz7AJwd1KkkkW27OjnbolOm2tK2qj1GnFIZaqT2Ynm9MfvqErrXpKy5OHB
         gEHzX3r7Jaosj3Fd1BACYFHZtjUVb1QJeIadRAXDWZDY9WOyXSXiOtiwIJgmBN/2ou0i
         GvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CSYWd6VeFZK8P72VO6QNWHyKLKv+RHglMAIawF/x8uk=;
        b=cOO2VrMTIof537g/Il9CPNXi6WA1qQTT4MHjJGDIiBOZzs19JutLBmLU+gj95zj6zf
         UopcW9dRjzy5wevj0u1Ln/C/y674dXd9X4atI3XG8+GbFKUJwrSDGPW4XvQl3VTV/ety
         wRFC6p6RYIjGnpIszf9ikA7Z6aBew2DmCLx6CqnFxTO8KthlkP7cXWm4vnske6J+vxu1
         4m72cI1msUdPX8mHusx8Y5cBvF8mnNIUMbmc6UX8wjXgJpGLaxBRuUpGv2ghBIYf4zED
         W1Yj13eZ8hIAfWSTLk0ic8+whOpZQ9NPOl0b1Ewc9biiUGNrLh7K0Y3FnDksZXkDXrD4
         +ThA==
X-Gm-Message-State: AJcUukd4KaqBncjalRVAhUt4mrZLZEKUB5criErcx391+q6iGrReusG8
        +8e4K2+CTKzJeE1J66tk9idXcg==
X-Google-Smtp-Source: ALg8bN6RTmQpLYFPorPual2M7RwPK9lJ3CXTe3NMKljh56xYmRBUArCfZKtTyXAkpSEOpSVRoHMrPg==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr11301316pgi.291.1546877482641;
        Mon, 07 Jan 2019 08:11:22 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.214])
        by smtp.gmail.com with ESMTPSA id a10sm93243512pfi.138.2019.01.07.08.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:11:22 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 3/5] RISC-V: Move setup_bootmem() to mm/init.c
Date:   Mon,  7 Jan 2019 21:40:45 +0530
Message-Id: <20190107161047.10516-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107161047.10516-1-anup@brainfault.org>
References: <20190107161047.10516-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

The setup_bootmem() mainly populates memblocks and does
early memory reservations. The right location for this
function is mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/setup.c        | 48 ++++----------------------------
 arch/riscv/mm/init.c             | 40 ++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 16301966d65b..35893810cba3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -404,6 +404,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define kern_addr_valid(addr)   (1) /* FIXME */
 #endif
 
+extern void setup_bootmem(void);
 extern void paging_init(void);
 
 static inline void pgtable_cache_init(void)
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f7132547b8b3..49a13b98e13f 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -156,49 +156,6 @@ void __init parse_dtb(unsigned int hartid, void *dtb)
 	early_init_dt_scan(__va(dtb));
 }
 
-static void __init setup_bootmem(void)
-{
-	struct memblock_region *reg;
-	phys_addr_t mem_size = 0;
-
-	/* Find the memory region containing the kernel */
-	for_each_memblock(memory, reg) {
-		phys_addr_t vmlinux_end = __pa(_end);
-		phys_addr_t end = reg->base + reg->size;
-
-		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
-			/*
-			 * Reserve from the start of the region to the end of
-			 * the kernel
-			 */
-			memblock_reserve(reg->base, vmlinux_end - reg->base);
-			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
-		}
-	}
-	BUG_ON(mem_size == 0);
-
-	set_max_mapnr(PFN_DOWN(mem_size));
-	max_low_pfn = memblock_end_of_DRAM();
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif /* CONFIG_BLK_DEV_INITRD */
-
-	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
-	memblock_allow_resize();
-	memblock_dump_all();
-
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
-		unsigned long end_pfn = memblock_region_memory_end_pfn(reg);
-
-		memblock_set_node(PFN_PHYS(start_pfn),
-		                  PFN_PHYS(end_pfn - start_pfn),
-		                  &memblock.memory, 0);
-	}
-}
-
 void __init setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _stext;
@@ -211,6 +168,11 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	setup_bootmem();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	paging_init();
 	unflatten_device_tree();
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f354486f9b78..d0965979ee70 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/swap.h>
 #include <linux/sizes.h>
+#include <linux/of_fdt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
@@ -62,3 +63,42 @@ void free_initmem(void)
 {
 	free_initmem_default(0);
 }
+
+void __init setup_bootmem(void)
+{
+	struct memblock_region *reg;
+	phys_addr_t mem_size = 0;
+
+	/* Find the memory region containing the kernel */
+	for_each_memblock(memory, reg) {
+		phys_addr_t vmlinux_end = __pa(_end);
+		phys_addr_t end = reg->base + reg->size;
+
+		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
+			/*
+			 * Reserve from the start of the region to the end of
+			 * the kernel
+			 */
+			memblock_reserve(reg->base, vmlinux_end - reg->base);
+			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
+		}
+	}
+	BUG_ON(mem_size == 0);
+
+	set_max_mapnr(PFN_DOWN(mem_size));
+	max_low_pfn = memblock_end_of_DRAM();
+
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+	memblock_allow_resize();
+	memblock_dump_all();
+
+	for_each_memblock(memory, reg) {
+		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
+		unsigned long end_pfn = memblock_region_memory_end_pfn(reg);
+
+		memblock_set_node(PFN_PHYS(start_pfn),
+				  PFN_PHYS(end_pfn - start_pfn),
+				  &memblock.memory, 0);
+	}
+}
-- 
2.17.1

