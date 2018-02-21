Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeBUU6B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:01 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47083 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 088/100] rtc: tile: remove useless message
Date: Wed, 21 Feb 2018 21:56:23 +0100
Message-Id: <20180221205635.31314-89-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to print a message when the time is invalid as
userspace will already get an error (and an optional dev_dbg message).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tile.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/rtc-tile.c b/drivers/rtc/rtc-tile.c
index 0b60867d8390..ef1cdabf05b4 100644
--- a/drivers/rtc/rtc-tile.c
+++ b/drivers/rtc/rtc-tile.c
@@ -39,9 +39,6 @@ static int read_rtc_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_yday = 0;
 	tm->tm_isdst = 0;
 
-	if (rtc_valid_tm(tm) < 0)
-		dev_warn(dev, "Read invalid date/time from RTC\n");
-
 	return 0;
 }
 
-- 
2.16.1
