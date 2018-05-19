Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeESIxq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:53:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41287 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbeESIxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:53:44 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: mxc_v2: use rtc_time64_to_tm in mxc_rtc_read_alarm
Date: Sat, 19 May 2018 10:53:30 +0200
Message-Id: <20180519085330.1211-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 64-bit version of rtc_time_to_tm in mxc_rtc_read_alarm

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mxc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index 24ca74ca632a..c75f26dc8fcc 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -193,7 +193,7 @@ static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	rtc_time_to_tm(readl(ioaddr + SRTC_LPSAR), &alrm->time);
+	rtc_time64_to_tm(readl(ioaddr + SRTC_LPSAR), &alrm->time);
 	alrm->pending = !!(readl(ioaddr + SRTC_LPSR) & SRTC_LPSR_ALP);
 	return mxc_rtc_unlock(pdata);
 }
-- 
2.17.0
