Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C73C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EE1218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfBALAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:00:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBALAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:00:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11AxJ6i3280981
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 02:59:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11AxJdx3280978;
        Fri, 1 Feb 2019 02:59:19 -0800
Date:   Fri, 1 Feb 2019 02:59:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-3c98e71b42a7d0c14639ccb565ea315f3c887f92@git.kernel.org>
Cc:     mingo@kernel.org, mingo@redhat.com, jgross@suse.com,
        thomas.lendacky@amd.com, tglx@linutronix.de, hpa@zytor.com,
        fanc.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org, bp@suse.de,
        x86@kernel.org, kirill.shutemov@linux.intel.com,
        keescook@chromium.org
Reply-To: bp@suse.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
          x86@kernel.org, linux-kernel@vger.kernel.org,
          fanc.fnst@cn.fujitsu.com, keescook@chromium.org,
          mingo@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          jgross@suse.com, thomas.lendacky@amd.com
In-Reply-To: <20190123110850.12433-3-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-3-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Add "acpi_rsdp=" early parsing
Git-Commit-ID: 3c98e71b42a7d0c14639ccb565ea315f3c887f92
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

Commit-ID:  3c98e71b42a7d0c14639ccb565ea315f3c887f92
Gitweb:     https://git.kernel.org/tip/3c98e71b42a7d0c14639ccb565ea315f3c887f92
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:45 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:54 +0100

x86/boot: Add "acpi_rsdp=" early parsing

KASLR may randomly choose offsets which are located in movable memory
regions resulting in the movable memory becoming immovable.

The ACPI SRAT (System/Static Resource Affinity Table) describes memory
ranges including ranges of memory provided by hot-added memory devices.
In order to access SRAT, one needs the Root System Description Pointer
(RSDP) with which to find the Root/Extended System Description Table
(R/XSDT) which then contains the system description tables of which SRAT
is one of.

In case the RSDP address has been passed on the command line (kexec-ing
a second kernel) parse it from there.

 [ bp: Rewrite the commit message and cleanup the code. ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: caoj.fnst@cn.fujitsu.com
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
Link: https://lkml.kernel.org/r/20190123110850.12433-3-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/compressed/acpi.c | 32 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
new file mode 100644
index 000000000000..bacfc4ea35ac
--- /dev/null
+++ b/arch/x86/boot/compressed/acpi.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BOOT_CTYPE_H
+#include "misc.h"
+#include "error.h"
+#include "../string.h"
+
+#ifdef CONFIG_ACPI
+
+/*
+ * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
+ * digits, and '\0' for termination.
+ */
+#define MAX_ADDR_LEN 19
+
+static acpi_physical_address get_acpi_rsdp(void)
+{
+	acpi_physical_address addr = 0;
+
+#ifdef CONFIG_KEXEC
+	char val[MAX_ADDR_LEN] = { };
+	int ret;
+
+	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (kstrtoull(val, 16, &addr))
+		return 0;
+#endif
+	return addr;
+}
+#endif /* CONFIG_ACPI */
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a1d5918765f3..764ad50c0119 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -25,6 +25,9 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 
+#define BOOT_CTYPE_H
+#include <linux/acpi.h>
+
 #define BOOT_BOOT_H
 #include "../ctype.h"
 
