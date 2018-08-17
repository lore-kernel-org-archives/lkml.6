Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C77220E20
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C77220E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeHQPkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:40:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbeHQPkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:40:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E70E96F9779E;
        Fri, 17 Aug 2018 20:36:48 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 20:36:46 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] thunderbolt: remove a meaningless null pointer check before dma_pool_destroy
Date:   Fri, 17 Aug 2018 20:24:56 +0800
Message-ID: <1534508696-36242-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_pool_destroy has taken the null pointer into account. so just
remove the null pointer check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/thunderbolt/ctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 37a7f4c..e54e84e 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -662,8 +662,7 @@ void tb_ctl_free(struct tb_ctl *ctl)
 		tb_ctl_pkg_free(ctl->rx_packets[i]);
 
 
-	if (ctl->frame_pool)
-		dma_pool_destroy(ctl->frame_pool);
+	dma_pool_destroy(ctl->frame_pool);
 	kfree(ctl);
 }
 
-- 
1.7.12.4

