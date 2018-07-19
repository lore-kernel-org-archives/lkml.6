Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2229ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5DE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5DE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeGSPbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731918AbeGSPbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADF70F7A1C220;
        Thu, 19 Jul 2018 22:48:04 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:47:57 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 4/9] net: hns3: Correct unreasonable code comments
Date:   Thu, 19 Jul 2018 15:47:01 +0100
Message-ID: <20180719144706.644-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719144706.644-1-salil.mehta@huawei.com>
References: <20180719144706.644-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch fixes some comment spelling errors, removes
redundant comments, rewrites misleading comments, and
adds some necessary comments.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 33 ++++++++++------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 13 +++++----
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index e66a762..940c159 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -71,7 +71,7 @@ struct hclge_misc_vector {
 struct hclge_cmq {
 	struct hclge_cmq_ring csq;
 	struct hclge_cmq_ring crq;
-	u16 tx_timeout; /* Tx timeout */
+	u16 tx_timeout;
 	enum hclge_cmd_status last_status;
 };
 
@@ -90,7 +90,7 @@ struct hclge_cmq {
 #define HCLGE_CMD_FLAG_ERR_INTR	BIT(HCLGE_CMD_FLAG_ERR_INTR_SHIFT)
 
 enum hclge_opcode_type {
-	/* Generic command */
+	/* Generic commands */
 	HCLGE_OPC_QUERY_FW_VER		= 0x0001,
 	HCLGE_OPC_CFG_RST_TRIGGER	= 0x0020,
 	HCLGE_OPC_GBL_RST_STATUS	= 0x0021,
@@ -106,18 +106,16 @@ enum hclge_opcode_type {
 	HCLGE_OPC_QUERY_REG_NUM		= 0x0040,
 	HCLGE_OPC_QUERY_32_BIT_REG	= 0x0041,
 	HCLGE_OPC_QUERY_64_BIT_REG	= 0x0042,
-	/* Device management command */
 
-	/* MAC commond */
+	/* MAC command */
 	HCLGE_OPC_CONFIG_MAC_MODE	= 0x0301,
 	HCLGE_OPC_CONFIG_AN_MODE	= 0x0304,
 	HCLGE_OPC_QUERY_AN_RESULT	= 0x0306,
 	HCLGE_OPC_QUERY_LINK_STATUS	= 0x0307,
 	HCLGE_OPC_CONFIG_MAX_FRM_SIZE	= 0x0308,
 	HCLGE_OPC_CONFIG_SPEED_DUP	= 0x0309,
-	/* MACSEC command */
 
-	/* PFC/Pause CMD*/
+	/* PFC/Pause commands */
 	HCLGE_OPC_CFG_MAC_PAUSE_EN      = 0x0701,
 	HCLGE_OPC_CFG_PFC_PAUSE_EN      = 0x0702,
 	HCLGE_OPC_CFG_MAC_PARA          = 0x0703,
@@ -148,7 +146,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_TM_QS_SCH_MODE_CFG    = 0x0814,
 	HCLGE_OPC_TM_BP_TO_QSET_MAPPING = 0x0815,
 
-	/* Packet buffer allocate command */
+	/* Packet buffer allocate commands */
 	HCLGE_OPC_TX_BUFF_ALLOC		= 0x0901,
 	HCLGE_OPC_RX_PRIV_BUFF_ALLOC	= 0x0902,
 	HCLGE_OPC_RX_PRIV_WL_ALLOC	= 0x0903,
@@ -156,11 +154,10 @@ enum hclge_opcode_type {
 	HCLGE_OPC_RX_COM_WL_ALLOC	= 0x0905,
 	HCLGE_OPC_RX_GBL_PKT_CNT	= 0x0906,
 
-	/* PTP command */
 	/* TQP management command */
 	HCLGE_OPC_SET_TQP_MAP		= 0x0A01,
 
-	/* TQP command */
+	/* TQP commands */
 	HCLGE_OPC_CFG_TX_QUEUE		= 0x0B01,
 	HCLGE_OPC_QUERY_TX_POINTER	= 0x0B02,
 	HCLGE_OPC_QUERY_TX_STATUS	= 0x0B03,
@@ -172,10 +169,10 @@ enum hclge_opcode_type {
 	HCLGE_OPC_CFG_COM_TQP_QUEUE	= 0x0B20,
 	HCLGE_OPC_RESET_TQP_QUEUE	= 0x0B22,
 
-	/* TSO cmd */
+	/* TSO command */
 	HCLGE_OPC_TSO_GENERIC_CONFIG	= 0x0C01,
 
-	/* RSS cmd */
+	/* RSS commands */
 	HCLGE_OPC_RSS_GENERIC_CONFIG	= 0x0D01,
 	HCLGE_OPC_RSS_INDIR_TABLE	= 0x0D07,
 	HCLGE_OPC_RSS_TC_MODE		= 0x0D08,
@@ -184,15 +181,15 @@ enum hclge_opcode_type {
 	/* Promisuous mode command */
 	HCLGE_OPC_CFG_PROMISC_MODE	= 0x0E01,
 
-	/* Vlan offload command */
+	/* Vlan offload commands */
 	HCLGE_OPC_VLAN_PORT_TX_CFG	= 0x0F01,
 	HCLGE_OPC_VLAN_PORT_RX_CFG	= 0x0F02,
 
-	/* Interrupts cmd */
+	/* Interrupts commands */
 	HCLGE_OPC_ADD_RING_TO_VECTOR	= 0x1503,
 	HCLGE_OPC_DEL_RING_TO_VECTOR	= 0x1504,
 
-	/* MAC command */
+	/* MAC commands */
 	HCLGE_OPC_MAC_VLAN_ADD		    = 0x1000,
 	HCLGE_OPC_MAC_VLAN_REMOVE	    = 0x1001,
 	HCLGE_OPC_MAC_VLAN_TYPE_ID	    = 0x1002,
@@ -201,13 +198,13 @@ enum hclge_opcode_type {
 	HCLGE_OPC_MAC_ETHTYPE_REMOVE	= 0x1011,
 	HCLGE_OPC_MAC_VLAN_MASK_SET	= 0x1012,
 
-	/* Multicast linear table cmd */
+	/* Multicast linear table commands */
 	HCLGE_OPC_MTA_MAC_MODE_CFG	    = 0x1020,
 	HCLGE_OPC_MTA_MAC_FUNC_CFG	    = 0x1021,
 	HCLGE_OPC_MTA_TBL_ITEM_CFG	    = 0x1022,
 	HCLGE_OPC_MTA_TBL_ITEM_QUERY	= 0x1023,
 
-	/* VLAN command */
+	/* VLAN commands */
 	HCLGE_OPC_VLAN_FILTER_CTRL	    = 0x1100,
 	HCLGE_OPC_VLAN_FILTER_PF_CFG	= 0x1101,
 	HCLGE_OPC_VLAN_FILTER_VF_CFG	= 0x1102,
@@ -215,7 +212,7 @@ enum hclge_opcode_type {
 	/* MDIO command */
 	HCLGE_OPC_MDIO_CONFIG		= 0x1900,
 
-	/* QCN command */
+	/* QCN commands */
 	HCLGE_OPC_QCN_MOD_CFG		= 0x1A01,
 	HCLGE_OPC_QCN_GRP_TMPLT_CFG	= 0x1A02,
 	HCLGE_OPC_QCN_SHAPPING_IR_CFG	= 0x1A03,
@@ -225,7 +222,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_QCN_AJUST_INIT	= 0x1A07,
 	HCLGE_OPC_QCN_DFX_CNT_STATUS    = 0x1A08,
 
-	/* Mailbox cmd */
+	/* Mailbox command */
 	HCLGEVF_OPC_MBX_PF_TO_VF	= 0x2000,
 
 	/* Led command */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b097988..de36dfb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5866,6 +5866,7 @@ static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
 	u32 *rss_indir;
 	int ret, i;
 
+	/* Free old tqps, and reallocate with new tqp number when nic setup */
 	hclge_release_tqp(vport);
 
 	ret = hclge_knic_setup(vport, new_tqps_num);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b01a51d..b84a140 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -203,7 +203,10 @@ struct hlcge_tqp_stats {
 };
 
 struct hclge_tqp {
-	struct device *dev;	/* Device for DMA mapping */
+	/* copy of device pointer from pci_dev,
+	 * used when perform DMA mapping
+	 */
+	struct device *dev;
 	struct hnae3_queue q;
 	struct hlcge_tqp_stats tqp_stats;
 	u16 index;	/* Global index in a NIC controller */
@@ -493,13 +496,11 @@ struct hclge_dev {
 	u16 num_tqps;			/* Num task queue pairs of this PF */
 	u16 num_req_vfs;		/* Num VFs requested for this PF */
 
-	/* Base task tqp physical id of this PF */
-	u16 base_tqp_pid;
+	u16 base_tqp_pid;	/* Base task tqp physical id of this PF */
 	u16 alloc_rss_size;		/* Allocated RSS task queue */
 	u16 rss_size_max;		/* HW defined max RSS task queue */
 
-	/* Num of guaranteed filters for this PF */
-	u16 fdir_pf_filter_count;
+	u16 fdir_pf_filter_count; /* Num of guaranteed filters for this PF */
 	u16 num_alloc_vport;		/* Num vports this driver supports */
 	u32 numa_node_mask;
 	u16 rx_buf_len;
@@ -561,7 +562,7 @@ struct hclge_dev {
 	u32 mps; /* Max packet size */
 
 	enum hclge_mta_dmac_sel_type mta_mac_sel_type;
-	bool enable_mta; /* Mutilcast filter enable */
+	bool enable_mta; /* Multicast filter enable */
 
 	struct hclge_vlan_type_cfg vlan_type_cfg;
 
-- 
2.7.4


