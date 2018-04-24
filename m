Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933951AbeDXNRt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37945 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933902AbeDXNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:34 -0400
X-Google-Smtp-Source: AIpwx4/SPb1Ae9wynFgVsM1G05DayVx5SyOnvaOLW8fNnhPhP4Zh2oJZTcOyxDUnj0L9PPbo48wQXQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
Subject: [PATCH] net: ethernet: ave: fix ave_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:17:25 +0200
Message-Id: <20180424131731.4458-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/socionext/sni_ave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 0b3b7a460..95625bca1 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1360,7 +1360,7 @@ static int ave_stop(struct net_device *ndev)
 	return 0;
 }
 
-static int ave_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t ave_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ave_private *priv = netdev_priv(ndev);
 	u32 proc_idx, done_idx, ndesc, cmdsts;
-- 
2.17.0
