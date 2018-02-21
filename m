Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeBUVVp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:21:45 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46941 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBUU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:14 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 014/100] rtc: da9052: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:09 +0100
Message-Id: <20180221205635.31314-15-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-da9052.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index 4273377562ec..03044e1bc497 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -187,8 +187,7 @@ static int da9052_rtc_read_time(struct device *dev, struct rtc_time *rtc_tm)
 			rtc_tm->tm_min  = v[0][1] & DA9052_RTC_MIN;
 			rtc_tm->tm_sec  = v[0][0] & DA9052_RTC_SEC;
 
-			ret = rtc_valid_tm(rtc_tm);
-			return ret;
+			return 0;
 		}
 
 		idx = (1-idx);
-- 
2.16.1
