Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeENHo1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:44:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeENHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:44:25 -0400
Date: Mon, 14 May 2018 00:44:00 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-75e4fd31ce90e7f268365cb455381581896e0bca@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        matt@codeblueprint.co.uk, peterz@infradead.org,
        ard.biesheuvel@linaro.org, tglx@linutronix.de
Reply-To: bp@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, ard.biesheuvel@linaro.org, peterz@infradead.org,
        matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
        mingo@kernel.org
In-Reply-To: <20180504060003.19618-3-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-3-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/cper: Remove the INDENT_SP silliness
Git-Commit-ID: 75e4fd31ce90e7f268365cb455381581896e0bca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  75e4fd31ce90e7f268365cb455381581896e0bca
Gitweb:     https://git.kernel.org/tip/75e4fd31ce90e7f268365cb455381581896e0bca
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 4 May 2018 07:59:48 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:47 +0200

efi/cper: Remove the INDENT_SP silliness

A separate define just to print a space character is silly and
completely unneeded. Remove it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/cper-arm.c | 6 ++----
 drivers/firmware/efi/cper.c     | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 698e5c8e0c8d..502811344e81 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -30,8 +30,6 @@
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 
-#define INDENT_SP	" "
-
 static const char * const arm_reg_ctx_strs[] = {
 	"AArch32 general purpose registers",
 	"AArch32 EL1 context registers",
@@ -283,7 +281,7 @@ void cper_print_proc_arm(const char *pfx,
 			pfx, proc->psci_state);
 	}
 
-	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
 
 	err_info = (struct cper_arm_err_info *)(proc + 1);
 	for (i = 0; i < proc->err_info_num; i++) {
@@ -310,7 +308,7 @@ void cper_print_proc_arm(const char *pfx,
 		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
 			printk("%serror_info: 0x%016llx\n", newpfx,
 			       err_info->error_info);
-			snprintf(infopfx, sizeof(infopfx), "%s%s", newpfx, INDENT_SP);
+			snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
 			cper_print_arm_err_info(infopfx, err_info->type,
 						err_info->error_info);
 		}
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index c165933ebf38..ab21f1614007 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -37,8 +37,6 @@
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 
-#define INDENT_SP	" "
-
 static char rcd_decode_str[CPER_REC_LEN];
 
 /*
@@ -433,7 +431,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 		printk("%s""fru_text: %.20s\n", pfx, gdata->fru_text);
 
-	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
 	if (guid_equal(sec_type, &CPER_SEC_PROC_GENERIC)) {
 		struct cper_sec_proc_generic *proc_err = acpi_hest_get_payload(gdata);
 
@@ -500,7 +498,7 @@ void cper_estatus_print(const char *pfx,
 		       "It has been corrected by h/w "
 		       "and requires no further action");
 	printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
-	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
 
 	apei_estatus_for_each_section(estatus, gdata) {
 		cper_estatus_print_section(newpfx, gdata, sec_no);
