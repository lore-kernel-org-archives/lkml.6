Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4D20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F4D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeIHSro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:47:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbeIHSro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:47:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4F48A6A14841;
        Sat,  8 Sep 2018 22:01:44 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 22:01:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dledford@redhat.com>, <benve@cisco.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] infiniband: remove redundant condition check before debugfs_remove
Date:   Sat, 8 Sep 2018 21:49:31 +0800
Message-ID: <1536414571-32675-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove has taken the IS_ERR_OR_NULL into account. Just
remove the unnecessary condition.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/infiniband/hw/usnic/usnic_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_debugfs.c b/drivers/infiniband/hw/usnic/usnic_debugfs.c
index 92dc66c..a311570 100644
--- a/drivers/infiniband/hw/usnic/usnic_debugfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_debugfs.c
@@ -165,6 +165,5 @@ void usnic_debugfs_flow_add(struct usnic_ib_qp_grp_flow *qp_flow)
 
 void usnic_debugfs_flow_remove(struct usnic_ib_qp_grp_flow *qp_flow)
 {
-	if (!IS_ERR_OR_NULL(qp_flow->dbgfs_dentry))
-		debugfs_remove(qp_flow->dbgfs_dentry);
+	debugfs_remove(qp_flow->dbgfs_dentry);
 }
-- 
1.7.12.4

