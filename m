Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965839AbeCSXst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:48:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54266 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964858AbeCSXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:48:34 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/6] rtc: 88pm80x: remove artificial limitation
Date: Tue, 20 Mar 2018 00:48:16 +0100
Message-Id: <20180319234817.16199-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
References: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 88pm80x supports time up to 2106 (it is a 32 bit counter). Also, the
year will never be before 1970 as the RTC core forbids that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm80x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 466bf7f9a285..6cbafefa80a2 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -134,9 +134,9 @@ static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
 	unsigned long ticks, base, data;
-	if ((tm->tm_year < 70) || (tm->tm_year > 138)) {
+	if (tm->tm_year > 206) {
 		dev_dbg(info->dev,
-			"Set time %d out of range. Please set time between 1970 to 2038.\n",
+			"Set time %d out of range. Please set time between 1970 to 2106.\n",
 			1900 + tm->tm_year);
 		return -EINVAL;
 	}
-- 
2.16.2
