Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeENHtR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:49:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeENHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:49:13 -0400
Date: Mon, 14 May 2018 00:48:49 -0700
From: tip-bot for Wei Yongjun <tipbot@zytor.com>
Message-ID: <tip-0add16c13f49bda5455d9418d479d6c89f7ab272@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, jarkko.sakkinen@linux.intel.com,
        matt@codeblueprint.co.uk, peterz@infradead.org,
        ard.biesheuvel@linaro.org
Reply-To: ard.biesheuvel@linaro.org, peterz@infradead.org,
        matt@codeblueprint.co.uk, jarkko.sakkinen@linux.intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, weiyongjun1@huawei.com,
        hpa@zytor.com
In-Reply-To: <20180504060003.19618-12-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-12-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/libstub/tpm: Make function
 efi_retrieve_tpm2_eventlog_1_2() static
Git-Commit-ID: 0add16c13f49bda5455d9418d479d6c89f7ab272
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

Commit-ID:  0add16c13f49bda5455d9418d479d6c89f7ab272
Gitweb:     https://git.kernel.org/tip/0add16c13f49bda5455d9418d479d6c89f7ab272
Author:     Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate: Fri, 4 May 2018 07:59:57 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:48 +0200

efi/libstub/tpm: Make function efi_retrieve_tpm2_eventlog_1_2() static

Fixes the following sparse warning:

drivers/firmware/efi/libstub/tpm.c:62:6: warning:
 symbol 'efi_retrieve_tpm2_eventlog_1_2' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-12-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 9d08cea3f1b0..caa37a6dd9d4 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -59,7 +59,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
 
 #endif
 
-void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
+static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
