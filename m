Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeBUVTb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:19:31 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46956 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeBUU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:23 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 022/100] rtc: ds1343: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:17 +0100
Message-Id: <20180221205635.31314-23-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1343.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 59d27db2fd37..5208da4cf94a 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -254,7 +254,7 @@ static int ds1343_read_time(struct device *dev, struct rtc_time *dt)
 	dt->tm_mon	= bcd2bin(buf[5] & 0x1F) - 1;
 	dt->tm_year	= bcd2bin(buf[6]) + 100; /* year offset from 1900 */
 
-	return rtc_valid_tm(dt);
+	return 0;
 }
 
 static int ds1343_set_time(struct device *dev, struct rtc_time *dt)
-- 
2.16.1
