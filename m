Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeBUVMi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:12:38 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47019 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBUU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:38 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 054/100] rtc: pcf50633: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:49 +0100
Message-Id: <20180221205635.31314-55-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf50633.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index 00c31c91b245..ef72b0c389d7 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -135,7 +135,7 @@ static int pcf50633_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		tm->tm_mday, tm->tm_mon, tm->tm_year,
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int pcf50633_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
