Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD66C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8030D208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8030D208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeGaPx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:53:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54543 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730230AbeGaPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:53:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECC4F616CA4AE;
        Tue, 31 Jul 2018 22:12:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Tue, 31 Jul 2018
 22:12:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <Ariel.Elior@cavium.com>,
        <everest-linux-l2@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qed: Make some functions static
Date:   Tue, 31 Jul 2018 22:12:30 +0800
Message-ID: <20180731141230.10780-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/net/ethernet/qlogic/qed/qed_cxt.c:1534:6: warning: symbol 'qed_cm_init_pf' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_dev.c:233:4: warning: symbol 'qed_init_qm_get_num_tcs' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_dev.c:238:5: warning: symbol 'qed_init_qm_get_num_vfs' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_dev.c:246:5: warning: symbol 'qed_init_qm_get_num_pf_rls' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_dev.c:264:5: warning: symbol 'qed_init_qm_get_num_vports' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_dev.c:276:5: warning: symbol 'qed_init_qm_get_num_pqs' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_mcp.c:573:5: warning: symbol 'qed_mcp_nvm_wr_cmd' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_mcp.c:3012:1: warning: symbol '__qed_mcp_resc_lock' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:870:6: warning: symbol 'qed_dcbx_aen' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_debug.c:7841:5: warning: symbol 'qed_dbg_nvm_image_length' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_debug.c:7857:5: warning: symbol 'qed_dbg_nvm_image' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_sriov.c:675:6: warning: symbol '_qed_iov_pf_sanity_check' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_sriov.c:690:6: warning: symbol 'qed_iov_pf_sanity_check' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_sriov.c:3982:6: warning: symbol 'qed_iov_pf_get_pending_events' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_vf.c:172:5: warning: symbol '_qed_vf_pf_release' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_rdma.c:137:5: warning: symbol 'qed_rdma_get_sb_id' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_rdma.c:709:5: warning: symbol 'qed_rdma_stop' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_ll2.c:161:6: warning: symbol 'qed_ll2b_complete_rx_packet' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_roce.c:160:6: warning: symbol 'qed_roce_free_cid_pair' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:380:12: warning: symbol 'iwarp_state_names' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:946:1: warning: symbol 'qed_iwarp_parse_private_data' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:971:1: warning: symbol 'qed_iwarp_mpa_reply_arrived' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2504:1: warning: symbol 'qed_iwarp_ll2_slowpath' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2806:6: warning: symbol 'qed_iwarp_qp_in_error' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2827:6: warning: symbol 'qed_iwarp_exception_received' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:2958:1: warning: symbol 'qed_iwarp_connect_complete' was not declared. Should it be static?
drivers/net/ethernet/qlogic/qed/qed_iscsi.c:876:6: warning: symbol 'qed_iscsi_free_connection' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c   |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c  |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c |  9 +++++----
 drivers/net/ethernet/qlogic/qed/qed_dev.c   | 10 +++++-----
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c |  4 ++--
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 20 +++++++++++---------
 drivers/net/ethernet/qlogic/qed/qed_ll2.c   |  3 ++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c   | 15 ++++++++-------
 drivers/net/ethernet/qlogic/qed/qed_rdma.c  |  4 ++--
 drivers/net/ethernet/qlogic/qed/qed_roce.c  |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c |  8 ++++----
 drivers/net/ethernet/qlogic/qed/qed_vf.c    |  2 +-
 12 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index b5b5ff7..f1977aa 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1531,7 +1531,7 @@ void qed_qm_init_pf(struct qed_hwfn *p_hwfn,
 }
 
 /* CM PF */
-void qed_cm_init_pf(struct qed_hwfn *p_hwfn)
+static void qed_cm_init_pf(struct qed_hwfn *p_hwfn)
 {
 	/* XCM pure-LB queue */
 	STORE_RT_REG(p_hwfn, XCM_REG_CON_PHY_Q3_RT_OFFSET,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index 12b4c2a..d02e774 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -867,7 +867,7 @@ static int qed_dcbx_read_mib(struct qed_hwfn *p_hwfn,
 	return rc;
 }
 
-void qed_dcbx_aen(struct qed_hwfn *hwfn, u32 mib_type)
+static void qed_dcbx_aen(struct qed_hwfn *hwfn, u32 mib_type)
 {
 	struct qed_common_cb_ops *op = hwfn->cdev->protocol_ops.common;
 	void *cookie = hwfn->cdev->ops_cookie;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 4340c4c..1aa9fc1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -7838,8 +7838,8 @@ int qed_dbg_igu_fifo_size(struct qed_dev *cdev)
 	return qed_dbg_feature_size(cdev, DBG_FEATURE_IGU_FIFO);
 }
 
-int qed_dbg_nvm_image_length(struct qed_hwfn *p_hwfn,
-			     enum qed_nvm_images image_id, u32 *length)
+static int qed_dbg_nvm_image_length(struct qed_hwfn *p_hwfn,
+				    enum qed_nvm_images image_id, u32 *length)
 {
 	struct qed_nvm_image_att image_att;
 	int rc;
@@ -7854,8 +7854,9 @@ int qed_dbg_nvm_image_length(struct qed_hwfn *p_hwfn,
 	return rc;
 }
 
-int qed_dbg_nvm_image(struct qed_dev *cdev, void *buffer,
-		      u32 *num_dumped_bytes, enum qed_nvm_images image_id)
+static int qed_dbg_nvm_image(struct qed_dev *cdev, void *buffer,
+			     u32 *num_dumped_bytes,
+			     enum qed_nvm_images image_id)
 {
 	struct qed_hwfn *p_hwfn =
 		&cdev->hwfns[cdev->dbg_params.engine_for_debug];
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 37817b3..6a0b46f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -230,12 +230,12 @@ static u32 qed_get_pq_flags(struct qed_hwfn *p_hwfn)
 }
 
 /* Getters for resource amounts necessary for qm initialization */
-u8 qed_init_qm_get_num_tcs(struct qed_hwfn *p_hwfn)
+static u8 qed_init_qm_get_num_tcs(struct qed_hwfn *p_hwfn)
 {
 	return p_hwfn->hw_info.num_hw_tc;
 }
 
-u16 qed_init_qm_get_num_vfs(struct qed_hwfn *p_hwfn)
+static u16 qed_init_qm_get_num_vfs(struct qed_hwfn *p_hwfn)
 {
 	return IS_QED_SRIOV(p_hwfn->cdev) ?
 	       p_hwfn->cdev->p_iov_info->total_vfs : 0;
@@ -243,7 +243,7 @@ u16 qed_init_qm_get_num_vfs(struct qed_hwfn *p_hwfn)
 
 #define NUM_DEFAULT_RLS 1
 
-u16 qed_init_qm_get_num_pf_rls(struct qed_hwfn *p_hwfn)
+static u16 qed_init_qm_get_num_pf_rls(struct qed_hwfn *p_hwfn)
 {
 	u16 num_pf_rls, num_vfs = qed_init_qm_get_num_vfs(p_hwfn);
 
@@ -261,7 +261,7 @@ u16 qed_init_qm_get_num_pf_rls(struct qed_hwfn *p_hwfn)
 	return num_pf_rls;
 }
 
-u16 qed_init_qm_get_num_vports(struct qed_hwfn *p_hwfn)
+static u16 qed_init_qm_get_num_vports(struct qed_hwfn *p_hwfn)
 {
 	u32 pq_flags = qed_get_pq_flags(p_hwfn);
 
@@ -273,7 +273,7 @@ u16 qed_init_qm_get_num_vports(struct qed_hwfn *p_hwfn)
 }
 
 /* calc amount of PQs according to the requested flags */
-u16 qed_init_qm_get_num_pqs(struct qed_hwfn *p_hwfn)
+static u16 qed_init_qm_get_num_pqs(struct qed_hwfn *p_hwfn)
 {
 	u32 pq_flags = qed_get_pq_flags(p_hwfn);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
index c0d4a54..1135387 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
@@ -873,8 +873,8 @@ static void qed_iscsi_release_connection(struct qed_hwfn *p_hwfn,
 	spin_unlock_bh(&p_hwfn->p_iscsi_info->lock);
 }
 
-void qed_iscsi_free_connection(struct qed_hwfn *p_hwfn,
-			       struct qed_iscsi_conn *p_conn)
+static void qed_iscsi_free_connection(struct qed_hwfn *p_hwfn,
+				      struct qed_iscsi_conn *p_conn)
 {
 	qed_chain_free(p_hwfn->cdev, &p_conn->xhq);
 	qed_chain_free(p_hwfn->cdev, &p_conn->uhq);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 90a2b53..17f3dfa 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -377,7 +377,7 @@ qed_iwarp2roce_state(enum qed_iwarp_qp_state state)
 	}
 }
 
-const char *iwarp_state_names[] = {
+const static char *iwarp_state_names[] = {
 	"IDLE",
 	"RTS",
 	"TERMINATE",
@@ -942,7 +942,7 @@ qed_iwarp_return_ep(struct qed_hwfn *p_hwfn, struct qed_iwarp_ep *ep)
 	spin_unlock_bh(&p_hwfn->p_rdma_info->iwarp.iw_lock);
 }
 
-void
+static void
 qed_iwarp_parse_private_data(struct qed_hwfn *p_hwfn, struct qed_iwarp_ep *ep)
 {
 	struct mpa_v2_hdr *mpa_v2_params;
@@ -967,7 +967,7 @@ qed_iwarp_parse_private_data(struct qed_hwfn *p_hwfn, struct qed_iwarp_ep *ep)
 				       mpa_data_size;
 }
 
-void
+static void
 qed_iwarp_mpa_reply_arrived(struct qed_hwfn *p_hwfn, struct qed_iwarp_ep *ep)
 {
 	struct qed_iwarp_cm_event_params params;
@@ -2500,7 +2500,7 @@ static void qed_iwarp_ll2_rel_tx_pkt(void *cxt, u8 connection_handle,
 /* The only slowpath for iwarp ll2 is unalign flush. When this completion
  * is received, need to reset the FPDU.
  */
-void
+static void
 qed_iwarp_ll2_slowpath(void *cxt,
 		       u8 connection_handle,
 		       u32 opaque_data_0, u32 opaque_data_1)
@@ -2803,8 +2803,9 @@ int qed_iwarp_stop(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 	return qed_iwarp_ll2_stop(p_hwfn, p_ptt);
 }
 
-void qed_iwarp_qp_in_error(struct qed_hwfn *p_hwfn,
-			   struct qed_iwarp_ep *ep, u8 fw_return_code)
+static void qed_iwarp_qp_in_error(struct qed_hwfn *p_hwfn,
+				  struct qed_iwarp_ep *ep,
+				  u8 fw_return_code)
 {
 	struct qed_iwarp_cm_event_params params;
 
@@ -2824,8 +2825,9 @@ void qed_iwarp_qp_in_error(struct qed_hwfn *p_hwfn,
 	ep->event_cb(ep->cb_context, &params);
 }
 
-void qed_iwarp_exception_received(struct qed_hwfn *p_hwfn,
-				  struct qed_iwarp_ep *ep, int fw_ret_code)
+static void qed_iwarp_exception_received(struct qed_hwfn *p_hwfn,
+					 struct qed_iwarp_ep *ep,
+					 int fw_ret_code)
 {
 	struct qed_iwarp_cm_event_params params;
 	bool event_cb = false;
@@ -2954,7 +2956,7 @@ qed_iwarp_tcp_connect_unsuccessful(struct qed_hwfn *p_hwfn,
 	}
 }
 
-void
+static void
 qed_iwarp_connect_complete(struct qed_hwfn *p_hwfn,
 			   struct qed_iwarp_ep *ep, u8 fw_return_code)
 {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 012973d..14ac9ca 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -158,7 +158,8 @@ static void qed_ll2_kill_buffers(struct qed_dev *cdev)
 		qed_ll2_dealloc_buffer(cdev, buffer);
 }
 
-void qed_ll2b_complete_rx_packet(void *cxt, struct qed_ll2_comp_rx_data *data)
+static void qed_ll2b_complete_rx_packet(void *cxt,
+					struct qed_ll2_comp_rx_data *data)
 {
 	struct qed_hwfn *p_hwfn = cxt;
 	struct qed_ll2_buffer *buffer = data->cookie;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 96a67ef..8e4f60e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -570,12 +570,13 @@ int qed_mcp_cmd(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
-int qed_mcp_nvm_wr_cmd(struct qed_hwfn *p_hwfn,
-		       struct qed_ptt *p_ptt,
-		       u32 cmd,
-		       u32 param,
-		       u32 *o_mcp_resp,
-		       u32 *o_mcp_param, u32 i_txn_size, u32 *i_buf)
+static int
+qed_mcp_nvm_wr_cmd(struct qed_hwfn *p_hwfn,
+		   struct qed_ptt *p_ptt,
+		   u32 cmd,
+		   u32 param,
+		   u32 *o_mcp_resp,
+		   u32 *o_mcp_param, u32 i_txn_size, u32 *i_buf)
 {
 	struct qed_mcp_mb_params mb_params;
 	int rc;
@@ -3008,7 +3009,7 @@ static int qed_mcp_resource_cmd(struct qed_hwfn *p_hwfn,
 	return rc;
 }
 
-int
+static int
 __qed_mcp_resc_lock(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt,
 		    struct qed_resc_lock_params *p_params)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 101d677..be941cf 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -134,7 +134,7 @@ static bool qed_bmap_is_empty(struct qed_bmap *bmap)
 	return bmap->max_count == find_first_bit(bmap->bitmap, bmap->max_count);
 }
 
-u32 qed_rdma_get_sb_id(void *p_hwfn, u32 rel_sb_id)
+static u32 qed_rdma_get_sb_id(void *p_hwfn, u32 rel_sb_id)
 {
 	/* First sb id for RoCE is after all the l2 sb */
 	return FEAT_NUM((struct qed_hwfn *)p_hwfn, QED_PF_L2_QUE) + rel_sb_id;
@@ -706,7 +706,7 @@ static int qed_rdma_setup(struct qed_hwfn *p_hwfn,
 	return qed_rdma_start_fw(p_hwfn, params, p_ptt);
 }
 
-int qed_rdma_stop(void *rdma_cxt)
+static int qed_rdma_stop(void *rdma_cxt)
 {
 	struct qed_hwfn *p_hwfn = (struct qed_hwfn *)rdma_cxt;
 	struct rdma_close_func_ramrod_data *p_ramrod;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index b5ce158..ada4c18 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -157,7 +157,7 @@ static enum roce_flavor qed_roce_mode_to_flavor(enum roce_mode roce_mode)
 	return flavor;
 }
 
-void qed_roce_free_cid_pair(struct qed_hwfn *p_hwfn, u16 cid)
+static void qed_roce_free_cid_pair(struct qed_hwfn *p_hwfn, u16 cid)
 {
 	spin_lock_bh(&p_hwfn->p_rdma_info->lock);
 	qed_bmap_release_id(p_hwfn, &p_hwfn->p_rdma_info->cid_map, cid);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index 26e918d..9b08a9d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -672,8 +672,8 @@ int qed_iov_hw_info(struct qed_hwfn *p_hwfn)
 	return 0;
 }
 
-bool _qed_iov_pf_sanity_check(struct qed_hwfn *p_hwfn,
-			      int vfid, bool b_fail_malicious)
+static bool _qed_iov_pf_sanity_check(struct qed_hwfn *p_hwfn,
+				     int vfid, bool b_fail_malicious)
 {
 	/* Check PF supports sriov */
 	if (IS_VF(p_hwfn->cdev) || !IS_QED_SRIOV(p_hwfn->cdev) ||
@@ -687,7 +687,7 @@ bool _qed_iov_pf_sanity_check(struct qed_hwfn *p_hwfn,
 	return true;
 }
 
-bool qed_iov_pf_sanity_check(struct qed_hwfn *p_hwfn, int vfid)
+static bool qed_iov_pf_sanity_check(struct qed_hwfn *p_hwfn, int vfid)
 {
 	return _qed_iov_pf_sanity_check(p_hwfn, vfid, true);
 }
@@ -3979,7 +3979,7 @@ static void qed_iov_process_mbx_req(struct qed_hwfn *p_hwfn,
 	}
 }
 
-void qed_iov_pf_get_pending_events(struct qed_hwfn *p_hwfn, u64 *events)
+static void qed_iov_pf_get_pending_events(struct qed_hwfn *p_hwfn, u64 *events)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index be6ddde..3d42696 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -169,7 +169,7 @@ static void qed_vf_pf_add_qid(struct qed_hwfn *p_hwfn,
 	p_qid_tlv->qid = p_cid->qid_usage_idx;
 }
 
-int _qed_vf_pf_release(struct qed_hwfn *p_hwfn, bool b_final)
+static int _qed_vf_pf_release(struct qed_hwfn *p_hwfn, bool b_final)
 {
 	struct qed_vf_iov *p_iov = p_hwfn->vf_iov_info;
 	struct pfvf_def_resp_tlv *resp;
-- 
2.7.0


