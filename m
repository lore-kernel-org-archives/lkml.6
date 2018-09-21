Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879BEECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F75A2154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F75A2154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbeIUTUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:20:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbeIUTUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:20:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 966FE3A0279A8;
        Fri, 21 Sep 2018 21:31:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 21:31:05 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>
CC:     <cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM / devfreq: remove redundant null pointer check before kfree
Date:   Fri, 21 Sep 2018 21:18:43 +0800
Message-ID: <1537535923-46240-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before kfree.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/devfreq/devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1..c37021d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -675,8 +675,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	device_unregister(&devfreq->dev);
 	devfreq = NULL;
 err_dev:
-	if (devfreq)
-		kfree(devfreq);
+	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
-- 
1.7.12.4

