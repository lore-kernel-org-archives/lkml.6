Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBUVho (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:37:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48058 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBUVhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:37:42 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] m68k: time: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 22:37:24 +0100
Message-Id: <20180221213724.810-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/m68k/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 87160b4415fb..97dd4e26f234 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -91,7 +91,7 @@ void read_persistent_clock(struct timespec *ts)
 static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
 	mach_hwclk(0, tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
