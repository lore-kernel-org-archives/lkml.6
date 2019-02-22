Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D59C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009F2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1mHfRL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBVU01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:26:27 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45160 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfBVU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:26:24 -0500
Received: by mail-qt1-f202.google.com with SMTP id 35so3098794qty.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QdqoL0K3zxFFGbmlyhBJxqAUmz+voVFPYJ0GB3SWvlY=;
        b=s1mHfRL+EDTU5WJMCV1wxupbcwVVB2OrrhGchRt5aCjj1ppa4myp4g5/p3mFBP/WCD
         rHK13sQYsXjNwu7nI+WX9gPhgpsfRreXtmCTw0dSyjYENcU6RFZI61hu0RFGVVDln9pt
         HOy26IrEpNsZeBRzUK2IJVRtdtTwvEKH3CHMLotGuKpPfZCSMMeXLIRlbG6vuU8BAKpq
         ui4n6yntzHt5j8jf0ulu04Hz0/KJ2rcBG/0t5PZ9rxU8hbMXHjUKwV7W/HP7fY1hqSxS
         DehwscNHkKhngiPM9A2H/57/h6oYyeQ+6BsfHHTVVFoiYzoK4EoP2XbXjFHTL1iLysmR
         u6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QdqoL0K3zxFFGbmlyhBJxqAUmz+voVFPYJ0GB3SWvlY=;
        b=t0qEuruTVR3T1SP6k3ck2H1jIgUsbYSJ8hgWoJzrfD1/MNlu3As8NvafynyAPlA05k
         ifAnGfUy/A3Uv2z6fKOh8ABmM9qcmNm5CLSmP8L8Riv1AuvSJDhwlWsXfUteLmLBoMzb
         AJ0nEYZuOMKJB12DNnkNMpF6RSXZdV9tQLhdz87hGaWm9VaH5flEd7QPlI5eG2MJwG4O
         ztvz3ZSx1GPjx114xtw7V2xj8Go2Nax7ra460no/aQb1AXNowlB0xwbHYBudF6mOtY0j
         1TffTDQ9lRzBqhKk9LTPTxecSgGRY5kOCdSMZeYy3k1B+20egz1R38U1oA28NK/il7y0
         uKQQ==
X-Gm-Message-State: AHQUAua8590kvkUyNZxSYN6PHA1BMdhtMLi45ZFvOC+SVqvXZQ9lYnZN
        KNfWfVvoqyBmYEx2CmmKnGYRqzhHxTFWtRc3JpbJmw==
X-Google-Smtp-Source: AHgI3IZ6hRQOpgvZQ7RZTDBrH6MpRsUnwB5Cm2xa4JwoZXOgxyM0uZaoo6PmI7/4HwRZladXWq0OXWEQpbpV0NseTkt1eg==
X-Received: by 2002:a37:d654:: with SMTP id t81mr3541286qki.4.1550867182796;
 Fri, 22 Feb 2019 12:26:22 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:26:06 -0800
In-Reply-To: <20190222202606.160816-1-matthewgarrett@google.com>
Message-Id: <20190222202606.160816-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190222202606.160816-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH V4 4/4] efi: Attempt to get the TCG2 event log in the boot stub
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

Right now we only attempt to obtain the SHA1-only event log. The
protocol also supports a crypto agile log format, which contains digests
for all algorithms in use. Attempt to obtain this first, and fall back
to obtaining the older format if the system doesn't support it. This is
lightly complicated by the event sizes being variable (as we don't know
in advance which algorithms are in use), and the interface giving us
back a pointer to the start of the final entry rather than a pointer to
the end of the log - as a result, we need to parse the final entry to
figure out its length in order to know how much data to copy up to the
OS.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/libstub/tpm.c | 50 ++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a90b0b8fc69a..523cd07c551c 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -59,7 +59,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
 
 #endif
 
-static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
+void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
@@ -69,6 +69,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
+	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	void *tcg2_protocol = NULL;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
@@ -76,14 +77,20 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return;
 
-	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
-				EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
-				&log_location, &log_last_entry, &truncated);
-	if (status != EFI_SUCCESS)
-		return;
+	status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+				tcg2_protocol, version, &log_location,
+				&log_last_entry, &truncated);
+
+	if (status != EFI_SUCCESS || !log_location) {
+		version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+		status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+					tcg2_protocol, version, &log_location,
+					&log_last_entry, &truncated);
+		if (status != EFI_SUCCESS || !log_location)
+			return;
+
+	}
 
-	if (!log_location)
-		return;
 	first_entry_addr = (unsigned long) log_location;
 
 	/*
@@ -98,8 +105,23 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 		 * We need to calculate its size to deduce the full size of
 		 * the logs.
 		 */
-		last_entry_size = sizeof(struct tcpa_event) +
-			((struct tcpa_event *) last_entry_addr)->event_size;
+		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+			/*
+			 * The TCG2 log format has variable length entries,
+			 * and the information to decode the hash algorithms
+			 * back into a size is contained in the first entry -
+			 * pass a pointer to the final entry (to calculate its
+			 * size) and the first entry (so we know how long each
+			 * digest is)
+			 */
+			last_entry_size =
+				__calc_tpm2_event_size((void *)last_entry_addr,
+						       (void *)log_location,
+						       false);
+		} else {
+			last_entry_size = sizeof(struct tcpa_event) +
+			   ((struct tcpa_event *) last_entry_addr)->event_size;
+		}
 		log_size = log_last_entry - log_location + last_entry_size;
 	}
 
@@ -116,7 +138,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 
 	memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
 	log_tbl->size = log_size;
-	log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	log_tbl->version = version;
 	memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
 
 	status = efi_call_early(install_configuration_table,
@@ -128,9 +150,3 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 err_free:
 	efi_call_early(free_pool, log_tbl);
 }
-
-void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
-{
-	/* Only try to retrieve the logs in 1.2 format. */
-	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
-}
-- 
2.21.0.rc0.258.g878e2cd30e-goog

