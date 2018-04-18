Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDROKe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:10:34 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:46368 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753147AbeDROKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:10:33 -0400
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To: jakob.unterwurzacher@theobroma-systems.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] can: dev: increase bus-off message severity
Date: Wed, 18 Apr 2018 16:10:03 +0200
Message-Id: <20180418141003.10229-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus-off is usually caused by hardware malfunction or
configuration error (baud rate mismatch) and causes a
complete loss of communication.

Increase the "bus-off" message's severity from netdev_dbg
to netdev_info to make it visible to the user.

A can interface going into bus-off is similar in severity to
ethernet's "Link is Down" message, which is also printed
at info level.

It is debatable whether the the "restarted" message should
also be changed to netdev_info to make the interface state
changes comprehensible from the kernel log.
I have chosen to keep the "restarted" message at dbg for now
as the "bus-off" message should be enough for the user to
notice and investigate the problem.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b1779566c5bb..3c71f1cb205f 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -605,7 +605,7 @@ void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	netdev_dbg(dev, "bus-off\n");
+	netdev_info(dev, "bus-off\n");
 
 	netif_carrier_off(dev);
 
-- 
2.11.0
