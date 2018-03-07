Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeCGWoU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:44:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56431 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934240AbeCGWoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:44:18 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: at91rm9200: Add range
Date: Wed,  7 Mar 2018 23:44:03 +0100
Message-Id: <20180307224403.18315-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307224403.18315-1-alexandre.belloni@bootlin.com>
References: <20180307224403.18315-1-alexandre.belloni@bootlin.com>
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
index de81ecedd571..c4a00ce58ffc 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -440,6 +440,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 1);
 
 	rtc->ops = &at91_rtc_ops;
+	rtc->range_min = -2208989361LL;
+	rtc->range_max = 4102441199ULL;
 	ret = rtc_register_device(rtc);
 	if (ret)
 		goto err_clk;
-- 
2.16.2
