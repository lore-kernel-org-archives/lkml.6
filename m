Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB19C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667FA2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667FA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeK3TOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:14:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbeK3TOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:14:10 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 03AC3C078451E;
        Fri, 30 Nov 2018 16:05:41 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 16:05:39 +0800
From:   liujian <liujian56@huawei.com>
To:     <qla2xxx-upstream@qlogic.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <vinholikatti@gmail.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] driver: scsi: qla2xxx: fix returnvar.cocci warning
Date:   Sat, 1 Dec 2018 02:07:44 +0800
Message-ID: <1543601264-12610-2-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543601264-12610-1-git-send-email-liujian56@huawei.com>
References: <1543601264-12610-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable used to store return value,
detected by the semantic patch returnvar.cocci.

Signed-off-by: liujian <liujian56@huawei.com>
---
 drivers/scsi/qla2xxx/qla_mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 60f964c..bb66ea4 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1712,7 +1712,6 @@ qlafx00_tgt_detach(struct scsi_qla_host *vha, int tgt_id)
 int
 qlafx00_process_aen(struct scsi_qla_host *vha, struct qla_work_evt *evt)
 {
-	int rval = 0;
 	uint32_t aen_code, aen_data;
 
 	aen_code = FCH_EVT_VENDOR_UNIQUE;
@@ -1764,7 +1763,7 @@ qlafx00_process_aen(struct scsi_qla_host *vha, struct qla_work_evt *evt)
 	fc_host_post_event(vha->host, fc_get_event_number(),
 	    aen_code, aen_data);
 
-	return rval;
+	return 0;
 }
 
 static void
-- 
2.7.4

