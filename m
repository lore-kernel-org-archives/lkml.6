Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68CCC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55A320856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697743;
	bh=Z8TiEyP7Fvh64SgbnroFeoKgPByJoeBc6HLA7pfB/6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYbCDO6GPTarYTLBO3tarYHLOyCXfecNt0m7ZpWdXTwP2UDyVKaI+tQgBpwKFJkLf
	 JfyI196A89Tjg1Zfnhwj30vLGaWmwG/mEvaEISyZkx9RDfFSDi1SzRfvxNt1aHMlzG
	 ZIOKDRKByFeS7B9ES9uTwFRxvpTLe05veIz1c31I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfA1RtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfA1PpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B1920880;
        Mon, 28 Jan 2019 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690321;
        bh=Z8TiEyP7Fvh64SgbnroFeoKgPByJoeBc6HLA7pfB/6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJuCaA0P9Wu0wk4cscso3LjG0qBpOFAO2sADN+kf/XM6OlBm3O6/tNWAB/IcjCvgG
         VmvPw+shOqXhl1yQjfgu4LJ8hw4PTIql/MveoMOwCsNdPPE/2cVzIxJGwuScVPUr7V
         g6vAwj3Wap9xt0IKGyJYtpKMEK8HGyfVmqvkOHFU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 050/304] scsi: hisi_sas: change the time of SAS SSP connection
Date:   Mon, 28 Jan 2019 10:39:27 -0500
Message-Id: <20190128154341.47195-50-sashal@kernel.org>
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
index a369450a1fa7..c3e0be90e19f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -494,7 +494,7 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_OOB_RESTART_MSK, 0x1);
 		hisi_sas_phy_write32(hisi_hba, i, STP_LINK_TIMER, 0x7f7a120);
 		hisi_sas_phy_write32(hisi_hba, i, CON_CFG_DRIVER, 0x2a0a01);
-
+		hisi_sas_phy_write32(hisi_hba, i, SAS_SSP_CON_TIMER_CFG, 0x32);
 		/* used for 12G negotiate */
 		hisi_sas_phy_write32(hisi_hba, i, COARSETUNE_TIME, 0x1e);
 		hisi_sas_phy_write32(hisi_hba, i, AIP_LIMIT, 0x2ffff);
-- 
2.19.1

