Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeBUVRm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:17:42 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46969 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeBUU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:25 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 033/100] rtc: lpc32xx: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:28 +0100
Message-Id: <20180221205635.31314-34-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtc_time_to_tm never generates an invalid tm. It is not necessary to
validate it. Also, the RTC core is always calling rtc_valid_tm after the
read_time callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lpc32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 887871c3d526..3ba87239aacc 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -70,7 +70,7 @@ static int lpc32xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 	elapsed_sec = rtc_readl(rtc, LPC32XX_RTC_UCOUNT);
 	rtc_time_to_tm(elapsed_sec, time);
 
-	return rtc_valid_tm(time);
+	return 0;
 }
 
 static int lpc32xx_rtc_set_mmss(struct device *dev, unsigned long secs)
-- 
2.16.1
