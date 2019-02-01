Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A15020870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfBADLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:11:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfBADLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:11:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E30516676884A45FAB5;
        Fri,  1 Feb 2019 11:11:39 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 11:11:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/hns: Make some function static
Date:   Fri, 1 Feb 2019 11:11:04 +0800
Message-ID: <20190201031104.15064-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5822:5: warning:
 symbol 'hns_roce_v2_query_srq' was not declared. Should it be static?
drivers/infiniband/hw/hns/hns_roce_srq.c:158:6: warning:
 symbol 'hns_roce_srq_free' was not declared. Should it be static?
drivers/infiniband/hw/hns/hns_roce_srq.c:81:5: warning:
 symbol 'hns_roce_srq_alloc' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c   | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5c483b4..58271d2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5819,7 +5819,7 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 	return 0;
 }
 
-int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
+static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 11be2db..a8ee2f6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -78,9 +78,9 @@ static int hns_roce_hw2sw_srq(struct hns_roce_dev *dev,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn, u16 xrcd,
-		       struct hns_roce_mtt *hr_mtt, u64 db_rec_addr,
-		       struct hns_roce_srq *srq)
+static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
+			      u16 xrcd, struct hns_roce_mtt *hr_mtt,
+			      u64 db_rec_addr, struct hns_roce_srq *srq)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	struct hns_roce_cmd_mailbox *mailbox;
@@ -155,7 +155,8 @@ int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn, u16 xrcd,
 	return ret;
 }
 
-void hns_roce_srq_free(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+static void hns_roce_srq_free(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_srq *srq)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	int ret;
-- 
2.7.0


