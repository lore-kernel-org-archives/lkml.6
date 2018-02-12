Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933226AbeBLWs4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:56 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37582 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932952AbeBLWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:37 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 27/45] rtc: sirfsoc: remove useless sirfsoc_rtc_ioctl
Date: Mon, 12 Feb 2018 23:47:41 +0100
Message-Id: <20180212224759.15999-28-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sirfsoc_rtc_ioctl() doesn't implement any actual ioctl, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sirfsoc.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index 7367f617145c..2a9e151cae99 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -204,23 +204,6 @@ static int sirfsoc_rtc_set_time(struct device *dev,
 	return 0;
 }
 
-static int sirfsoc_rtc_ioctl(struct device *dev, unsigned int cmd,
-		unsigned long arg)
-{
-	switch (cmd) {
-	case RTC_PIE_ON:
-	case RTC_PIE_OFF:
-	case RTC_UIE_ON:
-	case RTC_UIE_OFF:
-	case RTC_AIE_ON:
-	case RTC_AIE_OFF:
-		return 0;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-}
-
 static int sirfsoc_rtc_alarm_irq_enable(struct device *dev,
 		unsigned int enabled)
 {
@@ -250,7 +233,6 @@ static const struct rtc_class_ops sirfsoc_rtc_ops = {
 	.set_time = sirfsoc_rtc_set_time,
 	.read_alarm = sirfsoc_rtc_read_alarm,
 	.set_alarm = sirfsoc_rtc_set_alarm,
-	.ioctl = sirfsoc_rtc_ioctl,
 	.alarm_irq_enable = sirfsoc_rtc_alarm_irq_enable
 };
 
-- 
2.16.1
