Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeEDGB1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:01:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53514 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeEDGBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:01:24 -0400
X-Google-Smtp-Source: AB8JxZrPtnU3pEf9njCi0yQi7fnpcvi7kOUsloh3kyzlDTMUczRrBePgkeRfwdqF44IIHoIf4Qqdag==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] efi/libstub/tpm: Make function efi_retrieve_tpm2_eventlog_1_2() static
Date: Fri,  4 May 2018 07:59:57 +0200
Message-Id: <20180504060003.19618-12-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/firmware/efi/libstub/tpm.c:62:6: warning:
 symbol 'efi_retrieve_tpm2_eventlog_1_2' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.17.0
