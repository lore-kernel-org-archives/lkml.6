Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBUVWc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:22:32 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46913 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBUU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:13 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 009/100] rtc: ac100: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:04 +0100
Message-Id: <20180221205635.31314-10-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 8ff9dc3fe5bf..080e3c04be43 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -387,7 +387,7 @@ static int ac100_rtc_get_time(struct device *dev, struct rtc_time *rtc_tm)
 	rtc_tm->tm_year = bcd2bin(reg[6] & AC100_RTC_YEA_MASK) +
 			  AC100_YEAR_OFF;
 
-	return rtc_valid_tm(rtc_tm);
+	return 0;
 }
 
 static int ac100_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
-- 
2.16.1
