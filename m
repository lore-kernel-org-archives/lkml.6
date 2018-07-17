Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2BEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C53A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C53A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeGQOc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:32:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731497AbeGQOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:32:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E1C6F25FB8EF0;
        Tue, 17 Jul 2018 21:59:21 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 21:59:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jon.maloy@ericsson.com>,
        <ying.xue@windriver.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] tipc: remove unused tipc_link_is_active
Date:   Tue, 17 Jul 2018 21:58:46 +0800
Message-ID: <20180717135846.18600-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tipc_link_is_active is no longer used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tipc/link.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index df763be..6987ffc 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -297,11 +297,6 @@ static bool link_is_bc_rcvlink(struct tipc_link *l)
 	return ((l->bc_rcvlink == l) && !link_is_bc_sndlink(l));
 }
 
-int tipc_link_is_active(struct tipc_link *l)
-{
-	return l->active;
-}
-
 void tipc_link_set_active(struct tipc_link *l, bool active)
 {
 	l->active = active;
-- 
2.7.0


