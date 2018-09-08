Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140EC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA82086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEA82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeIHTKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:10:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51019 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbeIHTKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:10:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C108356C654AD;
        Sat,  8 Sep 2018 22:24:47 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 22:24:46 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] wireless: remove unnecessary condition check before kfree
Date:   Sat, 8 Sep 2018 22:12:35 +0800
Message-ID: <1536415955-33776-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken the null pointer into account. Just remove the
redundant condition check before kfree.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/wireless/reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5ad5b9f..dc87e3d 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1086,7 +1086,7 @@ int reg_reload_regdb(void)
 	}
 
 	rtnl_lock();
-	if (!IS_ERR_OR_NULL(regdb))
+	if (!IS_ERR(regdb))
 		kfree(regdb);
 	regdb = db;
 	rtnl_unlock();
@@ -3920,7 +3920,7 @@ void regulatory_exit(void)
 		kfree(reg_request);
 	}
 
-	if (!IS_ERR_OR_NULL(regdb))
+	if (!IS_ERR(regdb))
 		kfree(regdb);
 
 	free_regdb_keyring();
-- 
1.7.12.4

