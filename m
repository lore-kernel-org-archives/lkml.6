Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934114AbeDXNSz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:18:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55839 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934093AbeDXNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:18:49 -0400
X-Google-Smtp-Source: AIpwx48FephBBOxLs+S/oeJavNKMgCGNHxj3DSCqfdA5vkVileq+EeiEWNBHO/NofFZAL8HXfWYJJg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: [PATCH] batman-adv: fix batadv_interface_tx()'s return type
Date: Tue, 24 Apr 2018 15:18:46 +0200
Message-Id: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
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
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index edeffcb9f..e6c800b06 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -188,7 +188,7 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
-static int batadv_interface_tx(struct sk_buff *skb,
+static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr;
-- 
2.17.0
