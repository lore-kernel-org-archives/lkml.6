Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E7AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F007218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfBALBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:01:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729979AbfBALBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:01:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11B1B2S3281432
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 03:01:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11B1B3G3281429;
        Fri, 1 Feb 2019 03:01:11 -0800
Date:   Fri, 1 Feb 2019 03:01:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
Cc:     mingo@kernel.org, jgross@suse.com, yamada.masahiro@socionext.com,
        hpa@zytor.com, keescook@chromium.org, mingo@redhat.com,
        fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, x86@kernel.org,
        thomas.lendacky@amd.com, kirill.shutemov@linux.intel.com,
        bp@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          kirill.shutemov@linux.intel.com, bp@suse.de,
          fanc.fnst@cn.fujitsu.com, mingo@redhat.com,
          thomas.lendacky@amd.com, yamada.masahiro@socionext.com,
          caoj.fnst@cn.fujitsu.com, jgross@suse.com, mingo@kernel.org,
          keescook@chromium.org, x86@kernel.org, hpa@zytor.com
In-Reply-To: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Git-Commit-ID: 3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
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

Commit-ID:  3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
Gitweb:     https://git.kernel.org/tip/3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:48 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:55 +0100

x86/boot: Early parse RSDP and save it in boot_params

The RSDP is needed by KASLR so parse it early and save it in
boot_params.acpi_rsdp_addr, before KASLR setup runs.

RSDP is needed by other kernel facilities so have the parsing code
built-in instead of a long "depends on" line in Kconfig.

 [ bp:
    - Trim commit message and comments
    - Add CONFIG_ACPI dependency in the Makefile
    - Move ->acpi_rsdp_addr assignment with the rest of boot_params massaging in extract_kernel().
 ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190123110850.12433-6-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/compressed/Makefile |  2 ++
 arch/x86/boot/compressed/acpi.c   | 19 +++++++++++++++++++
 arch/x86/boot/compressed/misc.c   |  3 +++
 arch/x86/boot/compressed/misc.h   |  7 +++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f0515ac895a4..6b84afdd7538 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,6 +84,8 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 endif
 
+vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
+
 $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 66bda1b5cf94..b2b50ad5299a 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -184,3 +184,22 @@ static acpi_physical_address bios_get_rsdp_addr(void)
 
 	return 0;
 }
+
+/* Return RSDP address on success, otherwise 0. */
+acpi_physical_address get_rsdp_addr(void)
+{
+	acpi_physical_address pa;
+
+	pa = get_acpi_rsdp();
+
+	if (!pa)
+		pa = boot_params->acpi_rsdp_addr;
+
+	if (!pa)
+		pa = efi_get_rsdp_addr();
+
+	if (!pa)
+		pa = bios_get_rsdp_addr();
+
+	return pa;
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8dd1d5ccae58..c0d6c560df69 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -351,6 +351,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
+	/* Save RSDP address for later use. */
+	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+
 	sanitize_boot_params(boot_params);
 
 	if (boot_params->screen_info.orig_video_mode == 7) {
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 764ad50c0119..e1dd15769cf3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -119,3 +119,10 @@ static inline void console_init(void)
 void set_sev_encryption_mask(void);
 
 #endif
+
+/* acpi.c */
+#ifdef CONFIG_ACPI
+acpi_physical_address get_rsdp_addr(void);
+#else
+static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
+#endif
