Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C7C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC6121723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC6121723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeHGNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:45:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47941 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728167AbeHGNp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:45:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F0841918AD29F;
        Tue,  7 Aug 2018 19:31:57 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 7 Aug 2018 19:31:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <anna.schumaker@netapp.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] net:af_iucv: get rid of the unneeded variable 'err' in afiucv_pm_freeze
Date:   Tue, 7 Aug 2018 19:20:08 +0800
Message-ID: <1533640809-1221-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533640809-1221-1-git-send-email-zhongjiang@huawei.com>
References: <1533640809-1221-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will not use the variable 'err' after initalization, So remove it and
return 0.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/iucv/af_iucv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 92ee91e..a21d8ed 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -150,7 +150,6 @@ static int afiucv_pm_freeze(struct device *dev)
 {
 	struct iucv_sock *iucv;
 	struct sock *sk;
-	int err = 0;
 
 #ifdef CONFIG_PM_DEBUG
 	printk(KERN_WARNING "afiucv_pm_freeze\n");
@@ -175,7 +174,7 @@ static int afiucv_pm_freeze(struct device *dev)
 		skb_queue_purge(&iucv->backlog_skb_q);
 	}
 	read_unlock(&iucv_sk_list.lock);
-	return err;
+	return 0;
 }
 
 /**
-- 
1.7.12.4

