Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDSNWi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:22:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13723 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752947AbeDSNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:22:36 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/4] rtc: stm32: fix alarm interrupt flags by removing IRQF_TRIGGER_RISING
Date: Thu, 19 Apr 2018 15:21:41 +0200
Message-ID: <1524144103-21432-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC alarm interrupt is active high and already configured by device tree.
So remove IRQF_TRIGGER_RISING from driver.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 79d9e86..6a06078 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -663,8 +663,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	/* Handle RTC alarm interrupts */
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq_alarm, NULL,
-					stm32_rtc_alarm_irq,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					stm32_rtc_alarm_irq, IRQF_ONESHOT,
 					pdev->name, rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ%d (alarm interrupt) already claimed\n",
-- 
2.7.4
