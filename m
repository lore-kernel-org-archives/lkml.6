Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeBUVNi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:13:38 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47016 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbeBUU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 048/100] rtc: mt7622: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:43 +0100
Message-Id: <20180221205635.31314-49-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-mt7622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index d79b9ae4d237..da213278f343 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -232,7 +232,7 @@ static int mtk_rtc_gettime(struct device *dev, struct rtc_time *tm)
 
 	mtk_rtc_get_alarm_or_time(hw, tm, MTK_TC);
 
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int mtk_rtc_settime(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
