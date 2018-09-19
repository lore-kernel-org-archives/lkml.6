Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DD20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5DD20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeISUVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:21:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47509 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731311AbeISUVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:21:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D84D369C9EDE9;
        Wed, 19 Sep 2018 22:43:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 22:43:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <dougmill@linux.vnet.ibm.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ibm: remove redundant local variables 'act_nr_of_entries' and 'act_pages'
Date:   Wed, 19 Sep 2018 22:30:49 +0800
Message-ID: <1537367449-59565-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That local variable are never used after being assigned.
hence it should be redundant and can be removed.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
index a0820f7..5e4e371 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
@@ -125,7 +125,7 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
 	struct ehea_cq *cq;
 	struct h_epa epa;
 	u64 *cq_handle_ref, hret, rpage;
-	u32 act_nr_of_entries, act_pages, counter;
+	u32 counter;
 	int ret;
 	void *vpage;
 
@@ -140,8 +140,6 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
 	cq->adapter = adapter;
 
 	cq_handle_ref = &cq->fw_handle;
-	act_nr_of_entries = 0;
-	act_pages = 0;
 
 	hret = ehea_h_alloc_resource_cq(adapter->handle, &cq->attr,
 					&cq->fw_handle, &cq->epas);
-- 
1.7.12.4

