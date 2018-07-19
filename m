Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A038ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443A620673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443A620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbeGSPbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731732AbeGSPbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C730C9AAC6888;
        Thu, 19 Jul 2018 22:48:09 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:48:00 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: Use decimal for bit offset macros
Date:   Thu, 19 Jul 2018 15:47:02 +0100
Message-ID: <20180719144706.644-6-salil.mehta@huawei.com>
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

Using hex for bit offsets is inconsistent with the rest
of the file. Change them to decimal.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 24 +++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 940c159..219ffc7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -579,13 +579,13 @@ enum hclge_mac_vlan_tbl_opcode {
 	HCLGE_MAC_VLAN_LKUP,    /* Lookup a entry through mac_vlan key */
 };
 
-#define HCLGE_MAC_VLAN_BIT0_EN_B	0x0
-#define HCLGE_MAC_VLAN_BIT1_EN_B	0x1
-#define HCLGE_MAC_EPORT_SW_EN_B		0xc
-#define HCLGE_MAC_EPORT_TYPE_B		0xb
-#define HCLGE_MAC_EPORT_VFID_S		0x3
+#define HCLGE_MAC_VLAN_BIT0_EN_B	0
+#define HCLGE_MAC_VLAN_BIT1_EN_B	1
+#define HCLGE_MAC_EPORT_SW_EN_B		12
+#define HCLGE_MAC_EPORT_TYPE_B		11
+#define HCLGE_MAC_EPORT_VFID_S		3
 #define HCLGE_MAC_EPORT_VFID_M		GENMASK(10, 3)
-#define HCLGE_MAC_EPORT_PFID_S		0x0
+#define HCLGE_MAC_EPORT_PFID_S		0
 #define HCLGE_MAC_EPORT_PFID_M		GENMASK(2, 0)
 struct hclge_mac_vlan_tbl_entry_cmd {
 	u8	flags;
@@ -601,7 +601,7 @@ struct hclge_mac_vlan_tbl_entry_cmd {
 	u8      rsv2[6];
 };
 
-#define HCLGE_VLAN_MASK_EN_B		0x0
+#define HCLGE_VLAN_MASK_EN_B		0
 struct hclge_mac_vlan_mask_entry_cmd {
 	u8 rsv0[2];
 	u8 vlan_mask;
@@ -632,23 +632,23 @@ struct hclge_mac_mgr_tbl_entry_cmd {
 	u8      rsv3[2];
 };
 
-#define HCLGE_CFG_MTA_MAC_SEL_S		0x0
+#define HCLGE_CFG_MTA_MAC_SEL_S		0
 #define HCLGE_CFG_MTA_MAC_SEL_M		GENMASK(1, 0)
-#define HCLGE_CFG_MTA_MAC_EN_B		0x7
+#define HCLGE_CFG_MTA_MAC_EN_B		7
 struct hclge_mta_filter_mode_cmd {
 	u8	dmac_sel_en; /* Use lowest 2 bit as sel_mode, bit 7 as enable */
 	u8      rsv[23];
 };
 
-#define HCLGE_CFG_FUNC_MTA_ACCEPT_B	0x0
+#define HCLGE_CFG_FUNC_MTA_ACCEPT_B	0
 struct hclge_cfg_func_mta_filter_cmd {
 	u8	accept; /* Only used lowest 1 bit */
 	u8      function_id;
 	u8      rsv[22];
 };
 
-#define HCLGE_CFG_MTA_ITEM_ACCEPT_B	0x0
-#define HCLGE_CFG_MTA_ITEM_IDX_S	0x0
+#define HCLGE_CFG_MTA_ITEM_ACCEPT_B	0
+#define HCLGE_CFG_MTA_ITEM_IDX_S	0
 #define HCLGE_CFG_MTA_ITEM_IDX_M	GENMASK(11, 0)
 struct hclge_cfg_func_mta_item_cmd {
 	__le16	item_idx; /* Only used lowest 12 bit */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b84a140..aeae1ba 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -91,8 +91,8 @@
 #define HCLGE_MISC_RESET_STS_REG	0x20700
 #define HCLGE_MISC_VECTOR_INT_STS	0x20800
 #define HCLGE_GLOBAL_RESET_REG		0x20A00
-#define HCLGE_GLOBAL_RESET_BIT		0x0
-#define HCLGE_CORE_RESET_BIT		0x1
+#define HCLGE_GLOBAL_RESET_BIT		0
+#define HCLGE_CORE_RESET_BIT		1
 #define HCLGE_FUN_RST_ING		0x20C00
 #define HCLGE_FUN_RST_ING_B		0
 
-- 
2.7.4


