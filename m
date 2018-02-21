Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBUVk2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:40:28 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48141 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:40:27 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] parisc: time: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 22:40:23 +0100
Message-Id: <20180221214023.1045-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/parisc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 4b8fd6dc22da..f2890bd240f8 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -173,7 +173,7 @@ static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 
 	/* we treat tod_sec as unsigned, so this can work until year 2106 */
 	rtc_time64_to_tm(tod_data.tod_sec, tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
