Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDSOGw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:06:52 -0400
Received: from sauhun.de ([88.99.104.3]:45232 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeDSOGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:50 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 03/61] auxdisplay: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:33 +0200
Message-Id: <20180419140641.27926-4-wsa+renesas@sang-engineering.com>
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

 drivers/auxdisplay/arm-charlcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
index b3176ee92b90..26246ab7a066 100644
--- a/drivers/auxdisplay/arm-charlcd.c
+++ b/drivers/auxdisplay/arm-charlcd.c
@@ -329,8 +329,7 @@ static int __init charlcd_probe(struct platform_device *pdev)
 
 static int charlcd_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct charlcd *lcd = platform_get_drvdata(pdev);
+	struct charlcd *lcd = dev_get_drvdata(dev);
 
 	/* Power the display off */
 	charlcd_4bit_command(lcd, HD_DISPCTRL);
@@ -339,8 +338,7 @@ static int charlcd_suspend(struct device *dev)
 
 static int charlcd_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct charlcd *lcd = platform_get_drvdata(pdev);
+	struct charlcd *lcd = dev_get_drvdata(dev);
 
 	/* Turn the display back on */
 	charlcd_4bit_command(lcd, HD_DISPCTRL | HD_DISPCTRL_ON);
-- 
2.11.0
