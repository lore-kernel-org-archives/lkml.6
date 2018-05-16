Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeEPLVe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:21:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39796 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeEPLVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:21:33 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <tklauser@distanz.ch>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ethoc: Remove useless test before clk_disable_unprepare
Date: Wed, 16 May 2018 19:18:22 +0800
Message-ID: <20180516111822.26440-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ethoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index 8bb0db9..00a5727 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1246,8 +1246,7 @@ static int ethoc_probe(struct platform_device *pdev)
 	mdiobus_unregister(priv->mdio);
 	mdiobus_free(priv->mdio);
 free2:
-	if (priv->clk)
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 free:
 	free_netdev(netdev);
 out:
@@ -1271,8 +1270,7 @@ static int ethoc_remove(struct platform_device *pdev)
 			mdiobus_unregister(priv->mdio);
 			mdiobus_free(priv->mdio);
 		}
-		if (priv->clk)
-			clk_disable_unprepare(priv->clk);
+		clk_disable_unprepare(priv->clk);
 		unregister_netdev(netdev);
 		free_netdev(netdev);
 	}
-- 
2.7.0
