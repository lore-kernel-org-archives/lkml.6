Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C68ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9700221476
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9700221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeGQOr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:47:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729389AbeGQOr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:47:28 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1F7E3354166B;
        Tue, 17 Jul 2018 22:13:45 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 22:13:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jon.maloy@ericsson.com>,
        <ying.xue@windriver.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] tipc: remove unused tipc_group_size
Date:   Tue, 17 Jul 2018 22:11:23 +0800
Message-ID: <20180717141123.9684-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit eb929a91b213 ("tipc: improve poll() for group member socket"),
it is no longer used.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tipc/group.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index cbe39e8..8f43e7d 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -159,11 +159,6 @@ u32 tipc_group_exclude(struct tipc_group *grp)
 	return 0;
 }
 
-int tipc_group_size(struct tipc_group *grp)
-{
-	return grp->member_cnt;
-}
-
 struct tipc_group *tipc_group_create(struct net *net, u32 portid,
 				     struct tipc_group_req *mreq,
 				     bool *group_is_open)
-- 
2.7.0


