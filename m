Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeBUVOm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:14:42 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46985 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeBUU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:33 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 038/100] rtc: m48t86: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:33 +0100
Message-Id: <20180221205635.31314-39-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-m48t86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 8d17be1e6650..a9533535c3b7 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -100,7 +100,7 @@ static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		if (m48t86_readb(dev, M48T86_HOUR) & 0x80)
 			tm->tm_hour += 12;
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
