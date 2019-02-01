Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE89218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfBALD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:03:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfBALD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:03:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11B1nWN3281495
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 03:01:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11B1nBv3281492;
        Fri, 1 Feb 2019 03:01:49 -0800
Date:   Fri, 1 Feb 2019 03:01:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-02a3e3cdb7f12fb8589e4a2e85d23c9e6544b54a@git.kernel.org>
Cc:     bhe@redhat.com, indou.takao@jp.fujitsu.com,
        kirill.shutemov@linux.intel.com, jgross@suse.com, x86@kernel.org,
        caoj.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        fanc.fnst@cn.fujitsu.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, keescook@chromium.org,
        msys.mizuma@gmail.com, hpa@zytor.com, mingo@kernel.org, bp@suse.de,
        mingo@redhat.com, kasong@redhat.com
Reply-To: indou.takao@jp.fujitsu.com, kirill.shutemov@linux.intel.com,
          bhe@redhat.com, thomas.lendacky@amd.com, keescook@chromium.org,
          msys.mizuma@gmail.com, bp@suse.de, mingo@kernel.org,
          hpa@zytor.com, mingo@redhat.com, kasong@redhat.com,
          jgross@suse.com, x86@kernel.org, caoj.fnst@cn.fujitsu.com,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          tglx@linutronix.de, ard.biesheuvel@linaro.org,
          fanc.fnst@cn.fujitsu.com
In-Reply-To: <20190123110850.12433-7-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-7-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Parse SRAT table and count immovable
 memory regions
Git-Commit-ID: 02a3e3cdb7f12fb8589e4a2e85d23c9e6544b54a
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

Commit-ID:  02a3e3cdb7f12fb8589e4a2e85d23c9e6544b54a
Gitweb:     https://git.kernel.org/tip/02a3e3cdb7f12fb8589e4a2e85d23c9e6544b54a
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:49 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:55 +0100

x86/boot: Parse SRAT table and count immovable memory regions

Parse SRAT for the immovable memory regions and use that information to
control which offset KASLR selects so that it doesn't overlap with any
movable region.

 [ bp:
   - Move struct mem_vector where it is visible so that it builds.
   - Correct comments.
   - Rewrite commit message.
   ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: <caoj.fnst@cn.fujitsu.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <indou.takao@jp.fujitsu.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: <kasong@redhat.com>
Cc: <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <msys.mizuma@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190123110850.12433-7-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/compressed/acpi.c  | 121 +++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c |   4 --
 arch/x86/boot/compressed/misc.h  |  10 ++++
 3 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index b2b50ad5299a..c5a949335d8b 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -4,9 +4,22 @@
 #include "error.h"
 #include "../string.h"
 
+#include <linux/numa.h>
 #include <linux/efi.h>
 #include <asm/efi.h>
 
+/*
+ * Longest parameter of 'acpi=' is 'copy_dsdt', plus an extra '\0'
+ * for termination.
+ */
+#define MAX_ACPI_ARG_LENGTH 10
+
+/*
+ * Immovable memory regions representation. Max amount of memory regions is
+ * MAX_NUMNODES*2.
+ */
+struct mem_vector immovable_mem[MAX_NUMNODES*2];
+
 /*
  * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
  * digits, and '\0' for termination.
@@ -203,3 +216,111 @@ acpi_physical_address get_rsdp_addr(void)
 
 	return pa;
 }
+
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+/* Compute SRAT address from RSDP. */
+static unsigned long get_acpi_srat_table(void)
+{
+	unsigned long root_table, acpi_table;
+	struct acpi_table_header *header;
+	struct acpi_table_rsdp *rsdp;
+	u32 num_entries, size, len;
+	char arg[10];
+	u8 *entry;
+
+	rsdp = (struct acpi_table_rsdp *)(long)boot_params->acpi_rsdp_addr;
+	if (!rsdp)
+		return 0;
+
+	/* Get ACPI root table from RSDP.*/
+	if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
+	    !strncmp(arg, "rsdt", 4)) &&
+	    rsdp->xsdt_physical_address &&
+	    rsdp->revision > 1) {
+		root_table = rsdp->xsdt_physical_address;
+		size = ACPI_XSDT_ENTRY_SIZE;
+	} else {
+		root_table = rsdp->rsdt_physical_address;
+		size = ACPI_RSDT_ENTRY_SIZE;
+	}
+
+	if (!root_table)
+		return 0;
+
+	header = (struct acpi_table_header *)root_table;
+	len = header->length;
+	if (len < sizeof(struct acpi_table_header) + size)
+		return 0;
+
+	num_entries = (len - sizeof(struct acpi_table_header)) / size;
+	entry = (u8 *)(root_table + sizeof(struct acpi_table_header));
+
+	while (num_entries--) {
+		if (size == ACPI_RSDT_ENTRY_SIZE)
+			acpi_table = *(u32 *)entry;
+		else
+			acpi_table = *(u64 *)entry;
+
+		if (acpi_table) {
+			header = (struct acpi_table_header *)acpi_table;
+
+			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
+				return acpi_table;
+		}
+		entry += size;
+	}
+	return 0;
+}
+
+/**
+ * count_immovable_mem_regions - Parse SRAT and cache the immovable
+ * memory regions into the immovable_mem array.
+ *
+ * Return the number of immovable memory regions on success, 0 on failure:
+ *
+ * - Too many immovable memory regions
+ * - ACPI off or no SRAT found
+ * - No immovable memory region found.
+ */
+int count_immovable_mem_regions(void)
+{
+	unsigned long table_addr, table_end, table;
+	struct acpi_subtable_header *sub_table;
+	struct acpi_table_header *table_header;
+	char arg[MAX_ACPI_ARG_LENGTH];
+	int num = 0;
+
+	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
+	    !strncmp(arg, "off", 3))
+		return 0;
+
+	table_addr = get_acpi_srat_table();
+	if (!table_addr)
+		return 0;
+
+	table_header = (struct acpi_table_header *)table_addr;
+	table_end = table_addr + table_header->length;
+	table = table_addr + sizeof(struct acpi_table_srat);
+
+	while (table + sizeof(struct acpi_subtable_header) < table_end) {
+		sub_table = (struct acpi_subtable_header *)table;
+		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
+			struct acpi_srat_mem_affinity *ma;
+
+			ma = (struct acpi_srat_mem_affinity *)sub_table;
+			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
+				immovable_mem[num].start = ma->base_address;
+				immovable_mem[num].size = ma->length;
+				num++;
+			}
+
+			if (num >= MAX_NUMNODES*2) {
+				debug_putstr("Too many immovable memory regions, aborting.\n");
+				return 0;
+			}
+		}
+		table += sub_table->length;
+	}
+	return num;
+}
+#endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9ed9709d9947..b251572e77af 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -87,10 +87,6 @@ static unsigned long get_boot_seed(void)
 #define KASLR_COMPRESSED_BOOT
 #include "../../lib/kaslr.c"
 
-struct mem_vector {
-	unsigned long long start;
-	unsigned long long size;
-};
 
 /* Only supporting at most 4 unusable memmap regions with kaslr */
 #define MAX_MEMMAP_REGIONS	4
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index e1dd15769cf3..9911d11c5d09 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -72,6 +72,10 @@ int cmdline_find_option(const char *option, char *buffer, int bufsize);
 int cmdline_find_option_bool(const char *option);
 #endif
 
+struct mem_vector {
+	unsigned long long start;
+	unsigned long long size;
+};
 
 #if CONFIG_RANDOMIZE_BASE
 /* kaslr.c */
@@ -126,3 +130,9 @@ acpi_physical_address get_rsdp_addr(void);
 #else
 static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
 #endif
+
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+int count_immovable_mem_regions(void);
+#else
+static inline int count_immovable_mem_regions(void) { return 0; }
+#endif
