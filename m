Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeDXNvB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:51:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54278 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933623AbeDXNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:12 -0400
X-Google-Smtp-Source: AIpwx4/nhrEVOlo8VrfD39bnnU9AHzmO892G4EhM4wylV8yYrEqOH0pHCJ0Ao1DPP8+Z6sOkOfALMQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: janz-ican3: fix ican3_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:09 +0200
Message-Id: <20180424131609.3258-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index adfdb66a4..02042cb09 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1684,7 +1684,7 @@ static int ican3_stop(struct net_device *ndev)
 	return 0;
 }
 
-static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ican3_dev *mod = netdev_priv(ndev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
-- 
2.17.0
