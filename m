Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeDXNR4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933902AbeDXNRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:50 -0400
X-Google-Smtp-Source: AIpwx48NxL44yGJmMl3ju1Gvt6RKZ+JlIO87Lkctl38+bqM+3cYTwxmO7un/ANlgpdjq/Uesdvhwvg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org
Subject: [PATCH] openvswitch: fix internal_dev_xmit()'s return type
Date: Tue, 24 Apr 2018 15:17:47 +0200
Message-Id: <20180424131747.4711-1-luc.vanoostenryck@gmail.com>
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
 net/openvswitch/vport-internal_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index bb95c43aa..3ea55618e 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -43,7 +43,7 @@ static struct internal_dev *internal_dev_priv(struct net_device *netdev)
 }
 
 /* Called with rcu_read_lock_bh. */
-static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int len, err;
 
-- 
2.17.0
