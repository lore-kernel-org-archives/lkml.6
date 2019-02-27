Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD263C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7032B213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr+4Z61H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfB0U1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:27:09 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36169 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfB0U1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:27:06 -0500
Received: by mail-pf1-f202.google.com with SMTP id w16so14148182pfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jrd68x/FfHXCt7CWtZJCh8NI2YSDkYhEoPHIj9aDd98=;
        b=Mr+4Z61H4ihzxA34NS2wOMwksF4TBqoI5xQEP3vt/c9ak352gyuXdgBhX3eTgAZgEi
         LtDnaLQZ+o0xtLsn7yeYUSGlYcsjOA8NmRfeEZiqmnr64eDpKkmm+cTGCxZuvUdJOkJa
         mTZ+GczaudDIuNrq0SlU9uwBmIubvXSOpgoHU5vx+ITprhq9EkieilaV3We3ID21//d/
         1EeBA28sRf03O4oGVKmQIJX9WGBk19mcSqCZFgDcv4RZLDnjcWorDnSzAs1rJyxoIE+d
         FIok+G2VB41l3Wrl9TDwwchEUfl9SO1lFDQXzsHzLwk9F6QUkNjGJUocIW469A3jojsR
         ljog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jrd68x/FfHXCt7CWtZJCh8NI2YSDkYhEoPHIj9aDd98=;
        b=ILppfCv6wkxqWikfJ/Bd9D3BwBjabCdVnpsbifrOBCMNywoGG6iM3JnM4py/KbDAx8
         D1cn6kLWRh5kheam/hwVVVdPWTJ11kQ7IV+9TWUDS7z+Nd6j6Wiu26tZlZl9B6ssy9ex
         K3bpeJ8WV1DqIyI4he4+tV7fMLdqMRgoS4MT0QEpaYR70LmF8adsdYIpSTgV13+EGw7s
         U6bC9S7HAPNqtlcLCGa18h0fw/wfTCa9+90w8+ZwJwclYd6NGeTU6zSgaZY/zw0qDey+
         bjY97ynzFV3Yi92aVv9zBe/4ISNOjmLirzLsYnyLm22GPKL8UIjuBy6u/fYiCoxYUs9f
         wiXw==
X-Gm-Message-State: AHQUAuY3uE4rqgAC62+wEPWei/F3b/VbrvODV/7a4BsM36SfKwc4vi0I
        U0c8rtg30AEQ70it4ny/1zsFjXEMRf55SZuF9Meaqg==
X-Google-Smtp-Source: AHgI3IZgRw3yl6qrdUSq8bs/1lWfV5Ug2/XKiOGV829PVXdXG1iGG/yH0d2eMrA/FwlVVnkUA+8RsIZPCKCwrNQJb4tZXQ==
X-Received: by 2002:a17:902:8ec4:: with SMTP id x4mr1289915plo.124.1551299225370;
 Wed, 27 Feb 2019 12:27:05 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:26:55 -0800
In-Reply-To: <20190227202658.197113-1-matthewgarrett@google.com>
Message-Id: <20190227202658.197113-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH V5 1/4] tpm: Abstract crypto agile event size calculations
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
index f824563fc28d..1a977bdd3bd2 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,52 +40,7 @@
 static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
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
index 81519f163211..6a86144e13f1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,4 +112,72 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
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
2.21.0.352.gf09ad66450-goog

