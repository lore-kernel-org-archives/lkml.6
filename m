Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2AC43143
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C8D2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8D2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeIAHxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 03:53:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbeIAHxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 03:53:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3001951E79BF8;
        Sat,  1 Sep 2018 11:43:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Sat, 1 Sep 2018 11:43:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/qedr: remove set but not used variable 'ctx'
Date:   Sat, 1 Sep 2018 03:53:46 +0000
Message-ID: <1535774026-160694-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/hw/qedr/verbs.c: In function 'qedr_create_srq':
drivers/infiniband/hw/qedr/verbs.c:1450:24: warning:
 variable 'ctx' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 8cc3df2..9d4d165 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1447,7 +1447,6 @@ struct ib_srq *qedr_create_srq(struct ib_pd *ibpd,
 	u64 pbl_base_addr, phy_prod_pair_addr;
 	struct ib_ucontext *ib_ctx = NULL;
 	struct qedr_srq_hwq_info *hw_srq;
-	struct qedr_ucontext *ctx = NULL;
 	u32 page_cnt, page_size;
 	struct qedr_srq *srq;
 	int rc = 0;
@@ -1473,7 +1472,6 @@ struct ib_srq *qedr_create_srq(struct ib_pd *ibpd,
 
 	if (udata && ibpd->uobject && ibpd->uobject->context) {
 		ib_ctx = ibpd->uobject->context;
-		ctx = get_qedr_ucontext(ib_ctx);
 
 		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
 			DP_ERR(dev,

