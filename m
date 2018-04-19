Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeDSOIS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:08:18 -0400
Received: from sauhun.de ([88.99.104.3]:45350 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753572AbeDSOHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:16 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 60/61] net: dsa: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:30 +0200
Message-Id: <20180419140641.27926-61-wsa+renesas@sang-engineering.com>
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

 net/dsa/legacy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dsa/legacy.c b/net/dsa/legacy.c
index 42a7b85b84e1..f8d6b212328f 100644
--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -687,8 +687,7 @@ static void dsa_shutdown(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dsa_suspend(struct device *d)
 {
-	struct platform_device *pdev = to_platform_device(d);
-	struct dsa_switch_tree *dst = platform_get_drvdata(pdev);
+	struct dsa_switch_tree *dst = dev_get_drvdata(d);
 	int i, ret = 0;
 
 	for (i = 0; i < dst->pd->nr_chips; i++) {
@@ -703,8 +702,7 @@ static int dsa_suspend(struct device *d)
 
 static int dsa_resume(struct device *d)
 {
-	struct platform_device *pdev = to_platform_device(d);
-	struct dsa_switch_tree *dst = platform_get_drvdata(pdev);
+	struct dsa_switch_tree *dst = dev_get_drvdata(d);
 	int i, ret = 0;
 
 	for (i = 0; i < dst->pd->nr_chips; i++) {
-- 
2.11.0
