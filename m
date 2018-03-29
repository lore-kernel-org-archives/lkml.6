Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeC2Mlr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:41:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC2Mlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:41:46 -0400
From: Colin King <colin.king@canonical.com>
To: Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix a bunch of spelling mistakes/typos
Date: Thu, 29 Mar 2018 13:41:44 +0100
Message-Id: <20180329124144.27841-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes/typos in various DP_* messages.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qed/qed_init_ops.c | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c      | 4 ++--
 drivers/net/ethernet/qlogic/qed/qed_main.c     | 4 ++--
 drivers/net/ethernet/qlogic/qed/qed_rdma.c     | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c       | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_ops.c b/drivers/net/ethernet/qlogic/qed/qed_init_ops.c
index 3bb76da6baa2..b415d25afecf 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_ops.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_ops.c
@@ -407,7 +407,7 @@ static void qed_init_cmd_rd(struct qed_hwfn *p_hwfn,
 
 	if (i == QED_INIT_MAX_POLL_COUNT) {
 		DP_ERR(p_hwfn,
-		       "Timeout when polling reg: 0x%08x [ Waiting-for: %08x Got: %08x (comparsion %08x)]\n",
+		       "Timeout when polling reg: 0x%08x [ Waiting-for: %08x Got: %08x (comparison %08x)]\n",
 		       addr, le32_to_cpu(cmd->expected_val),
 		       val, le32_to_cpu(cmd->op_data));
 	}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index c4f14fdc4e77..e3622c5901ea 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2189,7 +2189,7 @@ static int qed_ll2_start_ooo(struct qed_dev *cdev,
 
 	rc = qed_ll2_establish_connection(hwfn, *handle);
 	if (rc) {
-		DP_INFO(cdev, "Failed to establist LL2 OOO connection\n");
+		DP_INFO(cdev, "Failed to establish LL2 OOO connection\n");
 		goto fail;
 	}
 
@@ -2383,7 +2383,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb)
 	u8 flags = 0;
 
 	if (unlikely(skb->ip_summed != CHECKSUM_NONE)) {
-		DP_INFO(cdev, "Cannot transmit a checksumed packet\n");
+		DP_INFO(cdev, "Cannot transmit a checksummed packet\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 27832885a87f..786267e7638a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -369,7 +369,7 @@ static struct qed_dev *qed_probe(struct pci_dev *pdev,
 		goto err2;
 	}
 
-	DP_INFO(cdev, "qed_probe completed successffuly\n");
+	DP_INFO(cdev, "qed_probe completed successfully\n");
 
 	return cdev;
 
@@ -679,7 +679,7 @@ static int qed_nic_stop(struct qed_dev *cdev)
 			tasklet_disable(p_hwfn->sp_dpc);
 			p_hwfn->b_sp_dpc_enabled = false;
 			DP_VERBOSE(cdev, NETIF_MSG_IFDOWN,
-				   "Disabled sp taskelt [hwfn %d] at %p\n",
+				   "Disabled sp tasklet [hwfn %d] at %p\n",
 				   i, p_hwfn->sp_dpc);
 		}
 	}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index a411f9c702a1..bae0f5111858 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -228,7 +228,7 @@ static int qed_rdma_alloc(struct qed_hwfn *p_hwfn,
 				 num_cons, "Toggle");
 	if (rc) {
 		DP_VERBOSE(p_hwfn, QED_MSG_RDMA,
-			   "Failed to allocate toogle bits, rc = %d\n", rc);
+			   "Failed to allocate toggle bits, rc = %d\n", rc);
 		goto free_cq_map;
 	}
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 91b5e9f02a62..4a0f7002b994 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -231,7 +231,7 @@ static void qed_vf_pf_acquire_reduce_resc(struct qed_hwfn *p_hwfn,
 {
 	DP_VERBOSE(p_hwfn,
 		   QED_MSG_IOV,
-		   "PF unwilling to fullill resource request: rxq [%02x/%02x] txq [%02x/%02x] sbs [%02x/%02x] mac [%02x/%02x] vlan [%02x/%02x] mc [%02x/%02x] cids [%02x/%02x]. Try PF recommended amount\n",
+		   "PF unwilling to fulfil resource request: rxq [%02x/%02x] txq [%02x/%02x] sbs [%02x/%02x] mac [%02x/%02x] vlan [%02x/%02x] mc [%02x/%02x] cids [%02x/%02x]. Try PF recommended amount\n",
 		   p_req->num_rxqs,
 		   p_resp->num_rxqs,
 		   p_req->num_rxqs,
-- 
2.15.1
