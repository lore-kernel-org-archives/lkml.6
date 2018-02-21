Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeBUVRo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:17:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46980 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeBUU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:24 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 032/100] rtc: lpc24xx: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:27 +0100
Message-Id: <20180221205635.31314-33-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-lpc24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lpc24xx.c b/drivers/rtc/rtc-lpc24xx.c
index 59d99596fdeb..14dc7b04fae0 100644
--- a/drivers/rtc/rtc-lpc24xx.c
+++ b/drivers/rtc/rtc-lpc24xx.c
@@ -110,7 +110,7 @@ static int lpc24xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_year = CT1_YEAR(ct1);
 	tm->tm_yday = CT2_DOY(ct2);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int lpc24xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
-- 
2.16.1
