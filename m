Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeBUVIe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:08:34 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47044 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeBUU5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:44 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 064/100] rtc: s3c: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:59 +0100
Message-Id: <20180221205635.31314-65-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-s3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index a8992c227f61..75c8c5033e08 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -232,7 +232,7 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 
 	rtc_tm->tm_mon -= 1;
 
-	return rtc_valid_tm(rtc_tm);
+	return 0;
 }
 
 static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
