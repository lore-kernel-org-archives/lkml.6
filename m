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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305C520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNp9fdlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfAKFOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:14:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfAKFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:14:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so6407498pfg.1;
        Thu, 10 Jan 2019 21:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzNgf1HX1LRzHvXNDEH6fLsdUxAcQ1NDOrWEAz1gjyY=;
        b=nNp9fdlMm4AGNuCQXSEDspc1l3wd3kiL5pN2RY2C6ARIPyzKYzWxs5yTIKKzt1E/4c
         1AQPFM9m526tFP8XgW/FDRCIVK8FzbGNOPrFqS9dJ85Eljim55SvQ3m7Pl+qp+NYmK9Y
         jzL2+No0eouItU9JipYU8TM4z84mydN9SQx+oqxcATXF6g+rkuoBRWk+xwI/wykLck8z
         4JNlCbwwgSvb8dqu8YF7hsEE9t6QDTiw44G6vYyaELAnc+yRqFcNh+xBfJKTGDJL5eyf
         77VVl3fWAVzrptI5Fsj5j/LsJH16Cgvwlx9V6lCfw/knmoQ6rH3tb8VrPeROAEychbS1
         zyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzNgf1HX1LRzHvXNDEH6fLsdUxAcQ1NDOrWEAz1gjyY=;
        b=H7qgqcDZp4hfgyXddfHV7Yse+NNQZY/cJfOguKKLr4wyWxfXcdljrKRSL06INd6hgE
         st0bPczT/91yfZQhsz3JQvLGwKnOVMq0hVe0vQu6As9MoIoMcYEcoqBVG02z3rIngS//
         SSnp1rIp+gWRQCFU4Eg/NaSr1ep6bK2cec9bXPE0wiEkO4rf9PpaHgmiIfBoFKN8eCGO
         E4FgBZmL+h0PKSkRrYf+IdsEB9eZ9iZQ1VhxJNgIOUpaMr1FakUbhOzqSi/HKxZ3BvC0
         HZeB/wXR/aYDGROeObTmGCISgjaaNBTxolHHFP0ec9ioxv8TN+Wm/Z1/nIRX9JlnKagM
         6Afw==
X-Gm-Message-State: AJcUukdqdIcEJiv+iOAXTPfdzC2IJv2Ckg4lebc8AaPsYVT/Qxqs2hQC
        UCocHtaVDPkyEyDChwBBx8RcESsKU6HA
X-Google-Smtp-Source: ALg8bN4yq2XtfY6ND6zW/GDd12iNHsw8DjiYMbmvmejWTF8nmnyuT4ditOyjlFffV1szW56d6KYupA==
X-Received: by 2002:a63:3602:: with SMTP id d2mr11870595pga.404.1547183641475;
        Thu, 10 Jan 2019 21:14:01 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:14:00 -0800 (PST)
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
Subject: [PATCHv2 6/7] x86/mm: remove bottom-up allocation style for x86_64
Date:   Fri, 11 Jan 2019 13:12:56 +0800
Message-Id: <1547183577-20309-7-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although kaslr-kernel can avoid to stain the movable node. [1] But the
pgtable can still stain the movable node. That is a probability problem,
although low, but exist. This patch tries to make it certainty by
allocating pgtable on unmovable node, instead of following kernel end.
There are two acheivements by this patch:
-1st. keep the subtree of pgtable away from movable node.
With the previous patch, at the point of init_mem_mapping(),
memblock allocator can work with the knowledge of acpi memory hotmovable
info, and avoid to stain the movable node. As a result,
memory_map_bottom_up() is not needed any more.
The following figure show the defection of current bottom-up style:
  [startA, endA][startB, "kaslr kernel verly close to" endB][startC, endC]
If nodeA,B is unmovable, while nodeC is movable, then init_mem_mapping()
can generate pgtable on nodeC, which stain movable node.
For more lengthy background, please refer to Background section

-2nd. simplify the logic of memory_map_top_down()
Thanks to the help of early_make_pgtable(), x86_64 can directly set up the
subtree of pgtable at any place, hence the careful iteration in
memory_map_top_down() can be discard.

*Background section*
When kaslr kernel can be guaranteed to sit inside unmovable node
after [1]. But if kaslr kernel is located near the end of the movable node,
then bottom-up allocator may create pagetable which crosses the boundary
between unmovable node and movable node.  It is a probability issue,
two factors include -1. how big the gap between kernel end and
unmovable node's end.  -2. how many memory does the system own.
Alternative way to fix this issue is by increasing the gap by
boot/compressed/kaslr*. But taking the scenario of PB level memory,
the pagetable will take server MB even if using 1GB page, different page
attr and fragment will make things worse. So it is hard to decide how much
should the gap increase.

[1]: https://lore.kernel.org/patchwork/patch/1029376/
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
 arch/x86/kernel/setup.c |  4 ++--
 arch/x86/mm/init.c      | 56 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9b57e01..00a1b84 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -827,7 +827,7 @@ static void early_acpi_parse(void)
 	early_acpi_boot_init();
 	initmem_init();
 	/* check whether memory is returned or not */
-	start = memblock_find_in_range(start, end, 1<<24, 1);
+	start = memblock_find_in_range(start, end, 1 << 24, 1);
 	if (!start)
 		pr_warn("the above acpi routines change and consume memory\n");
 	memblock_set_current_limit(orig_start, orig_end, enforcing);
@@ -1135,7 +1135,7 @@ void __init setup_arch(char **cmdline_p)
 	trim_platform_memory_ranges();
 	trim_low_memory_range();
 
-#ifdef CONFIG_MEMORY_HOTPLUG
+#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_X86_32)
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
 	 * cannot migrate the kernel pages. When memory hotplug is
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 385b9cd..003ad77 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -72,8 +72,6 @@ static unsigned long __initdata pgt_buf_start;
 static unsigned long __initdata pgt_buf_end;
 static unsigned long __initdata pgt_buf_top;
 
-static unsigned long min_pfn_mapped;
-
 static bool __initdata can_use_brk_pgt = true;
 
 static unsigned long min_pfn_allowed;
@@ -532,6 +530,10 @@ static unsigned long __init init_range_memory_mapping(
 	return mapped_ram_size;
 }
 
+#ifdef CONFIG_X86_32
+
+static unsigned long min_pfn_mapped;
+
 static unsigned long __init get_new_step_size(unsigned long step_size)
 {
 	/*
@@ -653,6 +655,32 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 	}
 }
 
+static unsigned long __init init_range_memory_mapping32(
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
+#endif
+
 void __init init_mem_mapping(void)
 {
 	unsigned long end;
@@ -663,6 +691,8 @@ void __init init_mem_mapping(void)
 
 #ifdef CONFIG_X86_64
 	end = max_pfn << PAGE_SHIFT;
+	/* allow alloc_low_pages() to allocate from memblock */
+	set_alloc_range(ISA_END_ADDRESS, end);
 #else
 	end = max_low_pfn << PAGE_SHIFT;
 #endif
@@ -673,32 +703,14 @@ void __init init_mem_mapping(void)
 	/* Init the trampoline, possibly with KASLR memory offset */
 	init_trampoline();
 
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
-		memory_map_bottom_up(kernel_end, end);
-		memory_map_bottom_up(ISA_END_ADDRESS, kernel_end);
-	} else {
-		memory_map_top_down(ISA_END_ADDRESS, end);
-	}
-
 #ifdef CONFIG_X86_64
+	init_range_memory_mapping(ISA_END_ADDRESS, end);
 	if (max_pfn > max_low_pfn) {
 		/* can we preseve max_low_pfn ?*/
 		max_low_pfn = max_pfn;
 	}
 #else
+	init_range_memory_mapping32(ISA_END_ADDRESS, end);
 	early_ioremap_page_table_range_init();
 #endif
 
-- 
2.7.4

