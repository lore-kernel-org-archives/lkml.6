Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbeDSOSR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:18:17 -0400
Received: from sauhun.de ([88.99.104.3]:45272 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753444AbeDSOHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:03 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>, netdev@vger.kernel.org
Subject: [PATCH 32/61] net: ethernet: cadence: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:02 +0200
Message-Id: <20180419140641.27926-33-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/net/ethernet/cadence/macb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b4c9268100bb..136bfd5d0be9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4056,8 +4056,7 @@ static int macb_remove(struct platform_device *pdev)
 
 static int __maybe_unused macb_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 
 	netif_carrier_off(netdev);
@@ -4079,8 +4078,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 
 static int __maybe_unused macb_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 
 	if (bp->wol & MACB_WOL_ENABLED) {
-- 
2.11.0
