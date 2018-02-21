Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBUVEd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:04:33 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47082 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 085/100] rtc: pm8xxx: remove useless message
Date: Wed, 21 Feb 2018 21:56:20 +0100
Message-Id: <20180221205635.31314-86-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pm8xxx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index fac835530671..8e0128796824 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -190,12 +190,6 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_time_to_tm(secs, tm);
 
-	rc = rtc_valid_tm(tm);
-	if (rc < 0) {
-		dev_err(dev, "Invalid time read from RTC\n");
-		return rc;
-	}
-
 	dev_dbg(dev, "secs = %lu, h:m:s == %d:%d:%d, d/m/y = %d/%d/%d\n",
 		secs, tm->tm_hour, tm->tm_min, tm->tm_sec,
 		tm->tm_mday, tm->tm_mon, tm->tm_year);
-- 
2.16.1
