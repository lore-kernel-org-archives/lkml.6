Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91164C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485892070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865277;
	bh=ULYmeCSVB/oSC6uiSYaT+qxFwtilTcGF522JwCycSGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lnl28PvxSdmmbWDAmeBkUKaTcqiK5l92DYswdlUY6kref/kBwLHAxcnN+7/u5LQHj
	 2NV9yZ67KRdOMc7evEfDRZTL9sZqGyZtIu3cT/nTsXNk0aVRQLNeBhBawlNMlcrFK0
	 xBap1uTaiYYX58JDwxGV1AuNPPEAZPLovQ/iFFag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeLZXBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbeLZWgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C46218E2;
        Wed, 26 Dec 2018 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863791;
        bh=ULYmeCSVB/oSC6uiSYaT+qxFwtilTcGF522JwCycSGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNNFgMqvfv3kq62TtjuaevrnQ50FnLPYqpJfEiRFtpIjYrn2uO4lIT3G3yiMh1VVX
         bGKGKHM1Uskdjxpc01/cTPiuwxBrFz6QX6yxntXy0bIEeEQufwOrjz+jebcZTxBOS3
         76kl3o5jqerrZ+X/WZ1TSTYxTil37ZbERzbCX6B4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/97] Revert "scsi: qla2xxx: Fix NVMe Target discovery"
Date:   Wed, 26 Dec 2018 17:34:42 -0500
Message-Id: <20181226223557.149329-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit c64a87f9518409d0a439895f09f6149ffdd427b8 ]

This reverts commit db186382af21e926e90df19499475f2552192b77.

This commit introduced regression with FCP discovery so revert it to fix
discovery for FCP luns.

Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index ae9fd2d01004..42b8f0d3e580 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4808,10 +4808,10 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 			fcport->d_id = e->u.new_sess.id;
 			fcport->flags |= FCF_FABRIC_DEVICE;
 			fcport->fw_login_state = DSC_LS_PLOGI_PEND;
-			if (e->u.new_sess.fc4_type & FS_FC4TYPE_FCP)
+			if (e->u.new_sess.fc4_type == FS_FC4TYPE_FCP)
 				fcport->fc4_type = FC4_TYPE_FCP_SCSI;
 
-			if (e->u.new_sess.fc4_type & FS_FC4TYPE_NVME) {
+			if (e->u.new_sess.fc4_type == FS_FC4TYPE_NVME) {
 				fcport->fc4_type = FC4_TYPE_OTHER;
 				fcport->fc4f_nvme = FC4_TYPE_NVME;
 			}
-- 
2.19.1

