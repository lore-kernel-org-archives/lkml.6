Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCUHS1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:18:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751411AbeCUHSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:15 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 04/11] net: hns3: export pci table of hclge and hclgevf to userspace
Date: Wed, 21 Mar 2018 15:49:23 +0800
Message-ID: <1521618570-129694-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

There is no module that is dependent on hclge or hclgevf's symbol,
but hns_enet need them to provide ops for it to run. When there is
a need to auto load the hns3 driver, the auto load will fail because
hclge or hclgevf is not loaded.

Hns_enet has already exported the pci table, so this patch exports
the pci table for hclge and hclgevf module too.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 588f231..869e98a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -55,6 +55,8 @@ static const struct pci_device_id ae_algo_pci_tbl[] = {
 	{0, }
 };
 
+MODULE_DEVICE_TABLE(pci, ae_algo_pci_tbl);
+
 static const char hns3_nic_test_strs[][ETH_GSTRING_LEN] = {
 	"Mac    Loopback test",
 	"Serdes Loopback test",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index c96cf03..14b0e26 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -18,6 +18,8 @@ static const struct pci_device_id ae_algovf_pci_tbl[] = {
 	{0, }
 };
 
+MODULE_DEVICE_TABLE(pci, ae_algovf_pci_tbl);
+
 static inline struct hclgevf_dev *hclgevf_ae_get_hdev(
 	struct hnae3_handle *handle)
 {
-- 
2.9.3
