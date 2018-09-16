Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4814ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2C21476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD2C21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeIPSwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:52:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbeIPSwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:52:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39CCBDCAD3B4E;
        Sun, 16 Sep 2018 21:29:13 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Sun, 16 Sep 2018 21:29:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>
CC:     <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: platform: remove redundant null pointer check before of_node_put
Date:   Sun, 16 Sep 2018 21:16:51 +0800
Message-ID: <1537103811-63670-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put has taken the null pinter check into account. So it is
safe to remove the duplicated check before of_node_put.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/media/platform/ti-vpe/cal.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index cc052b2..5f9d4e0 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1747,14 +1747,10 @@ static int of_cal_create_instance(struct cal_ctx *ctx, int inst)
 	}
 
 cleanup_exit:
-	if (remote_ep)
-		of_node_put(remote_ep);
-	if (sensor_node)
-		of_node_put(sensor_node);
-	if (ep_node)
-		of_node_put(ep_node);
-	if (port)
-		of_node_put(port);
+	of_node_put(remote_ep);
+	of_node_put(sensor_node);
+	of_node_put(ep_node);
+	of_node_put(port);
 
 	return ret;
 }
-- 
1.7.12.4

