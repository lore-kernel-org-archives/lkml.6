Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D470AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A420C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691713;
	bh=v+JXHTu3xvc3gg5A211D/qIdQoImpE1Oqhfyq9E82vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1F7LqAq/ic0s9Yk6IAojIqBdRPdvBLOctBxwaCuTbd/QICLcB0wzLyrGT2fAr0IKB
	 3lOEpBMZFUXWyk/FeIZWIhSax6/WK0/4NaZUoLoJT9kW8L3y5F0Oqm8tw0UwFGJhk7
	 XuVVbsAVDK7DWb4aSEEtTjt7kV4xJpqGC7hgVeJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfA1QIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbfA1QI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C5220989;
        Mon, 28 Jan 2019 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691706;
        bh=v+JXHTu3xvc3gg5A211D/qIdQoImpE1Oqhfyq9E82vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPeohBmCKL8wvHoz05qi0xG9Mln8K1o+qgc/EJBsZ7xjcBuZoHogz+Ak2Zp04XNPV
         UNJ1qnnNW5WlGgr4x/u2mUWD5FemansPvBBziFHL1BlkX2qRlntfLjuKoilGI4ybyL
         i4/gLXtNM9nfunwJn5YEbHNzoriu42j4Pn9y9qFE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 192/258] scsi: smartpqi: increase fw status register read timeout
Date:   Mon, 28 Jan 2019 10:58:18 -0500
Message-Id: <20190128155924.51521-192-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 5141bd4c9f06..ca7dfb3a520f 100644
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

