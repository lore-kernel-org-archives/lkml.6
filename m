Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBUU5E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:04 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46890 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBUU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 001/100] rtc: ds1511: let the core handle invalid time
Date: Wed, 21 Feb 2018 21:54:56 +0100
Message-Id: <20180221205635.31314-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning a valid time when the time is invalid is a bad practice, because
then userspace is not able to react on the information. Also, it doesn't
make sense to return epoch because it is already the default time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 5f55214db9f8..a7d5ca428d68 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -277,10 +277,6 @@ static int ds1511_rtc_read_time(struct device *dev, struct rtc_time *rtc_tm)
 
 	rtc_tm->tm_mon--;
 
-	if (rtc_valid_tm(rtc_tm) < 0) {
-		dev_err(dev, "retrieved date/time is not valid.\n");
-		rtc_time_to_tm(0, rtc_tm);
-	}
 	return 0;
 }
 
-- 
2.16.1
