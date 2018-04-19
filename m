Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbeDSOSi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:18:38 -0400
Received: from sauhun.de ([88.99.104.3]:45270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753427AbeDSOHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:03 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 31/61] net: dsa: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:01 +0200
Message-Id: <20180419140641.27926-32-wsa+renesas@sang-engineering.com>
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

 drivers/net/dsa/bcm_sf2.c | 6 ++----
 drivers/net/dsa/qca8k.c   | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 0378eded31f2..a61b937d1a37 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1148,16 +1148,14 @@ static void bcm_sf2_sw_shutdown(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int bcm_sf2_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct bcm_sf2_priv *priv = platform_get_drvdata(pdev);
+	struct bcm_sf2_priv *priv = dev_get_drvdata(dev);
 
 	return dsa_switch_suspend(priv->dev->ds);
 }
 
 static int bcm_sf2_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct bcm_sf2_priv *priv = platform_get_drvdata(pdev);
+	struct bcm_sf2_priv *priv = dev_get_drvdata(dev);
 
 	return dsa_switch_resume(priv->dev->ds);
 }
diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 600d5ad1fbde..9f503e5db88a 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -910,8 +910,7 @@ qca8k_set_pm(struct qca8k_priv *priv, int enable)
 
 static int qca8k_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qca8k_priv *priv = platform_get_drvdata(pdev);
+	struct qca8k_priv *priv = dev_get_drvdata(dev);
 
 	qca8k_set_pm(priv, 0);
 
@@ -920,8 +919,7 @@ static int qca8k_suspend(struct device *dev)
 
 static int qca8k_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qca8k_priv *priv = platform_get_drvdata(pdev);
+	struct qca8k_priv *priv = dev_get_drvdata(dev);
 
 	qca8k_set_pm(priv, 1);
 
-- 
2.11.0
