Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EEFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4049A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVizCX7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4049A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbeGZVma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:42:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42457 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeGZVma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:42:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so1298270plo.9;
        Thu, 26 Jul 2018 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=je7aQ3jurf64ONYjmHUGFXlh4NHT2dGPAFCAvnwJ4Hk=;
        b=GVizCX7UxDmf8YvVKMg1IrFDgM2p7tutYzGOvlh0G9U4SDn8KzYvBJBCNLTKErrkct
         CvX9sEes1FREWN9elo9JYt4Ng6g6uk5gkk2K6b5jAFgDBa0a0zYGNxxUcqycHJw9z44K
         f0czKS2BIvtHA8Z3ABxvyCFEtzyNVsm3cKsU8fBtRhMXN6FAMN6vz2rUDFgKXLCEW+5f
         wGVta/Ov3cd6gsjDkVY+LFtIMd/0a56KRTCv/JtI40opZTkc1XOB5aMIOZBlsgi2wV/H
         jPu3HALD72gInzv/yG7/YeB6CBnyrLvdZx4VlLS03HXmb5z5nVov7S6ft9CK1Qa4lsEG
         cPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=je7aQ3jurf64ONYjmHUGFXlh4NHT2dGPAFCAvnwJ4Hk=;
        b=HGGBoA0AnMZzHexVIdVWSC8RnVk6mBsEbrG/z1Nc0tMLIKx+145xa3YMMUbNkxXs38
         oSPPEceAQ7LZw4hCEpFPHPk0gD+MwpmnzMxF6LyGyfTwwq6qdoPBHZndYGj6qEkSluYj
         s2aj7I3IioABhsTEctfnXfb4mqS6Bjnhjyw83a4sIgxFufnZH53GBOAbDsJ0DULkEQUs
         KGzvaJnGEOqC8TGI1qHqtREthQCTrNLpYYobWtjg3pb0RtfbA0xHNBfeenS2F4E//KsX
         yRRWj/A/16yJwlX1PtWLq9m6/9PvXYpo1Qr/LYNfYm1Twf6IrzpZuDz5CI9kM6xxKYgm
         M5Pg==
X-Gm-Message-State: AOUpUlH8iM9qcm9V6z/T3HzecBS9rDPmy319Uro0lcnFzhe816nYFLQw
        DMxeplCK3AeFeTYLZv75ChAC2js2
X-Google-Smtp-Source: AAOMgpc5rWJEGSmJC6oQO5oukSseMDYmltNsOxUSk8QC3+s1FkLouHqLzQGaSGfJwQDoluEmLQEb/A==
X-Received: by 2002:a17:902:6684:: with SMTP id e4-v6mr3279392plk.35.1532636641676;
        Thu, 26 Jul 2018 13:24:01 -0700 (PDT)
Received: from localhost.localdomain ([162.255.34.186])
        by smtp.gmail.com with ESMTPSA id d9-v6sm3777101pfb.86.2018.07.26.13.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 13:24:01 -0700 (PDT)
From:   David Archuleta <darchuletajr@gmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, darchuletajr <darchuletajr@gmail.com>
Subject: [PATCH] acpi: processor_throttling: fixed a few brace coding style issues.
Date:   Thu, 26 Jul 2018 13:23:41 -0700
Message-Id: <20180726202341.9816-1-darchuletajr@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: darchuletajr <darchuletajr@gmail.com>

Fixed a few brace coding style issues found by running
./scripts/checkpatch

Signed-off-by: David Archuleta Jr. <darchuletajr@gmail.com>
---
 drivers/acpi/processor_throttling.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index fbc936cf2025..75cc179b352b 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -298,9 +298,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
-		}
 		return -ENODEV;
 	}
 
@@ -431,9 +430,8 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
-		}
 		return -ENODEV;
 	}
 
@@ -516,9 +514,8 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
-		}
 		return -ENODEV;
 	}
 
@@ -596,9 +593,8 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSD"));
-		}
 		return -ENODEV;
 	}
 
-- 
2.18.0

