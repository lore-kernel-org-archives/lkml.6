Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933790AbeDXNvf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:51:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36922 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933599AbeDXNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:05 -0400
X-Google-Smtp-Source: AIpwx4/vvV33VSmi/hM5LrTX1TUvJchmh73e7vvueT4gSSI0jXZTmtJDXQdqiKCe5uzj0oShagLYUQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        netdev@vger.kernel.org
Subject: [PATCH] caif: fix caif_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:02 +0200
Message-Id: <20180424131603.3109-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/caif/caif_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index a0f954f36..d9190c0ec 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -275,7 +275,7 @@ static int handle_tx(struct ser_device *ser)
 	return tty_wr;
 }
 
-static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t caif_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ser_device *ser;
 
-- 
2.17.0
