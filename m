Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBUU5S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46938 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeBUU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:14 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 011/100] rtc: bq32k: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:06 +0100
Message-Id: <20180221205635.31314-12-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-bq32k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 98ac8d5c7901..e8698e9870fe 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -110,7 +110,7 @@ static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_year = bcd2bin(regs.years) +
 				((regs.cent_hours & BQ32K_CENT) ? 100 : 0);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int bq32k_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
