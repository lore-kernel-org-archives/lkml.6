Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5A22146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5A22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeKOU0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:26:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728962AbeKOU0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:26:33 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52B3DFCE0216D;
        Thu, 15 Nov 2018 18:19:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Thu, 15 Nov 2018 18:19:09 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <hare@suse.com>, <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 5/5] scsi: libsas: Remove pcidev reference
Date:   Thu, 15 Nov 2018 18:20:32 +0800
Message-ID: <1542277232-135789-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1542277232-135789-1-git-send-email-john.garry@huawei.com>
References: <1542277232-135789-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all host drivers are PCI drivers - like hisi_sas, which supports a
platform driver - so remove reference to "pcidev".

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_discover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 3eb9ff2..726ada9 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -186,7 +186,7 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
 
 	res = i->dft->lldd_dev_found(dev);
 	if (res) {
-		pr_warn("driver on pcidev %s cannot handle device %llx, error:%d\n",
+		pr_warn("driver on host %s cannot handle device %llx, error:%d\n",
 			dev_name(sas_ha->dev),
 			SAS_ADDR(dev->sas_addr), res);
 	}
-- 
1.9.1

