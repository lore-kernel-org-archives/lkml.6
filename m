Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeEaDt7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:49:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932671AbeEaDtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:49:55 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <w-kwok2@ti.com>, <m-karicheri2@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: netcp: ethss: remove unnecessary pointer set to NULL
Date: Thu, 31 May 2018 11:48:48 +0800
Message-ID: <20180531034848.23080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If statement has make sure the 'slave->phy' is NULL

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 6a728d3..6e455a2 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3206,7 +3206,6 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 		if (!slave->phy) {
 			dev_err(dev, "phy not found for slave %d\n",
 				slave->slave_num);
-			slave->phy = NULL;
 		} else {
 			dev_dbg(dev, "phy found: id is: 0x%s\n",
 				phydev_name(slave->phy));
-- 
2.7.0
