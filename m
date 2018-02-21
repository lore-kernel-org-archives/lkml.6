Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeBUVHt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:07:49 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47040 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeBUU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:45 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 073/100] rtc: wm831x: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:08 +0100
Message-Id: <20180221205635.31314-74-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-wm831x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 75aea4c4d334..7b824dabf104 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -156,7 +156,7 @@ static int wm831x_rtc_readtime(struct device *dev, struct rtc_time *tm)
 			u32 time = (time1[0] << 16) | time1[1];
 
 			rtc_time_to_tm(time, tm);
-			return rtc_valid_tm(tm);
+			return 0;
 		}
 
 	} while (++count < WM831X_GET_TIME_RETRIES);
-- 
2.16.1
