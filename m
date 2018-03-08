Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755768AbeCHLKP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754566AbeCHLKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:13 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 1/6] net: hns3: VF should get the real rss_size instead of rss_size_max
Date: Thu, 8 Mar 2018 19:41:50 +0800
Message-ID: <1520509315-40895-2-git-send-email-lipeng321@huawei.com>
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

VF driver should get the real rss_size which is assigned
by host PF, not rss_size_max.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index f38fc5c..31383a6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -291,7 +291,7 @@ static int hclge_get_vf_queue_info(struct hclge_vport *vport,
 
 	/* get the queue related info */
 	memcpy(&resp_data[0], &vport->alloc_tqps, sizeof(u16));
-	memcpy(&resp_data[2], &hdev->rss_size_max, sizeof(u16));
+	memcpy(&resp_data[2], &vport->nic.kinfo.rss_size, sizeof(u16));
 	memcpy(&resp_data[4], &hdev->num_desc, sizeof(u16));
 	memcpy(&resp_data[6], &hdev->rx_buf_len, sizeof(u16));
 
-- 
2.9.3
