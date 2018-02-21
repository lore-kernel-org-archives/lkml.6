Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeBUU5l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:41 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46988 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeBUU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:33 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 041/100] rtc: max8997: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:36 +0100
Message-Id: <20180221205635.31314-42-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index db984d4bf952..e8cee123e8aa 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -153,7 +153,7 @@ static int max8997_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	max8997_rtc_data_to_tm(data, tm, info->rtc_24hr_mode);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int max8997_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
