Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeBUU53 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:29 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46975 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeBUU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:24 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 028/100] rtc: ds3232: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:23 +0100
Message-Id: <20180221205635.31314-29-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds3232.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 0550f7ba464f..7184e5145f12 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -145,7 +145,7 @@ static int ds3232_read_time(struct device *dev, struct rtc_time *time)
 
 	time->tm_year = bcd2bin(year) + add_century;
 
-	return rtc_valid_tm(time);
+	return 0;
 }
 
 static int ds3232_set_time(struct device *dev, struct rtc_time *time)
-- 
2.16.1
