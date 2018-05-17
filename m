Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEQURc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:17:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38513 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQURb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:17:31 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: at91rm9200: add range
Date: Thu, 17 May 2018 22:17:28 +0200
Message-Id: <20180517201728.21737-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The at91rm9200 RTC can support dates from 1900-01-01 00:00:00 to 2099-12-31
23:59:59.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index de81ecedd571..caa71d04e989 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -440,6 +440,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 1);
 
 	rtc->ops = &at91_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 	ret = rtc_register_device(rtc);
 	if (ret)
 		goto err_clk;
-- 
2.17.0
