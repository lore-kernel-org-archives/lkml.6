Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeBUVTs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:19:48 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46950 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeBUU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:23 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 019/100] rtc: ds1302: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:14 +0100
Message-Id: <20180221205635.31314-20-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1302.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 43bcb17c922e..2a881150d51c 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -98,8 +98,7 @@ static int ds1302_rtc_get_time(struct device *dev, struct rtc_time *time)
 	time->tm_mon = bcd2bin(buf[RTC_ADDR_MON]) - 1;
 	time->tm_year = bcd2bin(buf[RTC_ADDR_YEAR]) + 100;
 
-	/* Time may not be set */
-	return rtc_valid_tm(time);
+	return 0;
 }
 
 static const struct rtc_class_ops ds1302_rtc_ops = {
-- 
2.16.1
