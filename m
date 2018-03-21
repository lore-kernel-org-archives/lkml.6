Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeCUHSf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:18:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751542AbeCUHST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:19 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 09/11] net: hns3: add get_link support to VF
Date: Wed, 21 Mar 2018 15:49:28 +0800
Message-ID: <1521618570-129694-10-git-send-email-lipeng321@huawei.com>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

This patch adds ethtool_ops.get_link support to VF.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 502f347..513d8d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1053,6 +1053,7 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
 	.get_channels = hns3_get_channels,
 	.get_coalesce = hns3_get_coalesce,
 	.set_coalesce = hns3_set_coalesce,
+	.get_link = hns3_get_link,
 };
 
 static const struct ethtool_ops hns3_ethtool_ops = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 14b0e26..f917a1e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1468,6 +1468,13 @@ static void hclgevf_get_tqps_and_rss_info(struct hnae3_handle *handle,
 	*max_rss_size = hdev->rss_size_max;
 }
 
+static int hclgevf_get_status(struct hnae3_handle *handle)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	return hdev->hw.mac.link;
+}
+
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
@@ -1500,6 +1507,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.set_vlan_filter = hclgevf_set_vlan_filter,
 	.get_channels = hclgevf_get_channels,
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
+	.get_status = hclgevf_get_status,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
-- 
2.9.3
