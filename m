Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C6EC04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0F92156D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3/RAlDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0F92156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeHWV4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:56:39 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36739 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeHWV4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:56:38 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so7381970qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7+vJtbBGc5Wa+aMAWFCzB3tXwfJ28ewXy4EQlUruX64=;
        b=D3/RAlDtuUJoQQU3rBB5kBJyLVAil7aAosKZAZlJGmbuxyXk+R9EJZvnU4GfpgBCz6
         zQaJ8PK/qVwW5elgqktk8aHKkuEWtAmeMJN4tXgIgHCtGzi+Q7KGIXaoUZjEALB3vy5a
         jMwkwoSKMwvtzEfTuYcC8vNmAhGwwNvbXU8fD0oMtMVU9oUco9DXhyYUaQ39SMgTsPdL
         iWJWJthgHiYveHMwiymnfdQE6KdbfXNAS192c2RuzI1HH8tCfb/FnvFcE4Ma6gN4ZTWQ
         vBI88eRNjl95/gc24j2BHcRndZTwilsKGoOpYsb1i/dRDrOElG4BHOWfuCEvXMDNHUbM
         xL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7+vJtbBGc5Wa+aMAWFCzB3tXwfJ28ewXy4EQlUruX64=;
        b=hf3Xx8/aLLkKxw7fcRzv7i0AQpQxEiJHWu4W6wFRMiMtAYcaEfv/X2zsQJUCPPvRjO
         Rmd9+EWvkg7VMn6nRGrn7UMeP4CJzvM4aWQCt9j8m95RLMG2Tku7//cXSZD/8sGFuJGX
         2dzUrIdKLVDXuSS+8Qruz0/jtiTXvBsdGxIjSRg9OEU+gEioixW3Yv/vPK3LbtYuil2c
         G5Rza9svDS/x/rGQS3X3+/MOCAKmToRXOSKJ7lY+4bvUhLoDdDkm7xTWCYWITwyFsYUV
         TvlJKoCfKAVUOQ9TYgCXUm7lsLGvJfIFEAz/om1UrwWi//K/mKTZ+DqlL5QgevEvfVID
         flFA==
X-Gm-Message-State: AOUpUlFRspTqf7evdzcWxZ6FdbTe+iuyYMA8ijlMGbovPQH9dJp2jvr8
        DmsYtcJcP1iPcL2rKI3QBg==
X-Google-Smtp-Source: AA+uWPwt7XbeEFuzwkEzveKblgtH/g/ac7H9CnmZaZQU+YhO9fVruIhPZziOu8OtEQALnGQjglVmIA==
X-Received: by 2002:a0c:c489:: with SMTP id u9-v6mr57474052qvi.11.1535048742186;
        Thu, 23 Aug 2018 11:25:42 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o7-v6sm1233582qtp.75.2018.08.23.11.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 11:25:41 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/2] mm: zero remaining unavailable struct pages
Date:   Thu, 23 Aug 2018 14:25:13 -0400
Message-Id: <20180823182513.8801-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180823182513.8801-1-msys.mizuma@gmail.com>
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

There is a kernel panic that is triggered when reading /proc/kpageflags
on the kernel booted with kernel parameter 'memmap=nn[KMG]!ss[KMG]':

  BUG: unable to handle kernel paging request at fffffffffffffffe
  PGD 9b20e067 P4D 9b20e067 PUD 9b210067 PMD 0
  Oops: 0000 [#1] SMP PTI
  CPU: 2 PID: 1728 Comm: page-types Not tainted 4.17.0-rc6-mm1-v4.17-rc6-180605-0816-00236-g2dfb086ef02c+ #160
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.fc28 04/01/2014
  RIP: 0010:stable_page_flags+0x27/0x3c0
  Code: 00 00 00 0f 1f 44 00 00 48 85 ff 0f 84 a0 03 00 00 41 54 55 49 89 fc 53 48 8b 57 08 48 8b 2f 48 8d 42 ff 83 e2 01 48 0f 44 c7 <48> 8b 00 f6 c4 01 0f 84 10 03 00 00 31 db 49 8b 54 24 08 4c 89 e7
  RSP: 0018:ffffbbd44111fde0 EFLAGS: 00010202
  RAX: fffffffffffffffe RBX: 00007fffffffeff9 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: 0000000000000202 RDI: ffffed1182fff5c0
  RBP: ffffffffffffffff R08: 0000000000000001 R09: 0000000000000001
  R10: ffffbbd44111fed8 R11: 0000000000000000 R12: ffffed1182fff5c0
  R13: 00000000000bffd7 R14: 0000000002fff5c0 R15: ffffbbd44111ff10
  FS:  00007efc4335a500(0000) GS:ffff93a5bfc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: fffffffffffffffe CR3: 00000000b2a58000 CR4: 00000000001406e0
  Call Trace:
   kpageflags_read+0xc7/0x120
   proc_reg_read+0x3c/0x60
   __vfs_read+0x36/0x170
   vfs_read+0x89/0x130
   ksys_pread64+0x71/0x90
   do_syscall_64+0x5b/0x160
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7efc42e75e23
  Code: 09 00 ba 9f 01 00 00 e8 ab 81 f4 ff 66 2e 0f 1f 84 00 00 00 00 00 90 83 3d 29 0a 2d 00 00 75 13 49 89 ca b8 11 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 db d3 01 00 48 89 04 24

According to kernel bisection, this problem became visible due to commit
f7f99100d8d9 which changes how struct pages are initialized.

Memblock layout affects the pfn ranges covered by node/zone. Consider
that we have a VM with 2 NUMA nodes and each node has 4GB memory, and
the default (no memmap= given) memblock layout is like below:

  MEMBLOCK configuration:
   memory size = 0x00000001fff75c00 reserved size = 0x000000000300c000
   memory.cnt  = 0x4
   memory[0x0]     [0x0000000000001000-0x000000000009efff], 0x000000000009e000 bytes on node 0 flags: 0x0
   memory[0x1]     [0x0000000000100000-0x00000000bffd6fff], 0x00000000bfed7000 bytes on node 0 flags: 0x0
   memory[0x2]     [0x0000000100000000-0x000000013fffffff], 0x0000000040000000 bytes on node 0 flags: 0x0
   memory[0x3]     [0x0000000140000000-0x000000023fffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
   ...

If you give memmap=1G!4G (so it just covers memory[0x2]),
the range [0x100000000-0x13fffffff] is gone:

  MEMBLOCK configuration:
   memory size = 0x00000001bff75c00 reserved size = 0x000000000300c000
   memory.cnt  = 0x3
   memory[0x0]     [0x0000000000001000-0x000000000009efff], 0x000000000009e000 bytes on node 0 flags: 0x0
   memory[0x1]     [0x0000000000100000-0x00000000bffd6fff], 0x00000000bfed7000 bytes on node 0 flags: 0x0
   memory[0x2]     [0x0000000140000000-0x000000023fffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
   ...

This causes shrinking node 0's pfn range because it is calculated by
the address range of memblock.memory. So some of struct pages in the
gap range are left uninitialized.

We have a function zero_resv_unavail() which does zeroing the struct
pages outside memblock.memory, but currently it covers only the reserved
unavailable range (i.e. memblock.memory && !memblock.reserved).
This patch extends it to cover all unavailable range, which fixes
the reported issue.

Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Tested-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 include/linux/memblock.h | 15 ---------------
 mm/page_alloc.c          | 36 +++++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 516920549378..2acdd046df2d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -265,21 +265,6 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,	\
 			       nid, flags, p_start, p_end, p_nid)
 
-/**
- * for_each_resv_unavail_range - iterate through reserved and unavailable memory
- * @i: u64 used as loop variable
- * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
- * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
- *
- * Walks over unavailable but reserved (reserved && !memory) areas of memblock.
- * Available as soon as memblock is initialized.
- * Note: because this memory does not belong to any physical node, flags and
- * nid arguments do not make sense and thus not exported as arguments.
- */
-#define for_each_resv_unavail_range(i, p_start, p_end)			\
-	for_each_mem_range(i, &memblock.reserved, &memblock.memory,	\
-			   NUMA_NO_NODE, MEMBLOCK_NONE, p_start, p_end, NULL)
-
 static inline void memblock_set_region_flags(struct memblock_region *r,
 					     enum memblock_flags flags)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c677c1506d73..bdd3cba1d547 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6447,29 +6447,42 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
  * struct pages which are reserved in memblock allocator and their fields
  * may be accessed (for example page_to_pfn() on some configuration accesses
  * flags). We must explicitly zero those struct pages.
+ *
+ * This function also addresses a similar issue where struct pages are left
+ * uninitialized because the physical address range is not covered by
+ * memblock.memory or memblock.reserved. That could happen when memblock
+ * layout is manually configured via memmap=.
  */
 void __init zero_resv_unavail(void)
 {
 	phys_addr_t start, end;
 	unsigned long pfn;
 	u64 i, pgcnt;
+	phys_addr_t next = 0;
 
 	/*
-	 * Loop through ranges that are reserved, but do not have reported
-	 * physical memory backing.
+	 * Loop through unavailable ranges not covered by memblock.memory.
 	 */
 	pgcnt = 0;
-	for_each_resv_unavail_range(i, &start, &end) {
-		for (pfn = PFN_DOWN(start); pfn < PFN_UP(end); pfn++) {
-			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
-				pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
-					+ pageblock_nr_pages - 1;
-				continue;
+	for_each_mem_range(i, &memblock.memory, NULL,
+			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
+		if (next < start) {
+			for (pfn = PFN_DOWN(next); pfn < PFN_UP(start); pfn++) {
+				if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
+					continue;
+				mm_zero_struct_page(pfn_to_page(pfn));
+				pgcnt++;
 			}
-			mm_zero_struct_page(pfn_to_page(pfn));
-			pgcnt++;
 		}
+		next = end;
 	}
+	for (pfn = PFN_DOWN(next); pfn < max_pfn; pfn++) {
+		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
+			continue;
+		mm_zero_struct_page(pfn_to_page(pfn));
+		pgcnt++;
+	}
+
 
 	/*
 	 * Struct pages that do not have backing memory. This could be because
@@ -6479,7 +6492,8 @@ void __init zero_resv_unavail(void)
 	 * this code can be removed.
 	 */
 	if (pgcnt)
-		pr_info("Reserved but unavailable: %lld pages", pgcnt);
+		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
+
 }
 #endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
 
-- 
2.18.0

