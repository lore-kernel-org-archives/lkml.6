Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBUVXO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:23:14 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46905 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBUU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:12 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 007/100] rtc: ab3100: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:02 +0100
Message-Id: <20180221205635.31314-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtc_time64_to_tm never generates an invalid tm. It is not necessary to
validate it. Also, the RTC core is always calling rtc_valid_tm after the
read_time callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab3100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab3100.c b/drivers/rtc/rtc-ab3100.c
index 9b725c553058..821ff52a2222 100644
--- a/drivers/rtc/rtc-ab3100.c
+++ b/drivers/rtc/rtc-ab3100.c
@@ -106,7 +106,7 @@ static int ab3100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_time64_to_tm(time, tm);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int ab3100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
-- 
2.16.1
