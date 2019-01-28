Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DE820855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690907;
	bh=NTisI2VbLWTecP51IwIAJmIkwPiomUmaXN3crmEuUMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NCZALWTthaHsn4MYhM16rSX58T/Kghh2mRZ3F19urB7/VTY5ODBfybQ3HRJn7b6bq
	 FfpWN8l4Hxt7c16qsFXtLSGo5cd8rjBJrdvh8dxXfgE2wlDVG3JWHN6vM01Oc+sW17
	 ui9Z9w0QNWl+PCG18SkGk5PKJRmJn6YgHVmgimaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfA1PzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbfA1Py7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA8620989;
        Mon, 28 Jan 2019 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690898;
        bh=NTisI2VbLWTecP51IwIAJmIkwPiomUmaXN3crmEuUMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wl2n/A86vmTsWyzwnn8YDpsL+Qv9b0U/nE8+x3IJU6nrHClFd73JS8mB0fvElaBHp
         IBiEsgNiS42diJwSIHOOLCffjTAmIIty6614XT3jwaT1cm1uOxz+7mTCOaerhObuyl
         fPVSNdJx52//7kezLt1JHcFwFvTVzDSBMvD28xEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 228/304] scsi: smartpqi: increase fw status register read timeout
Date:   Mon, 28 Jan 2019 10:42:25 -0500
Message-Id: <20190128154341.47195-228-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>

[ Upstream commit 65111785acccb836ec75263b03b0e33f21e74f47 ]

Problem:
 - during the driver initialization, driver will poll fw
   for KERNEL_UP in a 30 seconds timeout.

 - if the firmware is not ready after 30 seconds,
   driver will not be loaded.

Fix:
 - change timeout from 30 seconds to 3 minutes.

Reported-by: Feng Li <lifeng1519@gmail.com>
Reviewed-by: Ajish Koshy <ajish.koshy@microsemi.com>
Reviewed-by: Murthy Bhat <Murthy.Bhat@microsemi.com>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_sis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_sis.c b/drivers/scsi/smartpqi/smartpqi_sis.c
index ea91658c7060..9d3043df22af 100644
--- a/drivers/scsi/smartpqi/smartpqi_sis.c
+++ b/drivers/scsi/smartpqi/smartpqi_sis.c
@@ -59,7 +59,7 @@
 
 #define SIS_CTRL_KERNEL_UP			0x80
 #define SIS_CTRL_KERNEL_PANIC			0x100
-#define SIS_CTRL_READY_TIMEOUT_SECS		30
+#define SIS_CTRL_READY_TIMEOUT_SECS		180
 #define SIS_CTRL_READY_RESUME_TIMEOUT_SECS	90
 #define SIS_CTRL_READY_POLL_INTERVAL_MSECS	10
 
-- 
2.19.1

