Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeBUU5m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:42 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46992 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBUU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:33 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 040/100] rtc: max6916: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:35 +0100
Message-Id: <20180221205635.31314-41-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-max6916.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max6916.c b/drivers/rtc/rtc-max6916.c
index 623ab27b2757..7e908a490cf6 100644
--- a/drivers/rtc/rtc-max6916.c
+++ b/drivers/rtc/rtc-max6916.c
@@ -75,7 +75,7 @@ static int max6916_read_time(struct device *dev, struct rtc_time *dt)
 	dt->tm_wday = bcd2bin(buf[5]) - 1;
 	dt->tm_year = bcd2bin(buf[6]) + 100;
 
-	return rtc_valid_tm(dt);
+	return 0;
 }
 
 static int max6916_set_time(struct device *dev, struct rtc_time *dt)
-- 
2.16.1
