Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeEaVKH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:10:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34458 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbeEaVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:10:02 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] rtc: test: remove useless proc info
Date: Thu, 31 May 2018 23:09:55 +0200
Message-Id: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc proc callback is useless for two reasosn:
 - the test RTC is often not the first RTC so it will never be used
 - all the info is available in the name file of the RTC sys folder

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index a0d1571c4af6..f0eb8e0c5055 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -40,23 +40,12 @@ static int test_rtc_set_mmss64(struct device *dev, time64_t secs)
 	return 0;
 }
 
-static int test_rtc_proc(struct device *dev, struct seq_file *seq)
-{
-	struct platform_device *plat_dev = to_platform_device(dev);
-
-	seq_printf(seq, "test\t\t: yes\n");
-	seq_printf(seq, "id\t\t: %d\n", plat_dev->id);
-
-	return 0;
-}
-
 static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
 	return 0;
 }
 
 static const struct rtc_class_ops test_rtc_ops = {
-	.proc = test_rtc_proc,
 	.read_time = test_rtc_read_time,
 	.read_alarm = test_rtc_read_alarm,
 	.set_alarm = test_rtc_set_alarm,
-- 
2.17.0
