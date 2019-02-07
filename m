Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A0AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7729421902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBGMqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:46:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfBGMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:46:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1grj2F-0001Nr-PZ; Thu, 07 Feb 2019 12:44:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt fusion: fix indentation issues
Date:   Thu,  7 Feb 2019 12:44:07 +0000
Message-Id: <20190207124407.2365-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several statements and code blocks there are incorrectly
indented. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/message/fusion/mptctl.c   |  2 +-
 drivers/message/fusion/mptsas.c   | 40 +++++++++++++++----------------
 drivers/message/fusion/mptscsih.c |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 8d22d6134a89..0f73f95ba33a 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -565,7 +565,7 @@ mptctl_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *pEvReply)
 	 * TODO - this define is not in MPI spec yet,
 	 * but they plan to set it to 0x21
 	 */
-	 if (event == 0x21 ) {
+	if (event == 0x21) {
 		ioc->aen_event_read_flag=1;
 		dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Raised SIGIO to application\n",
 		    ioc->name));
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 612cb5bc1333..e2de8ea17b95 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -2928,27 +2928,27 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
 	if (ioc->sas_mgmt.status & MPT_MGMT_STATUS_RF_VALID) {
 		u8 *tmp;
 
-	smprep = (SmpPassthroughReply_t *)ioc->sas_mgmt.reply;
-	if (le16_to_cpu(smprep->ResponseDataLength) !=
-		sizeof(struct rep_manu_reply))
-			goto out_free;
-
-	manufacture_reply = data_out + sizeof(struct rep_manu_request);
-	strncpy(edev->vendor_id, manufacture_reply->vendor_id,
-		SAS_EXPANDER_VENDOR_ID_LEN);
-	strncpy(edev->product_id, manufacture_reply->product_id,
-		SAS_EXPANDER_PRODUCT_ID_LEN);
-	strncpy(edev->product_rev, manufacture_reply->product_rev,
-		SAS_EXPANDER_PRODUCT_REV_LEN);
-	edev->level = manufacture_reply->sas_format;
-	if (manufacture_reply->sas_format) {
-		strncpy(edev->component_vendor_id,
-			manufacture_reply->component_vendor_id,
+		smprep = (SmpPassthroughReply_t *)ioc->sas_mgmt.reply;
+		if (le16_to_cpu(smprep->ResponseDataLength) !=
+		    sizeof(struct rep_manu_reply))
+			goto out_free;
+
+		manufacture_reply = data_out + sizeof(struct rep_manu_request);
+		strncpy(edev->vendor_id, manufacture_reply->vendor_id,
+			SAS_EXPANDER_VENDOR_ID_LEN);
+		strncpy(edev->product_id, manufacture_reply->product_id,
+			SAS_EXPANDER_PRODUCT_ID_LEN);
+		strncpy(edev->product_rev, manufacture_reply->product_rev,
+			SAS_EXPANDER_PRODUCT_REV_LEN);
+		edev->level = manufacture_reply->sas_format;
+		if (manufacture_reply->sas_format) {
+			strncpy(edev->component_vendor_id,
+				manufacture_reply->component_vendor_id,
 				SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN);
-		tmp = (u8 *)&manufacture_reply->component_id;
-		edev->component_id = tmp[0] << 8 | tmp[1];
-		edev->component_revision_id =
-			manufacture_reply->component_revision_id;
+			tmp = (u8 *)&manufacture_reply->component_id;
+			edev->component_id = tmp[0] << 8 | tmp[1];
+			edev->component_revision_id =
+				manufacture_reply->component_revision_id;
 		}
 	} else {
 		printk(MYIOC_s_ERR_FMT
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 6ba07c7feb92..587b5daf74b4 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -1934,7 +1934,7 @@ mptscsih_host_reset(struct scsi_cmnd *SCpnt)
 	/*  If our attempts to reset the host failed, then return a failed
 	 *  status.  The host will be taken off line by the SCSI mid-layer.
 	 */
-    retval = mpt_Soft_Hard_ResetHandler(ioc, CAN_SLEEP);
+	retval = mpt_Soft_Hard_ResetHandler(ioc, CAN_SLEEP);
 	if (retval < 0)
 		status = FAILED;
 	else
-- 
2.20.1

