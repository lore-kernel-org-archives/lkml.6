Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC24021741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeLTDQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729627AbeLTDQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:26 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 536CAC66870C8;
        Thu, 20 Dec 2018 11:16:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 11:16:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param
Date:   Thu, 20 Dec 2018 11:16:07 +0800
Message-ID: <20181220031607.10588-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return code should be check while qla4xxx_copy_from_fwddb_param
fails.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 949e186..1bc4db6 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -7232,6 +7232,8 @@ static int qla4xxx_sysfs_ddb_tgt_create(struct scsi_qla_host *ha,
 
 	rc = qla4xxx_copy_from_fwddb_param(fnode_sess, fnode_conn,
 					   fw_ddb_entry);
+	if (rc)
+		goto free_sess;
 
 	ql4_printk(KERN_INFO, ha, "%s: sysfs entry %s created\n",
 		   __func__, fnode_sess->dev.kobj.name);
-- 
2.7.0


