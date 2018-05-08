Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeEHJ2t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:28:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49281 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeEHJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:28:43 -0400
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/7] can: dev: increase bus-off message severity
Date: Tue,  8 May 2018 11:28:25 +0200
Message-Id: <20180508092831.28247-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
References: <20180508092831.28247-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

bus-off is usually caused by hardware malfunction or configuration error
(baud rate mismatch) and causes a complete loss of communication.

Increase the "bus-off" message's severity from netdev_dbg() to
netdev_info() to make it visible to the user.

A can interface going into bus-off is similar in severity to ethernet's
"Link is Down" message, which is also printed at info level.

It is debatable whether the the "restarted" message should also be
changed to netdev_info() to make the interface state changes
comprehensible from the kernel log. I have chosen to keep the
"restarted" message at dbg for now as the "bus-off" message should be
enough for the user to notice and investigate the problem.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.17.0
