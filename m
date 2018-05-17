Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEQMFJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:05:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750938AbeEQMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:05:06 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 1/4] rtc: stm32: fix misspelling and misalignment issues
Date: Thu, 17 May 2018 14:04:23 +0200
Message-ID: <1526558666-24243-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
References: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans the following checkpatch complaints:

CHECK: 'initalized' may be misspelled - perhaps 'initialized'?
#644: FILE: drivers/rtc/rtc-stm32.c:644:
+	 * the calendar has been initalized or not. INITS flag is reset by a

CHECK: Alignment should match open parenthesis
#669: FILE: drivers/rtc/rtc-stm32.c:669:
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
+			&stm32_rtc_ops, THIS_MODULE);

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index de49b5b..d41f804 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -641,7 +641,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	/*
 	 * After a system reset, RTC_ISR.INITS flag can be read to check if
-	 * the calendar has been initalized or not. INITS flag is reset by a
+	 * the calendar has been initialized or not. INITS flag is reset by a
 	 * power-on reset (no vbat, no power-supply). It is not reset if
 	 * rtc_ck parent clock has changed (so RTC prescalers need to be
 	 * changed). That's why we cannot rely on this flag to know if RTC
@@ -666,7 +666,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 			 "alarm won't be able to wake up the system");
 
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
-			&stm32_rtc_ops, THIS_MODULE);
+						&stm32_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		ret = PTR_ERR(rtc->rtc_dev);
 		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
-- 
2.7.4
