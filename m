Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeBUVK4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:10:56 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47025 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeBUU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:43 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 058/100] rtc: r7301: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:53 +0100
Message-Id: <20180221205635.31314-59-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-r7301.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-r7301.c b/drivers/rtc/rtc-r7301.c
index 500e8c8a2605..169704b2ce13 100644
--- a/drivers/rtc/rtc-r7301.c
+++ b/drivers/rtc/rtc-r7301.c
@@ -224,7 +224,7 @@ static int rtc7301_read_time(struct device *dev, struct rtc_time *tm)
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return err ? err : rtc_valid_tm(tm);
+	return err;
 }
 
 static int rtc7301_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
