Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B3C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BB327265
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gnpx/BmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BB327265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeF1Ktk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:49:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41595 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbeF1Ktj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:49:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so2580521ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=6fXebd9EPRi5L5odUT2ucVtJeMU91E2RPHkOOxwSQs4=;
        b=Gnpx/BmUoFNLhRR3Mpp6Jt0JTIJjuIu41yH81dHzhghuH1Vwq2kA372rGjCApPB2+j
         Cx1tBf8d52rtJDLi/hi8MmV56PccXX0etMBHoew3GhhjmQmGTQ8Q2fafLMLGvkN87Xhe
         3M12e+oW/77JVs5whlQg9rXImYraDi8KXtnX+SR26l6RGkGzP1FFSBgnxYY+Lv8YZjE2
         FTHksfofTtKV5Ob6G0pE/7T1NjYLb9kueOArNVPia8N+aUHP54iPg589o+wXkk7GEdk4
         Zqw389icZ4gS5QLHANK3o0Soz/N2sH42kJGisvqGwXhZN9+3+UfWlXoQ+4WLgcz2JEE+
         XX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6fXebd9EPRi5L5odUT2ucVtJeMU91E2RPHkOOxwSQs4=;
        b=dMKNTfJ9aT5iNppP+9vsytd7PnBjE8qyibNq3CxkPoXF87OQSOc4dwr0alBfCb0c9c
         IAF9nuIj5WY8Niw9TAqP6SrRSu9qyra/OJEP9UvSpYQ2A4Nn4tXcFuuoSJqr7w1bvMWV
         7GxZr7MtNzVyf3XcoJLLP5m6fJlfIucvfL1X6JOJPV/6FplSKR0epIMFTAm96zMBY6HU
         pKU/eP+UWdNwpL10IYf7oo/IyZqAHFGJHapfi9tz4tnJQCXCikWvJ6QtLevrj2yUoxdy
         v44I4bMvoQs1va2QLodFz4DCUqTv9h2B/SN0gU3X6eTEQns+PW5igaqrhuH4BPYItN1M
         NAjA==
X-Gm-Message-State: APt69E0kRq6YnDNjOvWHbhJuPOCNGt5X9Sl5dxuwnEU35BQ0OfFLiEcp
        HPwgdXCS6eDjb2y6urR9HrY=
X-Google-Smtp-Source: ADUXVKIoZanZtIa91urBK1a+Rag+ELjiwTfZjDPP9t0/Vv7eabllzCa7cLy2IkAhc9TTdYa2Ihk4dA==
X-Received: by 2002:a17:902:1e4:: with SMTP id b91-v6mr9989532plb.155.1530182978637;
        Thu, 28 Jun 2018 03:49:38 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id s5-v6sm10886408pgo.65.2018.06.28.03.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 03:49:38 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        ren_guo@c-sky.com
Subject: [PATCH 1/2] nds32: To implement these icache invalidation APIs since nds32 cores don't snoop data cache. This issue is found by Guo Ren. Based on the Documentation/core-api/cachetlb.rst and it says:
Date:   Thu, 28 Jun 2018 18:49:27 +0800
Message-Id: <20180628104927.9130-1-greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Any necessary cache flushing or other coherency operations
that need to occur should happen here.  If the processor's
instruction cache does not snoop cpu stores, it is very
likely that you will need to flush the instruction cache
for copy_to_user_page()."

"If the icache does not snoop stores then this
routine(flush_icache_range) will need
to flush it."

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/cacheflush.h |  9 +++++--
 arch/nds32/mm/cacheflush.c          | 49 +++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 10b48f0d8e85..8b26198d51bb 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -8,6 +8,8 @@
 
 #define PG_dcache_dirty PG_arch_1
 
+void flush_icache_range(unsigned long start, unsigned long end);
+void flush_icache_page(struct vm_area_struct *vma, struct page *page);
 #ifdef CONFIG_CPU_CACHE_ALIASING
 void flush_cache_mm(struct mm_struct *mm);
 void flush_cache_dup_mm(struct mm_struct *mm);
@@ -34,13 +36,16 @@ void flush_anon_page(struct vm_area_struct *vma,
 void flush_kernel_dcache_page(struct page *page);
 void flush_kernel_vmap_range(void *addr, int size);
 void invalidate_kernel_vmap_range(void *addr, int size);
-void flush_icache_range(unsigned long start, unsigned long end);
-void flush_icache_page(struct vm_area_struct *vma, struct page *page);
 #define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
 #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
 
 #else
 #include <asm-generic/cacheflush.h>
+#undef flush_icache_range
+#undef flush_icache_page
+#undef flush_icache_user_range
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+	                     unsigned long addr, int len);
 #endif
 
 #endif /* __NDS32_CACHEFLUSH_H__ */
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index ce8fd34497bf..1b473d4ad2b6 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -13,6 +13,34 @@
 
 extern struct cache_info L1_cache_info[2];
 
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size, flags;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & ~(line_size - 1);
+	end = (end + line_size - 1) & ~(line_size - 1);
+	local_irq_save(flags);
+	cpu_cache_wbinval_range(start, end, 1);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(flush_icache_range);
+
+void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	cpu_cache_wbinval_page((unsigned long)page_address(page),
+			       vma->vm_flags & VM_EXEC);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(flush_icache_page);
+
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+	                     unsigned long addr, int len)
+{
+	unsigned long _addr = (unsigned long) page_address(page) + (addr & ~PAGE_MASK);
+	flush_icache_range(_addr, _addr + len);
+}
 #ifndef CONFIG_CPU_CACHE_ALIASING
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		      pte_t * pte)
@@ -318,27 +346,6 @@ void invalidate_kernel_vmap_range(void *addr, int size)
 }
 EXPORT_SYMBOL(invalidate_kernel_vmap_range);
 
-void flush_icache_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size, flags;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & ~(line_size - 1);
-	end = (end + line_size - 1) & ~(line_size - 1);
-	local_irq_save(flags);
-	cpu_cache_wbinval_range(start, end, 1);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(flush_icache_range);
-
-void flush_icache_page(struct vm_area_struct *vma, struct page *page)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	cpu_cache_wbinval_page((unsigned long)page_address(page),
-			       vma->vm_flags & VM_EXEC);
-	local_irq_restore(flags);
-}
-
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		      pte_t * pte)
 {
-- 
1.9.5

