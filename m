Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBUVKy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:10:54 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47029 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeBUU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:43 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 062/100] rtc: rx8010: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:57 +0100
Message-Id: <20180221205635.31314-63-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 5c5938ab3d86..7ddc22eb5b0f 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -138,7 +138,7 @@ static int rx8010_get_time(struct device *dev, struct rtc_time *dt)
 	dt->tm_year = bcd2bin(date[RX8010_YEAR - RX8010_SEC]) + 100;
 	dt->tm_wday = ffs(date[RX8010_WDAY - RX8010_SEC] & 0x7f);
 
-	return rtc_valid_tm(dt);
+	return 0;
 }
 
 static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
-- 
2.16.1
