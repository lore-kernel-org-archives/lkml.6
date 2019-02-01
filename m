Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F439C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfBALDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:03:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbfBALDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:03:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11B2ReZ3281541
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 03:02:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11B2R5e3281538;
        Fri, 1 Feb 2019 03:02:27 -0800
Date:   Fri, 1 Feb 2019 03:02:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-690eaa53205769fd5c0c36e3aa737a615135f969@git.kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, ard.biesheuvel@linaro.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jgross@suse.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com, bp@suse.de,
        dave.hansen@linux.intel.com, thomas.lendacky@amd.com,
        keescook@chromium.org, mingo@redhat.com, bhe@redhat.com,
        fanc.fnst@cn.fujitsu.com
Reply-To: ard.biesheuvel@linaro.org, hpa@zytor.com, tglx@linutronix.de,
          x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
          kirill.shutemov@linux.intel.com, jgross@suse.com,
          keescook@chromium.org, mingo@redhat.com,
          fanc.fnst@cn.fujitsu.com, bhe@redhat.com, bp@suse.de,
          dave.hansen@linux.intel.com, thomas.lendacky@amd.com
In-Reply-To: <20190123110850.12433-8-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-8-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/KASLR: Limit KASLR to extract the kernel in
 immovable memory only
Git-Commit-ID: 690eaa53205769fd5c0c36e3aa737a615135f969
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  690eaa53205769fd5c0c36e3aa737a615135f969
Gitweb:     https://git.kernel.org/tip/690eaa53205769fd5c0c36e3aa737a615135f969
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:50 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:55 +0100

x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only

KASLR may randomly choose a range which is located in movable memory
regions. As a result, this will break memory hotplug and make the
movable memory chosen by KASLR immovable.

Therefore, limit KASLR to choose memory regions in the immovable range
after consulting the SRAT table.

 [ bp:
    - Rewrite commit message.
    - Trim comments.
 ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: caoj.fnst@cn.fujitsu.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190123110850.12433-8-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/compressed/kaslr.c | 71 +++++++++++++++++++++++++++++++++-------
 arch/x86/boot/compressed/misc.h  |  1 +
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b251572e77af..a2039afe14a7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -97,6 +97,8 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 static unsigned long long mem_limit = ULLONG_MAX;
 
+/* Number of immovable memory regions */
+static int num_immovable_mem;
 
 enum mem_avoid_index {
 	MEM_AVOID_ZO_RANGE = 0,
@@ -413,6 +415,9 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_options();
 
+	/* Enumerate the immovable memory regions */
+	num_immovable_mem = count_immovable_mem_regions();
+
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
 	add_identity_map(0, PMD_SIZE);
@@ -568,9 +573,9 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
-static void process_mem_region(struct mem_vector *entry,
-			       unsigned long minimum,
-			       unsigned long image_size)
+static void __process_mem_region(struct mem_vector *entry,
+				 unsigned long minimum,
+				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
 	unsigned long start_orig, end;
@@ -646,6 +651,56 @@ static void process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static bool process_mem_region(struct mem_vector *region,
+			       unsigned long long minimum,
+			       unsigned long long image_size)
+{
+	int i;
+	/*
+	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
+	 * use @region directly.
+	 */
+	if (!num_immovable_mem) {
+		__process_mem_region(region, minimum, image_size);
+
+		if (slot_area_index == MAX_SLOT_AREA) {
+			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+			return 1;
+		}
+		return 0;
+	}
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	/*
+	 * If immovable memory found, filter the intersection between
+	 * immovable memory and @region.
+	 */
+	for (i = 0; i < num_immovable_mem; i++) {
+		unsigned long long start, end, entry_end, region_end;
+		struct mem_vector entry;
+
+		if (!mem_overlaps(region, &immovable_mem[i]))
+			continue;
+
+		start = immovable_mem[i].start;
+		end = start + immovable_mem[i].size;
+		region_end = region->start + region->size;
+
+		entry.start = clamp(region->start, start, end);
+		entry_end = clamp(region_end, start, end);
+		entry.size = entry_end - entry.start;
+
+		__process_mem_region(&entry, minimum, image_size);
+
+		if (slot_area_index == MAX_SLOT_AREA) {
+			debug_putstr("Aborted e820/efi memmap scan when walking immovable regions(slot_areas full)!\n");
+			return 1;
+		}
+	}
+	return 0;
+#endif
+}
+
 #ifdef CONFIG_EFI
 /*
  * Returns true if mirror region found (and must have been processed
@@ -711,11 +766,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
 		region.start = md->phys_addr;
 		region.size = md->num_pages << EFI_PAGE_SHIFT;
-		process_mem_region(&region, minimum, image_size);
-		if (slot_area_index == MAX_SLOT_AREA) {
-			debug_putstr("Aborted EFI scan (slot_areas full)!\n");
+		if (process_mem_region(&region, minimum, image_size))
 			break;
-		}
 	}
 	return true;
 }
@@ -742,11 +794,8 @@ static void process_e820_entries(unsigned long minimum,
 			continue;
 		region.start = entry->addr;
 		region.size = entry->size;
-		process_mem_region(&region, minimum, image_size);
-		if (slot_area_index == MAX_SLOT_AREA) {
-			debug_putstr("Aborted e820 scan (slot_areas full)!\n");
+		if (process_mem_region(&region, minimum, image_size))
 			break;
-		}
 	}
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9911d11c5d09..19e8231a6fd6 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -132,6 +132,7 @@ static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
 #endif
 
 #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
 int count_immovable_mem_regions(void);
 #else
 static inline int count_immovable_mem_regions(void) { return 0; }
