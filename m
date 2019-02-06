Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB23C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C39217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfBFKwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:52:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfBFKwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:52:32 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D78F915233BED428F4D7;
        Wed,  6 Feb 2019 18:52:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Feb 2019 18:52:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/6] scsi: hisi_sas: change queue depth from 512 to 4096
Date:   Wed, 6 Feb 2019 18:52:53 +0800
Message-ID: <1549450376-114929-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
References: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

If sending IOs to many disks from single queue, it is possible that the
queue may be full. To avoid the situation, change queue depth from 512
to 4096 which is the max number of IOs for v3 hw.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index df2a92a0e7a1..ff844d4ba0d3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -30,7 +30,7 @@
 
 #define HISI_SAS_MAX_PHYS	9
 #define HISI_SAS_MAX_QUEUES	32
-#define HISI_SAS_QUEUE_SLOTS 512
+#define HISI_SAS_QUEUE_SLOTS	4096
 #define HISI_SAS_MAX_ITCT_ENTRIES 1024
 #define HISI_SAS_MAX_DEVICES HISI_SAS_MAX_ITCT_ENTRIES
 #define HISI_SAS_RESET_BIT	0
-- 
2.17.1

