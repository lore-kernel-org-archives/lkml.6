Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeDSOKb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:10:31 -0400
Received: from sauhun.de ([88.99.104.3]:45448 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753557AbeDSOHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:13 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 52/61] thermal: st: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:22 +0200
Message-Id: <20180419140641.27926-53-wsa+renesas@sang-engineering.com>
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

 drivers/thermal/st/st_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index be637e6b01d2..b2bbdf6eb02b 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -277,8 +277,7 @@ EXPORT_SYMBOL_GPL(st_thermal_unregister);
 #ifdef CONFIG_PM_SLEEP
 static int st_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	return st_thermal_sensor_off(sensor);
 }
@@ -286,8 +285,7 @@ static int st_thermal_suspend(struct device *dev)
 static int st_thermal_resume(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	ret = st_thermal_sensor_on(sensor);
 	if (ret)
-- 
2.11.0
