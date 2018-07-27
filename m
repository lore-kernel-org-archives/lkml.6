Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D292064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D292064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeG0Ovw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:51:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730205AbeG0Ovw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:51:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1461166A59FE5;
        Fri, 27 Jul 2018 21:29:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 21:29:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <Ariel.Elior@cavium.com>,
        <everest-linux-l2@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qed: remove redundant functions qed_set_gft_event_id_cm_hdr
Date:   Fri, 27 Jul 2018 21:24:27 +0800
Message-ID: <20180727132427.17588-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-tree callers of qed_set_gft_event_id_cm_hdr.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
index d845bad..d6430df 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
@@ -1225,19 +1225,6 @@ void qed_gft_disable(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, u16 pf_id)
 	       0);
 }
 
-void qed_set_gft_event_id_cm_hdr(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
-{
-	u32 rfs_cm_hdr_event_id;
-
-	/* Set RFS event ID to be awakened i Tstorm By Prs */
-	rfs_cm_hdr_event_id = qed_rd(p_hwfn, p_ptt, PRS_REG_CM_HDR_GFT);
-	rfs_cm_hdr_event_id |= T_ETH_PACKET_ACTION_GFT_EVENTID <<
-			       PRS_REG_CM_HDR_GFT_EVENT_ID_SHIFT;
-	rfs_cm_hdr_event_id |= PARSER_ETH_CONN_GFT_ACTION_CM_HDR <<
-			       PRS_REG_CM_HDR_GFT_CM_HDR_SHIFT;
-	qed_wr(p_hwfn, p_ptt, PRS_REG_CM_HDR_GFT, rfs_cm_hdr_event_id);
-}
-
 void qed_gft_config(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt,
 		    u16 pf_id,
-- 
2.7.0


