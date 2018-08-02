Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9D20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE9D20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeHBEpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:45:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbeHBEpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:45:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 597821CD7E5E7;
        Thu,  2 Aug 2018 10:56:47 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 10:56:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <andy.shevchenko@gmail.com>, <john.garry@huawei.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] scsi:qla1280: remove unnessary same condition check
Date:   Thu, 2 Aug 2018 10:45:00 +0800
Message-ID: <1533177901-19514-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
References: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

doulbe test in a expression is redundant. so just remove one of
them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/qla1280.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 390775d..8e6f156 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1504,7 +1504,6 @@ static void qla1280_mailbox_timeout(struct timer_list *t)
 	/* Issue SCSI reset, if we can't reset twice then bus is dead */
 	for (bus = 0; bus < ha->ports; bus++) {
 		if (!ha->bus_settings[bus].disable_scsi_reset &&
-		    qla1280_bus_reset(ha, bus) &&
 		    qla1280_bus_reset(ha, bus))
 			ha->bus_settings[bus].scsi_bus_dead = 1;
 	}
-- 
1.7.12.4

