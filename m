Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91B2213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZusZWA5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfB0U1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:27:17 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:54363 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbfB0U1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:27:15 -0500
Received: by mail-io1-f74.google.com with SMTP id i24so13849501iol.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HzTSVpbyy+61Yj0es9srcGM5gLbmwFRA6fCyyZe10xo=;
        b=ZusZWA5EWkQ+3nCd805J8/tavC/3hxqnGpjfNPRYUqt8JvpiExogjJEkkVML/0y74E
         o4sGk7SOvvHT53H7iyoPjUCxgie//+BiD3SNozSwsExQVQufylbi25iDHzmzYakg+IdV
         1Ttm+TAfpuB4mlGyUkkC+ol2rS2GCTcqrFQlcZ9199FAGgAD8gjrrALo7EYbcatNvBwl
         brG3+4j38HaJG88dsGO1Q4v6iBWPrZkkVhXw0xXW+WswXRIZ78LJEUAKCGnq9uYvAt0b
         nS+fyLV0dTnepFrhR/W51QHl5ZuyBfAsWUrNLvdfnVdQmdJn1JWGYFZBi1SIg/qGQQX7
         XDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HzTSVpbyy+61Yj0es9srcGM5gLbmwFRA6fCyyZe10xo=;
        b=Ygf6n8fJz7S5cw+VuFlMpwmDvtgj3TVacH3AuCv0TZa2jBwJBfFZ3Fn3TQZXrKAnWL
         W81d9WLNgBuGK7U0pAchwhIBk2zWxSQgqb3BkN+xSeUv9xxIU0pCYcv0+2Ham78i/sB2
         WEEt6N17F1Yq8Rwdm0YC3tv1ePJoEm4Xy0syyS+yA3QCbPUGZjvo++Vv9SSXu1li/D/D
         yk2wA9zHsHod+Dd9hh4niPQykDlykUvraGGi8tCe+D5DLbaPPv7g5mdbfyOAHY4jy+MR
         ffxJVwfyhGB0+JqQa3+YjnBEip6u4B8Q8XHPitPKiTvz5QQMk24a0aB3KzCVTm0CjhDg
         EmBA==
X-Gm-Message-State: APjAAAU74nt4dRVHIYwdAvcKkT0rOsX9lbvdbhsktgesb2e879ot+MyS
        Uw48zAA0CxvhDoGsblHUlOL2hNjhaDhgPwt9L5ohaA==
X-Google-Smtp-Source: AHgI3IYEHy3njru0ZiQXMFT9KtKvZZOvQBghwSLugT0cTDATMRJw63EMRy3MT3DnTjp8rSqvXodtXe3T3G+COzFS3Dud+g==
X-Received: by 2002:a24:cd07:: with SMTP id l7mr778172itg.22.1551299233980;
 Wed, 27 Feb 2019 12:27:13 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:26:58 -0800
In-Reply-To: <20190227202658.197113-1-matthewgarrett@google.com>
Message-Id: <20190227202658.197113-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH V5 4/4] efi: Attempt to get the TCG2 event log in the boot stub
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
2.21.0.352.gf09ad66450-goog

