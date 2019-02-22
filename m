Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B83C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80662081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rB/3gxjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBVU0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:26:19 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46824 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBVU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:26:16 -0500
Received: by mail-pg1-f201.google.com with SMTP id f10so2494235pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PIskTotTS30my00PpyuDNjp7J1bfei86ZvMSyGFT+Tk=;
        b=rB/3gxjtk7QInhP1fGU8s+7yNH6+fpF0d5AA0bKpDTTw8lDg0EsawLZWApduXgPYNg
         8Pp6j6FKF6wRBUiPMKzRMczZu9t5SRqDs0T1Z5bo3/ARbTqLGK0waiVl8xMr+1pT+4GK
         ahvQH0BMa6XLYz+5fmSqFHxEGyDIZ8sgviV3I68okHCOSlkUAJxihw6Ce9WsNogzu5Kd
         1NTw+nHvBqWbsHu0YN2DhmC0lU5ReT4DLgrsQpyfYXQKQ49jxjyYhybtMlfQ2wqE20n1
         eQ0VE1cdXUmhXRuJE8i73SWMG+RuWeScAXSDX6CK9xbiZAGY6qVC1B5hoX7pcov4F6n4
         nRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PIskTotTS30my00PpyuDNjp7J1bfei86ZvMSyGFT+Tk=;
        b=YsHHpaYDEtOzSp+P2XJMRwcKGF8g53FkcODodrngQneJHWmSlwVvw4G0lwDoO+PLlC
         k74RqPzD6AaRfizBzLLi6ZtFWbnZZ3JpyuQ9FT6FMtaDFm1BsAKZPxxpgvQCo8wfqFy5
         vWbOOePC0U4xuruQIiZiTbecn4j9lEJJcQ3IXWrH9wSqN3hDezb8fABETxf/gdHZpOql
         CVxJHcFSfqRroqOEDKJpGrIpPetaHUcca4O2cpCdeQegQhY+mCEEPqWfctwZEw+Kifxh
         WbWZLGV7E/CkXMDaZ7syybgj5mpbeJmIwD9Wgxz0tJNQkjf+Lb3tpyy3NS4c/IiQy83i
         dMSA==
X-Gm-Message-State: AHQUAuaxxfzMh/4wyLhC5i99nGAG6vZVxLwhFQdznEKrGdCQ9bzNVc3z
        jocPMWvWuReam5xrs8A337E03InpCBVe/vFgWlGkjA==
X-Google-Smtp-Source: AHgI3IbrUQQy7H+Rwm147t40V6tiYOdDt8xad6imXP9blhPLdeTT8QyWUi2atbMieXcz40bMPiRoSjJNMxNHsA0Vw4GD9Q==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9mr1867783plz.70.1550867174986;
 Fri, 22 Feb 2019 12:26:14 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:26:03 -0800
In-Reply-To: <20190222202606.160816-1-matthewgarrett@google.com>
Message-Id: <20190222202606.160816-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190222202606.160816-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH V4 1/4] tpm: Abstract crypto agile event size calculations
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

We need to calculate the size of crypto agile events in multiple
locations, including in the EFI boot stub. The easiest way to do this is
to put it in a header file as an inline and leave a wrapper to ensure we
don't end up with multiple copies of it embedded in the existing code.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 47 +---------------------
 include/linux/tpm_eventlog.h     | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index d8b77133a83a..dc12e1cbd03a 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,52 +40,7 @@
 static int calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				struct tcg_pcr_event *event_header)
 {
-	struct tcg_efi_specid_event_head *efispecid;
-	struct tcg_event_field *event_field;
-	void *marker;
-	void *marker_start;
-	u32 halg_size;
-	size_t size;
-	u16 halg;
-	int i;
-	int j;
-
-	marker = event;
-	marker_start = marker;
-	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
-		+ sizeof(event->count);
-
-	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
-
-	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs)
-		return 0;
-
-	for (i = 0; i < event->count; i++) {
-		halg_size = sizeof(event->digests[i].alg_id);
-		memcpy(&halg, marker, halg_size);
-		marker = marker + halg_size;
-		for (j = 0; j < efispecid->num_algs; j++) {
-			if (halg == efispecid->digest_sizes[j].alg_id) {
-				marker +=
-					efispecid->digest_sizes[j].digest_size;
-				break;
-			}
-		}
-		/* Algorithm without known length. Such event is unparseable. */
-		if (j == efispecid->num_algs)
-			return 0;
-	}
-
-	event_field = (struct tcg_event_field *)marker;
-	marker = marker + sizeof(event_field->event_size)
-		+ event_field->event_size;
-	size = marker - marker_start;
-
-	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
-
-	return size;
+	return __calc_tpm2_event_size(event, event_header);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index f47342361e87..09c19d506b69 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -117,4 +117,72 @@ struct tcg_pcr_event2_head {
 	struct tpm2_digest digests[];
 } __packed;
 
+/**
+ * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
+ * @event:        Pointer to the event whose size should be calculated
+ * @event_header: Pointer to the initial event containing the digest lengths
+ *
+ * The TPM2 event log format can contain multiple digests corresponding to
+ * separate PCR banks, and also contains a variable length of the data that
+ * was measured. This requires knowledge of how long each digest type is,
+ * and this information is contained within the first event in the log.
+ *
+ * We calculate the length by examining the number of events, and then looking
+ * at each event in turn to determine how much space is used for events in
+ * total. Once we've done this we know the offset of the data length field,
+ * and can calculate the total size of the event.
+ *
+ * Return: size of the event on success, <0 on failure
+ */
+
+static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+					 struct tcg_pcr_event *event_header)
+{
+	struct tcg_efi_specid_event_head *efispecid;
+	struct tcg_event_field *event_field;
+	void *marker;
+	void *marker_start;
+	u32 halg_size;
+	size_t size;
+	u16 halg;
+	int i;
+	int j;
+
+	marker = event;
+	marker_start = marker;
+	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
+		+ sizeof(event->count);
+
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
+
+	/* Check if event is malformed. */
+	if (event->count > efispecid->num_algs)
+		return 0;
+
+	for (i = 0; i < event->count; i++) {
+		halg_size = sizeof(event->digests[i].alg_id);
+		memcpy(&halg, marker, halg_size);
+		marker = marker + halg_size;
+		for (j = 0; j < efispecid->num_algs; j++) {
+			if (halg == efispecid->digest_sizes[j].alg_id) {
+				marker +=
+					efispecid->digest_sizes[j].digest_size;
+				break;
+			}
+		}
+		/* Algorithm without known length. Such event is unparseable. */
+		if (j == efispecid->num_algs)
+			return 0;
+	}
+
+	event_field = (struct tcg_event_field *)marker;
+	marker = marker + sizeof(event_field->event_size)
+		+ event_field->event_size;
+	size = marker - marker_start;
+
+	if ((event->event_type == 0) && (event_field->event_size == 0))
+		return 0;
+
+	return size;
+}
 #endif
-- 
2.21.0.rc0.258.g878e2cd30e-goog

