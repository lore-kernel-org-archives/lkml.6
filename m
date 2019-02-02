Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E07220870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfBBKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:40:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfBBKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:40:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gpsjE-00067U-QG; Sat, 02 Feb 2019 10:40:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aacraid: clean up some indentation and formatting issues
Date:   Sat,  2 Feb 2019 10:40:52 +0000
Message-Id: <20190202104052.16552-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several issues with badly indented statements. Fix these
and clean up the formatting.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/aacraid/commsup.c | 25 +++++++++++++------------
 drivers/scsi/aacraid/linit.c   |  3 +--
 drivers/scsi/aacraid/src.c     |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index d5a6aa9676c8..0bdc6b0f725f 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1376,18 +1376,19 @@ static void aac_handle_aif(struct aac_dev * dev, struct fib * fibptr)
 
 	container = 0;
 retry_next:
-	if (device_config_needed == NOTHING)
-	for (; container < dev->maximum_num_containers; ++container) {
-		if ((dev->fsa_dev[container].config_waiting_on == 0) &&
-			(dev->fsa_dev[container].config_needed != NOTHING) &&
-			time_before(jiffies, dev->fsa_dev[container].config_waiting_stamp + AIF_SNIFF_TIMEOUT)) {
-			device_config_needed =
-				dev->fsa_dev[container].config_needed;
-			dev->fsa_dev[container].config_needed = NOTHING;
-			channel = CONTAINER_TO_CHANNEL(container);
-			id = CONTAINER_TO_ID(container);
-			lun = CONTAINER_TO_LUN(container);
-			break;
+	if (device_config_needed == NOTHING) {
+		for (; container < dev->maximum_num_containers; ++container) {
+			if ((dev->fsa_dev[container].config_waiting_on == 0) &&
+			    (dev->fsa_dev[container].config_needed != NOTHING) &&
+			    time_before(jiffies, dev->fsa_dev[container].config_waiting_stamp + AIF_SNIFF_TIMEOUT)) {
+				device_config_needed =
+					dev->fsa_dev[container].config_needed;
+				dev->fsa_dev[container].config_needed = NOTHING;
+				channel = CONTAINER_TO_CHANNEL(container);
+				id = CONTAINER_TO_ID(container);
+				lun = CONTAINER_TO_LUN(container);
+				break;
+			}
 		}
 	}
 	if (device_config_needed == NOTHING)
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 7e56a11836c1..e977b459f823 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -852,8 +852,7 @@ static u8 aac_eh_tmf_hard_reset_fib(struct aac_hba_map_info *info,
 
 	address = (u64)fib->hw_error_pa;
 	rst->error_ptr_hi = cpu_to_le32((u32)(address >> 32));
-	rst->error_ptr_lo = cpu_to_le32
-		((u32)(address & 0xffffffff));
+	rst->error_ptr_lo = cpu_to_le32((u32)(address & 0xffffffff));
 	rst->error_length = cpu_to_le32(FW_ERROR_BUFFER_SIZE);
 	fib->hbacmd_size = sizeof(*rst);
 
diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 8377aec0649d..97bb9e9d201c 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -1157,7 +1157,7 @@ static int aac_src_soft_reset(struct aac_dev *dev)
 		dev_err(&dev->pdev->dev, "%s: %s status = %d", __func__,
 			state_str[state], rc);
 
-return rc;
+	return rc;
 }
 /**
  *  aac_srcv_init	-	initialize an SRCv card
-- 
2.20.1

