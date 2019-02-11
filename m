Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BD2218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="mxJwbMP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbfBKQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:00:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44499 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbfBKObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id a16so4826879ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln6fM3szTzWlr7YX/AOAutoZxJqo4vzjmHWgjbDG09Q=;
        b=mxJwbMP9AE6Z6Xp7QcJsYtNs7m7uIBdHTmLfyahLu/gVBKQOVWIeUJA53gs5y+8KMX
         6ClTgjljC9bCDzHAu8FHU/HwDzCQ5uC8gSrusVFvywOEuwONj7YJi5uO4e0kT7pOA2Cl
         hrJIrgW5pM7aBoX88phdDCsZz+UDUpMe4TD7W2RVOhEtvSsKxDtgjgIGXyzoYkshghGf
         DZJT093lT9NiUEp9zkMnnaICXKLp6wUbZz4QTyDt+4QOKOMu/GgeePuVivgYcNFn2UXP
         h6suGnqUvWm+tSl3KsnCzBLB+D+eCIn/JYirLMmVA/K0P+xewGAeG3GitDVw1Yzg/Zof
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln6fM3szTzWlr7YX/AOAutoZxJqo4vzjmHWgjbDG09Q=;
        b=JImdXJm4GXYGyxXWP14v3zf6JcnI/zCi+PayTTPDGmfxd1gWmeSTUD+Puujur6gH58
         huD3GDcsASojuYXnem0xnX5kF/aKG7kK8dgsRw3ykPoXMyjx242UUIdTV+5pVyZqOG4L
         9d08RTDXWeoEDdg2vNVeqHqYKRTyYojZTscQaDKD9W1EnF9iz4whVDUKJWXENbjrO05b
         GCnsv6Bo/u2wK/oXBUmUmXWiA9qVr2GSH/2ol+rTk13upgSZo3XuQy2Hav8hG8nemJrL
         Y/Sfi0hwYLpnNxyYBKfT5JMvXRNR0Bj4tfN98GrCVYVy2XUDNI/hpvVDQxxeRbXUorYZ
         HbIA==
X-Gm-Message-State: AHQUAub/Sjg8gdcnC9wVqcNedSybJWchvzXX55WvmaLb8moi3EFdN4Ab
        e4xvtcNJG7Yko9tLRDBn531woVFFCZfsNA==
X-Google-Smtp-Source: AHgI3IbmPwTbEcsSKY4UjyIhXnteVk4oYnCvmlgsENltt+kNY1l4LZq8SWX4uOYolHBw++8lZm7VFQ==
X-Received: by 2002:a2e:99d4:: with SMTP id l20-v6mr4713090ljj.142.1549895501475;
        Mon, 11 Feb 2019 06:31:41 -0800 (PST)
Received: from bsz-kubuntu.semihalf.local (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id z6sm2322373lfa.87.2019.02.11.06.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:31:40 -0800 (PST)
From:   bsz@semihalf.com
To:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, ard.biesheuvel@linaro.org
Cc:     tweek@google.com, mingo@kernel.org, hdegoede@redhat.com,
        leif.lindholm@linaro.org, mw@semihalf.com,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH 4/5] efi/libstub/tpm: Retrieve TPM event log in 2.0 format
Date:   Mon, 11 Feb 2019 15:30:51 +0100
Message-Id: <20190211143052.3128-5-bsz@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211143052.3128-1-bsz@semihalf.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Szczepanek <bsz@semihalf.com>

Currently, the only way to get TPM 2.0 event log from firmware is to use
device tree. Introduce efi_retrieve_tpm2_eventlog_2 function to enable
retrieving it from EFI structures.

Include lib/tpm.c into EFI stub to calculate event sizes using helper
function.

Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
---
 drivers/firmware/efi/libstub/Makefile |   3 +-
 drivers/firmware/efi/libstub/tpm.c    | 107 +++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d9845099635e..0d7d66ad916d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,7 +38,8 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT			:= n
 
-lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o
+lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
+				   lib-tpm.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a90b0b8fc69a..c8c2531be413 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -129,8 +129,111 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	efi_call_early(free_pool, log_tbl);
 }
 
+static efi_status_t
+efi_calc_tpm2_eventlog_2_size(efi_system_table_t *sys_table_arg,
+	void *log, void *last_entry, ssize_t *log_size)
+{
+	struct tcg_pcr_event2 *event = last_entry;
+	struct tcg_efi_specid_event *efispecid;
+	struct tcg_pcr_event *log_header = log;
+	ssize_t last_entry_size;
+
+	efispecid = (struct tcg_efi_specid_event *) log_header->event;
+
+	if (last_entry == NULL || log_size == NULL)
+		return EFI_INVALID_PARAMETER;
+
+	if (log == last_entry) {
+		/*
+		 * Only one entry (header) in the log.
+		 */
+		*log_size = log_header->event_size +
+			    sizeof(struct tcg_pcr_event);
+		return EFI_SUCCESS;
+	}
+
+	if (event->count > efispecid->num_algs) {
+		efi_printk(sys_table_arg,
+			   "TCG2 event uses more algorithms than defined\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	last_entry_size = calc_tpm2_event_size(last_entry, efispecid);
+	if (last_entry_size < 0) {
+		efi_printk(sys_table_arg,
+			"TCG2 log has invalid last entry size\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	*log_size = last_entry + last_entry_size - log;
+	return EFI_SUCCESS;
+}
+
+static efi_status_t efi_retrieve_tpm2_eventlog_2(efi_system_table_t *sys_table_arg)
+{
+	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
+	efi_physical_addr_t log_location = 0, log_last_entry = 0;
+	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	efi_bool_t truncated;
+	efi_status_t status;
+	struct linux_efi_tpm_eventlog *log_tbl = NULL;
+	void *tcg2_protocol = NULL;
+	ssize_t log_size;
+
+	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
+				&tcg2_protocol);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
+				EFI_TCG2_EVENT_LOG_FORMAT_TCG_2,
+				&log_location, &log_last_entry, &truncated);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	if (!log_location)
+		return EFI_NOT_FOUND;
+
+	status = efi_calc_tpm2_eventlog_2_size(sys_table_arg,
+					       (void *)log_location,
+					       (void *) log_last_entry,
+					       &log_size);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	/* Allocate space for the logs and copy them. */
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
+				sizeof(*log_tbl) + log_size,
+				(void **) &log_tbl);
+
+	if (status != EFI_SUCCESS) {
+		efi_printk(sys_table_arg,
+			   "Unable to allocate memory for event log\n");
+		return status;
+	}
+
+	memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
+	log_tbl->size = log_size;
+	log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	memcpy(log_tbl->log, (void *) log_location, log_size);
+
+	status = efi_call_early(install_configuration_table,
+				&linux_eventlog_guid, log_tbl);
+	if (status != EFI_SUCCESS)
+		goto err_free;
+
+	return EFI_SUCCESS;
+
+err_free:
+	efi_call_early(free_pool, log_tbl);
+	return status;
+}
+
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 {
-	/* Only try to retrieve the logs in 1.2 format. */
-	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
+	efi_status_t status;
+
+	status = efi_retrieve_tpm2_eventlog_2(sys_table_arg);
+	if (status != EFI_SUCCESS)
+		efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
 }
-- 
2.14.4

