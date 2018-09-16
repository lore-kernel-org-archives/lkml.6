Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9CECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A31208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A31208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIPSkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:40:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbeIPSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:40:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA6141ADB9342;
        Sun, 16 Sep 2018 21:17:09 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Sun, 16 Sep 2018 21:17:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>
CC:     <p.zabel@pengutronix.de>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: coda: remove redundant null pointer check before of_node_put
Date:   Sun, 16 Sep 2018 21:04:49 +0800
Message-ID: <1537103089-63003-1-git-send-email-zhongjiang@huawei.com>
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
 drivers/media/platform/coda/coda-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 0bffa1e..6bff416 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -376,8 +376,7 @@ static struct vdoa_data *coda_get_vdoa_data(void)
 		vdoa_data = ERR_PTR(-EPROBE_DEFER);
 
 out:
-	if (vdoa_node)
-		of_node_put(vdoa_node);
+	of_node_put(vdoa_node);
 
 	return vdoa_data;
 }
-- 
1.7.12.4

