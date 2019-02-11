Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB13C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24727218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="g0WkK0wA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfBKQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:00:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43887 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfBKObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id j1so7884849lfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdCd+eahJl+Jgx83sGQrXrCpsjO9ENXDoI/VLqO8N5s=;
        b=g0WkK0wADX8usdHfa0VcNaX+oFsXFAHJ7hqtjYsXRj13tO75890Yt7ke+hAf3zNhO4
         qvpNKp8vZzVbGiWc6pNTDqZFddInSVwpzCPBjWZnRMKFwHfzQNDEEOFR5lCVyaY1Rk20
         XB/9OiEbnok9nElviucOobsJrWqxiDRl2ylaMkTL26Qb6GSmrGjrlTgjj450XtF29Vi3
         kbXv9UKnZrqWAU8bTnzoheeEJ/cjRj7UHK/5V7qBxH5yeEi1u6We0QjZGBWASReXZmEs
         0bN8HQxhah2hDaYTbFRLmV8LZNBVHAhRC+wIA9QS67dlmCAjymW+8v83YyRPhhsluckM
         ojdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdCd+eahJl+Jgx83sGQrXrCpsjO9ENXDoI/VLqO8N5s=;
        b=IPrFLIxYkXJt3iGRND8rBXzuUQF7D+wppomxi9EvWfWPXI06gbYUFQVVDapuZbKTXM
         9jQRxYDzM5IftdLSTzbSRSj0R89RjHo8tihxUiNe20av9FnihnwspalyDB6UvgLbtPDT
         WFQSNEDP9qauAF9ddGammlSNbEIsHIqpUN4uH7/gli+1+rxanWzgLUnMu6EBDw+B84F2
         tlCD11XdIfXUCTIMEGj2d1NkQyCy9ZhkVYtkrV5KISaa67BEQx6UyiFlMfkAyaVfHYdd
         egDfUO2GkW644swDPTV6TgiWAtmpHLpGT+UQtrO5MSKmfpXDFzj8CUslN3oSGD7TJfPZ
         6nRA==
X-Gm-Message-State: AHQUAuYPgFItSZGatFC5FDUckI5zTJnYApBGGfnmFCalbKNW808BDeV6
        u4Wha1h/eNOQhwsvqU6f1E6BIg==
X-Google-Smtp-Source: AHgI3Ia/bzbAdHoVwbD8MW7fu5H495FVNVCwC6MPyee5idQwV9PqSGypBxhNikglHZ/R6FsZ8RUsuw==
X-Received: by 2002:ac2:43b7:: with SMTP id t23mr1696969lfl.50.1549895491490;
        Mon, 11 Feb 2019 06:31:31 -0800 (PST)
Received: from bsz-kubuntu.semihalf.local (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id z6sm2322373lfa.87.2019.02.11.06.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:31:31 -0800 (PST)
From:   bsz@semihalf.com
To:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, ard.biesheuvel@linaro.org
Cc:     tweek@google.com, mingo@kernel.org, hdegoede@redhat.com,
        leif.lindholm@linaro.org, mw@semihalf.com,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH 2/5] tpm: Change calc_tpm2_event_size signature
Date:   Mon, 11 Feb 2019 15:30:49 +0100
Message-Id: <20190211143052.3128-3-bsz@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211143052.3128-1-bsz@semihalf.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Szczepanek <bsz@semihalf.com>

Pass tcg_efi_specid_event as an argument instead of tcg_pcr_event, as the
former is what is actually needed to compute event size. tcg_pcr_event
structure describes TPM event log header (even though its name), from where
efispecid can be extracted -- it seems cleaner and less misleading to do it
out of calc_tpm2_event_size function.

Also, use ssize_t instead of int for event log size.

Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
---
 lib/tpm.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/tpm.c b/lib/tpm.c
index aaeeafe52426..263ccfdaefa5 100644
--- a/lib/tpm.c
+++ b/lib/tpm.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/tpm_eventlog.h>
+#include <linux/errno.h>
 
 /*
  * calc_tpm2_event_size() - calculate the event size, where event
@@ -23,19 +24,18 @@
  * Family "2.0".
 
  * @event: event whose size is to be calculated.
- * @event_header: the first event in the event log.
+ * @efispecid: pointer to structure describing algorithms used.
  *
- * Returns size of the event. If it is an invalid event, returns 0.
+ * Returns size of the event. If it is an invalid event, returns -EINVAL.
  */
-int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
-			 struct tcg_pcr_event *event_header)
+ssize_t calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+			     struct tcg_efi_specid_event *efispecid)
 {
-	struct tcg_efi_specid_event *efispecid;
 	struct tcg_event_field *event_field;
 	void *marker;
 	void *marker_start;
 	u32 halg_size;
-	size_t size;
+	ssize_t size;
 	u16 halg;
 	int i;
 	int j;
@@ -45,11 +45,9 @@ int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
 	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
 		+ sizeof(event->count);
 
-	efispecid = (struct tcg_efi_specid_event *)event_header->event;
-
 	/* Check if event is malformed. */
 	if (event->count > efispecid->num_algs)
-		return 0;
+		return -EINVAL;
 
 	for (i = 0; i < event->count; i++) {
 		halg_size = sizeof(event->digests[i].alg_id);
@@ -64,7 +62,7 @@ int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
 		}
 		/* Algorithm without known length. Such event is unparseable. */
 		if (j == efispecid->num_algs)
-			return 0;
+			return -EINVAL;
 	}
 
 	event_field = (struct tcg_event_field *)marker;
@@ -73,7 +71,7 @@ int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
 	size = marker - marker_start;
 
 	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
+		return -EINVAL;
 
 	return size;
 }
-- 
2.14.4

