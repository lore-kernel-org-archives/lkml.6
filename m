Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5137D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfBLQB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:01:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42115 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfBLQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:01:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtaVN-000311-G3; Tue, 12 Feb 2019 16:01:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ariel Elior <aelior@marvell.com>, GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix indentation issue with statements in an if-block
Date:   Tue, 12 Feb 2019 16:01:53 +0000
Message-Id: <20190212160153.12432-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some statements in an if-block that are not correctly
indented. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 35c9f484eb9f..e61d1d905415 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -2135,12 +2135,12 @@ int qed_cxt_set_pf_params(struct qed_hwfn *p_hwfn, u32 rdma_tasks)
 		struct qed_eth_pf_params *p_params =
 		    &p_hwfn->pf_params.eth_pf_params;
 
-			if (!p_params->num_vf_cons)
-				p_params->num_vf_cons =
-				    ETH_PF_PARAMS_VF_CONS_DEFAULT;
-			qed_cxt_set_proto_cid_count(p_hwfn, PROTOCOLID_ETH,
-						    p_params->num_cons,
-						    p_params->num_vf_cons);
+		if (!p_params->num_vf_cons)
+			p_params->num_vf_cons =
+			    ETH_PF_PARAMS_VF_CONS_DEFAULT;
+		qed_cxt_set_proto_cid_count(p_hwfn, PROTOCOLID_ETH,
+					    p_params->num_cons,
+					    p_params->num_vf_cons);
 		p_hwfn->p_cxt_mngr->arfs_count = p_params->num_arfs_filters;
 		break;
 	}
-- 
2.20.1

