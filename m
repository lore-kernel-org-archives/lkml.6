Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933010AbeCJC6g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:58:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeCJC5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:39 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: fix error type definition of return value
Date: Sat, 10 Mar 2018 11:29:30 +0800
Message-ID: <1520652573-75644-10-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
References: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

An enum type variable was used to store an "int" type return value.
This patch fixes it.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ea33cc5..ba84281 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4107,8 +4107,8 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 {
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_mac_vlan_tbl_entry_cmd req;
-	enum hclge_cmd_status status;
 	u16 egress_port = 0;
+	int ret;
 
 	/* mac addr check */
 	if (is_zero_ether_addr(addr) ||
@@ -4140,9 +4140,9 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 
 	hclge_prepare_mac_addr(&req, addr);
 
-	status = hclge_add_mac_vlan_tbl(vport, &req, NULL);
+	ret = hclge_add_mac_vlan_tbl(vport, &req, NULL);
 
-	return status;
+	return ret;
 }
 
 static int hclge_rm_uc_addr(struct hnae3_handle *handle,
@@ -4158,7 +4158,7 @@ int hclge_rm_uc_addr_common(struct hclge_vport *vport,
 {
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_mac_vlan_tbl_entry_cmd req;
-	enum hclge_cmd_status status;
+	int ret;
 
 	/* mac addr check */
 	if (is_zero_ether_addr(addr) ||
@@ -4174,9 +4174,9 @@ int hclge_rm_uc_addr_common(struct hclge_vport *vport,
 	hnae_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hclge_prepare_mac_addr(&req, addr);
-	status = hclge_remove_mac_vlan_tbl(vport, &req);
+	ret = hclge_remove_mac_vlan_tbl(vport, &req);
 
-	return status;
+	return ret;
 }
 
 static int hclge_add_mc_addr(struct hnae3_handle *handle,
-- 
2.9.3
