Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeETMd4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 08:33:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54498 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbeETMdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 08:33:51 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: st-lpc: add range
Date: Sun, 20 May 2018 14:33:37 +0200
Message-Id: <20180520123337.14856-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
References: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC has a 64 bit counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 2f1ef2c28740..df467ace397b 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -258,6 +258,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->rtc_dev->ops = &st_rtc_ops;
+	rtc->range_max = do_div(U64_MAX, rtc->clkrate);
 
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret) {
-- 
2.17.0
