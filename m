Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeBUVgb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:36:31 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48029 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUVg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:36:29 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] alpha: rtc: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 22:36:16 +0100
Message-Id: <20180221213616.591-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/alpha/kernel/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index b3da0dcda47d..ed72a017d42a 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -97,7 +97,7 @@ alpha_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		tm->tm_year = year;
 	}
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int
-- 
2.16.1
