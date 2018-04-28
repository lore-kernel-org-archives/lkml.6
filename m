Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759624AbeD1HuR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 03:50:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41233 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752688AbeD1HuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 03:50:15 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: dev:  use skb_put_zero to simplfy code
Date: Sat, 28 Apr 2018 15:49:57 +0800
Message-ID: <20180428074957.17084-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use helper skb_put_zero to replace the pattern of skb_put() && memset()

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b177956..d8140a9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -649,8 +649,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
-	*cf = skb_put(skb, sizeof(struct can_frame));
-	memset(*cf, 0, sizeof(struct can_frame));
+	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 }
@@ -678,8 +677,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
-	*cfd = skb_put(skb, sizeof(struct canfd_frame));
-	memset(*cfd, 0, sizeof(struct canfd_frame));
+	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	return skb;
 }
-- 
2.7.0
