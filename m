Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CEEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D620879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbfAVPKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:10:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfAVPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:10:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1glxh8-0001jw-Qk; Tue, 22 Jan 2019 15:10:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: atp870u: clean up code style and indentation issues
Date:   Tue, 22 Jan 2019 15:10:30 +0000
Message-Id: <20190122151030.7007-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Clean up { brace to fix cppcheck warning. Remove some trailing spaces
at end of a statement.  Also clean up an indentation issue.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/atp870u.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index 1267200380f8..446a789cdaf5 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -194,12 +194,11 @@ static irqreturn_t atp870u_intr_handle(int irq, void *dev_id)
 				((unsigned char *) &adrcnt)[2] = atp_readb_io(dev, c, 0x12);
 				((unsigned char *) &adrcnt)[1] = atp_readb_io(dev, c, 0x13);
 				((unsigned char *) &adrcnt)[0] = atp_readb_io(dev, c, 0x14);
-				if (dev->id[c][target_id].last_len != adrcnt)
-				{
-			   		k = dev->id[c][target_id].last_len;
+				if (dev->id[c][target_id].last_len != adrcnt) {
+					k = dev->id[c][target_id].last_len;
 			   		k -= adrcnt;
 			   		dev->id[c][target_id].tran_len = k;			   
-			   	dev->id[c][target_id].last_len = adrcnt;			   
+					dev->id[c][target_id].last_len = adrcnt;
 				}
 #ifdef ED_DBGP
 				printk("dev->id[c][target_id].last_len = %d dev->id[c][target_id].tran_len = %d\n",dev->id[c][target_id].last_len,dev->id[c][target_id].tran_len);
-- 
2.19.1

