Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9850C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BF52063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217384;
	bh=xTTGRTuV8UeEtbYnZJelZdevVfD1ktiwt731u+Bq+uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ijXXdGYnOpSQyaKsnFD1fj6RteCf/MFWee7ZUzq2N6RBzojRg3iDWhR6e2jpxpTC5
	 syJTgNNkBAdgrOjRnDRqR8Q0LZZrs5Zza+ckuiP+32hVdr0hxop4VK5RUtPLr1t1JU
	 ZvJcph7oDtVlG4UZ37okdX16gzuaVBquj5gEK+GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbfAKOgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390347AbfAKOgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA652063F;
        Fri, 11 Jan 2019 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217379;
        bh=xTTGRTuV8UeEtbYnZJelZdevVfD1ktiwt731u+Bq+uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEePJl3apvuKk304J3fnh3F20WPV+gzeXhoM1lVJtwhoFkBjHUsY2bYtCNVYONtYr
         FDso9iL6vqz2IYwgCL/IwjkvGi3rztPAEW9YT/BUhqx2lc7x4yZjU5P3SXgLNHR2gE
         3CN7GzQgdp0DApugFB3D3cnjZz9U7pYswmNItacE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/148] Revert "scsi: qla2xxx: Fix NVMe Target discovery"
Date:   Fri, 11 Jan 2019 15:13:20 +0100
Message-Id: <20190111131115.204846484@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



