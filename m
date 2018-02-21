Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeBUVOk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:14:40 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46987 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeBUU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:33 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 039/100] rtc: max6902: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:34 +0100
Message-Id: <20180221205635.31314-40-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-max6902.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max6902.c b/drivers/rtc/rtc-max6902.c
index 315d09e0f2c1..745827463367 100644
--- a/drivers/rtc/rtc-max6902.c
+++ b/drivers/rtc/rtc-max6902.c
@@ -85,7 +85,7 @@ static int max6902_read_time(struct device *dev, struct rtc_time *dt)
 	dt->tm_year += century;
 	dt->tm_year -= 1900;
 
-	return rtc_valid_tm(dt);
+	return 0;
 }
 
 static int max6902_set_time(struct device *dev, struct rtc_time *dt)
-- 
2.16.1
