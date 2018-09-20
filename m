Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87262ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CBB21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV87+OT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CBB21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeIUClD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:41:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37767 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:41:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so10745410wrr.4;
        Thu, 20 Sep 2018 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nMmWAq+YeA8+MPfqRaG5j5PHRxPCbSFTBDt5WMxM88=;
        b=jV87+OT3zPErB1xMrU7oozev+/ETJELFi1NfsvvCRb8onlN2bP88KqLJDZ2NnRIKHo
         csjeOqKX/tBFNGFS4JGkv/JCRNTKr5GJS1zKzZmLLH+H1QtXK4RjqeONTC2Nn9RgGVql
         DoyKyhKb4dU7ObDkV323On3NHsYZiJgYBTI/47drF5M5fflJaMfDAr7PYxb7PkC7Vm1G
         9Bgbh0U3Rtj7C1/F9tA75yOkOdM48uMKPT6ddgN9R38HxpQwOJwvgpZlCM7NY2srJMCe
         7i9jPLHVbrTEFC4SDj8AmjA0R9npEOxtKxvm9/nq0CaEvTa/87qpzRJbxXs8a6De3kHn
         yD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nMmWAq+YeA8+MPfqRaG5j5PHRxPCbSFTBDt5WMxM88=;
        b=K4wH4ihqA2jSCtikJRXfsUEMvLIwuxmrb6YvCrix5cLDe/KYvfwVay+7+Tww6FF21Z
         WL6UEItDBVdVjCCu3AHb6VFyLllHDV3Zr0b/06x1W1CMLxmImw5OklufcWb5gTHGilYz
         ZP02OOPmQKqLo4OFGS+GpY4ci1p+4ISwEa9ozAaVGU916ESi8sL5tuXvfC8GJIVaIjSj
         FjrjIiW0Tmz0S9jiDoPjoQhDFcjrzqjS0kETElMgXHfs7wlB2OkEpdqIrg6l+gExy1l+
         6ZwSVtqKEFuSPrVPbPo7A6OURcZ+vTb7oKOnOszPu0CGbEkPS4UFpP8hhCImcGzKnfPq
         9wug==
X-Gm-Message-State: APzg51CgR1vznTllI8kHQKZa53cpIIiwzP7KT3UQZeXrcNVIP1AVDMMB
        xu2nPak8jV1QXnHzaAtj4dI=
X-Google-Smtp-Source: ANB0Vdbvz0KHtv/DIPT6kRzHhEKSnUsiSsYKS2qG+WWeKYnpL4sWIbsbcHKWiQg4vXRRu7ZkyF/fFQ==
X-Received: by 2002:adf:fc44:: with SMTP id e4-v6mr8730530wrs.9.1537476939125;
        Thu, 20 Sep 2018 13:55:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r1-v6sm3504389wmg.9.2018.09.20.13.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:55:38 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: arcmsr: Remove unnecessary parentheses
Date:   Thu, 20 Sep 2018 13:55:23 -0700
Message-Id: <20180920205523.4705-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/scsi/arcmsr/arcmsr_hba.c:4138:19: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        if ((acb->dev_id == 0x1680)) {
             ~~~~~~~~~~~~^~~~~~~~~
drivers/scsi/arcmsr/arcmsr_hba.c:4138:19: note: remove extraneous
parentheses around the comparison to silence this warning
        if ((acb->dev_id == 0x1680)) {
            ~            ^        ~
drivers/scsi/arcmsr/arcmsr_hba.c:4138:19: note: use '=' to turn this
equality comparison into an assignment
        if ((acb->dev_id == 0x1680)) {
                         ^~
                         =
drivers/scsi/arcmsr/arcmsr_hba.c:4140:26: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        } else if ((acb->dev_id == 0x1880)) {
                    ~~~~~~~~~~~~^~~~~~~~~
drivers/scsi/arcmsr/arcmsr_hba.c:4140:26: note: remove extraneous
parentheses around the comparison to silence this warning
        } else if ((acb->dev_id == 0x1880)) {
                   ~            ^        ~
drivers/scsi/arcmsr/arcmsr_hba.c:4140:26: note: use '=' to turn this
equality comparison into an assignment
        } else if ((acb->dev_id == 0x1880)) {
                                ^~
                                =
drivers/scsi/arcmsr/arcmsr_hba.c:4164:26: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        } else if ((acb->dev_id == 0x1214)) {
                    ~~~~~~~~~~~~^~~~~~~~~
drivers/scsi/arcmsr/arcmsr_hba.c:4164:26: note: remove extraneous
parentheses around the comparison to silence this warning
        } else if ((acb->dev_id == 0x1214)) {
                   ~            ^        ~
drivers/scsi/arcmsr/arcmsr_hba.c:4164:26: note: use '=' to turn this
equality comparison into an assignment
        } else if ((acb->dev_id == 0x1214)) {
                                ^~
                                =
3 warnings generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/146
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index cc0be4651128..22cf697adab0 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -4135,9 +4135,9 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 		pci_read_config_byte(acb->pdev, i, &value[i]);
 	}
 	/* hardware reset signal */
-	if ((acb->dev_id == 0x1680)) {
+	if (acb->dev_id == 0x1680) {
 		writel(ARCMSR_ARC1680_BUS_RESET, &pmuA->reserved1[0]);
-	} else if ((acb->dev_id == 0x1880)) {
+	} else if (acb->dev_id == 0x1880) {
 		do {
 			count++;
 			writel(0xF, &pmuC->write_sequence);
@@ -4161,7 +4161,7 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 		} while (((readl(&pmuE->host_diagnostic_3xxx) &
 			ARCMSR_ARC1884_DiagWrite_ENABLE) == 0) && (count < 5));
 		writel(ARCMSR_ARC188X_RESET_ADAPTER, &pmuE->host_diagnostic_3xxx);
-	} else if ((acb->dev_id == 0x1214)) {
+	} else if (acb->dev_id == 0x1214) {
 		writel(0x20, pmuD->reset_request);
 	} else {
 		pci_write_config_byte(acb->pdev, 0x84, 0x20);
-- 
2.19.0

