Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0772DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF1721783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkCRn4Rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfAKFOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:14:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33957 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfAKFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:14:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so6233857plz.1;
        Thu, 10 Jan 2019 21:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6n7WLTQIQU4iYs5jAR5RfAZTaxdM+QIQwvErCLIWGI0=;
        b=OkCRn4RmDaTCWIV/VlqEcURdQeHooOBsggtOA4KSHGJ1ClFwy19LqiaQCia1SwBNKy
         pZHQZ84BZ8h50LkR1ja3p+I0NmEivjjzSbAFjnIEJBR/MTHMdg7G4GmsvoytwREHBZGL
         ajccvvhf7Aj9VGbNKj7+jnRLgmau6Fq0aa+H0HzOqV7E5+mGyeeheB+4LbSPKNwfpGX5
         RtMOQG1dCfsKMl8hODWqb+G/ooKw2pr3b05rXMIdY4IWaThAznQdtH/MCq6/GAF2yvWX
         1G12E6qLk3vWBdXsbx2nrJeTAYki46RuNPQJ517kU5Ma+oPNknZqDERAwKjnJkCDytvM
         yy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6n7WLTQIQU4iYs5jAR5RfAZTaxdM+QIQwvErCLIWGI0=;
        b=OG8wSndx7z11wI/yMQqLc0ub1ezVcmlpYw4GlOG7ANiS4aOPMBOmBE+lreO7zD79+s
         uf+ngoTZVQG0oILdKZgQSBqZ28XBpqz0QA+d2/TZt3kNGJz+yCupzsglhXNiicUq4s3y
         nN/eEv6kfiV1/C7QjF/o8DMMZD3ehI8HgL+8Dci1849KjL963VK7iH+/hlKkzxS0uNjw
         pFc/cwqedZ8yeodqYaXYUDeCsSdlvXMI2fhDuMaa13m5mAqv4tlyJXdeuk8Qv7Vmt8k3
         cSeamXc1wdNacBiqStW76If2QcQ310tqwwqE4hd+Qi/ZIfJIV/kZ0u3D1j/5xxwAFV98
         dS4w==
X-Gm-Message-State: AJcUukctPW1/p9QZoevMUrFcuI6O81SSWf3aMOULYDT4IUo9Av1hfjWQ
        7Nh417BvIx3LLdVtMOFtOlHrkOwy3WXi
X-Google-Smtp-Source: ALg8bN519M8FSblftpFRFKZNcmDiRvlUMgPPvlgL7aMetK7LTEx85h37vl9npAeYzhOQCFfavx0WJw==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr13628711plf.202.1547183649391;
        Thu, 10 Jan 2019 21:14:09 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:14:08 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHv2 7/7] x86/mm: isolate the bottom-up style to init_32.c
Date:   Fri, 11 Jan 2019 13:12:57 +0800
Message-Id: <1547183577-20309-8-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bottom-up style is useless in x86_64 any longer, isolate it. Later, it may
be removed completely from x86.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: x86@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-mm@kvack.org
---
 arch/x86/mm/init.c        | 153 +---------------------------------------------
 arch/x86/mm/init_32.c     | 147 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mm_internal.h |   8 ++-
 3 files changed, 155 insertions(+), 153 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 003ad77..6a853e4 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -502,7 +502,7 @@ unsigned long __ref init_memory_mapping(unsigned long start,
  * That range would have hole in the middle or ends, and only ram parts
  * will be mapped in init_range_memory_mapping().
  */
-static unsigned long __init init_range_memory_mapping(
+unsigned long __init init_range_memory_mapping(
 					   unsigned long r_start,
 					   unsigned long r_end)
 {
@@ -530,157 +530,6 @@ static unsigned long __init init_range_memory_mapping(
 	return mapped_ram_size;
 }
 
-#ifdef CONFIG_X86_32
-
-static unsigned long min_pfn_mapped;
-
-static unsigned long __init get_new_step_size(unsigned long step_size)
-{
-	/*
-	 * Initial mapped size is PMD_SIZE (2M).
-	 * We can not set step_size to be PUD_SIZE (1G) yet.
-	 * In worse case, when we cross the 1G boundary, and
-	 * PG_LEVEL_2M is not set, we will need 1+1+512 pages (2M + 8k)
-	 * to map 1G range with PTE. Hence we use one less than the
-	 * difference of page table level shifts.
-	 *
-	 * Don't need to worry about overflow in the top-down case, on 32bit,
-	 * when step_size is 0, round_down() returns 0 for start, and that
-	 * turns it into 0x100000000ULL.
-	 * In the bottom-up case, round_up(x, 0) returns 0 though too, which
-	 * needs to be taken into consideration by the code below.
-	 */
-	return step_size << (PMD_SHIFT - PAGE_SHIFT - 1);
-}
-
-/**
- * memory_map_top_down - Map [map_start, map_end) top down
- * @map_start: start address of the target memory range
- * @map_end: end address of the target memory range
- *
- * This function will setup direct mapping for memory range
- * [map_start, map_end) in top-down. That said, the page tables
- * will be allocated at the end of the memory, and we map the
- * memory in top-down.
- */
-static void __init memory_map_top_down(unsigned long map_start,
-				       unsigned long map_end)
-{
-	unsigned long real_end, start, last_start;
-	unsigned long step_size;
-	unsigned long addr;
-	unsigned long mapped_ram_size = 0;
-
-	/* xen has big range in reserved near end of ram, skip it at first.*/
-	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
-
-	/* step_size need to be small so pgt_buf from BRK could cover it */
-	step_size = PMD_SIZE;
-	max_pfn_mapped = 0; /* will get exact value next */
-	min_pfn_mapped = real_end >> PAGE_SHIFT;
-	last_start = start = real_end;
-
-	/*
-	 * We start from the top (end of memory) and go to the bottom.
-	 * The memblock_find_in_range() gets us a block of RAM from the
-	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
-	 * for page table.
-	 */
-	while (last_start > map_start) {
-		if (last_start > step_size) {
-			start = round_down(last_start - 1, step_size);
-			if (start < map_start)
-				start = map_start;
-		} else
-			start = map_start;
-		mapped_ram_size += init_range_memory_mapping(start,
-							last_start);
-		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
-		last_start = start;
-		min_pfn_mapped = last_start >> PAGE_SHIFT;
-		if (mapped_ram_size >= step_size)
-			step_size = get_new_step_size(step_size);
-	}
-
-	if (real_end < map_end) {
-		init_range_memory_mapping(real_end, map_end);
-		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
-	}
-}
-
-/**
- * memory_map_bottom_up - Map [map_start, map_end) bottom up
- * @map_start: start address of the target memory range
- * @map_end: end address of the target memory range
- *
- * This function will setup direct mapping for memory range
- * [map_start, map_end) in bottom-up. Since we have limited the
- * bottom-up allocation above the kernel, the page tables will
- * be allocated just above the kernel and we map the memory
- * in [map_start, map_end) in bottom-up.
- */
-static void __init memory_map_bottom_up(unsigned long map_start,
-					unsigned long map_end)
-{
-	unsigned long next, start;
-	unsigned long mapped_ram_size = 0;
-	/* step_size need to be small so pgt_buf from BRK could cover it */
-	unsigned long step_size = PMD_SIZE;
-
-	start = map_start;
-	min_pfn_mapped = start >> PAGE_SHIFT;
-
-	/*
-	 * We start from the bottom (@map_start) and go to the top (@map_end).
-	 * The memblock_find_in_range() gets us a block of RAM from the
-	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
-	 * for page table.
-	 */
-	while (start < map_end) {
-		if (step_size && map_end - start > step_size) {
-			next = round_up(start + 1, step_size);
-			if (next > map_end)
-				next = map_end;
-		} else {
-			next = map_end;
-		}
-
-		mapped_ram_size += init_range_memory_mapping(start, next);
-		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
-		start = next;
-
-		if (mapped_ram_size >= step_size)
-			step_size = get_new_step_size(step_size);
-	}
-}
-
-static unsigned long __init init_range_memory_mapping32(
-	unsigned long r_start, unsigned long r_end)
-{
-	/*
-	 * If the allocation is in bottom-up direction, we setup direct mapping
-	 * in bottom-up, otherwise we setup direct mapping in top-down.
-	 */
-	if (memblock_bottom_up()) {
-		unsigned long kernel_end = __pa_symbol(_end);
-
-		/*
-		 * we need two separate calls here. This is because we want to
-		 * allocate page tables above the kernel. So we first map
-		 * [kernel_end, end) to make memory above the kernel be mapped
-		 * as soon as possible. And then use page tables allocated above
-		 * the kernel to map [ISA_END_ADDRESS, kernel_end).
-		 */
-		memory_map_bottom_up(kernel_end, r_end);
-		memory_map_bottom_up(r_start, kernel_end);
-	} else {
-		memory_map_top_down(r_start, r_end);
-	}
-}
-
-#endif
-
 void __init init_mem_mapping(void)
 {
 	unsigned long end;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 49ecf5e..f802678 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -550,6 +550,153 @@ void __init early_ioremap_page_table_range_init(void)
 	early_ioremap_reset();
 }
 
+static unsigned long min_pfn_mapped;
+
+static unsigned long __init get_new_step_size(unsigned long step_size)
+{
+	/*
+	 * Initial mapped size is PMD_SIZE (2M).
+	 * We can not set step_size to be PUD_SIZE (1G) yet.
+	 * In worse case, when we cross the 1G boundary, and
+	 * PG_LEVEL_2M is not set, we will need 1+1+512 pages (2M + 8k)
+	 * to map 1G range with PTE. Hence we use one less than the
+	 * difference of page table level shifts.
+	 *
+	 * Don't need to worry about overflow in the top-down case, on 32bit,
+	 * when step_size is 0, round_down() returns 0 for start, and that
+	 * turns it into 0x100000000ULL.
+	 * In the bottom-up case, round_up(x, 0) returns 0 though too, which
+	 * needs to be taken into consideration by the code below.
+	 */
+	return step_size << (PMD_SHIFT - PAGE_SHIFT - 1);
+}
+
+/**
+ * memory_map_top_down - Map [map_start, map_end) top down
+ * @map_start: start address of the target memory range
+ * @map_end: end address of the target memory range
+ *
+ * This function will setup direct mapping for memory range
+ * [map_start, map_end) in top-down. That said, the page tables
+ * will be allocated at the end of the memory, and we map the
+ * memory in top-down.
+ */
+static void __init memory_map_top_down(unsigned long map_start,
+				       unsigned long map_end)
+{
+	unsigned long real_end, start, last_start;
+	unsigned long step_size;
+	unsigned long addr;
+	unsigned long mapped_ram_size = 0;
+
+	/* xen has big range in reserved near end of ram, skip it at first.*/
+	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
+	real_end = addr + PMD_SIZE;
+
+	/* step_size need to be small so pgt_buf from BRK could cover it */
+	step_size = PMD_SIZE;
+	max_pfn_mapped = 0; /* will get exact value next */
+	min_pfn_mapped = real_end >> PAGE_SHIFT;
+	last_start = start = real_end;
+
+	/*
+	 * We start from the top (end of memory) and go to the bottom.
+	 * The memblock_find_in_range() gets us a block of RAM from the
+	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
+	 * for page table.
+	 */
+	while (last_start > map_start) {
+		if (last_start > step_size) {
+			start = round_down(last_start - 1, step_size);
+			if (start < map_start)
+				start = map_start;
+		} else
+			start = map_start;
+		mapped_ram_size += init_range_memory_mapping(start,
+							last_start);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+		last_start = start;
+		min_pfn_mapped = last_start >> PAGE_SHIFT;
+		if (mapped_ram_size >= step_size)
+			step_size = get_new_step_size(step_size);
+	}
+
+	if (real_end < map_end) {
+		init_range_memory_mapping(real_end, map_end);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+	}
+}
+
+/**
+ * memory_map_bottom_up - Map [map_start, map_end) bottom up
+ * @map_start: start address of the target memory range
+ * @map_end: end address of the target memory range
+ *
+ * This function will setup direct mapping for memory range
+ * [map_start, map_end) in bottom-up. Since we have limited the
+ * bottom-up allocation above the kernel, the page tables will
+ * be allocated just above the kernel and we map the memory
+ * in [map_start, map_end) in bottom-up.
+ */
+static void __init memory_map_bottom_up(unsigned long map_start,
+					unsigned long map_end)
+{
+	unsigned long next, start;
+	unsigned long mapped_ram_size = 0;
+	/* step_size need to be small so pgt_buf from BRK could cover it */
+	unsigned long step_size = PMD_SIZE;
+
+	start = map_start;
+	min_pfn_mapped = start >> PAGE_SHIFT;
+
+	/*
+	 * We start from the bottom (@map_start) and go to the top (@map_end).
+	 * The memblock_find_in_range() gets us a block of RAM from the
+	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
+	 * for page table.
+	 */
+	while (start < map_end) {
+		if (step_size && map_end - start > step_size) {
+			next = round_up(start + 1, step_size);
+			if (next > map_end)
+				next = map_end;
+		} else {
+			next = map_end;
+		}
+
+		mapped_ram_size += init_range_memory_mapping(start, next);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+		start = next;
+
+		if (mapped_ram_size >= step_size)
+			step_size = get_new_step_size(step_size);
+	}
+}
+
+void __init init_range_memory_mapping32(
+	unsigned long r_start, unsigned long r_end)
+{
+	/*
+	 * If the allocation is in bottom-up direction, we setup direct mapping
+	 * in bottom-up, otherwise we setup direct mapping in top-down.
+	 */
+	if (memblock_bottom_up()) {
+		unsigned long kernel_end = __pa_symbol(_end);
+
+		/*
+		 * we need two separate calls here. This is because we want to
+		 * allocate page tables above the kernel. So we first map
+		 * [kernel_end, end) to make memory above the kernel be mapped
+		 * as soon as possible. And then use page tables allocated above
+		 * the kernel to map [ISA_END_ADDRESS, kernel_end).
+		 */
+		memory_map_bottom_up(kernel_end, r_end);
+		memory_map_bottom_up(r_start, kernel_end);
+	} else {
+		memory_map_top_down(r_start, r_end);
+	}
+}
+
 static void __init pagetable_init(void)
 {
 	pgd_t *pgd_base = swapper_pg_dir;
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 4e1f6e1..5ab133c 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -9,7 +9,13 @@ static inline void *alloc_low_page(void)
 }
 
 void early_ioremap_page_table_range_init(void);
-
+void init_range_memory_mapping32(
+					unsigned long r_start,
+					unsigned long r_end);
+void set_alloc_range(unsigned long low, unsigned long high);
+unsigned long __init init_range_memory_mapping(
+					unsigned long r_start,
+					unsigned long r_end);
 unsigned long kernel_physical_mapping_init(unsigned long start,
 					     unsigned long end,
 					     unsigned long page_size_mask);
-- 
2.7.4

