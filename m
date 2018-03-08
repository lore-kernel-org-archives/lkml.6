Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755872AbeCHLK1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755785AbeCHLKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:18 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 6/6] net: hns3: add support for VF driver inner interface hclgevf_ops.get_tqps_and_rss_info
Date: Thu, 8 Mar 2018 19:41:55 +0800
Message-ID: <1520509315-40895-7-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
References: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for VF driver inner interface
hclgevf_ops.get_tqps_and_rss_info. This interface will be
used in the initialization process.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 0d89965..c9a916a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1447,6 +1447,15 @@ static void hclgevf_get_channels(struct hnae3_handle *handle,
 	ch->combined_count = hdev->num_tqps;
 }
 
+static void hclgevf_get_tqps_and_rss_info(struct hnae3_handle *handle,
+					  u16 *free_tqps, u16 *max_rss_size)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	*free_tqps = 0;
+	*max_rss_size = hdev->rss_size_max;
+}
+
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
@@ -1477,6 +1486,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_fw_version = hclgevf_get_fw_version,
 	.set_vlan_filter = hclgevf_set_vlan_filter,
 	.get_channels = hclgevf_get_channels,
+	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
 };
 
 static struct hnae3_ae_algo ae_algovf = {
-- 
2.9.3
