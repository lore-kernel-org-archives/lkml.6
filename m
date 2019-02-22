Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B95206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjk9Y0DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfBVU0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:26:35 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:36904 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBVU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:26:21 -0500
Received: by mail-vk1-f202.google.com with SMTP id q65so1600479vkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8ZLu9apGJq8gMxM5fACckAPsW9cvH79FQBy+6X2uyc4=;
        b=jjk9Y0DSJr31PAijE1VAhzeYGJwQBiuw4R13Y+cM2jKBQWe7RFRRzTRWqyb0AQhqd8
         tOalXyt8ulNJgbQBaV915incR5EvtBoFKTx2KRjMcK40a4Swexf1RR+lyDZwcPR0xZHZ
         pk3B9oAx/m1niI99/67S94VbZIdEdcxWCiLKwOZ0TDFjtnV5CJ8YUe29uUmgloHE7ZWh
         c/Q2SMU77B+TWlewVizz6l3TTnmfjnsQlTydvywAtTjmaikZmhz9zZFM+KB5Rcw0N+GU
         zjYUsgXdUWZzur4GTYlCNlu19siCy8VDEjmFzBAjj/T1HPWc9GVEkYCCwHldooZfQuxj
         GG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8ZLu9apGJq8gMxM5fACckAPsW9cvH79FQBy+6X2uyc4=;
        b=gB5HHVcCkz9Skgb047LeCw/dXgu8Lwwttncc6Ei81e23d4yp3NTquvgUj6AulaI8Yb
         WcGSYEhHgZ+mLZt6lyBY7QbDP4DULov45JVz7IGh0XbjCkXRIWRtf7IR/6bLIfnKonB6
         WaQgrjK1b+hOD5Ds7S6Naz6Hwn5TPRZB7U2FTFf1R4GV+abSO/vYakyARhyv/ZSvDM3q
         hTM3GcgOYy1nTZPOrFkrxROKeCMI4yUZK40fPLRhflfPLFeY99+tIRsRXyLOMT6Ho70r
         v8ydvIQbe0yrOPNNf2ijN/Vm6ZNfoQsdCvF+Fwmue3ehXUbzk5uR6TC3LbwfJQu6o7yp
         BHrQ==
X-Gm-Message-State: AHQUAuaLQpw+N5AIZT5AbvwucP4i8jnQK88nVwAXsbBnjrDg9ENILgbe
        bNk1vrVlQ5NTOLo+CoU8zlYMyF3oAW267Pv/HNNehw==
X-Google-Smtp-Source: AHgI3IbxQ+WnEa1/boPr02rjPJvsi/TF2O3WIyWJ2V88tbL2ZfaXand/Xu/BuwpCrTw/FKj2l4P2xXsSmArD5SMITXRi0w==
X-Received: by 2002:a1f:9750:: with SMTP id z77mr196035vkd.5.1550867180288;
 Fri, 22 Feb 2019 12:26:20 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:26:05 -0800
In-Reply-To: <20190222202606.160816-1-matthewgarrett@google.com>
Message-Id: <20190222202606.160816-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190222202606.160816-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH V4 3/4] tpm: Append the final event log to the TPM event log
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

Any events that are logged after GetEventsLog() is called are logged to
the EFI Final Events table. These events are defined as being in the
crypto agile log format, so we can just append them directly to the
existing log if it's in the same format. In theory we can also construct
old-style SHA1 log entries for devices that only return logs in that
format, but EDK2 doesn't generate the final event log in that case so
it doesn't seem worth it at the moment.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/efi.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 3e673ab22cb4..9179cf6bdee9 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -21,10 +21,13 @@
 int tpm_read_log_efi(struct tpm_chip *chip)
 {
 
+	struct efi_tcg2_final_events_table *final_tbl = NULL;
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct tpm_bios_log *log;
 	u32 log_size;
 	u8 tpm_log_version;
+	void *tmp;
+	int ret;
 
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
@@ -52,15 +55,48 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 
 	/* malloc EventLog space */
 	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
-	if (!log->bios_event_log)
-		goto err_memunmap;
-	log->bios_event_log_end = log->bios_event_log + log_size;
+	if (!log->bios_event_log) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
+	log->bios_event_log_end = log->bios_event_log + log_size;
 	tpm_log_version = log_tbl->version;
-	memunmap(log_tbl);
-	return tpm_log_version;
 
-err_memunmap:
+	ret = tpm_log_version;
+
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
+	    efi_tpm_final_log_size == 0 ||
+	    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		goto out;
+
+	final_tbl = memremap(efi.tpm_final_log,
+			     sizeof(*final_tbl) + efi_tpm_final_log_size,
+			     MEMREMAP_WB);
+	if (!final_tbl) {
+		pr_err("Could not map UEFI TPM final log\n");
+		kfree(log->bios_event_log);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tmp = krealloc(log->bios_event_log,
+		       log_size + efi_tpm_final_log_size,
+		       GFP_KERNEL);
+	if (!tmp) {
+		kfree(log->bios_event_log);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	log->bios_event_log = tmp;
+	memcpy((void *)log->bios_event_log + log_size,
+	       final_tbl->events, efi_tpm_final_log_size);
+	log->bios_event_log_end = log->bios_event_log +
+		log_size + efi_tpm_final_log_size;
+
+out:
+	memunmap(final_tbl);
 	memunmap(log_tbl);
-	return -ENOMEM;
+	return ret;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

