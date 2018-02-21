Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeBUVTt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:19:49 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46952 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeBUU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:23 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 020/100] rtc: ds1305: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:15 +0100
Message-Id: <20180221205635.31314-21-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1305.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 3d2400a39da9..2d502fc85698 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -203,8 +203,7 @@ static int ds1305_get_time(struct device *dev, struct rtc_time *time)
 		time->tm_hour, time->tm_mday,
 		time->tm_mon, time->tm_year, time->tm_wday);
 
-	/* Time may not be set */
-	return rtc_valid_tm(time);
+	return 0;
 }
 
 static int ds1305_set_time(struct device *dev, struct rtc_time *time)
-- 
2.16.1
