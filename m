Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1AEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D544321526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D544321526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJQUb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:31:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbeJQUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:31:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1AD0ACB0A7375;
        Wed, 17 Oct 2018 20:34:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Wed, 17 Oct 2018
 20:34:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <willy@infradead.org>, <hare@suse.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] advansys: remove set but not used variable 'srb_tag' in adv_isr_callback
Date:   Wed, 17 Oct 2018 20:34:32 +0800
Message-ID: <20181017123432.18304-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/advansys.c: In function 'adv_isr_callback':
drivers/scsi/advansys.c:5952:6: warning:
 variable 'srb_tag' set but not used [-Wunused-but-set-variable]

It never used since introduction in
commit 9c17c62aedb0 ("advansys: use shared host tag map for command lookup")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/advansys.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 44c9619..223ef6f 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -5949,7 +5949,6 @@ static void adv_async_callback(ADV_DVC_VAR *adv_dvc_varp, uchar code)
 static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
 {
 	struct asc_board *boardp = adv_dvc_varp->drv_ptr;
-	u32 srb_tag;
 	adv_req_t *reqp;
 	adv_sgblk_t *sgblkp;
 	struct scsi_cmnd *scp;
@@ -5965,7 +5964,6 @@ static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
 	 * completed. The adv_req_t structure actually contains the
 	 * completed ADV_SCSI_REQ_Q structure.
 	 */
-	srb_tag = le32_to_cpu(scsiqp->srb_tag);
 	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);
 
 	ASC_DBG(1, "scp 0x%p\n", scp);
-- 
2.7.0


