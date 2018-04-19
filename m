Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeDSOLR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:11:17 -0400
Received: from sauhun.de ([88.99.104.3]:45416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753552AbeDSOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:12 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH 51/61] thermal: int340x_thermal: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:21 +0200
Message-Id: <20180419140641.27926-52-wsa+renesas@sang-engineering.com>
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

 drivers/thermal/int340x_thermal/int3400_thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index e26b01c05e82..61ca7ce3624e 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -48,8 +48,7 @@ static ssize_t available_uuids_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
+	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
 	int i;
 	int length = 0;
 
@@ -68,8 +67,7 @@ static ssize_t available_uuids_show(struct device *dev,
 static ssize_t current_uuid_show(struct device *dev,
 				 struct device_attribute *devattr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
+	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
 
 	if (priv->uuid_bitmap & (1 << priv->current_uuid_index))
 		return sprintf(buf, "%s\n",
@@ -82,8 +80,7 @@ static ssize_t current_uuid_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
+	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
-- 
2.11.0
