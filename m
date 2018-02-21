Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeBUVOj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:14:39 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47014 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeBUU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 046/100] rtc: mrst: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:41 +0100
Message-Id: <20180221205635.31314-47-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-mrst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 7334c44fa7c3..901a8d170f68 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -105,7 +105,7 @@ static int mrst_read_time(struct device *dev, struct rtc_time *time)
 	/* Adjust for the 1972/1900 */
 	time->tm_year += 72;
 	time->tm_mon--;
-	return rtc_valid_tm(time);
+	return 0;
 }
 
 static int mrst_set_time(struct device *dev, struct rtc_time *time)
-- 
2.16.1
