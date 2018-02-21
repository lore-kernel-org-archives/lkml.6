Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeBUU5u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47055 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeBUU5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:46 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 072/100] rtc: tx4939: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:07 +0100
Message-Id: <20180221205635.31314-73-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-tx4939.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 1f351308afdc..438bed6f3b28 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -112,7 +112,7 @@ static int tx4939_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	sec = ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
 		(buf[3] << 8) | buf[2];
 	rtc_time_to_tm(sec, tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int tx4939_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.16.1
