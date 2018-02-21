Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeBUVEc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:04:32 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47085 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 089/100] rtc: rk808: remove useless debug message
Date: Wed, 21 Feb 2018 21:56:24 +0100
Message-Id: <20180221205635.31314-90-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At probe time, printing a message when the time is invalid doesn't have
much value. Also, as the comment suggest, this is a leftover from
development wherhe this was used to set the RTc to a default time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rk808.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 35c9aada07c8..e40f35d1ced3 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -375,7 +375,6 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
 	struct rk808_rtc *rk808_rtc;
-	struct rtc_time tm;
 	int ret;
 
 	rk808_rtc = devm_kzalloc(&pdev->dev, sizeof(*rk808_rtc), GFP_KERNEL);
@@ -404,16 +403,6 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	/* set init time */
-	ret = rk808_rtc_readtime(&pdev->dev, &tm);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to read RTC time\n");
-		return ret;
-	}
-	ret = rtc_valid_tm(&tm);
-	if (ret)
-		dev_warn(&pdev->dev, "invalid date/time\n");
-
 	device_init_wakeup(&pdev->dev, 1);
 
 	rk808_rtc->rtc = devm_rtc_device_register(&pdev->dev, "rk808-rtc",
-- 
2.16.1
