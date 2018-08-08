Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF0FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B15A21A14
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15A21A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeHHRa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:30:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeHHRa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:30:29 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9DD0EAE03F048;
        Wed,  8 Aug 2018 23:10:19 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 23:10:16 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <axboe@kernel.dk>, <jthumshirn@suse.de>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/block/mtip32xx: remove the null check for debugfs_remove_recursive
Date:   Wed, 8 Aug 2018 22:58:33 +0800
Message-ID: <1533740313-11906-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive has taken null pointer into account. So it is
safe to drop the null check before calling the funtion.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 2b6d6bc..d0666f5c 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2574,8 +2574,7 @@ static int mtip_hw_debugfs_init(struct driver_data *dd)
 
 static void mtip_hw_debugfs_exit(struct driver_data *dd)
 {
-	if (dd->dfs_node)
-		debugfs_remove_recursive(dd->dfs_node);
+	debugfs_remove_recursive(dd->dfs_node);
 }
 
 /*
-- 
1.7.12.4

