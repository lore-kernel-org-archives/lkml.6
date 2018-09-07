Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FFD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FFD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeIGGSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:18:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725745AbeIGGSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:18:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 38226B7FC08A6;
        Fri,  7 Sep 2018 09:40:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Fri, 7 Sep 2018 09:40:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] interconnect: Remove set but not used variable 'p'
Date:   Fri, 7 Sep 2018 01:50:37 +0000
Message-ID: <1536285037-171513-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/interconnect/core.c: In function 'icc_set':
drivers/interconnect/core.c:350:23: warning:
 variable 'p' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/interconnect/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2740f1a..8b1ba1a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -347,7 +347,6 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	struct icc_node *node;
-	struct icc_provider *p;
 	size_t i;
 	int ret;
 
@@ -358,7 +357,6 @@ int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
-		p = node->provider;
 
 		/* update the consumer request for this path */
 		path->reqs[i].avg_bw = avg_bw;

