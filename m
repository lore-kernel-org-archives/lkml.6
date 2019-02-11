Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A6AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DCA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895998;
	bh=Rb2kKW7gI3nR1jHUFOorKn+g5I5NQQOzFtogUgbk454=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NlLGcS4crBLRKeKzQ/wgwoIFp4cOiiD3G6vyR8tx3XyJGALdSm8AhOjKr0K35tQcT
	 /fi5kXxotivhA+oS6vAvyxWBa/5z2TGhSoN0dfjxz8OR7nckkp9N8MCHIkMIkaRwV2
	 wpO23H2IZZNDfa885bWzv7TN1f3xtxpe+WdKerrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbfBKOj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfBKOjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B242081B;
        Mon, 11 Feb 2019 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895992;
        bh=Rb2kKW7gI3nR1jHUFOorKn+g5I5NQQOzFtogUgbk454=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmPFoBrQnjhUzX7uUa2hixQDUBwfjg5k9KMg5nRMqT7Jadd0pKiTgbp2rkmtG9G0L
         KdKPF6UaTqFepLlKuwcqSEwh7Ya368UtS2Gzwoo8LGysV2erd8AueffhmqcJxtj22Z
         V391wnivxrZ7IE0S06OnoU4KLm80ZUyL6drwZBeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/313] scsi: hisi_sas: change the time of SAS SSP connection
Date:   Mon, 11 Feb 2019 15:15:18 +0100
Message-Id: <20190211141856.058952741@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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



