Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeEQUTR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:19:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeEQUTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:15 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] rtc: 88pm80x: remove unused pm80x_rtc_info members
Date: Thu, 17 May 2018 22:18:57 +0200
Message-Id: <20180517201900.22055-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
References: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm80x_rtc_info.calib_work and pm80x_rtc_info.vrtc are never used, remove
them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm80x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 76df274f3e1a..f60c0d73c2f3 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -52,10 +52,8 @@ struct pm80x_rtc_info {
 	struct regmap *map;
 	struct rtc_device *rtc_dev;
 	struct device *dev;
-	struct delayed_work calib_work;
 
 	int irq;
-	int vrtc;
 };
 
 static irqreturn_t rtc_update_handler(int irq, void *data)
-- 
2.17.0
