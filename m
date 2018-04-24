Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933926AbeDXNm7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:42:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56298 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbeDXNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:45 -0400
X-Google-Smtp-Source: AIpwx49uY5NgY3KE3/nNcE7p7X3BriAkpn5frDj4mS3n/JUQMbbBWYwHcgiCasAsWoEhaSFxuYMHFw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH] net: gemini: fix gmac_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:41 +0200
Message-Id: <20180424131642.3806-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index bd3f6e4d1..564b9ceb1 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1188,7 +1188,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	return -ENOMEM;
 }
 
-static int gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->txq_order) - 1;
-- 
2.17.0
