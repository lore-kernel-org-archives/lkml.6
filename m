Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeBUVLX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:11:23 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47021 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBUU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:43 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 057/100] rtc: ps3: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:52 +0100
Message-Id: <20180221205635.31314-58-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtc_time_to_tm never generates an invalid tm. It is not necessary to
validate it. Also, the RTC core is always calling rtc_valid_tm after the
read_time callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ps3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ps3.c b/drivers/rtc/rtc-ps3.c
index 6a8f5d758eac..347288bff438 100644
--- a/drivers/rtc/rtc-ps3.c
+++ b/drivers/rtc/rtc-ps3.c
@@ -41,7 +41,7 @@ static u64 read_rtc(void)
 static int ps3_get_time(struct device *dev, struct rtc_time *tm)
 {
 	rtc_time_to_tm(read_rtc() + ps3_os_area_get_rtc_diff(), tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int ps3_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
