Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeEQUrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:47:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39327 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbeEQUrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:47:09 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: vr41xx: add range
Date: Thu, 17 May 2018 22:47:06 +0200
Message-Id: <20180517204706.28192-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517204706.28192-1-alexandre.belloni@bootlin.com>
References: <20180517204706.28192-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vr41xx RTC is a 48-bit counter counting at 32.768 kHz, giving a maximum
value of 2^(48-15)-1 seconds.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-vr41xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 2f1212a25f7e..70f013e692b0 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -300,6 +300,8 @@ static int rtc_probe(struct platform_device *pdev)
 
 	rtc->ops = &vr41xx_rtc_ops;
 
+	/* 48-bit counter at 32.768 kHz */
+	rtc->range_max = (1ULL << 33) - 1;
 	rtc->max_user_freq = MAX_PERIODIC_RATE;
 
 	spin_lock_irq(&rtc_lock);
-- 
2.17.0
