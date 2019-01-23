Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2488C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F812183F
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfAWMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:53:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53458 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:53:24 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gmI1v-0003Ri-SL; Wed, 23 Jan 2019 12:53:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: dpt_i2o: clean up indentation issues, remove spaces
Date:   Wed, 23 Jan 2019 12:53:19 +0000
Message-Id: <20190123125319.17193-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several lines where the indentation has an extra space,
fix this by removing the spaces.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/dpt_i2o.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 70d1a18278af..f9560a183c12 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -877,8 +877,8 @@ static void adpt_i2o_sys_shutdown(void)
 	adpt_hba *pHba, *pNext;
 	struct adpt_i2o_post_wait_data *p1, *old;
 
-	 printk(KERN_INFO"Shutting down Adaptec I2O controllers.\n");
-	 printk(KERN_INFO"   This could take a few minutes if there are many devices attached\n");
+	printk(KERN_INFO "Shutting down Adaptec I2O controllers.\n");
+	printk(KERN_INFO "   This could take a few minutes if there are many devices attached\n");
 	/* Delete all IOPs from the controller chain */
 	/* They should have already been released by the
 	 * scsi-core
@@ -901,7 +901,7 @@ static void adpt_i2o_sys_shutdown(void)
 //	spin_unlock_irqrestore(&adpt_post_wait_lock, flags);
 	adpt_post_wait_queue = NULL;
 
-	 printk(KERN_INFO "Adaptec I2O controllers down.\n");
+	printk(KERN_INFO "Adaptec I2O controllers down.\n");
 }
 
 static int adpt_install_hba(struct scsi_host_template* sht, struct pci_dev* pDev)
@@ -3427,7 +3427,7 @@ static int adpt_i2o_issue_params(int cmd, adpt_hba* pHba, int tid,
 		return -((res[1] >> 16) & 0xFF); /* -BlockStatus */
 	}
 
-	 return 4 + ((res[1] & 0x0000FFFF) << 2); /* bytes used in resblk */ 
+	return 4 + ((res[1] & 0x0000FFFF) << 2); /* bytes used in resblk */
 }
 
 
@@ -3500,8 +3500,8 @@ static int adpt_i2o_enable_hba(adpt_hba* pHba)
 
 static int adpt_i2o_systab_send(adpt_hba* pHba)
 {
-	 u32 msg[12];
-	 int ret;
+	u32 msg[12];
+	int ret;
 
 	msg[0] = I2O_MESSAGE_SIZE(12) | SGL_OFFSET_6;
 	msg[1] = I2O_CMD_SYS_TAB_SET<<24 | HOST_TID<<12 | ADAPTER_TID;
-- 
2.19.1

