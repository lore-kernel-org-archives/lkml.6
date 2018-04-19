Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeDSOM6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:12:58 -0400
Received: from sauhun.de ([88.99.104.3]:45448 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbeDSOHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:09 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH 45/61] slimbus: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:15 +0200
Message-Id: <20180419140641.27926-46-wsa+renesas@sang-engineering.com>
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

 drivers/slimbus/qcom-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ffb46f915334..45c38fff15d2 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -655,8 +655,7 @@ static int qcom_slim_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int qcom_slim_runtime_suspend(struct device *device)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "pm_runtime: suspending...\n");
@@ -673,8 +672,7 @@ static int qcom_slim_runtime_suspend(struct device *device)
 
 static int qcom_slim_runtime_resume(struct device *device)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
 	int ret = 0;
 
 	dev_dbg(device, "pm_runtime: resuming...\n");
-- 
2.11.0
