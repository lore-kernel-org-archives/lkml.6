Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeDXNZd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:25:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55095 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934081AbeDXNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:18:54 -0400
X-Google-Smtp-Source: AIpwx48//MtON9RMtk/+fevlcnREUn33p7CYPNzrIsTmKE27KaaXO4ALCWLxbtv/0ps0B5eiBrvRzg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvid Brodin <arvid.brodin@alten.se>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH] net/hsr: fix hsr_dev_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:51 +0200
Message-Id: <20180424131851.5568-1-luc.vanoostenryck@gmail.com>
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
 net/hsr/hsr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b8cd43c9e..a067150f0 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -233,7 +233,7 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
 }
 
 
-static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hsr_priv *hsr = netdev_priv(dev);
 	struct hsr_port *master;
-- 
2.17.0
