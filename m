Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeDSOHI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:07:08 -0400
Received: from sauhun.de ([88.99.104.3]:45350 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753378AbeDSOG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:59 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 23/61] input: touchscreen: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:53 +0200
Message-Id: <20180419140641.27926-24-wsa+renesas@sang-engineering.com>
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

 drivers/input/touchscreen/imx6ul_tsc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index ee82a975bfd2..da9e0a774e4b 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -515,8 +515,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 
 static int __maybe_unused imx6ul_tsc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx6ul_tsc *tsc = platform_get_drvdata(pdev);
+	struct imx6ul_tsc *tsc = dev_get_drvdata(dev);
 	struct input_dev *input_dev = tsc->input;
 
 	mutex_lock(&input_dev->mutex);
@@ -535,8 +534,7 @@ static int __maybe_unused imx6ul_tsc_suspend(struct device *dev)
 
 static int __maybe_unused imx6ul_tsc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx6ul_tsc *tsc = platform_get_drvdata(pdev);
+	struct imx6ul_tsc *tsc = dev_get_drvdata(dev);
 	struct input_dev *input_dev = tsc->input;
 	int retval = 0;
 
-- 
2.11.0
