Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ACDC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D312080A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025842;
	bh=1idsZXoE6VWMEVo+6aOMEXPg1t00RsllOiRYPyDftoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NRaPrM/ZCxc0BEjSdKZpR7BjMEgPRW+LiLBe/V6Ir3uzJbOjRF4B8+1PQjd/Pj2Lq
	 d3FuRR+74zMQ9+3ffQE85wEzQcLtk1Qoi60EdZl9W8oPtXvXYs1+CtP76t9mGqDJhI
	 85YeIFEZo2gcFFtlPKyhGEMtI702qhTkX6Y6a0CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbfBMCoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733220AbfBMCl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972F6222C2;
        Wed, 13 Feb 2019 02:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025687;
        bh=1idsZXoE6VWMEVo+6aOMEXPg1t00RsllOiRYPyDftoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDzhs42Kwxf7HaWU/FWVz2JJL5pcMrNevv9fIDFI8Zh1oVc8rC5KSXrESrolIpcQp
         2nTUbTkuSAP3RrZWpHyUMcY9BeJSsLN6KubQebgjZGAo05769IJpWt0mBE1RS2RCVt
         U7s3ojw/+L5w1H+WtjJbJV8YNy1mgqv3jf4G8vZs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/16] scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param
Date:   Tue, 12 Feb 2019 21:41:06 -0500
Message-Id: <20190213024112.22038-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024112.22038-1-sashal@kernel.org>
References: <20190213024112.22038-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 72b4a0465f995175a2e22cf4a636bf781f1f28a7 ]

The return code should be check while qla4xxx_copy_from_fwddb_param fails.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index d8c03431d0aa..f9f899ec9427 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -7245,6 +7245,8 @@ static int qla4xxx_sysfs_ddb_tgt_create(struct scsi_qla_host *ha,
 
 	rc = qla4xxx_copy_from_fwddb_param(fnode_sess, fnode_conn,
 					   fw_ddb_entry);
+	if (rc)
+		goto free_sess;
 
 	ql4_printk(KERN_INFO, ha, "%s: sysfs entry %s created\n",
 		   __func__, fnode_sess->dev.kobj.name);
-- 
2.19.1

