Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBUU5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:39 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47010 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbeBUU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 044/100] rtc: mcp795: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:39 +0100
Message-Id: <20180221205635.31314-45-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-mcp795.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 77f21331ae21..79e24eadbe99 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -262,7 +262,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
 			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
 
-	return rtc_valid_tm(tim);
+	return 0;
 }
 
 static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
-- 
2.16.1
