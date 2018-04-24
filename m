Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933991AbeDXNSG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:18:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39872 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933902AbeDXNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:58 -0400
X-Google-Smtp-Source: AIpwx48eYrs1yKo/aZLY/uGHCnK0BbEau1Zd28kPj12ZzE5P0ZYRrEB8zaAm5Or8C4HfBqMmESV66A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        David Windsor <dwindsor@gmail.com>, Kees Cook <keescook@chromium.org>,
        netdev@vger.kernel.org
Subject: [PATCH] rapidio/rionet: fix rionet_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:17:53 +0200
Message-Id: <20180424131756.4812-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/rionet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index e9f101c9b..8696f9376 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -170,7 +170,7 @@ static int rionet_queue_tx_msg(struct sk_buff *skb, struct net_device *ndev,
 	return 0;
 }
 
-static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	int i;
 	struct rionet_private *rnet = netdev_priv(ndev);
-- 
2.17.0
