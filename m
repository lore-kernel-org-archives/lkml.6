Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754390AbeEaJ53 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:57:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44964 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754488AbeEaJ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:57:19 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: ds1685: Add range
Date: Thu, 31 May 2018 11:56:43 +0200
Message-Id: <20180531095643.8581-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531095643.8581-1-alexandre.belloni@bootlin.com>
References: <20180531095643.8581-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful range is 2000-2099 because leap year fails on centuries.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index e6390475380f..5c0db6c8134c 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -2043,6 +2043,10 @@ ds1685_rtc_probe(struct platform_device *pdev)
 
 	rtc_dev->ops = &ds1685_rtc_ops;
 
+	/* Century bit is useless because leap year fails in 1900 and 2100 */
+	rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
+
 	/* Maximum periodic rate is 8192Hz (0.122070ms). */
 	rtc_dev->max_user_freq = RTC_MAX_USER_FREQ;
 
-- 
2.17.0
