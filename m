Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeBUU6A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:00 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47059 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeBUU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:53 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 078/100] rtc: m41t80: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:13 +0100
Message-Id: <20180221205635.31314-79-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-m41t80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index c90fba3ed861..1103cdc33bfa 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -230,7 +230,7 @@ static int m41t80_get_datetime(struct i2c_client *client,
 
 	/* assume 20YY not 19YY, and ignore the Century Bit */
 	tm->tm_year = bcd2bin(buf[M41T80_REG_YEAR]) + 100;
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 /* Sets the given date and time to the real time clock. */
-- 
2.16.1
