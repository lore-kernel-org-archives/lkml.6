Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeEQU0o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:26:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38895 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeEQU0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:26:41 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: tps65910: add range
Date: Thu, 17 May 2018 22:26:23 +0200
Message-Id: <20180517202623.23497-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517202623.23497-1-alexandre.belloni@bootlin.com>
References: <20180517202623.23497-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps65910 RTC can support dates from 01/01/2000 to 31/12/2099.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tps65910.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index 819d2d0957b4..a9bbd022aeef 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -426,6 +426,8 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, 1);
 
 	tps_rtc->rtc->ops = &tps65910_rtc_ops;
+	tps_rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	tps_rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	ret = rtc_register_device(tps_rtc->rtc);
 	if (ret) {
-- 
2.17.0
