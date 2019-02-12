Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FE3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8812186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wV4ypSTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfBLKJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:09:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45765 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfBLKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:09:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so1503621lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eDxgpCyTt8rhddJ7l37wFgpldPhrbft8aF2wK2MXIg=;
        b=wV4ypSTqcrDd0SztvKI9oqw/2agdeio1aJvvkDH0hls5whgiHNQFh2gikmSk2mEptB
         XBAblMjCJdO5Yp9a90kkBWt3+mlKLvlS545xN5v8utYy5kblwY8v+fwOs72XlxG3bye1
         OMOtxQ344IyV+uXphmI4TUSZ0YWcUlVmx/qdsuY4pFa1e2L8ZeF8vZDS7gJ/njPlbU/U
         INq19AxpKqG8/poQmVQKuRvjIYCgMsLNmjAbxLSVfBTO6I8FEKW6Cccl3Bz0xdppjYPO
         5Q9RPkwCizhSGZkXEB/VgLsWr0rsqHSuiJOCmXuW9F9GuH7oW5meKV0LvWlR7zLGNlp7
         mM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eDxgpCyTt8rhddJ7l37wFgpldPhrbft8aF2wK2MXIg=;
        b=VUTF944WGqKw3iUJGF5fGAlGR1nXRqwENXGjhjxp/ZIrximq1fNRWlxUYGP5a/dfcQ
         Z8MWO/38PlBogiXFVjcnAMS5qzpcWI5VHOsN4gsIRspheNTUzGR6ca08sDbp/+UOZKDX
         f4PSPzT6IrzHyhL3R1fLoLqGPZRBsFsKV2SOohaaN2KPCDqfo36Up5DKpix8n6Eg6GTn
         dQPWKQq1bx9FslKEp0BVjdSOV6BDq8sxOKjL11vHcQPej2QE2O+tUz8pS64w5CWrYvW7
         hX/bOuHZSXC86Yq5rP3hpxz9IzqxA25q3Hv3s+VwfYfqpw0cFvHin01MVr6anfSPjyTZ
         N2oQ==
X-Gm-Message-State: AHQUAuZsl8CMrYTlXiU3d+MVrFUP5jrEcfZQZ4LaGyY5jraFTBiWY7Bt
        mfvJKBSmrPWWjZ5BSZB0i2I9Iw==
X-Google-Smtp-Source: AHgI3IbqZxwkkApp8j8YB3RC34hPEVtBLuxR2c7Ey7k9k0LDbCYkDWX3x37flrS6KMcpiEkV31LCrA==
X-Received: by 2002:a19:da1a:: with SMTP id r26mr1748578lfg.2.1549966144583;
        Tue, 12 Feb 2019 02:09:04 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id k3-v6sm2600300lja.8.2019.02.12.02.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 02:09:03 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] efi: fix build error redeclaration of enumerator
Date:   Tue, 12 Feb 2019 11:08:25 +0100
Message-Id: <20190212100825.9113-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212100825.9113-1-anders.roxell@linaro.org>
References: <20190212100825.9113-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a893ea15d764 ("tpm: move tpm_chip definition to
include/linux/tpm.h") introduced a build error when both ima and efi is
enabled. What happens is that both headers (ima.h and efi.h) defines the
same 'NONE' constant, and it broke when they started getting included
from the same file.

In file included from ../security/integrity/ima/ima_fs.c:30:
../security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator "NONE"
  hook(NONE)   \
       ^~~~
../security/integrity/ima/ima.h:188:34: note: in definition of macro "__ima_hook_enumify"
 #define __ima_hook_enumify(ENUM) ENUM,
                                  ^~~~
../security/integrity/ima/ima.h:191:2: note: in expansion of macro "__ima_hooks"
  __ima_hooks(__ima_hook_enumify)
  ^~~~~~~~~~~
In file included from ../arch/arm64/include/asm/acpi.h:15,
                 from ../include/acpi/acpi_io.h:7,
                 from ../include/linux/acpi.h:47,
                 from ../include/linux/tpm.h:26,
                 from ../security/integrity/ima/ima.h:25,
                 from ../security/integrity/ima/ima_fs.c:30:
../include/linux/efi.h:1723:2: note: previous definition of "NONE" was here
  NONE,
  ^~~~
make[4]: *** [../scripts/Makefile.build:277: security/integrity/ima/ima_fs.o] Error 1

Rework to prefix the efi enum with 'EFI_*'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

We only need one of the two patches applied.

 arch/x86/platform/efi/quirks.c          |  2 +-
 drivers/firmware/efi/runtime-wrappers.c | 48 ++++++++++++-------------
 include/linux/efi.h                     | 26 +++++++-------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 9ce85e605052..b7c0b04ee6ad 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -742,7 +742,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * because this case occurs *very* rarely and hence could be improved
 	 * on a need by basis.
 	 */
-	if (efi_rts_work.efi_rts_id == RESET_SYSTEM) {
+	if (efi_rts_work.efi_rts_id == EFI_RESET_SYSTEM) {
 		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
 		machine_real_restart(MRR_BIOS);
 		return;
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index c70df5ae7c4a..28138534643e 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -85,7 +85,7 @@ struct efi_runtime_work efi_rts_work;
 		pr_err("Failed to queue work to efi_rts_wq.\n");	\
 									\
 exit:									\
-	efi_rts_work.efi_rts_id = NONE;					\
+	efi_rts_work.efi_rts_id = EFI_NONE;				\
 	efi_rts_work.status;						\
 })
 
@@ -181,50 +181,50 @@ static void efi_call_rts(struct work_struct *work)
 	arg5 = efi_rts_work.arg5;
 
 	switch (efi_rts_work.efi_rts_id) {
-	case GET_TIME:
+	case EFI_GET_TIME:
 		status = efi_call_virt(get_time, (efi_time_t *)arg1,
 				       (efi_time_cap_t *)arg2);
 		break;
-	case SET_TIME:
+	case EFI_SET_TIME:
 		status = efi_call_virt(set_time, (efi_time_t *)arg1);
 		break;
-	case GET_WAKEUP_TIME:
+	case EFI_GET_WAKEUP_TIME:
 		status = efi_call_virt(get_wakeup_time, (efi_bool_t *)arg1,
 				       (efi_bool_t *)arg2, (efi_time_t *)arg3);
 		break;
-	case SET_WAKEUP_TIME:
+	case EFI_SET_WAKEUP_TIME:
 		status = efi_call_virt(set_wakeup_time, *(efi_bool_t *)arg1,
 				       (efi_time_t *)arg2);
 		break;
-	case GET_VARIABLE:
+	case EFI_GET_VARIABLE:
 		status = efi_call_virt(get_variable, (efi_char16_t *)arg1,
 				       (efi_guid_t *)arg2, (u32 *)arg3,
 				       (unsigned long *)arg4, (void *)arg5);
 		break;
-	case GET_NEXT_VARIABLE:
+	case EFI_GET_NEXT_VARIABLE:
 		status = efi_call_virt(get_next_variable, (unsigned long *)arg1,
 				       (efi_char16_t *)arg2,
 				       (efi_guid_t *)arg3);
 		break;
-	case SET_VARIABLE:
+	case EFI_SET_VARIABLE:
 		status = efi_call_virt(set_variable, (efi_char16_t *)arg1,
 				       (efi_guid_t *)arg2, *(u32 *)arg3,
 				       *(unsigned long *)arg4, (void *)arg5);
 		break;
-	case QUERY_VARIABLE_INFO:
+	case EFI_QUERY_VARIABLE_INFO:
 		status = efi_call_virt(query_variable_info, *(u32 *)arg1,
 				       (u64 *)arg2, (u64 *)arg3, (u64 *)arg4);
 		break;
-	case GET_NEXT_HIGH_MONO_COUNT:
+	case EFI_GET_NEXT_HIGH_MONO_COUNT:
 		status = efi_call_virt(get_next_high_mono_count, (u32 *)arg1);
 		break;
-	case UPDATE_CAPSULE:
+	case EFI_UPDATE_CAPSULE:
 		status = efi_call_virt(update_capsule,
 				       (efi_capsule_header_t **)arg1,
 				       *(unsigned long *)arg2,
 				       *(unsigned long *)arg3);
 		break;
-	case QUERY_CAPSULE_CAPS:
+	case EFI_QUERY_CAPSULE_CAPS:
 		status = efi_call_virt(query_capsule_caps,
 				       (efi_capsule_header_t **)arg1,
 				       *(unsigned long *)arg2, (u64 *)arg3,
@@ -248,7 +248,7 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
+	status = efi_queue_work(EFI_GET_TIME, tm, tc, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -259,7 +259,7 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
+	status = efi_queue_work(EFI_SET_TIME, tm, NULL, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -272,7 +272,7 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
+	status = efi_queue_work(EFI_GET_WAKEUP_TIME, enabled, pending, tm, NULL,
 				NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -284,7 +284,7 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
+	status = efi_queue_work(EFI_SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
 				NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -300,7 +300,7 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
+	status = efi_queue_work(EFI_GET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -314,7 +314,7 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
+	status = efi_queue_work(EFI_GET_NEXT_VARIABLE, name_size, name, vendor,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -330,7 +330,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
+	status = efi_queue_work(EFI_SET_VARIABLE, name, vendor, &attr, &data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -365,7 +365,7 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
+	status = efi_queue_work(EFI_QUERY_VARIABLE_INFO, &attr, storage_space,
 				remaining_space, max_variable_size, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -397,7 +397,7 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
+	status = efi_queue_work(EFI_GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -413,7 +413,7 @@ static void virt_efi_reset_system(int reset_type,
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
-	efi_rts_work.efi_rts_id = RESET_SYSTEM;
+	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	__efi_call_virt(reset_system, reset_type, status, data_size, data);
 	up(&efi_runtime_lock);
 }
@@ -429,7 +429,7 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
+	status = efi_queue_work(EFI_UPDATE_CAPSULE, capsules, &count, &sg_list,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -447,7 +447,7 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
+	status = efi_queue_work(EFI_QUERY_CAPSULE_CAPS, capsules, &count,
 				max_size, reset_type, NULL);
 	up(&efi_runtime_lock);
 	return status;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a4de93c96907..b3471b6ff92f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1720,19 +1720,19 @@ extern int efi_tpm_eventlog_init(void);
  * fault happened while executing an efi runtime service.
  */
 enum efi_rts_ids {
-	NONE,
-	GET_TIME,
-	SET_TIME,
-	GET_WAKEUP_TIME,
-	SET_WAKEUP_TIME,
-	GET_VARIABLE,
-	GET_NEXT_VARIABLE,
-	SET_VARIABLE,
-	QUERY_VARIABLE_INFO,
-	GET_NEXT_HIGH_MONO_COUNT,
-	RESET_SYSTEM,
-	UPDATE_CAPSULE,
-	QUERY_CAPSULE_CAPS,
+	EFI_NONE,
+	EFI_GET_TIME,
+	EFI_SET_TIME,
+	EFI_GET_WAKEUP_TIME,
+	EFI_SET_WAKEUP_TIME,
+	EFI_GET_VARIABLE,
+	EFI_GET_NEXT_VARIABLE,
+	EFI_SET_VARIABLE,
+	EFI_QUERY_VARIABLE_INFO,
+	EFI_GET_NEXT_HIGH_MONO_COUNT,
+	EFI_RESET_SYSTEM,
+	EFI_UPDATE_CAPSULE,
+	EFI_QUERY_CAPSULE_CAPS,
 };
 
 /*
-- 
2.20.1

