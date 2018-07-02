Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F863C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB002592C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB002592C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeGBHUC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:20:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932323AbeGBHTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:19:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AFB8344543669;
        Mon,  2 Jul 2018 15:18:57 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.382.0; Mon, 2 Jul 2018 15:18:52 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH V2 net-next 9/9] net: hns3: modify hnae_ to hnae3_
Date:   Mon, 2 Jul 2018 15:50:26 +0800
Message-ID: <1530517826-69226-10-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
References: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency, prefix hnae_ should be modified to hnae3_.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  28 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  16 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 218 ++++++++-------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   8 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 306 ++++++++++-----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  24 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  38 +--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   8 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  24 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   2 +-
 11 files changed, 343 insertions(+), 336 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 1a02620..0762ad1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -40,13 +40,13 @@ static void hnae3_set_client_init_flag(struct hnae3_client *client,
 {
 	switch (client->type) {
 	case HNAE3_CLIENT_KNIC:
-		hnae_set_bit(ae_dev->flag, HNAE3_KNIC_CLIENT_INITED_B, inited);
+		hnae3_set_bit(ae_dev->flag, HNAE3_KNIC_CLIENT_INITED_B, inited);
 		break;
 	case HNAE3_CLIENT_UNIC:
-		hnae_set_bit(ae_dev->flag, HNAE3_UNIC_CLIENT_INITED_B, inited);
+		hnae3_set_bit(ae_dev->flag, HNAE3_UNIC_CLIENT_INITED_B, inited);
 		break;
 	case HNAE3_CLIENT_ROCE:
-		hnae_set_bit(ae_dev->flag, HNAE3_ROCE_CLIENT_INITED_B, inited);
+		hnae3_set_bit(ae_dev->flag, HNAE3_ROCE_CLIENT_INITED_B, inited);
 		break;
 	default:
 		break;
@@ -60,16 +60,16 @@ static int hnae3_get_client_init_flag(struct hnae3_client *client,
 
 	switch (client->type) {
 	case HNAE3_CLIENT_KNIC:
-		inited = hnae_get_bit(ae_dev->flag,
+		inited = hnae3_get_bit(ae_dev->flag,
 				       HNAE3_KNIC_CLIENT_INITED_B);
 		break;
 	case HNAE3_CLIENT_UNIC:
-		inited = hnae_get_bit(ae_dev->flag,
+		inited = hnae3_get_bit(ae_dev->flag,
 				       HNAE3_UNIC_CLIENT_INITED_B);
 		break;
 	case HNAE3_CLIENT_ROCE:
-		inited = hnae_get_bit(ae_dev->flag,
-				      HNAE3_ROCE_CLIENT_INITED_B);
+		inited = hnae3_get_bit(ae_dev->flag,
+				       HNAE3_ROCE_CLIENT_INITED_B);
 		break;
 	default:
 		break;
@@ -85,7 +85,7 @@ static int hnae3_match_n_instantiate(struct hnae3_client *client,
 
 	/* check if this client matches the type of ae_dev */
 	if (!(hnae3_client_match(client->type, ae_dev->dev_type) &&
-	      hnae_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))) {
+	      hnae3_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))) {
 		return 0;
 	}
 
@@ -190,7 +190,7 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 			continue;
 		}
 
-		hnae_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 1);
+		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 1);
 
 		/* check the client list for the match with this ae_dev type and
 		 * initialize the figure out client instance
@@ -220,7 +220,7 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 	mutex_lock(&hnae3_common_lock);
 	/* Check if there are matched ae_dev */
 	list_for_each_entry(ae_dev, &hnae3_ae_dev_list, node) {
-		if (!hnae_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))
+		if (!hnae3_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))
 			continue;
 
 		id = pci_match_id(ae_algo->pdev_id_table, ae_dev->pdev);
@@ -234,7 +234,7 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 			hnae3_match_n_instantiate(client, ae_dev, false);
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
-		hnae_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
 	}
 
 	list_del(&ae_algo->node);
@@ -278,7 +278,7 @@ void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 			goto out_err;
 		}
 
-		hnae_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 1);
+		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 1);
 		break;
 	}
 
@@ -310,7 +310,7 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 	mutex_lock(&hnae3_common_lock);
 	/* Check if there are matched ae_algo */
 	list_for_each_entry(ae_algo, &hnae3_ae_algo_list, node) {
-		if (!hnae_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))
+		if (!hnae3_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B))
 			continue;
 
 		id = pci_match_id(ae_algo->pdev_id_table, ae_dev->pdev);
@@ -321,7 +321,7 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 			hnae3_match_n_instantiate(client, ae_dev, false);
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
-		hnae_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
 	}
 
 	list_del(&ae_dev->node);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 422c56b..da806fd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -62,10 +62,10 @@
 		BIT(HNAE3_DEV_SUPPORT_ROCE_B))
 
 #define hnae3_dev_roce_supported(hdev) \
-	hnae_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B)
+	hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B)
 
 #define hnae3_dev_dcb_supported(hdev) \
-	hnae_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_DCB_B)
+	hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_DCB_B)
 
 #define ring_ptr_move_fw(ring, p) \
 	((ring)->p = ((ring)->p + 1) % (ring)->desc_num)
@@ -507,17 +507,17 @@ struct hnae3_handle {
 	u32 numa_node_mask;	/* for multi-chip support */
 };
 
-#define hnae_set_field(origin, mask, shift, val) \
+#define hnae3_set_field(origin, mask, shift, val) \
 	do { \
 		(origin) &= (~(mask)); \
 		(origin) |= ((val) << (shift)) & (mask); \
 	} while (0)
-#define hnae_get_field(origin, mask, shift) (((origin) & (mask)) >> (shift))
+#define hnae3_get_field(origin, mask, shift) (((origin) & (mask)) >> (shift))
 
-#define hnae_set_bit(origin, shift, val) \
-	hnae_set_field((origin), (0x1 << (shift)), (shift), (val))
-#define hnae_get_bit(origin, shift) \
-	hnae_get_field((origin), (0x1 << (shift)), (shift))
+#define hnae3_set_bit(origin, shift, val) \
+	hnae3_set_field((origin), (0x1 << (shift)), (shift), (val))
+#define hnae3_get_bit(origin, shift) \
+	hnae3_get_field((origin), (0x1 << (shift)), (shift))
 
 void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev);
 void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 8fce363..7e34d5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -493,8 +493,8 @@ static int hns3_set_tso(struct sk_buff *skb, u32 *paylen,
 
 	/* find the txbd field values */
 	*paylen = skb->len - hdr_len;
-	hnae_set_bit(*type_cs_vlan_tso,
-		     HNS3_TXD_TSO_B, 1);
+	hnae3_set_bit(*type_cs_vlan_tso,
+		      HNS3_TXD_TSO_B, 1);
 
 	/* get MSS for TSO */
 	*mss = skb_shinfo(skb)->gso_size;
@@ -586,21 +586,21 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 
 	/* compute L2 header size for normal packet, defined in 2 Bytes */
 	l2_len = l3.hdr - skb->data;
-	hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_M,
-		       HNS3_TXD_L2LEN_S, l2_len >> 1);
+	hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_M,
+			HNS3_TXD_L2LEN_S, l2_len >> 1);
 
 	/* tunnel packet*/
 	if (skb->encapsulation) {
 		/* compute OL2 header size, defined in 2 Bytes */
 		ol2_len = l2_len;
-		hnae_set_field(*ol_type_vlan_len_msec,
-			       HNS3_TXD_L2LEN_M,
-			       HNS3_TXD_L2LEN_S, ol2_len >> 1);
+		hnae3_set_field(*ol_type_vlan_len_msec,
+				HNS3_TXD_L2LEN_M,
+				HNS3_TXD_L2LEN_S, ol2_len >> 1);
 
 		/* compute OL3 header size, defined in 4 Bytes */
 		ol3_len = l4.hdr - l3.hdr;
-		hnae_set_field(*ol_type_vlan_len_msec, HNS3_TXD_L3LEN_M,
-			       HNS3_TXD_L3LEN_S, ol3_len >> 2);
+		hnae3_set_field(*ol_type_vlan_len_msec, HNS3_TXD_L3LEN_M,
+				HNS3_TXD_L3LEN_S, ol3_len >> 2);
 
 		/* MAC in UDP, MAC in GRE (0x6558)*/
 		if ((ol4_proto == IPPROTO_UDP) || (ol4_proto == IPPROTO_GRE)) {
@@ -609,16 +609,17 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 
 			/* compute OL4 header size, defined in 4 Bytes. */
 			ol4_len = l2_hdr - l4.hdr;
-			hnae_set_field(*ol_type_vlan_len_msec, HNS3_TXD_L4LEN_M,
-				       HNS3_TXD_L4LEN_S, ol4_len >> 2);
+			hnae3_set_field(*ol_type_vlan_len_msec,
+					HNS3_TXD_L4LEN_M, HNS3_TXD_L4LEN_S,
+					ol4_len >> 2);
 
 			/* switch IP header ptr from outer to inner header */
 			l3.hdr = skb_inner_network_header(skb);
 
 			/* compute inner l2 header size, defined in 2 Bytes. */
 			l2_len = l3.hdr - l2_hdr;
-			hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_M,
-				       HNS3_TXD_L2LEN_S, l2_len >> 1);
+			hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L2LEN_M,
+					HNS3_TXD_L2LEN_S, l2_len >> 1);
 		} else {
 			/* skb packet types not supported by hardware,
 			 * txbd len fild doesn't be filled.
@@ -634,22 +635,24 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 
 	/* compute inner(/normal) L3 header size, defined in 4 Bytes */
 	l3_len = l4.hdr - l3.hdr;
-	hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L3LEN_M,
-		       HNS3_TXD_L3LEN_S, l3_len >> 2);
+	hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3LEN_M,
+			HNS3_TXD_L3LEN_S, l3_len >> 2);
 
 	/* compute inner(/normal) L4 header size, defined in 4 Bytes */
 	switch (l4_proto) {
 	case IPPROTO_TCP:
-		hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
-			       HNS3_TXD_L4LEN_S, l4.tcp->doff);
+		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
+				HNS3_TXD_L4LEN_S, l4.tcp->doff);
 		break;
 	case IPPROTO_SCTP:
-		hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
-			       HNS3_TXD_L4LEN_S, (sizeof(struct sctphdr) >> 2));
+		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
+				HNS3_TXD_L4LEN_S,
+				(sizeof(struct sctphdr) >> 2));
 		break;
 	case IPPROTO_UDP:
-		hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
-			       HNS3_TXD_L4LEN_S, (sizeof(struct udphdr) >> 2));
+		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L4LEN_M,
+				HNS3_TXD_L4LEN_S,
+				(sizeof(struct udphdr) >> 2));
 		break;
 	default:
 		/* skb packet types not supported by hardware,
@@ -703,32 +706,34 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 		/* define outer network header type.*/
 		if (skb->protocol == htons(ETH_P_IP)) {
 			if (skb_is_gso(skb))
-				hnae_set_field(*ol_type_vlan_len_msec,
-					       HNS3_TXD_OL3T_M, HNS3_TXD_OL3T_S,
-					       HNS3_OL3T_IPV4_CSUM);
+				hnae3_set_field(*ol_type_vlan_len_msec,
+						HNS3_TXD_OL3T_M,
+						HNS3_TXD_OL3T_S,
+						HNS3_OL3T_IPV4_CSUM);
 			else
-				hnae_set_field(*ol_type_vlan_len_msec,
-					       HNS3_TXD_OL3T_M, HNS3_TXD_OL3T_S,
-					       HNS3_OL3T_IPV4_NO_CSUM);
+				hnae3_set_field(*ol_type_vlan_len_msec,
+						HNS3_TXD_OL3T_M,
+						HNS3_TXD_OL3T_S,
+						HNS3_OL3T_IPV4_NO_CSUM);
 
 		} else if (skb->protocol == htons(ETH_P_IPV6)) {
-			hnae_set_field(*ol_type_vlan_len_msec, HNS3_TXD_OL3T_M,
-				       HNS3_TXD_OL3T_S, HNS3_OL3T_IPV6);
+			hnae3_set_field(*ol_type_vlan_len_msec, HNS3_TXD_OL3T_M,
+					HNS3_TXD_OL3T_S, HNS3_OL3T_IPV6);
 		}
 
 		/* define tunnel type(OL4).*/
 		switch (l4_proto) {
 		case IPPROTO_UDP:
-			hnae_set_field(*ol_type_vlan_len_msec,
-				       HNS3_TXD_TUNTYPE_M,
-				       HNS3_TXD_TUNTYPE_S,
-				       HNS3_TUN_MAC_IN_UDP);
+			hnae3_set_field(*ol_type_vlan_len_msec,
+					HNS3_TXD_TUNTYPE_M,
+					HNS3_TXD_TUNTYPE_S,
+					HNS3_TUN_MAC_IN_UDP);
 			break;
 		case IPPROTO_GRE:
-			hnae_set_field(*ol_type_vlan_len_msec,
-				       HNS3_TXD_TUNTYPE_M,
-				       HNS3_TXD_TUNTYPE_S,
-				       HNS3_TUN_NVGRE);
+			hnae3_set_field(*ol_type_vlan_len_msec,
+					HNS3_TXD_TUNTYPE_M,
+					HNS3_TXD_TUNTYPE_S,
+					HNS3_TUN_NVGRE);
 			break;
 		default:
 			/* drop the skb tunnel packet if hardware don't support,
@@ -749,43 +754,43 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 	}
 
 	if (l3.v4->version == 4) {
-		hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
-			       HNS3_TXD_L3T_S, HNS3_L3T_IPV4);
+		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
+				HNS3_TXD_L3T_S, HNS3_L3T_IPV4);
 
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
 		if (skb_is_gso(skb))
-			hnae_set_bit(*type_cs_vlan_tso, HNS3_TXD_L3CS_B, 1);
+			hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L3CS_B, 1);
 
-		hnae_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
+		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 	} else if (l3.v6->version == 6) {
-		hnae_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
-			       HNS3_TXD_L3T_S, HNS3_L3T_IPV6);
-		hnae_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
+		hnae3_set_field(*type_cs_vlan_tso, HNS3_TXD_L3T_M,
+				HNS3_TXD_L3T_S, HNS3_L3T_IPV6);
+		hnae3_set_bit(*type_cs_vlan_tso, HNS3_TXD_L4CS_B, 1);
 	}
 
 	switch (l4_proto) {
 	case IPPROTO_TCP:
-		hnae_set_field(*type_cs_vlan_tso,
-			       HNS3_TXD_L4T_M,
-			       HNS3_TXD_L4T_S,
-			       HNS3_L4T_TCP);
+		hnae3_set_field(*type_cs_vlan_tso,
+				HNS3_TXD_L4T_M,
+				HNS3_TXD_L4T_S,
+				HNS3_L4T_TCP);
 		break;
 	case IPPROTO_UDP:
 		if (hns3_tunnel_csum_bug(skb))
 			break;
 
-		hnae_set_field(*type_cs_vlan_tso,
-			       HNS3_TXD_L4T_M,
-			       HNS3_TXD_L4T_S,
-			       HNS3_L4T_UDP);
+		hnae3_set_field(*type_cs_vlan_tso,
+				HNS3_TXD_L4T_M,
+				HNS3_TXD_L4T_S,
+				HNS3_L4T_UDP);
 		break;
 	case IPPROTO_SCTP:
-		hnae_set_field(*type_cs_vlan_tso,
-			       HNS3_TXD_L4T_M,
-			       HNS3_TXD_L4T_S,
-			       HNS3_L4T_SCTP);
+		hnae3_set_field(*type_cs_vlan_tso,
+				HNS3_TXD_L4T_M,
+				HNS3_TXD_L4T_S,
+				HNS3_L4T_SCTP);
 		break;
 	default:
 		/* drop the skb tunnel packet if hardware don't support,
@@ -807,11 +812,11 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 static void hns3_set_txbd_baseinfo(u16 *bdtp_fe_sc_vld_ra_ri, int frag_end)
 {
 	/* Config bd buffer end */
-	hnae_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_BDTYPE_M,
-		       HNS3_TXD_BDTYPE_S, 0);
-	hnae_set_bit(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_FE_B, !!frag_end);
-	hnae_set_bit(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_VLD_B, 1);
-	hnae_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_SC_M, HNS3_TXD_SC_S, 0);
+	hnae3_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_BDTYPE_M,
+			HNS3_TXD_BDTYPE_S, 0);
+	hnae3_set_bit(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_FE_B, !!frag_end);
+	hnae3_set_bit(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_VLD_B, 1);
+	hnae3_set_field(*bdtp_fe_sc_vld_ra_ri, HNS3_TXD_SC_M, HNS3_TXD_SC_S, 0);
 }
 
 static int hns3_fill_desc_vtags(struct sk_buff *skb,
@@ -844,10 +849,10 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 		 * and use inner_vtag in one tag case.
 		 */
 		if (skb->protocol == htons(ETH_P_8021Q)) {
-			hnae_set_bit(*out_vlan_flag, HNS3_TXD_OVLAN_B, 1);
+			hnae3_set_bit(*out_vlan_flag, HNS3_TXD_OVLAN_B, 1);
 			*out_vtag = vlan_tag;
 		} else {
-			hnae_set_bit(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
+			hnae3_set_bit(*inner_vlan_flag, HNS3_TXD_VLAN_B, 1);
 			*inner_vtag = vlan_tag;
 		}
 	} else if (skb->protocol == htons(ETH_P_8021Q)) {
@@ -1135,7 +1140,7 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	wmb(); /* Commit all data before submit */
 
-	hnae_queue_xmit(ring->tqp, buf_num);
+	hnae3_queue_xmit(ring->tqp, buf_num);
 
 	return NETDEV_TX_OK;
 
@@ -1703,7 +1708,7 @@ static void hns3_set_default_feature(struct net_device *netdev)
 static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
 			     struct hns3_desc_cb *cb)
 {
-	unsigned int order = hnae_page_order(ring);
+	unsigned int order = hnae3_page_order(ring);
 	struct page *p;
 
 	p = dev_alloc_pages(order);
@@ -1714,7 +1719,7 @@ static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
 	cb->page_offset = 0;
 	cb->reuse_flag = 0;
 	cb->buf  = page_address(p);
-	cb->length = hnae_page_size(ring);
+	cb->length = hnae3_page_size(ring);
 	cb->type = DESC_TYPE_PAGE;
 
 	return 0;
@@ -1881,7 +1886,7 @@ static void hns3_nic_reclaim_one_desc(struct hns3_enet_ring *ring, int *bytes,
 
 	(*pkts) += (desc_cb->type == DESC_TYPE_SKB);
 	(*bytes) += desc_cb->length;
-	/* desc_cb will be cleaned, after hnae_free_buffer_detach*/
+	/* desc_cb will be cleaned, after hnae3_free_buffer_detach*/
 	hns3_free_buffer_detach(ring, ring->next_to_clean);
 
 	ring_ptr_move_fw(ring, next_to_clean);
@@ -2010,15 +2015,15 @@ static void hns3_nic_reuse_page(struct sk_buff *skb, int i,
 	bool twobufs;
 
 	twobufs = ((PAGE_SIZE < 8192) &&
-		hnae_buf_size(ring) == HNS3_BUFFER_SIZE_2048);
+		hnae3_buf_size(ring) == HNS3_BUFFER_SIZE_2048);
 
 	desc = &ring->desc[ring->next_to_clean];
 	size = le16_to_cpu(desc->rx.size);
 
-	truesize = hnae_buf_size(ring);
+	truesize = hnae3_buf_size(ring);
 
 	if (!twobufs)
-		last_offset = hnae_page_size(ring) - hnae_buf_size(ring);
+		last_offset = hnae3_page_size(ring) - hnae3_buf_size(ring);
 
 	skb_add_rx_frag(skb, i, desc_cb->priv, desc_cb->page_offset + pull_len,
 			size - pull_len, truesize);
@@ -2070,13 +2075,13 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		return;
 
 	/* check if hardware has done checksum */
-	if (!hnae_get_bit(bd_base_info, HNS3_RXD_L3L4P_B))
+	if (!hnae3_get_bit(bd_base_info, HNS3_RXD_L3L4P_B))
 		return;
 
-	if (unlikely(hnae_get_bit(l234info, HNS3_RXD_L3E_B) ||
-		     hnae_get_bit(l234info, HNS3_RXD_L4E_B) ||
-		     hnae_get_bit(l234info, HNS3_RXD_OL3E_B) ||
-		     hnae_get_bit(l234info, HNS3_RXD_OL4E_B))) {
+	if (unlikely(hnae3_get_bit(l234info, HNS3_RXD_L3E_B) ||
+		     hnae3_get_bit(l234info, HNS3_RXD_L4E_B) ||
+		     hnae3_get_bit(l234info, HNS3_RXD_OL3E_B) ||
+		     hnae3_get_bit(l234info, HNS3_RXD_OL4E_B))) {
 		netdev_err(netdev, "L3/L4 error pkt\n");
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.l3l4_csum_err++;
@@ -2085,12 +2090,13 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		return;
 	}
 
-	l3_type = hnae_get_field(l234info, HNS3_RXD_L3ID_M,
-				 HNS3_RXD_L3ID_S);
-	l4_type = hnae_get_field(l234info, HNS3_RXD_L4ID_M,
-				 HNS3_RXD_L4ID_S);
+	l3_type = hnae3_get_field(l234info, HNS3_RXD_L3ID_M,
+				  HNS3_RXD_L3ID_S);
+	l4_type = hnae3_get_field(l234info, HNS3_RXD_L4ID_M,
+				  HNS3_RXD_L4ID_S);
 
-	ol4_type = hnae_get_field(l234info, HNS3_RXD_OL4ID_M, HNS3_RXD_OL4ID_S);
+	ol4_type = hnae3_get_field(l234info, HNS3_RXD_OL4ID_M,
+				   HNS3_RXD_OL4ID_S);
 	switch (ol4_type) {
 	case HNS3_OL4_TYPE_MAC_IN_UDP:
 	case HNS3_OL4_TYPE_NVGRE:
@@ -2129,8 +2135,8 @@ static u16 hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 #define HNS3_STRP_OUTER_VLAN	0x1
 #define HNS3_STRP_INNER_VLAN	0x2
 
-	switch (hnae_get_field(l234info, HNS3_RXD_STRP_TAGP_M,
-			       HNS3_RXD_STRP_TAGP_S)) {
+	switch (hnae3_get_field(l234info, HNS3_RXD_STRP_TAGP_M,
+				HNS3_RXD_STRP_TAGP_S)) {
 	case HNS3_STRP_OUTER_VLAN:
 		vlan_tag = le16_to_cpu(desc->rx.ot_vlan_tag);
 		break;
@@ -2168,7 +2174,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
 
 	/* Check valid BD */
-	if (unlikely(!hnae_get_bit(bd_base_info, HNS3_RXD_VLD_B)))
+	if (unlikely(!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B)))
 		return -EFAULT;
 
 	va = (unsigned char *)desc_cb->buf + desc_cb->page_offset;
@@ -2223,7 +2229,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 		hns3_nic_reuse_page(skb, 0, ring, pull_len, desc_cb);
 		ring_ptr_move_fw(ring, next_to_clean);
 
-		while (!hnae_get_bit(bd_base_info, HNS3_RXD_FE_B)) {
+		while (!hnae3_get_bit(bd_base_info, HNS3_RXD_FE_B)) {
 			desc = &ring->desc[ring->next_to_clean];
 			desc_cb = &ring->desc_cb[ring->next_to_clean];
 			bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
@@ -2251,7 +2257,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 					       vlan_tag);
 	}
 
-	if (unlikely(!hnae_get_bit(bd_base_info, HNS3_RXD_VLD_B))) {
+	if (unlikely(!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B))) {
 		netdev_err(netdev, "no valid bd,%016llx,%016llx\n",
 			   ((u64 *)desc)[0], ((u64 *)desc)[1]);
 		u64_stats_update_begin(&ring->syncp);
@@ -2263,7 +2269,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	}
 
 	if (unlikely((!desc->rx.pkt_len) ||
-		     hnae_get_bit(l234info, HNS3_RXD_TRUNCAT_B))) {
+		     hnae3_get_bit(l234info, HNS3_RXD_TRUNCAT_B))) {
 		netdev_err(netdev, "truncated pkt\n");
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.err_pkt_len++;
@@ -2273,7 +2279,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 		return -EFAULT;
 	}
 
-	if (unlikely(hnae_get_bit(l234info, HNS3_RXD_L2E_B))) {
+	if (unlikely(hnae3_get_bit(l234info, HNS3_RXD_L2E_B))) {
 		netdev_err(netdev, "L2 error pkt\n");
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.l2_err++;
@@ -2526,10 +2532,10 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 	tx_ring = tqp_vector->tx_group.ring;
 	if (tx_ring) {
 		cur_chain->tqp_index = tx_ring->tqp->tqp_index;
-		hnae_set_bit(cur_chain->flag, HNAE3_RING_TYPE_B,
-			     HNAE3_RING_TYPE_TX);
-		hnae_set_field(cur_chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
-			       HNAE3_RING_GL_IDX_S, HNAE3_RING_GL_TX);
+		hnae3_set_bit(cur_chain->flag, HNAE3_RING_TYPE_B,
+			      HNAE3_RING_TYPE_TX);
+		hnae3_set_field(cur_chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
+				HNAE3_RING_GL_IDX_S, HNAE3_RING_GL_TX);
 
 		cur_chain->next = NULL;
 
@@ -2543,12 +2549,12 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 
 			cur_chain->next = chain;
 			chain->tqp_index = tx_ring->tqp->tqp_index;
-			hnae_set_bit(chain->flag, HNAE3_RING_TYPE_B,
-				     HNAE3_RING_TYPE_TX);
-			hnae_set_field(chain->int_gl_idx,
-				       HNAE3_RING_GL_IDX_M,
-				       HNAE3_RING_GL_IDX_S,
-				       HNAE3_RING_GL_TX);
+			hnae3_set_bit(chain->flag, HNAE3_RING_TYPE_B,
+				      HNAE3_RING_TYPE_TX);
+			hnae3_set_field(chain->int_gl_idx,
+					HNAE3_RING_GL_IDX_M,
+					HNAE3_RING_GL_IDX_S,
+					HNAE3_RING_GL_TX);
 
 			cur_chain = chain;
 		}
@@ -2558,10 +2564,10 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 	if (!tx_ring && rx_ring) {
 		cur_chain->next = NULL;
 		cur_chain->tqp_index = rx_ring->tqp->tqp_index;
-		hnae_set_bit(cur_chain->flag, HNAE3_RING_TYPE_B,
-			     HNAE3_RING_TYPE_RX);
-		hnae_set_field(cur_chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
-			       HNAE3_RING_GL_IDX_S, HNAE3_RING_GL_RX);
+		hnae3_set_bit(cur_chain->flag, HNAE3_RING_TYPE_B,
+			      HNAE3_RING_TYPE_RX);
+		hnae3_set_field(cur_chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
+				HNAE3_RING_GL_IDX_S, HNAE3_RING_GL_RX);
 
 		rx_ring = rx_ring->next;
 	}
@@ -2573,10 +2579,10 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 
 		cur_chain->next = chain;
 		chain->tqp_index = rx_ring->tqp->tqp_index;
-		hnae_set_bit(chain->flag, HNAE3_RING_TYPE_B,
-			     HNAE3_RING_TYPE_RX);
-		hnae_set_field(chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
-			       HNAE3_RING_GL_IDX_S, HNAE3_RING_GL_RX);
+		hnae3_set_bit(chain->flag, HNAE3_RING_TYPE_B,
+			      HNAE3_RING_TYPE_RX);
+		hnae3_set_field(chain->int_gl_idx, HNAE3_RING_GL_IDX_M,
+				HNAE3_RING_GL_IDX_S, HNAE3_RING_GL_RX);
 
 		cur_chain = chain;
 
@@ -2799,7 +2805,7 @@ static int hns3_ring_get_cfg(struct hnae3_queue *q, struct hns3_nic_priv *priv,
 		ring->io_base = q->io_base;
 	}
 
-	hnae_set_bit(ring->flag, HNAE3_RING_TYPE_B, ring_type);
+	hnae3_set_bit(ring->flag, HNAE3_RING_TYPE_B, ring_type);
 
 	ring->tqp = q;
 	ring->desc = NULL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 8d6096c..bf9aa02 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -590,7 +590,7 @@ static inline void hns3_write_reg(void __iomem *base, u32 reg, u32 value)
 #define hns3_write_dev(a, reg, value) \
 	hns3_write_reg((a)->io_base, (reg), (value))
 
-#define hnae_queue_xmit(tqp, buf_num) writel_relaxed(buf_num, \
+#define hnae3_queue_xmit(tqp, buf_num) writel_relaxed(buf_num, \
 		(tqp)->io_base + HNS3_RING_TX_RING_TAIL_REG)
 
 #define ring_to_dev(ring) (&(ring)->tqp->handle->pdev->dev)
@@ -600,9 +600,9 @@ static inline void hns3_write_reg(void __iomem *base, u32 reg, u32 value)
 
 #define tx_ring_data(priv, idx) ((priv)->ring_data[idx])
 
-#define hnae_buf_size(_ring) ((_ring)->buf_size)
-#define hnae_page_order(_ring) (get_order(hnae_buf_size(_ring)))
-#define hnae_page_size(_ring) (PAGE_SIZE << hnae_page_order(_ring))
+#define hnae3_buf_size(_ring) ((_ring)->buf_size)
+#define hnae3_page_order(_ring) (get_order(hnae3_buf_size(_ring)))
+#define hnae3_page_size(_ring) (PAGE_SIZE << hnae3_page_order(_ring))
 
 /* iterator for handling rings in ring group */
 #define hns3_for_each_ring(pos, head) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2a0cd70..6fffc69 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -939,8 +939,8 @@ static int hclge_query_pf_resource(struct hclge_dev *hdev)
 
 	if (hnae3_dev_roce_supported(hdev)) {
 		hdev->num_roce_msi =
-		hnae_get_field(__le16_to_cpu(req->pf_intr_vector_number),
-			       HCLGE_PF_VEC_NUM_M, HCLGE_PF_VEC_NUM_S);
+		hnae3_get_field(__le16_to_cpu(req->pf_intr_vector_number),
+				HCLGE_PF_VEC_NUM_M, HCLGE_PF_VEC_NUM_S);
 
 		/* PF should have NIC vectors and Roce vectors,
 		 * NIC vectors are queued before Roce vectors.
@@ -948,8 +948,8 @@ static int hclge_query_pf_resource(struct hclge_dev *hdev)
 		hdev->num_msi = hdev->num_roce_msi  + HCLGE_ROCE_VECTOR_OFFSET;
 	} else {
 		hdev->num_msi =
-		hnae_get_field(__le16_to_cpu(req->pf_intr_vector_number),
-			       HCLGE_PF_VEC_NUM_M, HCLGE_PF_VEC_NUM_S);
+		hnae3_get_field(__le16_to_cpu(req->pf_intr_vector_number),
+				HCLGE_PF_VEC_NUM_M, HCLGE_PF_VEC_NUM_S);
 	}
 
 	return 0;
@@ -1038,38 +1038,38 @@ static void hclge_parse_cfg(struct hclge_cfg *cfg, struct hclge_desc *desc)
 	req = (struct hclge_cfg_param_cmd *)desc[0].data;
 
 	/* get the configuration */
-	cfg->vmdq_vport_num = hnae_get_field(__le32_to_cpu(req->param[0]),
-					     HCLGE_CFG_VMDQ_M,
-					     HCLGE_CFG_VMDQ_S);
-	cfg->tc_num = hnae_get_field(__le32_to_cpu(req->param[0]),
-				     HCLGE_CFG_TC_NUM_M, HCLGE_CFG_TC_NUM_S);
-	cfg->tqp_desc_num = hnae_get_field(__le32_to_cpu(req->param[0]),
-					   HCLGE_CFG_TQP_DESC_N_M,
-					   HCLGE_CFG_TQP_DESC_N_S);
-
-	cfg->phy_addr = hnae_get_field(__le32_to_cpu(req->param[1]),
-				       HCLGE_CFG_PHY_ADDR_M,
-				       HCLGE_CFG_PHY_ADDR_S);
-	cfg->media_type = hnae_get_field(__le32_to_cpu(req->param[1]),
-					 HCLGE_CFG_MEDIA_TP_M,
-					 HCLGE_CFG_MEDIA_TP_S);
-	cfg->rx_buf_len = hnae_get_field(__le32_to_cpu(req->param[1]),
-					 HCLGE_CFG_RX_BUF_LEN_M,
-					 HCLGE_CFG_RX_BUF_LEN_S);
+	cfg->vmdq_vport_num = hnae3_get_field(__le32_to_cpu(req->param[0]),
+					      HCLGE_CFG_VMDQ_M,
+					      HCLGE_CFG_VMDQ_S);
+	cfg->tc_num = hnae3_get_field(__le32_to_cpu(req->param[0]),
+				      HCLGE_CFG_TC_NUM_M, HCLGE_CFG_TC_NUM_S);
+	cfg->tqp_desc_num = hnae3_get_field(__le32_to_cpu(req->param[0]),
+					    HCLGE_CFG_TQP_DESC_N_M,
+					    HCLGE_CFG_TQP_DESC_N_S);
+
+	cfg->phy_addr = hnae3_get_field(__le32_to_cpu(req->param[1]),
+					HCLGE_CFG_PHY_ADDR_M,
+					HCLGE_CFG_PHY_ADDR_S);
+	cfg->media_type = hnae3_get_field(__le32_to_cpu(req->param[1]),
+					  HCLGE_CFG_MEDIA_TP_M,
+					  HCLGE_CFG_MEDIA_TP_S);
+	cfg->rx_buf_len = hnae3_get_field(__le32_to_cpu(req->param[1]),
+					  HCLGE_CFG_RX_BUF_LEN_M,
+					  HCLGE_CFG_RX_BUF_LEN_S);
 	/* get mac_address */
 	mac_addr_tmp = __le32_to_cpu(req->param[2]);
-	mac_addr_tmp_high = hnae_get_field(__le32_to_cpu(req->param[3]),
-					   HCLGE_CFG_MAC_ADDR_H_M,
-					   HCLGE_CFG_MAC_ADDR_H_S);
+	mac_addr_tmp_high = hnae3_get_field(__le32_to_cpu(req->param[3]),
+					    HCLGE_CFG_MAC_ADDR_H_M,
+					    HCLGE_CFG_MAC_ADDR_H_S);
 
 	mac_addr_tmp |= (mac_addr_tmp_high << 31) << 1;
 
-	cfg->default_speed = hnae_get_field(__le32_to_cpu(req->param[3]),
-					    HCLGE_CFG_DEFAULT_SPEED_M,
-					    HCLGE_CFG_DEFAULT_SPEED_S);
-	cfg->rss_size_max = hnae_get_field(__le32_to_cpu(req->param[3]),
-					   HCLGE_CFG_RSS_SIZE_M,
-					   HCLGE_CFG_RSS_SIZE_S);
+	cfg->default_speed = hnae3_get_field(__le32_to_cpu(req->param[3]),
+					     HCLGE_CFG_DEFAULT_SPEED_M,
+					     HCLGE_CFG_DEFAULT_SPEED_S);
+	cfg->rss_size_max = hnae3_get_field(__le32_to_cpu(req->param[3]),
+					    HCLGE_CFG_RSS_SIZE_M,
+					    HCLGE_CFG_RSS_SIZE_S);
 
 	for (i = 0; i < ETH_ALEN; i++)
 		cfg->mac_addr[i] = (mac_addr_tmp >> (8 * i)) & 0xff;
@@ -1077,9 +1077,9 @@ static void hclge_parse_cfg(struct hclge_cfg *cfg, struct hclge_desc *desc)
 	req = (struct hclge_cfg_param_cmd *)desc[1].data;
 	cfg->numa_node_map = __le32_to_cpu(req->param[0]);
 
-	cfg->speed_ability = hnae_get_field(__le32_to_cpu(req->param[1]),
-					    HCLGE_CFG_SPEED_ABILITY_M,
-					    HCLGE_CFG_SPEED_ABILITY_S);
+	cfg->speed_ability = hnae3_get_field(__le32_to_cpu(req->param[1]),
+					     HCLGE_CFG_SPEED_ABILITY_M,
+					     HCLGE_CFG_SPEED_ABILITY_S);
 }
 
 /* hclge_get_cfg: query the static parameter from flash
@@ -1098,11 +1098,11 @@ static int hclge_get_cfg(struct hclge_dev *hdev, struct hclge_cfg *hcfg)
 		req = (struct hclge_cfg_param_cmd *)desc[i].data;
 		hclge_cmd_setup_basic_desc(&desc[i], HCLGE_OPC_GET_CFG_PARAM,
 					   true);
-		hnae_set_field(offset, HCLGE_CFG_OFFSET_M,
-			       HCLGE_CFG_OFFSET_S, i * HCLGE_CFG_RD_LEN_BYTES);
+		hnae3_set_field(offset, HCLGE_CFG_OFFSET_M,
+				HCLGE_CFG_OFFSET_S, i * HCLGE_CFG_RD_LEN_BYTES);
 		/* Len should be united by 4 bytes when send to hardware */
-		hnae_set_field(offset, HCLGE_CFG_RD_LEN_M, HCLGE_CFG_RD_LEN_S,
-			       HCLGE_CFG_RD_LEN_BYTES / HCLGE_CFG_RD_LEN_UNIT);
+		hnae3_set_field(offset, HCLGE_CFG_RD_LEN_M, HCLGE_CFG_RD_LEN_S,
+				HCLGE_CFG_RD_LEN_BYTES / HCLGE_CFG_RD_LEN_UNIT);
 		req->offset = cpu_to_le32(offset);
 	}
 
@@ -1189,7 +1189,7 @@ static int hclge_configure(struct hclge_dev *hdev)
 
 	/* Currently not support uncontiuous tc */
 	for (i = 0; i < hdev->tm_info.num_tc; i++)
-		hnae_set_bit(hdev->hw_tc_map, i, 1);
+		hnae3_set_bit(hdev->hw_tc_map, i, 1);
 
 	hdev->tx_sch_mode = HCLGE_FLAG_TC_BASE_SCH_MODE;
 
@@ -1208,13 +1208,13 @@ static int hclge_config_tso(struct hclge_dev *hdev, int tso_mss_min,
 	req = (struct hclge_cfg_tso_status_cmd *)desc.data;
 
 	tso_mss = 0;
-	hnae_set_field(tso_mss, HCLGE_TSO_MSS_MIN_M,
-		       HCLGE_TSO_MSS_MIN_S, tso_mss_min);
+	hnae3_set_field(tso_mss, HCLGE_TSO_MSS_MIN_M,
+			HCLGE_TSO_MSS_MIN_S, tso_mss_min);
 	req->tso_mss_min = cpu_to_le16(tso_mss);
 
 	tso_mss = 0;
-	hnae_set_field(tso_mss, HCLGE_TSO_MSS_MIN_M,
-		       HCLGE_TSO_MSS_MIN_S, tso_mss_max);
+	hnae3_set_field(tso_mss, HCLGE_TSO_MSS_MIN_M,
+			HCLGE_TSO_MSS_MIN_S, tso_mss_max);
 	req->tso_mss_max = cpu_to_le16(tso_mss);
 
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2118,48 +2118,48 @@ int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex)
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_SPEED_DUP, false);
 
-	hnae_set_bit(req->speed_dup, HCLGE_CFG_DUPLEX_B, !!duplex);
+	hnae3_set_bit(req->speed_dup, HCLGE_CFG_DUPLEX_B, !!duplex);
 
 	switch (speed) {
 	case HCLGE_MAC_SPEED_10M:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 6);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 6);
 		break;
 	case HCLGE_MAC_SPEED_100M:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 7);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 7);
 		break;
 	case HCLGE_MAC_SPEED_1G:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 0);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 0);
 		break;
 	case HCLGE_MAC_SPEED_10G:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 1);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 1);
 		break;
 	case HCLGE_MAC_SPEED_25G:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 2);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 2);
 		break;
 	case HCLGE_MAC_SPEED_40G:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 3);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 3);
 		break;
 	case HCLGE_MAC_SPEED_50G:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 4);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 4);
 		break;
 	case HCLGE_MAC_SPEED_100G:
-		hnae_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
-			       HCLGE_CFG_SPEED_S, 5);
+		hnae3_set_field(req->speed_dup, HCLGE_CFG_SPEED_M,
+				HCLGE_CFG_SPEED_S, 5);
 		break;
 	default:
 		dev_err(&hdev->pdev->dev, "invalid speed (%d)\n", speed);
 		return -EINVAL;
 	}
 
-	hnae_set_bit(req->mac_change_fec_en, HCLGE_CFG_MAC_SPEED_CHANGE_EN_B,
-		     1);
+	hnae3_set_bit(req->mac_change_fec_en, HCLGE_CFG_MAC_SPEED_CHANGE_EN_B,
+		      1);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
@@ -2201,9 +2201,9 @@ static int hclge_query_mac_an_speed_dup(struct hclge_dev *hdev, int *speed,
 		return ret;
 	}
 
-	*duplex = hnae_get_bit(req->an_syn_dup_speed, HCLGE_QUERY_DUPLEX_B);
-	speed_tmp = hnae_get_field(req->an_syn_dup_speed, HCLGE_QUERY_SPEED_M,
-				   HCLGE_QUERY_SPEED_S);
+	*duplex = hnae3_get_bit(req->an_syn_dup_speed, HCLGE_QUERY_DUPLEX_B);
+	speed_tmp = hnae3_get_field(req->an_syn_dup_speed, HCLGE_QUERY_SPEED_M,
+				    HCLGE_QUERY_SPEED_S);
 
 	ret = hclge_parse_speed(speed_tmp, speed);
 	if (ret) {
@@ -2225,7 +2225,7 @@ static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_AN_MODE, false);
 
 	req = (struct hclge_config_auto_neg_cmd *)desc.data;
-	hnae_set_bit(flag, HCLGE_MAC_CFG_AN_EN_B, !!enable);
+	hnae3_set_bit(flag, HCLGE_MAC_CFG_AN_EN_B, !!enable);
 	req->cfg_an_cmd_flag = cpu_to_le32(flag);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2269,8 +2269,8 @@ static int hclge_set_default_mac_vlan_mask(struct hclge_dev *hdev,
 	req = (struct hclge_mac_vlan_mask_entry_cmd *)desc.data;
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MAC_VLAN_MASK_SET, false);
 
-	hnae_set_bit(req->vlan_mask, HCLGE_VLAN_MASK_EN_B,
-		     mask_vlan ? 1 : 0);
+	hnae3_set_bit(req->vlan_mask, HCLGE_VLAN_MASK_EN_B,
+		      mask_vlan ? 1 : 0);
 	ether_addr_copy(req->mac_mask, mac_mask);
 
 	status = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2711,7 +2711,7 @@ static int hclge_reset_wait(struct hclge_dev *hdev)
 	}
 
 	val = hclge_read_dev(&hdev->hw, reg);
-	while (hnae_get_bit(val, reg_bit) && cnt < HCLGE_RESET_WAIT_CNT) {
+	while (hnae3_get_bit(val, reg_bit) && cnt < HCLGE_RESET_WAIT_CNT) {
 		msleep(HCLGE_RESET_WATI_MS);
 		val = hclge_read_dev(&hdev->hw, reg);
 		cnt++;
@@ -2733,7 +2733,7 @@ int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id)
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_RST_TRIGGER, false);
-	hnae_set_bit(req->mac_func_reset, HCLGE_CFG_RESET_FUNC_B, 1);
+	hnae3_set_bit(req->mac_func_reset, HCLGE_CFG_RESET_FUNC_B, 1);
 	req->fun_reset_vfid = func_id;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2752,13 +2752,13 @@ static void hclge_do_reset(struct hclge_dev *hdev)
 	switch (hdev->reset_type) {
 	case HNAE3_GLOBAL_RESET:
 		val = hclge_read_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG);
-		hnae_set_bit(val, HCLGE_GLOBAL_RESET_BIT, 1);
+		hnae3_set_bit(val, HCLGE_GLOBAL_RESET_BIT, 1);
 		hclge_write_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG, val);
 		dev_info(&pdev->dev, "Global Reset requested\n");
 		break;
 	case HNAE3_CORE_RESET:
 		val = hclge_read_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG);
-		hnae_set_bit(val, HCLGE_CORE_RESET_BIT, 1);
+		hnae3_set_bit(val, HCLGE_CORE_RESET_BIT, 1);
 		hclge_write_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG, val);
 		dev_info(&pdev->dev, "Core Reset requested\n");
 		break;
@@ -3115,11 +3115,11 @@ static int hclge_set_rss_tc_mode(struct hclge_dev *hdev, u16 *tc_valid,
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
 		u16 mode = 0;
 
-		hnae_set_bit(mode, HCLGE_RSS_TC_VALID_B, (tc_valid[i] & 0x1));
-		hnae_set_field(mode, HCLGE_RSS_TC_SIZE_M,
-			       HCLGE_RSS_TC_SIZE_S, tc_size[i]);
-		hnae_set_field(mode, HCLGE_RSS_TC_OFFSET_M,
-			       HCLGE_RSS_TC_OFFSET_S, tc_offset[i]);
+		hnae3_set_bit(mode, HCLGE_RSS_TC_VALID_B, (tc_valid[i] & 0x1));
+		hnae3_set_field(mode, HCLGE_RSS_TC_SIZE_M,
+				HCLGE_RSS_TC_SIZE_S, tc_size[i]);
+		hnae3_set_field(mode, HCLGE_RSS_TC_OFFSET_M,
+				HCLGE_RSS_TC_OFFSET_S, tc_offset[i]);
 
 		req->rss_tc_mode[i] = cpu_to_le16(mode);
 	}
@@ -3496,16 +3496,16 @@ int hclge_bind_ring_with_vector(struct hclge_vport *vport,
 	i = 0;
 	for (node = ring_chain; node; node = node->next) {
 		tqp_type_and_id = le16_to_cpu(req->tqp_type_and_id[i]);
-		hnae_set_field(tqp_type_and_id,  HCLGE_INT_TYPE_M,
-			       HCLGE_INT_TYPE_S,
-			       hnae_get_bit(node->flag, HNAE3_RING_TYPE_B));
-		hnae_set_field(tqp_type_and_id, HCLGE_TQP_ID_M,
-			       HCLGE_TQP_ID_S, node->tqp_index);
-		hnae_set_field(tqp_type_and_id, HCLGE_INT_GL_IDX_M,
-			       HCLGE_INT_GL_IDX_S,
-			       hnae_get_field(node->int_gl_idx,
-					      HNAE3_RING_GL_IDX_M,
-					      HNAE3_RING_GL_IDX_S));
+		hnae3_set_field(tqp_type_and_id,  HCLGE_INT_TYPE_M,
+				HCLGE_INT_TYPE_S,
+				hnae3_get_bit(node->flag, HNAE3_RING_TYPE_B));
+		hnae3_set_field(tqp_type_and_id, HCLGE_TQP_ID_M,
+				HCLGE_TQP_ID_S, node->tqp_index);
+		hnae3_set_field(tqp_type_and_id, HCLGE_INT_GL_IDX_M,
+				HCLGE_INT_GL_IDX_S,
+				hnae3_get_field(node->int_gl_idx,
+						HNAE3_RING_GL_IDX_M,
+						HNAE3_RING_GL_IDX_S));
 		req->tqp_type_and_id[i] = cpu_to_le16(tqp_type_and_id);
 		if (++i >= HCLGE_VECTOR_ELEMENTS_PER_CMD) {
 			req->int_cause_num = HCLGE_VECTOR_ELEMENTS_PER_CMD;
@@ -3653,20 +3653,20 @@ static void hclge_cfg_mac_mode(struct hclge_dev *hdev, bool enable)
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_MAC_MODE, false);
-	hnae_set_bit(loop_en, HCLGE_MAC_TX_EN_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_RX_EN_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_PAD_TX_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_PAD_RX_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_1588_TX_B, 0);
-	hnae_set_bit(loop_en, HCLGE_MAC_1588_RX_B, 0);
-	hnae_set_bit(loop_en, HCLGE_MAC_APP_LP_B, 0);
-	hnae_set_bit(loop_en, HCLGE_MAC_LINE_LP_B, 0);
-	hnae_set_bit(loop_en, HCLGE_MAC_FCS_TX_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_RX_FCS_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_RX_FCS_STRIP_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_TX_OVERSIZE_TRUNCATE_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_RX_OVERSIZE_TRUNCATE_B, enable);
-	hnae_set_bit(loop_en, HCLGE_MAC_TX_UNDER_MIN_ERR_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_TX_EN_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_RX_EN_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_PAD_TX_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_PAD_RX_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_1588_TX_B, 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_1588_RX_B, 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_APP_LP_B, 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_LINE_LP_B, 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_FCS_TX_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_RX_FCS_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_RX_FCS_STRIP_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_TX_OVERSIZE_TRUNCATE_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_RX_OVERSIZE_TRUNCATE_B, enable);
+	hnae3_set_bit(loop_en, HCLGE_MAC_TX_UNDER_MIN_ERR_B, enable);
 	req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -3694,7 +3694,7 @@ static int hclge_set_mac_loopback(struct hclge_dev *hdev, bool en)
 
 	/* 2 Then setup the loopback flag */
 	loop_en = le32_to_cpu(req->txrx_pad_fcs_loop_en);
-	hnae_set_bit(loop_en, HCLGE_MAC_APP_LP_B, en ? 1 : 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_APP_LP_B, en ? 1 : 0);
 
 	req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
 
@@ -3958,10 +3958,10 @@ static int hclge_set_mta_filter_mode(struct hclge_dev *hdev,
 	req = (struct hclge_mta_filter_mode_cmd *)desc.data;
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MTA_MAC_MODE_CFG, false);
 
-	hnae_set_bit(req->dmac_sel_en, HCLGE_CFG_MTA_MAC_EN_B,
-		     enable);
-	hnae_set_field(req->dmac_sel_en, HCLGE_CFG_MTA_MAC_SEL_M,
-		       HCLGE_CFG_MTA_MAC_SEL_S, mta_mac_sel);
+	hnae3_set_bit(req->dmac_sel_en, HCLGE_CFG_MTA_MAC_EN_B,
+		      enable);
+	hnae3_set_field(req->dmac_sel_en, HCLGE_CFG_MTA_MAC_SEL_M,
+			HCLGE_CFG_MTA_MAC_SEL_S, mta_mac_sel);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
@@ -3985,8 +3985,8 @@ int hclge_cfg_func_mta_filter(struct hclge_dev *hdev,
 	req = (struct hclge_cfg_func_mta_filter_cmd *)desc.data;
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MTA_MAC_FUNC_CFG, false);
 
-	hnae_set_bit(req->accept, HCLGE_CFG_FUNC_MTA_ACCEPT_B,
-		     enable);
+	hnae3_set_bit(req->accept, HCLGE_CFG_FUNC_MTA_ACCEPT_B,
+		      enable);
 	req->function_id = func_id;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -4012,10 +4012,10 @@ static int hclge_set_mta_table_item(struct hclge_vport *vport,
 
 	req = (struct hclge_cfg_func_mta_item_cmd *)desc.data;
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MTA_TBL_ITEM_CFG, false);
-	hnae_set_bit(req->accept, HCLGE_CFG_MTA_ITEM_ACCEPT_B, enable);
+	hnae3_set_bit(req->accept, HCLGE_CFG_MTA_ITEM_ACCEPT_B, enable);
 
-	hnae_set_field(item_idx, HCLGE_CFG_MTA_ITEM_IDX_M,
-		       HCLGE_CFG_MTA_ITEM_IDX_S, idx);
+	hnae3_set_field(item_idx, HCLGE_CFG_MTA_ITEM_IDX_M,
+			HCLGE_CFG_MTA_ITEM_IDX_S, idx);
 	req->item_idx = cpu_to_le16(item_idx);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -4262,10 +4262,10 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 	}
 
 	memset(&req, 0, sizeof(req));
-	hnae_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
+	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 
-	hnae_set_field(egress_port, HCLGE_MAC_EPORT_VFID_M,
-		       HCLGE_MAC_EPORT_VFID_S, vport->vport_id);
+	hnae3_set_field(egress_port, HCLGE_MAC_EPORT_VFID_M,
+			HCLGE_MAC_EPORT_VFID_S, vport->vport_id);
 
 	req.egress_port = cpu_to_le16(egress_port);
 
@@ -4316,8 +4316,8 @@ int hclge_rm_uc_addr_common(struct hclge_vport *vport,
 	}
 
 	memset(&req, 0, sizeof(req));
-	hnae_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
+	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hclge_prepare_mac_addr(&req, addr);
 	ret = hclge_remove_mac_vlan_tbl(vport, &req);
 
@@ -4349,10 +4349,10 @@ int hclge_add_mc_addr_common(struct hclge_vport *vport,
 		return -EINVAL;
 	}
 	memset(&req, 0, sizeof(req));
-	hnae_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
+	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
+	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hclge_prepare_mac_addr(&req, addr);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
@@ -4416,10 +4416,10 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	}
 
 	memset(&req, 0, sizeof(req));
-	hnae_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
-	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
+	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
+	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hclge_prepare_mac_addr(&req, addr);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
@@ -4800,19 +4800,19 @@ static int hclge_set_vlan_tx_offload_cfg(struct hclge_vport *vport)
 	req = (struct hclge_vport_vtag_tx_cfg_cmd *)desc.data;
 	req->def_vlan_tag1 = cpu_to_le16(vcfg->default_tag1);
 	req->def_vlan_tag2 = cpu_to_le16(vcfg->default_tag2);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG1_B,
-			vcfg->accept_tag1 ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG1_B,
-			vcfg->accept_untag1 ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG2_B,
-			vcfg->accept_tag2 ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG2_B,
-			vcfg->accept_untag2 ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_PORT_INS_TAG1_EN_B,
-		     vcfg->insert_tag1_en ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_PORT_INS_TAG2_EN_B,
-		     vcfg->insert_tag2_en ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_CFG_NIC_ROCE_SEL_B, 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG1_B,
+		      vcfg->accept_tag1 ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG1_B,
+		      vcfg->accept_untag1 ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_TAG2_B,
+		      vcfg->accept_tag2 ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_ACCEPT_UNTAG2_B,
+		      vcfg->accept_untag2 ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_PORT_INS_TAG1_EN_B,
+		      vcfg->insert_tag1_en ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_PORT_INS_TAG2_EN_B,
+		      vcfg->insert_tag2_en ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_CFG_NIC_ROCE_SEL_B, 0);
 
 	req->vf_offset = vport->vport_id / HCLGE_VF_NUM_PER_CMD;
 	req->vf_bitmap[req->vf_offset] =
@@ -4838,14 +4838,14 @@ static int hclge_set_vlan_rx_offload_cfg(struct hclge_vport *vport)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_VLAN_PORT_RX_CFG, false);
 
 	req = (struct hclge_vport_vtag_rx_cfg_cmd *)desc.data;
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_REM_TAG1_EN_B,
-		     vcfg->strip_tag1_en ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_REM_TAG2_EN_B,
-		     vcfg->strip_tag2_en ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_SHOW_TAG1_EN_B,
-		     vcfg->vlan1_vlan_prionly ? 1 : 0);
-	hnae_set_bit(req->vport_vlan_cfg, HCLGE_SHOW_TAG2_EN_B,
-		     vcfg->vlan2_vlan_prionly ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_REM_TAG1_EN_B,
+		      vcfg->strip_tag1_en ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_REM_TAG2_EN_B,
+		      vcfg->strip_tag2_en ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_SHOW_TAG1_EN_B,
+		      vcfg->vlan1_vlan_prionly ? 1 : 0);
+	hnae3_set_bit(req->vport_vlan_cfg, HCLGE_SHOW_TAG2_EN_B,
+		      vcfg->vlan2_vlan_prionly ? 1 : 0);
 
 	req->vf_offset = vport->vport_id / HCLGE_VF_NUM_PER_CMD;
 	req->vf_bitmap[req->vf_offset] =
@@ -5041,7 +5041,7 @@ static int hclge_send_reset_tqp_cmd(struct hclge_dev *hdev, u16 queue_id,
 
 	req = (struct hclge_reset_tqp_queue_cmd *)desc.data;
 	req->tqp_id = cpu_to_le16(queue_id & HCLGE_RING_ID_MASK);
-	hnae_set_bit(req->reset_req, HCLGE_TQP_RESET_B, enable);
+	hnae3_set_bit(req->reset_req, HCLGE_TQP_RESET_B, enable);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
@@ -5071,7 +5071,7 @@ static int hclge_get_reset_status(struct hclge_dev *hdev, u16 queue_id)
 		return ret;
 	}
 
-	return hnae_get_bit(req->ready_to_reset, HCLGE_TQP_RESET_B);
+	return hnae3_get_bit(req->ready_to_reset, HCLGE_TQP_RESET_B);
 }
 
 static u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle,
@@ -5378,12 +5378,12 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 	phy_write(phydev, HCLGE_PHY_PAGE_REG, HCLGE_PHY_PAGE_MDIX);
 
 	retval = phy_read(phydev, HCLGE_PHY_CSC_REG);
-	mdix_ctrl = hnae_get_field(retval, HCLGE_PHY_MDIX_CTRL_M,
-				   HCLGE_PHY_MDIX_CTRL_S);
+	mdix_ctrl = hnae3_get_field(retval, HCLGE_PHY_MDIX_CTRL_M,
+				    HCLGE_PHY_MDIX_CTRL_S);
 
 	retval = phy_read(phydev, HCLGE_PHY_CSS_REG);
-	mdix = hnae_get_bit(retval, HCLGE_PHY_MDIX_STATUS_B);
-	is_resolved = hnae_get_bit(retval, HCLGE_PHY_SPEED_DUP_RESOLVE_B);
+	mdix = hnae3_get_bit(retval, HCLGE_PHY_MDIX_STATUS_B);
+	is_resolved = hnae3_get_bit(retval, HCLGE_PHY_SPEED_DUP_RESOLVE_B);
 
 	phy_write(phydev, HCLGE_PHY_PAGE_REG, HCLGE_PHY_PAGE_COPPER);
 
@@ -6156,8 +6156,8 @@ static int hclge_set_led_status(struct hclge_dev *hdev, u8 locate_led_status)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_LED_STATUS_CFG, false);
 
 	req = (struct hclge_set_led_state_cmd *)desc.data;
-	hnae_set_field(req->locate_led_config, HCLGE_LED_LOCATE_STATE_M,
-		       HCLGE_LED_LOCATE_STATE_S, locate_led_status);
+	hnae3_set_field(req->locate_led_config, HCLGE_LED_LOCATE_STATE_M,
+			HCLGE_LED_LOCATE_STATE_S, locate_led_status);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 7541cb9..50ae2f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -128,12 +128,12 @@ static int hclge_get_ring_chain_from_mbx(
 		HCLGE_MBX_RING_NODE_VARIABLE_NUM))
 		return -ENOMEM;
 
-	hnae_set_bit(ring_chain->flag, HNAE3_RING_TYPE_B, req->msg[3]);
+	hnae3_set_bit(ring_chain->flag, HNAE3_RING_TYPE_B, req->msg[3]);
 	ring_chain->tqp_index =
 			hclge_get_queue_id(vport->nic.kinfo.tqp[req->msg[4]]);
-	hnae_set_field(ring_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
-		       HCLGE_INT_GL_IDX_S,
-		       req->msg[5]);
+	hnae3_set_field(ring_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
+			HCLGE_INT_GL_IDX_S,
+			req->msg[5]);
 
 	cur_chain = ring_chain;
 
@@ -142,19 +142,19 @@ static int hclge_get_ring_chain_from_mbx(
 		if (!new_chain)
 			goto err;
 
-		hnae_set_bit(new_chain->flag, HNAE3_RING_TYPE_B,
-			     req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
-			     HCLGE_MBX_RING_MAP_BASIC_MSG_NUM]);
+		hnae3_set_bit(new_chain->flag, HNAE3_RING_TYPE_B,
+			      req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
+			      HCLGE_MBX_RING_MAP_BASIC_MSG_NUM]);
 
 		new_chain->tqp_index =
 		hclge_get_queue_id(vport->nic.kinfo.tqp
 			[req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
 			HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 1]]);
 
-		hnae_set_field(new_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
-			       HCLGE_INT_GL_IDX_S,
-			       req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
-			       HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 2]);
+		hnae3_set_field(new_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
+				HCLGE_INT_GL_IDX_S,
+				req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
+				HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 2]);
 
 		cur_chain->next = new_chain;
 		cur_chain = new_chain;
@@ -460,7 +460,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
-		if (unlikely(!hnae_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B))) {
+		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B))) {
 			dev_warn(&hdev->pdev->dev,
 				 "dropped invalid mailbox message, code = %d\n",
 				 req->msg[0]);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 9f7932e42..b6cfe6f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -67,16 +67,16 @@ static int hclge_mdio_write(struct mii_bus *bus, int phyid, int regnum,
 
 	mdio_cmd = (struct hclge_mdio_cfg_cmd *)desc.data;
 
-	hnae_set_field(mdio_cmd->phyid, HCLGE_MDIO_PHYID_M,
-		       HCLGE_MDIO_PHYID_S, phyid);
-	hnae_set_field(mdio_cmd->phyad, HCLGE_MDIO_PHYREG_M,
-		       HCLGE_MDIO_PHYREG_S, regnum);
+	hnae3_set_field(mdio_cmd->phyid, HCLGE_MDIO_PHYID_M,
+			HCLGE_MDIO_PHYID_S, phyid);
+	hnae3_set_field(mdio_cmd->phyad, HCLGE_MDIO_PHYREG_M,
+			HCLGE_MDIO_PHYREG_S, regnum);
 
-	hnae_set_bit(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_START_B, 1);
-	hnae_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_ST_M,
-		       HCLGE_MDIO_CTRL_ST_S, 1);
-	hnae_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_OP_M,
-		       HCLGE_MDIO_CTRL_OP_S, HCLGE_MDIO_C22_WRITE);
+	hnae3_set_bit(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_START_B, 1);
+	hnae3_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_ST_M,
+			HCLGE_MDIO_CTRL_ST_S, 1);
+	hnae3_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_OP_M,
+			HCLGE_MDIO_CTRL_OP_S, HCLGE_MDIO_C22_WRITE);
 
 	mdio_cmd->data_wr = cpu_to_le16(data);
 
@@ -105,16 +105,16 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 
 	mdio_cmd = (struct hclge_mdio_cfg_cmd *)desc.data;
 
-	hnae_set_field(mdio_cmd->phyid, HCLGE_MDIO_PHYID_M,
-		       HCLGE_MDIO_PHYID_S, phyid);
-	hnae_set_field(mdio_cmd->phyad, HCLGE_MDIO_PHYREG_M,
-		       HCLGE_MDIO_PHYREG_S, regnum);
+	hnae3_set_field(mdio_cmd->phyid, HCLGE_MDIO_PHYID_M,
+			HCLGE_MDIO_PHYID_S, phyid);
+	hnae3_set_field(mdio_cmd->phyad, HCLGE_MDIO_PHYREG_M,
+			HCLGE_MDIO_PHYREG_S, regnum);
 
-	hnae_set_bit(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_START_B, 1);
-	hnae_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_ST_M,
-		       HCLGE_MDIO_CTRL_ST_S, 1);
-	hnae_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_OP_M,
-		       HCLGE_MDIO_CTRL_OP_S, HCLGE_MDIO_C22_READ);
+	hnae3_set_bit(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_START_B, 1);
+	hnae3_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_ST_M,
+			HCLGE_MDIO_CTRL_ST_S, 1);
+	hnae3_set_field(mdio_cmd->ctrl_bit, HCLGE_MDIO_CTRL_OP_M,
+			HCLGE_MDIO_CTRL_OP_S, HCLGE_MDIO_C22_READ);
 
 	/* Read out phy data */
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -125,7 +125,7 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 		return ret;
 	}
 
-	if (hnae_get_bit(le16_to_cpu(mdio_cmd->sta), HCLGE_MDIO_STA_B)) {
+	if (hnae3_get_bit(le16_to_cpu(mdio_cmd->sta), HCLGE_MDIO_STA_B)) {
 		dev_err(&hdev->pdev->dev, "mdio read data error\n");
 		return -EIO;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 262c125..82bc30f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1184,10 +1184,10 @@ static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
 			u16 qs_id = vport->qs_offset + tc;
 			u8 grp, sub_grp;
 
-			grp = hnae_get_field(qs_id, HCLGE_BP_GRP_ID_M,
-					     HCLGE_BP_GRP_ID_S);
-			sub_grp = hnae_get_field(qs_id, HCLGE_BP_SUB_GRP_ID_M,
-						 HCLGE_BP_SUB_GRP_ID_S);
+			grp = hnae3_get_field(qs_id, HCLGE_BP_GRP_ID_M,
+					      HCLGE_BP_GRP_ID_S);
+			sub_grp = hnae3_get_field(qs_id, HCLGE_BP_SUB_GRP_ID_M,
+						  HCLGE_BP_SUB_GRP_ID_S);
 			if (i == grp)
 				qs_bitmap |= (1 << sub_grp);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index c2b6e8a..c82d49e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -123,10 +123,11 @@ struct hclge_port_shapping_cmd {
 };
 
 #define hclge_tm_set_field(dest, string, val) \
-			hnae_set_field((dest), (HCLGE_TM_SHAP_##string##_MSK), \
-				       (HCLGE_TM_SHAP_##string##_LSH), val)
+			   hnae3_set_field((dest), \
+			   (HCLGE_TM_SHAP_##string##_MSK), \
+			   (HCLGE_TM_SHAP_##string##_LSH), val)
 #define hclge_tm_get_field(src, string) \
-			hnae_get_field((src), (HCLGE_TM_SHAP_##string##_MSK), \
+			hnae3_get_field((src), (HCLGE_TM_SHAP_##string##_MSK), \
 				       (HCLGE_TM_SHAP_##string##_LSH))
 
 int hclge_tm_schd_init(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 1638193..5a86532 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -450,12 +450,12 @@ static int hclgevf_set_rss_tc_mode(struct hclgevf_dev *hdev,  u16 rss_size)
 
 	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_RSS_TC_MODE, false);
 	for (i = 0; i < HCLGEVF_MAX_TC_NUM; i++) {
-		hnae_set_bit(req->rss_tc_mode[i], HCLGEVF_RSS_TC_VALID_B,
-			     (tc_valid[i] & 0x1));
-		hnae_set_field(req->rss_tc_mode[i], HCLGEVF_RSS_TC_SIZE_M,
-			       HCLGEVF_RSS_TC_SIZE_S, tc_size[i]);
-		hnae_set_field(req->rss_tc_mode[i], HCLGEVF_RSS_TC_OFFSET_M,
-			       HCLGEVF_RSS_TC_OFFSET_S, tc_offset[i]);
+		hnae3_set_bit(req->rss_tc_mode[i], HCLGEVF_RSS_TC_VALID_B,
+			      (tc_valid[i] & 0x1));
+		hnae3_set_field(req->rss_tc_mode[i], HCLGEVF_RSS_TC_SIZE_M,
+				HCLGEVF_RSS_TC_SIZE_S, tc_size[i]);
+		hnae3_set_field(req->rss_tc_mode[i], HCLGEVF_RSS_TC_OFFSET_M,
+				HCLGEVF_RSS_TC_OFFSET_S, tc_offset[i]);
 	}
 	status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
 	if (status)
@@ -582,11 +582,11 @@ static int hclgevf_bind_ring_to_vector(struct hnae3_handle *handle, bool en,
 		}
 
 		req->msg[idx_offset] =
-				hnae_get_bit(node->flag, HNAE3_RING_TYPE_B);
+				hnae3_get_bit(node->flag, HNAE3_RING_TYPE_B);
 		req->msg[idx_offset + 1] = node->tqp_index;
-		req->msg[idx_offset + 2] = hnae_get_field(node->int_gl_idx,
-							  HNAE3_RING_GL_IDX_M,
-							  HNAE3_RING_GL_IDX_S);
+		req->msg[idx_offset + 2] = hnae3_get_field(node->int_gl_idx,
+							   HNAE3_RING_GL_IDX_M,
+							   HNAE3_RING_GL_IDX_S);
 
 		i++;
 		if ((i == (HCLGE_MBX_VF_MSG_DATA_NUM -
@@ -1000,8 +1000,8 @@ static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
 
 	/* wait to check the hardware reset completion status */
 	val = hclgevf_read_dev(&hdev->hw, HCLGEVF_FUN_RST_ING);
-	while (hnae_get_bit(val, HCLGEVF_FUN_RST_ING_B) &&
-			    (cnt < HCLGEVF_RESET_WAIT_CNT)) {
+	while (hnae3_get_bit(val, HCLGEVF_FUN_RST_ING_B) &&
+	       (cnt < HCLGEVF_RESET_WAIT_CNT)) {
 		msleep(HCLGEVF_RESET_WAIT_MS);
 		val = hclgevf_read_dev(&hdev->hw, HCLGEVF_FUN_RST_ING);
 		cnt++;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index b598c06..173ca27 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -152,7 +152,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		req = (struct hclge_mbx_pf_to_vf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
-		if (unlikely(!hnae_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B))) {
+		if (unlikely(!hnae3_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B))) {
 			dev_warn(&hdev->pdev->dev,
 				 "dropped invalid mailbox message, code = %d\n",
 				 req->msg[0]);
-- 
1.9.1

