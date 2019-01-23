Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9922C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955DE20855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfAWNKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:10:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53702 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfAWNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:10:08 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gmII8-0006ou-Dg; Wed, 23 Jan 2019 13:10:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qlogicfas408: clean up a couple of indentation issues
Date:   Wed, 23 Jan 2019 13:10:04 +0000
Message-Id: <20190123131004.24460-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An if statement is indented correctly and an outb statement has
a redundant empty comment and incorrect indentation. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qlogicfas408.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 8b471a925b43..136681ad18a5 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -139,7 +139,7 @@ static int ql_pdma(struct qlogicfas408_priv *priv, int phase, char *request, int
 	} else {		/* out */
 #if QL_TURBO_PDMA
 		rtrc(4)
-		    if (reqlen >= 128 && inb(qbase + 8) & 0x10) {	/* empty */
+		if (reqlen >= 128 && inb(qbase + 8) & 0x10) {	/* empty */
 			outsl(qbase + 4, request, 32);
 			reqlen -= 128;
 			request += 128;
@@ -240,7 +240,7 @@ static void ql_icmd(struct scsi_cmnd *cmd)
 	outb(0x40 | qlcfg8 | priv->qinitid, qbase + 8);
 	outb(qlcfg7, qbase + 7);
 	outb(qlcfg6, qbase + 6);
-	 /**/ outb(qlcfg5, qbase + 5);	/* select timer */
+	outb(qlcfg5, qbase + 5);	/* select timer */
 	outb(qlcfg9 & 7, qbase + 9);	/* prescaler */
 /*	outb(0x99, qbase + 5);	*/
 	outb(scmd_id(cmd), qbase + 4);
-- 
2.19.1

