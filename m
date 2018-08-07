Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096FFC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4235217C7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4235217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbeHGNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:45:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733210AbeHGNp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:45:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C553D49FA5614;
        Tue,  7 Aug 2018 19:31:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 7 Aug 2018 19:31:55 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <anna.schumaker@netapp.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] net:mod: remove unneeded variable 'ret' in init_p9
Date:   Tue, 7 Aug 2018 19:20:09 +0800
Message-ID: <1533640809-1221-4-git-send-email-zhongjiang@huawei.com>
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

The ret is modified after initalization, so just remove it and
return 0.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/9p/mod.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/9p/mod.c b/net/9p/mod.c
index eb9777f..253ba82 100644
--- a/net/9p/mod.c
+++ b/net/9p/mod.c
@@ -171,13 +171,11 @@ void v9fs_put_trans(struct p9_trans_module *m)
  */
 static int __init init_p9(void)
 {
-	int ret = 0;
-
 	p9_error_init();
 	pr_info("Installing 9P2000 support\n");
 	p9_trans_fd_init();
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
1.7.12.4

