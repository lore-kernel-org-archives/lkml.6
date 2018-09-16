Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A65ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E58208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E58208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeIPSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:44:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbeIPSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:44:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 12ADE51923D05;
        Sun, 16 Sep 2018 21:21:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sun, 16 Sep 2018 21:21:03 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: sram: remove redundant null pointer check before of_node_put
Date:   Sun, 16 Sep 2018 21:08:45 +0800
Message-ID: <1537103325-63227-1-git-send-email-zhongjiang@huawei.com>
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
 drivers/misc/sram.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 74b183b..80d8cbe 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -323,10 +323,8 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 		cur_start = block->start + block->size;
 	}
 
- err_chunks:
-	if (child)
-		of_node_put(child);
-
+err_chunks:
+	of_node_put(child);
 	kfree(rblocks);
 
 	return ret;
-- 
1.7.12.4

