Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F066C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1093E21917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691284;
	bh=mdG0bx07wU/Yo0PkNfyR67BVF/JdW76Kh7d2VO1RRsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vot/sP4sUCtNcBzTCDGKV2RliIOr/7/BtRVmJz7HSaQr4kScYs9p8ab7CFRN3qm26
	 zMxw1ibYfTbXo8jYuIZZ0Cj0DZLw9byLVr0vHxnNKgtFmhAjc3pYj1FqccqEPGTsPk
	 zgNmkvAacyDQQa3LwLPNRCHA+FchYuwVjtVJB144=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfA1QBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730998AbfA1QBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2ABB2175B;
        Mon, 28 Jan 2019 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691278;
        bh=mdG0bx07wU/Yo0PkNfyR67BVF/JdW76Kh7d2VO1RRsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpzzJ0SeX4DlhuHjXLRpATTU3Hx9fBjXsBFgAiLbGJASCn6ynRFgRIZkvNpSvYftn
         QpyP+qVW0bMsAcmPYHGG3atM3ADuk1601vcBDTt5uSlDG0MRF4Cokb11gCwQkU63ML
         8jMhUa9p4YsiGzHLYWH94erFjt53BOPvIWhFdRlw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 043/258] scsi: hisi_sas: change the time of SAS SSP connection
Date:   Mon, 28 Jan 2019 10:55:49 -0500
Message-Id: <20190128155924.51521-43-sashal@kernel.org>
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

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 15bc43f31a074076f114e0b87931e3b220b7bff1 ]

Currently the time of SAS SSP connection is 1ms, which means the link
connection will fail if no IO response after this period.

For some disks handling large IO (such as 512k), 1ms is not enough, so
change it to 5ms.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 687ff61bba9f..3922b17e2ea3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -492,7 +492,7 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_OOB_RESTART_MSK, 0x1);
 		hisi_sas_phy_write32(hisi_hba, i, STP_LINK_TIMER, 0x7f7a120);
 		hisi_sas_phy_write32(hisi_hba, i, CON_CFG_DRIVER, 0x2a0a01);
-
+		hisi_sas_phy_write32(hisi_hba, i, SAS_SSP_CON_TIMER_CFG, 0x32);
 		/* used for 12G negotiate */
 		hisi_sas_phy_write32(hisi_hba, i, COARSETUNE_TIME, 0x1e);
 	}
-- 
2.19.1

