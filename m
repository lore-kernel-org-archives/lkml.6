Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeBUVFS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:05:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47079 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 083/100] rtc: tegra: stop validating rtc_time in .set_time
Date: Wed, 21 Feb 2018 21:56:18 +0100
Message-Id: <20180221205635.31314-84-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always validating the rtc_time struct before calling
.set_time. It is not necessary to do it again in .set_time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tegra.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index d30d57b048d3..66efff60c4d5 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -144,10 +144,6 @@ static int tegra_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 
 	/* convert tm to seconds. */
-	ret = rtc_valid_tm(tm);
-	if (ret)
-		return ret;
-
 	rtc_tm_to_time(tm, &sec);
 
 	dev_vdbg(dev, "time set to %lu. %d/%d/%d %d:%02u:%02u\n",
-- 
2.16.1
