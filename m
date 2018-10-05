Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA3DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D652098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D652098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeJFAEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:04:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728900AbeJFAEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:04:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 241F1FB978EA1;
        Sat,  6 Oct 2018 01:04:34 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sat, 6 Oct 2018 01:04:25 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Zhongzhu Liu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 1/6] net: hns3: Remove the default mask configuration for mac vlan table
Date:   Fri, 5 Oct 2018 18:03:24 +0100
Message-ID: <20181005170329.6512-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181005170329.6512-1-salil.mehta@huawei.com>
References: <20181005170329.6512-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The default mask configuration has been done by firmware, so the driver
doesn't need to do it any more.

Signed-off-by: Zhongzhu Liu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 10 -------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 32 ----------------------
 2 files changed, 42 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index e5e66b2..26fda05 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -177,7 +177,6 @@ enum hclge_opcode_type {
 	HCLGE_OPC_MAC_VLAN_INSERT	    = 0x1003,
 	HCLGE_OPC_MAC_ETHTYPE_ADD	    = 0x1010,
 	HCLGE_OPC_MAC_ETHTYPE_REMOVE	= 0x1011,
-	HCLGE_OPC_MAC_VLAN_MASK_SET	= 0x1012,
 
 	/* Multicast linear table commands */
 	HCLGE_OPC_MTA_MAC_MODE_CFG	    = 0x1020,
@@ -591,15 +590,6 @@ struct hclge_mac_vlan_tbl_entry_cmd {
 	u8      rsv2[6];
 };
 
-#define HCLGE_VLAN_MASK_EN_B		0
-struct hclge_mac_vlan_mask_entry_cmd {
-	u8 rsv0[2];
-	u8 vlan_mask;
-	u8 rsv1;
-	u8 mac_mask[6];
-	u8 rsv2[14];
-};
-
 #define HCLGE_MAC_MGR_MASK_VLAN_B		BIT(0)
 #define HCLGE_MAC_MGR_MASK_MAC_B		BIT(1)
 #define HCLGE_MAC_MGR_MASK_ETHERTYPE_B		BIT(2)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 21ca4af..0106c1b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1939,36 +1939,11 @@ static int hclge_get_autoneg(struct hnae3_handle *handle)
 	return hdev->hw.mac.autoneg;
 }
 
-static int hclge_set_default_mac_vlan_mask(struct hclge_dev *hdev,
-					   bool mask_vlan,
-					   u8 *mac_mask)
-{
-	struct hclge_mac_vlan_mask_entry_cmd *req;
-	struct hclge_desc desc;
-	int status;
-
-	req = (struct hclge_mac_vlan_mask_entry_cmd *)desc.data;
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MAC_VLAN_MASK_SET, false);
-
-	hnae3_set_bit(req->vlan_mask, HCLGE_VLAN_MASK_EN_B,
-		      mask_vlan ? 1 : 0);
-	ether_addr_copy(req->mac_mask, mac_mask);
-
-	status = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (status)
-		dev_err(&hdev->pdev->dev,
-			"Config mac_vlan_mask failed for cmd_send, ret =%d\n",
-			status);
-
-	return status;
-}
-
 static int hclge_mac_init(struct hclge_dev *hdev)
 {
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
 	struct net_device *netdev = handle->kinfo.netdev;
 	struct hclge_mac *mac = &hdev->hw.mac;
-	u8 mac_mask[ETH_ALEN] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 	struct hclge_vport *vport;
 	int mtu;
 	int ret;
@@ -2011,13 +1986,6 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 		}
 	}
 
-	ret = hclge_set_default_mac_vlan_mask(hdev, true, mac_mask);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"set default mac_vlan_mask fail ret=%d\n", ret);
-		return ret;
-	}
-
 	if (netdev)
 		mtu = netdev->mtu;
 	else
-- 
2.7.4


