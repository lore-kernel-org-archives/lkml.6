Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CF6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F90123D4E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bKFoBRCl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bKFoBRCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F90123D4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeFZPoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:44:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeFZPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:44:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0DF360274; Tue, 26 Jun 2018 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530027882;
        bh=WJhHrIhiBCo1FX6Y4d2oEz3cJN0v8nMU0bgXcjQRaSY=;
        h=From:To:Cc:Subject:Date:From;
        b=bKFoBRClzhO3BSD9TZpd4OrMqZYHW6a6R4EWyeQaNO7V8sMP1oW9yZgJhMGzXaqj9
         OHZtOME3zmK6CuxPaiFDjF64sgYHctUF616hhCiDaZ6NkfiVVp56Ux5DOIUMzQ0etJ
         l6m6yGLYpEbaDLMr9Y6X3oHmc1Jzx9b9vjUY897s=
Received: from thunderhorn.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tbaicar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8822460117;
        Tue, 26 Jun 2018 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530027882;
        bh=WJhHrIhiBCo1FX6Y4d2oEz3cJN0v8nMU0bgXcjQRaSY=;
        h=From:To:Cc:Subject:Date:From;
        b=bKFoBRClzhO3BSD9TZpd4OrMqZYHW6a6R4EWyeQaNO7V8sMP1oW9yZgJhMGzXaqj9
         OHZtOME3zmK6CuxPaiFDjF64sgYHctUF616hhCiDaZ6NkfiVVp56Ux5DOIUMzQ0etJ
         l6m6yGLYpEbaDLMr9Y6X3oHmc1Jzx9b9vjUY897s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8822460117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
From:   Tyler Baicar <tbaicar@codeaurora.org>
To:     helgaas@kernel.org, bhelgaas@google.com, poza@codeaurora.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH] PCI/AER: Adopt lspci naming convention for AER prints
Date:   Tue, 26 Jun 2018 11:44:15 -0400
Message-Id: <1530027855-19709-1-git-send-email-tbaicar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lspci uses abbreviated naming for AER error strings. Adopt the
same naming convention for the AER printing so they match.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..08a5219 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -459,22 +459,22 @@ int pci_aer_init(struct pci_dev *dev)
 };
 
 static const char *aer_correctable_error_string[] = {
-	"Receiver Error",		/* Bit Position 0	*/
+	"RxErr",			/* Bit Position 0	*/
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
-	"Bad TLP",			/* Bit Position 6	*/
-	"Bad DLLP",			/* Bit Position 7	*/
-	"RELAY_NUM Rollover",		/* Bit Position 8	*/
+	"BadTLP",			/* Bit Position 6	*/
+	"BadDLLP",			/* Bit Position 7	*/
+	"Rollover",			/* Bit Position 8	*/
 	NULL,
 	NULL,
 	NULL,
-	"Replay Timer Timeout",		/* Bit Position 12	*/
-	"Advisory Non-Fatal",		/* Bit Position 13	*/
-	"Corrected Internal Error",	/* Bit Position 14	*/
-	"Header Log Overflow",		/* Bit Position 15	*/
+	"Timeout",			/* Bit Position 12	*/
+	"NonFatalErr",			/* Bit Position 13	*/
+	"CorrIntErr",			/* Bit Position 14	*/
+	"HeaderOF",			/* Bit Position 15	*/
 };
 
 static const char *aer_uncorrectable_error_string[] = {
@@ -482,28 +482,28 @@ int pci_aer_init(struct pci_dev *dev)
 	NULL,
 	NULL,
 	NULL,
-	"Data Link Protocol",		/* Bit Position 4	*/
-	"Surprise Down Error",		/* Bit Position 5	*/
+	"DLP",				/* Bit Position 4	*/
+	"SDES",				/* Bit Position 5	*/
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
-	"Poisoned TLP",			/* Bit Position 12	*/
-	"Flow Control Protocol",	/* Bit Position 13	*/
-	"Completion Timeout",		/* Bit Position 14	*/
-	"Completer Abort",		/* Bit Position 15	*/
-	"Unexpected Completion",	/* Bit Position 16	*/
-	"Receiver Overflow",		/* Bit Position 17	*/
-	"Malformed TLP",		/* Bit Position 18	*/
+	"TLP",				/* Bit Position 12	*/
+	"FCP",				/* Bit Position 13	*/
+	"CmpltTO",			/* Bit Position 14	*/
+	"CmpltAbrt",			/* Bit Position 15	*/
+	"UnxCmplt",			/* Bit Position 16	*/
+	"RxOF",				/* Bit Position 17	*/
+	"MalfTLP",			/* Bit Position 18	*/
 	"ECRC",				/* Bit Position 19	*/
-	"Unsupported Request",		/* Bit Position 20	*/
-	"ACS Violation",		/* Bit Position 21	*/
-	"Uncorrectable Internal Error",	/* Bit Position 22	*/
-	"MC Blocked TLP",		/* Bit Position 23	*/
-	"AtomicOp Egress Blocked",	/* Bit Position 24	*/
-	"TLP Prefix Blocked Error",	/* Bit Position 25	*/
+	"UnsupReq",			/* Bit Position 20	*/
+	"ACSViol",			/* Bit Position 21	*/
+	"UncorrIntErr",			/* Bit Position 22	*/
+	"BlockedTLP",			/* Bit Position 23	*/
+	"AtomicOpBlocked",		/* Bit Position 24	*/
+	"TLPBlockedErr",		/* Bit Position 25	*/
 };
 
 static const char *aer_agent_string[] = {
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

