Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCVUIz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:08:55 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.111]:30996 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751771AbeCVUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:08:54 -0400
Date: Thu, 22 Mar 2018 15:08:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] qed: Use true and false for boolean values
Message-ID: <20180322200849.GA28033@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1ez6W3-001FIK-N7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:54268
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 553a6d1..cdb3eec 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -298,8 +298,8 @@ static void qed_init_qm_params(struct qed_hwfn *p_hwfn)
 	qm_info->start_vport = (u8) RESC_START(p_hwfn, QED_VPORT);
 
 	/* rate limiting and weighted fair queueing are always enabled */
-	qm_info->vport_rl_en = 1;
-	qm_info->vport_wfq_en = 1;
+	qm_info->vport_rl_en = true;
+	qm_info->vport_wfq_en = true;
 
 	/* TC config is different for AH 4 port */
 	four_port = p_hwfn->cdev->num_ports_in_engine == MAX_NUM_PORTS_K2;
@@ -1276,9 +1276,9 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 
 	if (p_hwfn->mcp_info) {
 		if (p_hwfn->mcp_info->func_info.bandwidth_max)
-			qm_info->pf_rl_en = 1;
+			qm_info->pf_rl_en = true;
 		if (p_hwfn->mcp_info->func_info.bandwidth_min)
-			qm_info->pf_wfq_en = 1;
+			qm_info->pf_wfq_en = true;
 	}
 
 	memset(&params, 0, sizeof(params));
@@ -1630,7 +1630,7 @@ static int qed_vf_start(struct qed_hwfn *p_hwfn,
 		qed_vf_pf_tunnel_param_update(p_hwfn, p_params->p_tunn);
 	}
 
-	p_hwfn->b_int_enabled = 1;
+	p_hwfn->b_int_enabled = true;
 
 	return 0;
 }
-- 
2.7.4
