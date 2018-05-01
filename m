Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756592AbeEAS6E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756247AbeEAS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:00 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: fix to correctly fetch l4 protocol outer header
Date: Tue, 1 May 2018 19:55:58 +0100
Message-ID: <20180501185605.9584-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

This patch fixes the function being used to fetch L4
protocol outer header. Mistakenly skb_inner_transport_header
API was being used earlier.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 8c55965..c4e2950 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -502,7 +502,7 @@ static int hns3_get_l4_protocol(struct sk_buff *skb, u8 *ol4_proto,
 
 	/* find outer header point */
 	l3.hdr = skb_network_header(skb);
-	l4_hdr = skb_inner_transport_header(skb);
+	l4_hdr = skb_transport_header(skb);
 
 	if (skb->protocol == htons(ETH_P_IPV6)) {
 		exthdr = l3.hdr + sizeof(*l3.v6);
-- 
2.7.4
