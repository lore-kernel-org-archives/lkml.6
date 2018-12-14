Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81CFC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E61920575
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBj2mcjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E61920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeLNNWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44404 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeLNNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so4215642lfe.11;
        Fri, 14 Dec 2018 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzFgi5+J5E6OjV+Ybi94fjxP/tFRW4r6bP5KzmD5Ac8=;
        b=IBj2mcjx9aUNyc+PMNouYqv9iwdGYiFeCKXdlBXhoeIBuJmsxo2NLD0sGAtlDwaXCe
         WuugHhq0d6bSDLsTfuRQHS3Pu3+sxyVLJ9eZqvhTUieaRnTIKxwdf86w8x5pNgMLK9Ss
         JwCo2zDIZpbFRs//XOlFFMAQylJjvG/uJPM0Z8LvzPK/W3qGFeLtlRbgK1s4NDElgbds
         mb12OXv/ZQlKMKMT2cP6iDI2uFuvzOoUjTkBlEoMFEVI61fPOOkgya3Jg8GRX45VC76S
         OF0YOTi4ShjgFUFcy8lVtlNVcUs27UjOHyR5yJJNZTHNd81igSfqqOeEuWIwMRh6HGFl
         ZRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzFgi5+J5E6OjV+Ybi94fjxP/tFRW4r6bP5KzmD5Ac8=;
        b=Sk7pJ3pKhNIskwICuUnYOMNerIV6CwWZ7od8VdY/BCFHWX+q6/2In8PIdt2ay3qGJA
         DlIQHJYdWk0l0xYlrNu6JND/xqYRylefLEuGkCWljiXNa96ZS6LW+jP1Z48+k+aVHJW6
         qPbswRlNbc/e09oE+hL1DhGNkBuBm9frlh9oW3p6o2JhJp6N6PRJdE3ANMqnctcZYSRr
         QJyv2wfIAbn+mcGyOhkRXQyFaSQfv7PpqwGC3EPz84ayfr1ZrVEjc3lqJIVfsyyhHAVH
         Y6CbAoV4BuLy7P9F1VNjrH+NrvKPo0GjVMZ9Z72GWVuCFXE57uEMEs2y/eCEHEO+9J7f
         cUrw==
X-Gm-Message-State: AA+aEWZndPxuFizGNaytgn6orScWIhHaNaCMQ3JD3QFtGejMGIH0C8F1
        i4aVlv4AWC4UIL07L1qPB8+YzFLY2AXjcN7S
X-Google-Smtp-Source: AFSGD/XCCXRtpY7zOMDQrieTvUH4J5yzPT4H04HMjV/2E+Ds67G0GsBvfpNg1p8hKjmFQTrX4ztlRw==
X-Received: by 2002:a19:f510:: with SMTP id j16mr1710706lfb.35.1544793750436;
        Fri, 14 Dec 2018 05:22:30 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:29 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 6/6] scsi: hpsa: Do not use HBA flag from NVRAM if HBA is not supported
Date:   Fri, 14 Dec 2018 18:21:15 +0500
Message-Id: <20181214132115.21440-7-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check bmic_identify_controller.yet_more_controller_flags for HBA support
bit before trying to enable HBA mode.

HP's ssacli tool calls this bit "Hba Mode Supported" in full diagnostics
report.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/hpsa.c     | 16 ++++++++++++++--
 drivers/scsi/hpsa_cmd.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 0b5b3a651b70..38026b82ac6b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4342,6 +4342,12 @@ static bool hpsa_skip_device(struct ctlr_info *h, u8 *lunaddrbytes,
 	return false;
 }
 
+static bool is_hba_supported(const struct bmic_identify_controller *id_ctlr)
+{
+	return le32_to_cpu(id_ctlr->yet_more_controller_flags) &
+			YET_MORE_CTLR_FLAG_HBA_MODE_SUPP;
+}
+
 static int hpsa_nvram_hba_flag_enabled(struct ctlr_info *h, bool *flag_enabled)
 {
 	int rc;
@@ -4364,7 +4370,8 @@ static int hpsa_nvram_hba_flag_enabled(struct ctlr_info *h, bool *flag_enabled)
 	return rc;
 }
 
-static int hpsa_update_nvram_hba_mode(struct ctlr_info *h, u32 nlogicals)
+static int hpsa_update_nvram_hba_mode(struct ctlr_info *h, u32 nlogicals,
+	const struct bmic_identify_controller *id_ctlr)
 {
 	int rc;
 	bool flag_enabled;
@@ -4373,6 +4380,11 @@ static int hpsa_update_nvram_hba_mode(struct ctlr_info *h, u32 nlogicals)
 	if (!hpsa_use_nvram_hba_flag)
 		return 0;
 
+	if (!is_hba_supported(id_ctlr)) {
+		dev_info(&h->pdev->dev, "NVRAM HBA flag: not supported\n");
+		return 0;
+	}
+
 	rc = hpsa_nvram_hba_flag_enabled(h, &flag_enabled);
 	if (rc == -ENOMEM)
 		dev_warn(&h->pdev->dev, "Out of memory.\n");
@@ -4446,7 +4458,7 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 			__func__);
 	}
 
-	if (hpsa_update_nvram_hba_mode(h, nlogicals)) {
+	if (hpsa_update_nvram_hba_mode(h, nlogicals, id_ctlr)) {
 		h->drv_req_rescan = 1;
 		goto out;
 	}
diff --git a/drivers/scsi/hpsa_cmd.h b/drivers/scsi/hpsa_cmd.h
index 64100a33f844..b27f94b257bc 100644
--- a/drivers/scsi/hpsa_cmd.h
+++ b/drivers/scsi/hpsa_cmd.h
@@ -806,6 +806,10 @@ struct bmic_identify_controller {
 };
 
 
+/* ssacli calls this bit "Hba Mode Supported". */
+#define YET_MORE_CTLR_FLAG_HBA_MODE_SUPP (1 << 25)
+
+
 struct bmic_identify_physical_device {
 	u8    scsi_bus;          /* SCSI Bus number on controller */
 	u8    scsi_id;           /* SCSI ID on this bus */
-- 
2.19.2

