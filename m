Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBUVFZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:05:25 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47064 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeBUU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:53 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 079/100] rtc: m41t93: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:14 +0100
Message-Id: <20180221205635.31314-80-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-m41t93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index 5ac45fc1a787..4a08a9dabc82 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -159,7 +159,7 @@ static int m41t93_get_time(struct device *dev, struct rtc_time *tm)
 		tm->tm_hour, tm->tm_mday,
 		tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	return ret < 0 ? ret : rtc_valid_tm(tm);
+	return ret;
 }
 
 
-- 
2.16.1
