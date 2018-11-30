Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0790DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE2420863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE2420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeK3TOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:14:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726459AbeK3TOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:14:10 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08ABADD8B868F;
        Fri, 30 Nov 2018 16:05:41 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 16:05:38 +0800
From:   liujian <liujian56@huawei.com>
To:     <qla2xxx-upstream@qlogic.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <vinholikatti@gmail.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] driver: scsi: ufs-qcom: fix returnvar.cocci warning
Date:   Sat, 1 Dec 2018 02:07:43 +0800
Message-ID: <1543601264-12610-1-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable used to store return value,
detected by the semantic patch returnvar.cocci.

Signed-off-by: liujian <liujian56@huawei.com>
---
 drivers/scsi/ufs/ufs-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3aeadb1..4d5532d 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -543,7 +543,6 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct phy *phy = host->generic_phy;
-	int ret = 0;
 
 	if (ufs_qcom_is_link_off(hba)) {
 		/*
@@ -569,7 +568,7 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	}
 
 out:
-	return ret;
+	return 0;
 }
 
 static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
-- 
2.7.4

