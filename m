Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeBUVHu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:07:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47053 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeBUU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:45 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 071/100] rtc: tps6586x: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:06 +0100
Message-Id: <20180221205635.31314-72-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index a3418a8a3796..d7785ae0a2b4 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -90,7 +90,7 @@ static int tps6586x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	seconds = ticks >> 10;
 	seconds += rtc->epoch_start;
 	rtc_time_to_tm(seconds, tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int tps6586x_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
