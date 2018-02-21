Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeBUU66 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:58 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47091 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeBUU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:58:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 097/100] rtc: max6900: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:32 +0100
Message-Id: <20180221205635.31314-98-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-max6900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
index cbdc86a560ba..84f06106f5ba 100644
--- a/drivers/rtc/rtc-max6900.c
+++ b/drivers/rtc/rtc-max6900.c
@@ -157,7 +157,7 @@ static int max6900_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
 		      bcd2bin(regs[MAX6900_REG_CENTURY]) * 100 - 1900;
 	tm->tm_wday = bcd2bin(regs[MAX6900_REG_DW]);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int max6900_i2c_clear_write_protect(struct i2c_client *client)
-- 
2.16.1
