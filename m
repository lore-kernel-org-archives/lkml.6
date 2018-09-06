Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C147C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA35C2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyIPje1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA35C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIFHKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:10:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35720 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:10:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7-v6so4402840pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSJEsQ19FcDT5DRYEoyr0lH0VN6O26QK5vu3Q8cSQrU=;
        b=EyIPje1guFViIIdtNI2dhTrCxU/DUm0J4QO3njGDN7whjgxj/xqCWINAl+3Lca1J1k
         xehGw3tRG0ug+T3FvcOjdipPO1wMbfSmKv29Q0jTATvFYBC3eh7WzXWfAPOUOU8FUqr8
         pS8aJVicUfBWYmQLe4VvKrbyoghG/DbHEMhpIIX8/TgoyA6beYHJh0VffvS5l2Uycm/o
         XcpLHQDOI5h1lNx1lPqyV5t+K6b9dQBfi6WqJfN4WABDBFobZG2HRrQ7tcTBW/yyvf8d
         rJ9oPiqnftfLLHeMQzdw9F7m7rAXSH5YSCZ5QXnW2cFDIkOarntqhWG+WOAdG+yRyGjG
         g6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSJEsQ19FcDT5DRYEoyr0lH0VN6O26QK5vu3Q8cSQrU=;
        b=MjtE8htvG/2ubkpt+c2KnQeRPMwzhdD90jgVMX12cF9D0NrkTmgX9e0D6SoVVxCDel
         O9CbJimN5rdq7bYGA9hJojzZSPK62vIfuMHFXUkeYgBlOpx0WFS9eSLFUMWrB1WCg5jY
         0Kj3Xg64G3MkmtIL2Iebi1rjnNqX+StjIvYKfMxQYkvniOteC7NkBjF4+PC0o1nQmw1r
         /KuqFF896/f4CtKE1UkVONAeNyh5LZMs96xIlSTXzDpxH2c8spZONLuHW4qjeSYnwx+F
         GkVEIHu2V1SIiBYGZMby58tSUaj9TGYnEcfXt5hf5Y64+jVt+/oyQri9e9Od+osPevld
         gTMg==
X-Gm-Message-State: APzg51Bj0I6JQlOTc7BHncuwpK8ua5Hiz/wNhNRgK0yqkG8EbdKlkZw5
        Cr3c4DYN38RDvub5uJC0Z+4EvC4=
X-Google-Smtp-Source: ANB0VdZWlhMvRkhD3PplHa1wvvMq48DCrUVmh6wTr7u6W74GD9XUB6Z6Y/8p1QpX/v6DZb/jGyDIRg==
X-Received: by 2002:a63:740f:: with SMTP id p15-v6mr589185pgc.395.1536201422660;
        Wed, 05 Sep 2018 19:37:02 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r17-v6sm8780990pff.50.2018.09.05.19.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 19:37:01 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, x86@kernel.org
Subject: [PATCH 3/3] x86/boot/KASLR: enhance randomness when using GiB hugepage
Date:   Thu,  6 Sep 2018 10:36:22 +0800
Message-Id: <1536201382-13133-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 747ff6265db4 ("x86/boot/KASLR: Skip specified number of 1GB huge
pages when doing physical randomization (KASLR)") and
commit 9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages
handling") prevent the physical load addr of kernel from spoiling a good
candidate of GiB page. But the algorithm deterministicly chooses the most
front GiB page for hugetlb, and sacrifices the randomness, which
is the heart of the KASLR. This patch tries to enlarge the randomness in
the cases where hugepages=X < the num Y of good candidate of GiB
page.
To comparison, taking a typical KVM guest for example, the head 3GiB mem
can not be used as GiB hugetlb. Denoting the total mem size as Z(GiB), when
Z=5, then Y=2, assuming X=1, the randomness range before this patch is
4GiB, after this patch is 5GiB, and get a 25% improvement of randomness.
If Z=6, then Y=3, assuming X=2, the improvement equals: 50%( 6/(6-2) - 1);
assuming X=1, the improvement will be: 20% (6/(6-1) - 1)

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com> (authored:1/16=6%)
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/kaslr.c | 174 ++++++++++++++++++++++++++-------------
 1 file changed, 116 insertions(+), 58 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 584f17c..b0bc489 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -50,6 +50,7 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
 #endif
 
 extern unsigned long get_cmd_line_ptr(void);
+static int figure_hugepage_layout(unsigned long kernel_sz);
 
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
@@ -109,6 +110,9 @@ enum mem_avoid_index {
 	MEM_AVOID_BOOTPARAMS,
 	MEM_AVOID_MEMMAP_BEGIN,
 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
+	MEM_AVOID_HUGEPAGE_BEGIN,
+	/* support 4 continuous chunk which can hold GiB */
+	MEM_AVOID_HUGEPAGE_END = MEM_AVOID_HUGEPAGE_BEGIN + 4,
 	MEM_AVOID_MAX,
 };
 
@@ -241,7 +245,7 @@ static void parse_gb_huge_pages(char *param, char *val)
 }
 
 
-static int handle_mem_options(void)
+static int handle_mem_options(unsigned long output_size)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	size_t len = strlen((char *)args);
@@ -291,6 +295,8 @@ static int handle_mem_options(void)
 		}
 	}
 
+	if (max_gb_huge_pages != 0)
+		figure_hugepage_layout(output_size);
 	free(tmp_cmdline);
 	return 0;
 }
@@ -370,7 +376,7 @@ static int handle_mem_options(void)
  * becomes the MEM_AVOID_ZO_RANGE below.
  */
 static void mem_avoid_init(unsigned long input, unsigned long input_size,
-			   unsigned long output)
+			   unsigned long output, unsigned long output_size)
 {
 	unsigned long init_size = boot_params->hdr.init_size;
 	u64 initrd_start, initrd_size;
@@ -416,7 +422,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* We don't need to set a mapping for setup_data. */
 
 	/* Mark the memmap regions we need to avoid */
-	handle_mem_options();
+	handle_mem_options(output_size);
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
@@ -495,60 +501,6 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 	}
 }
 
-/*
- * Skip as many 1GB huge pages as possible in the passed region
- * according to the number which users specified:
- */
-static void
-process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
-{
-	unsigned long addr, size = 0;
-	struct mem_vector tmp;
-	int i = 0;
-
-	if (!max_gb_huge_pages) {
-		store_slot_info(region, image_size);
-		return;
-	}
-
-	addr = ALIGN(region->start, PUD_SIZE);
-	/* Did we raise the address above the passed in memory entry? */
-	if (addr < region->start + region->size)
-		size = region->size - (addr - region->start);
-
-	/* Check how many 1GB huge pages can be filtered out: */
-	while (size > PUD_SIZE && max_gb_huge_pages) {
-		size -= PUD_SIZE;
-		max_gb_huge_pages--;
-		i++;
-	}
-
-	/* No good 1GB huge pages found: */
-	if (!i) {
-		store_slot_info(region, image_size);
-		return;
-	}
-
-	/*
-	 * Skip those 'i'*1GB good huge pages, and continue checking and
-	 * processing the remaining head or tail part of the passed region
-	 * if available.
-	 */
-
-	if (addr >= region->start + image_size) {
-		tmp.start = region->start;
-		tmp.size = addr - region->start;
-		store_slot_info(&tmp, image_size);
-	}
-
-	size  = region->size - (addr - region->start) - i * PUD_SIZE;
-	if (size >= image_size) {
-		tmp.start = addr + i * PUD_SIZE;
-		tmp.size = size;
-		store_slot_info(&tmp, image_size);
-	}
-}
-
 static unsigned long slots_fetch_random(void)
 {
 	unsigned long slot;
@@ -573,6 +525,9 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
+static struct slot_area gb_slots[MAX_SLOT_AREA];
+static int max_gb_chunk;
+
 typedef void (*handles_mem_region)(struct mem_vector *entry,
 			       unsigned long minimum,
 			       unsigned long image_size);
@@ -580,6 +535,19 @@ typedef void (*handles_mem_region)(struct mem_vector *entry,
 typedef void (*store_info)(struct mem_vector *region,
 	unsigned long image_size);
 
+static void store_gb_slot_info(struct mem_vector *region,
+	unsigned long unused_image_size)
+{
+	int num;
+
+	if (region->size < PUD_SIZE)
+		return;
+	num = region->size / PUD_SIZE;
+	gb_slots[max_gb_chunk].addr = region->start;
+	gb_slots[max_gb_chunk].num = num;
+	max_gb_chunk++;
+}
+
 static void __process_mem_region(struct mem_vector *entry,
 	unsigned long minimum, unsigned long volume, unsigned long align,
 	store_info store)
@@ -751,6 +719,26 @@ process_efi_entries(unsigned long minimum, unsigned long image_size,
 }
 #endif
 
+
+/* the candidate region for 1GiB page should avoid [0, MEM_AVOID_MEMMAP_END]
+ */
+static void calc_gb_slots(struct mem_vector *entry, unsigned long unused_min,
+	unsigned long unused)
+{
+	struct mem_vector v;
+	unsigned long start;
+
+	if (max_gb_chunk == MAX_SLOT_AREA) {
+		debug_putstr("Aborted GiB chunks full)!\n");
+		return;
+	}
+	v.start = ALIGN(entry->start, PUD_SIZE);
+	v.size = entry->start + entry->size - v.start;
+	if (v.size < 0)
+		return;
+	__process_mem_region(&v, 0, PUD_SIZE, PUD_SIZE, store_gb_slot_info);
+}
+
 static void process_e820_entries(unsigned long minimum,
 	unsigned long image_size, handles_mem_region handle)
 {
@@ -774,6 +762,76 @@ static void process_e820_entries(unsigned long minimum,
 	}
 }
 
+/* figure out the good 1GiB page slots, and compare the GiB slots num with
+ * "hugepages=x" in cmdline. For little and equal, It falls into 3 cases:
+ * 1st: equal, then prevent kaslr from extract kernel into these GiB slots
+ * 2nd. equal x plus 1, then pick up a GiB slot randomly into which kaslr is
+ * allows to extract kernel.
+ * 3rd. the rest, kaslr can extract kernel to any GiB slot
+ */
+static int figure_hugepage_layout(unsigned long kernel_sz)
+{
+	int i, idx = 0;
+	struct mem_vector region;
+	unsigned long first_end, second_start;
+	long slot_chosen, cur_slot_num;
+	long off;
+	int gb_total_slot = 0;
+
+	if (!process_efi_entries(0x1000000, kernel_sz, calc_gb_slots))
+		process_e820_entries(0x1000000, kernel_sz, calc_gb_slots);
+
+	/* for hugepage, the load addr should be only limited when ... */
+
+	for (i = 0; i < max_gb_chunk; i++)
+		gb_total_slot += gb_slots[i].num;
+	if (max_gb_huge_pages < (unsigned long)(gb_total_slot - 1))
+		return 0;
+
+	idx = MEM_AVOID_HUGEPAGE_BEGIN;
+	if (max_gb_huge_pages == gb_total_slot) {
+		for (i = 0; i < gb_total_slot; i++, idx++) {
+			mem_avoid[idx].start = gb_slots[i].addr;
+			mem_avoid[idx].size = gb_slots[i].num * PUD_SIZE;
+		}
+	/* randomly choose a GiB slot to load kernel */
+	} else if (max_gb_huge_pages == gb_total_slot - 1) {
+		slot_chosen = kaslr_get_random_long("Physical") % gb_total_slot;
+		cur_slot_num = 0;
+		for (i = 0; i < max_gb_chunk; i++) {
+			off = slot_chosen - cur_slot_num;
+			if (off > 0 && off < gb_slots[i].num) {
+				/* split the continuous area into two parts */
+				first_end = gb_slots[i].addr
+					+ (off - 1) * PUD_SIZE;
+				/* prevent kernel from crossing the GiB boundary
+				 * otherwise waste a good hugepage
+				 */
+				second_start = gb_slots[i].addr + off * PUD_SIZE
+				  - ALIGN(kernel_sz, CONFIG_PHYSICAL_ALIGN);
+				if (first_end != gb_slots[i].addr) {
+					mem_avoid[idx].start = gb_slots[i].addr;
+					mem_avoid[idx].size =
+						first_end - gb_slots[i].addr;
+					idx++;
+				}
+				mem_avoid[idx].start = second_start;
+				mem_avoid[idx].size = gb_slots[i].addr +
+				    gb_slots[i].num * PUD_SIZE - second_start;
+				idx++;
+			} else {
+				mem_avoid[idx].start = gb_slots[i].addr;
+				mem_avoid[idx].size =
+					gb_slots[i].num * PUD_SIZE;
+				idx++;
+			}
+			cur_slot_num += gb_slots[i].num;
+		}
+	}
+
+	return 0;
+}
+
 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
@@ -847,7 +905,7 @@ void choose_random_location(unsigned long input,
 	initialize_identity_maps();
 
 	/* Record the various known unsafe memory ranges. */
-	mem_avoid_init(input, input_size, *output);
+	mem_avoid_init(input, input_size, *output, output_size);
 
 	/*
 	 * Low end of the randomization range should be the
-- 
2.7.4

