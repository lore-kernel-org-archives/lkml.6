Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA857C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BFC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BFC20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeINK3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:29:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726890AbeINK3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:29:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D26DC2E1F527;
        Fri, 14 Sep 2018 13:16:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 13:16:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <stefan@datenfreihafen.org>, <h.morris@cascoda.com>,
        <alex.aring@gmail.com>, <davem@davemloft.net>
CC:     <linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ieee802154: ca8210: remove redundant condition check before debugfs_remove
Date:   Fri, 14 Sep 2018 13:04:37 +0800
Message-ID: <1536901477-28375-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove has taken the IS_ERR into account. Just
remove the unnecessary condition.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ieee802154/ca8210.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 58299fb..46b4818 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3044,8 +3044,7 @@ static void ca8210_test_interface_clear(struct ca8210_priv *priv)
 {
 	struct ca8210_test *test = &priv->test;
 
-	if (!IS_ERR(test->ca8210_dfs_spi_int))
-		debugfs_remove(test->ca8210_dfs_spi_int);
+	debugfs_remove(test->ca8210_dfs_spi_int);
 	kfifo_free(&test->up_fifo);
 	dev_info(&priv->spi->dev, "Test interface removed\n");
 }
-- 
1.7.12.4

