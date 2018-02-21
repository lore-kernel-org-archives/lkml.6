Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeBUVIb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:08:31 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47049 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeBUU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:45 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 068/100] rtc: starfire: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:56:03 +0100
Message-Id: <20180221205635.31314-69-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-starfire.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-starfire.c b/drivers/rtc/rtc-starfire.c
index 7fc36973fa33..a7d49329d626 100644
--- a/drivers/rtc/rtc-starfire.c
+++ b/drivers/rtc/rtc-starfire.c
@@ -28,7 +28,7 @@ static u32 starfire_get_time(void)
 static int starfire_read_time(struct device *dev, struct rtc_time *tm)
 {
 	rtc_time_to_tm(starfire_get_time(), tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static const struct rtc_class_ops starfire_rtc_ops = {
-- 
2.16.1
