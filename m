Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B48C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1575F21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="v2ksebaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfBKQBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:01:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39386 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfBKOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id v12-v6so4212197ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AI0vxFWLuRgnzWT6ylhQhD0AdrQinrJeHY3w7Uhh0g8=;
        b=v2ksebaY4Ez01MrEKe6v7Ktauk/pBeXlPkS/WEEjGiEuuyVqjEhrsebEPUp/cy3/EB
         e7gMkTC9Df0iGfKUWHq7S4Br3Q/hWaRaMCWaC7kruVyrPzL6o+RvDsogOk1/4HFS/hsn
         YOtZgNvjDi1Lq0eKe9UwTEKbuoPB9V6EpQpBmAzhni7kOGifauuOTtGipb95GlP3eKD9
         VL0d+KYCWP2FioU+0HTpRmu+7ao4H/JAwtxSdYtocJ9XrRyOH1UtuQOYa8uC5QUepFVj
         5gZvG6dvlKhsJWpuul7dGLENK8xSy2JjGe0F+xoVwA0cVR/taP56iUxwwrcfIUvwFtnM
         DvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AI0vxFWLuRgnzWT6ylhQhD0AdrQinrJeHY3w7Uhh0g8=;
        b=pIcK1+pJpBsGRO6Gu48fBWRqMy4pEOuL4QpF0r/Ll22D4QKmfQw+bWTfgnSrP32KsG
         ftHBrUcRHvsHV1J4jxfefctcFAmgwcLEdeiP652tflN75w+2FUvde+9okjhPYs4vsuVe
         Ue/Mq+yX7/DwfQXtkx2waFnJTSLv2M8Z5NO8wgVkgBmkq40hHdpZIca7nsxdmOh3Po6L
         pzUFciyDsBh/Aagk3pctlt5Qvi1pvdhBO4pSoxLlroFJttAP9I4Bb25LOYpd4Jn0cXdE
         mencc6Q8FErRRqFyMXgKRzrZZA+4Vsv6blI2SgE6dqQtGPWpygVFMeYhw85ss1ZXq0IW
         +mvQ==
X-Gm-Message-State: AHQUAuZfPaHIP/vzwi1yj95AkaDAn9diDk70cgAlEvYBtsVS3ePvDWRt
        p6yERH9mx2T4xKhtzy7UQsyc+w==
X-Google-Smtp-Source: AHgI3IbqX799aYtadJ9H5rJ43BT7V/No+WEWTRtHyQaGle1ozhHIWCdnMmsH0XJCoRNlAMab1Q9ACQ==
X-Received: by 2002:a2e:874b:: with SMTP id q11-v6mr1980029ljj.97.1549895485732;
        Mon, 11 Feb 2019 06:31:25 -0800 (PST)
Received: from bsz-kubuntu.semihalf.local (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id z6sm2322373lfa.87.2019.02.11.06.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:31:25 -0800 (PST)
From:   bsz@semihalf.com
To:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, ard.biesheuvel@linaro.org
Cc:     tweek@google.com, mingo@kernel.org, hdegoede@redhat.com,
        leif.lindholm@linaro.org, mw@semihalf.com,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH 1/5] tpm: Copy calc_tpm2_event_size() to TPM library
Date:   Mon, 11 Feb 2019 15:30:48 +0100
Message-Id: <20190211143052.3128-2-bsz@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211143052.3128-1-bsz@semihalf.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Szczepanek <bsz@semihalf.com>

Function to calculate event size in TPM 2.0 log will also be needed in EFI
stub. Separate it to library to make it accessible out of TPM character
driver.

It will be removed from tpm2.c in subsequent commit.

Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
---
 lib/tpm.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 lib/tpm.c

diff --git a/lib/tpm.c b/lib/tpm.c
new file mode 100644
index 000000000000..aaeeafe52426
--- /dev/null
+++ b/lib/tpm.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Parts of this file based on earlier work by:
+ *      Nayna Jain <nayna@linux.vnet.ibm.com>
+ *      Petr Vandrovec <petr@vmware.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/string.h>
+#include <linux/tpm_eventlog.h>
+
+/*
+ * calc_tpm2_event_size() - calculate the event size, where event
+ * is an entry in the TPM 2.0 event log. The event is of type Crypto
+ * Agile Log Entry Format as defined in TCG EFI Protocol Specification
+ * Family "2.0".
+
+ * @event: event whose size is to be calculated.
+ * @event_header: the first event in the event log.
+ *
+ * Returns size of the event. If it is an invalid event, returns 0.
+ */
+int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+			 struct tcg_pcr_event *event_header)
+{
+	struct tcg_efi_specid_event *efispecid;
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
+	efispecid = (struct tcg_efi_specid_event *)event_header->event;
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
+EXPORT_SYMBOL(calc_tpm2_event_size);
-- 
2.14.4

