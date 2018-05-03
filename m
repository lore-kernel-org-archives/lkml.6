Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeECLOT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:14:19 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:53487 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbeECLOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:14:14 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520870400";
   d="scan'208";a="447812"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="7302707"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        linux-mmc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/10] scsi: ufs-qcom: remove broken hci version quirk
Date: Thu,  3 May 2018 16:37:19 +0530
Message-Id: <c20e9a0036c3f1bd0a255da9dfd092aa0fad238b.1525343531.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1525341340.git.asutoshd@codeaurora.org>
References: <cover.1525341340.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1525343531.git.asutoshd@codeaurora.org>
References: <cover.1525343531.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION is only applicable for QCOM UFS host
controller version 2.x.y and this has been fixed from version 3.x.y
onwards, hence this change removes this quirk for version 3.x.y onwards.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index d9edef8..27be327 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1103,7 +1103,7 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 		hba->quirks |= UFSHCD_QUIRK_BROKEN_LCC;
 	}
 
-	if (host->hw_ver.major >= 0x2) {
+	if (host->hw_ver.major == 0x2) {
 		hba->quirks |= UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION;
 		hba->quirks |= UFSHCD_QUIRK_BROKEN_PWR_MODE_CHANGE;
 		if (!ufs_qcom_cap_qunipro(host))
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
