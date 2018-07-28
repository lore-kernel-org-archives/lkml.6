Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718D9C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B34B20891
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B34B20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeG1LuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 07:50:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbeG1LuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 07:50:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B72F7F7D2CDD;
        Sat, 28 Jul 2018 18:24:05 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Sat, 28 Jul 2018
 18:23:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <Ariel.Elior@cavium.com>,
        <everest-linux-l2@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qed: remove redundant functions qed_get_cm_pq_idx_rl
Date:   Sat, 28 Jul 2018 18:23:36 +0800
Message-ID: <20180728102336.16956-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-tree callers of qed_get_cm_pq_idx_rl since it be there,
so it can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index e5249b4..37817b3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -507,16 +507,6 @@ u16 qed_get_cm_pq_idx_vf(struct qed_hwfn *p_hwfn, u16 vf)
 	return qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_VFS) + vf;
 }
 
-u16 qed_get_cm_pq_idx_rl(struct qed_hwfn *p_hwfn, u8 rl)
-{
-	u16 max_rl = qed_init_qm_get_num_pf_rls(p_hwfn);
-
-	if (rl > max_rl)
-		DP_ERR(p_hwfn, "rl %d must be smaller than %d\n", rl, max_rl);
-
-	return qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_RLS) + rl;
-}
-
 /* Functions for creating specific types of pqs */
 static void qed_init_qm_lb_pq(struct qed_hwfn *p_hwfn)
 {
-- 
2.7.0


