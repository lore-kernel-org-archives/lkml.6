Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeDSOQa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:16:30 -0400
Received: from sauhun.de ([88.99.104.3]:45350 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753486AbeDSOHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:05 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        netdev@vger.kernel.org
Subject: [PATCH 36/61] net: ethernet: wiznet: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:06 +0200
Message-Id: <20180419140641.27926-37-wsa+renesas@sang-engineering.com>
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

 drivers/net/ethernet/wiznet/w5300.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index 56ae573001e8..692fc71d904d 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -661,8 +661,7 @@ static int w5300_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int w5300_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5300_priv *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
@@ -676,8 +675,7 @@ static int w5300_suspend(struct device *dev)
 
 static int w5300_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct w5300_priv *priv = netdev_priv(ndev);
 
 	if (!netif_running(ndev)) {
-- 
2.11.0
