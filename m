Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCWJPe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:15:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46348 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751668AbeCWJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:29 -0400
X-UUID: 079b8eabf5b2482f82aa1f3459be29f0-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 06/16] rtc: mediatek: remove unnecessary parentheses
Date: Fri, 23 Mar 2018 17:15:03 +0800
Message-ID: <92d07e90f43899981a82fbc684c3d15aaecaf591.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-3.964800-8.000000-10
X-TMASE-MatchedRID: RviKwqHC+xdlJTodqNqEzshI95kTx6VeQl/FdRYkUZLfUZT83lbkEEtH
        ojrK13E4rr978FDbQViAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07X8VRCNw0kiD/cV
        V4ZeC0Pcy4PDy8PpiMHjXqtiLMVy/tYgZAet2fB6zX1Y5tjAkB5wPJY7+f6ROOL0tgq42erKkPw
        z7S39OurXpNhFtIO5o2kC7SwvGlKhDwb7Jglhh1lFkOwaJdCKgviPEqcclEtzAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.964800-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Remove unnecessary parentheses due to explicit C operator precedence.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 0df7ccd..4411c08 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -106,7 +106,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
 	int ret;
 
 	ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_IRQ_STA, &irqsta);
-	if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
+	if (ret >= 0 && irqsta & RTC_IRQ_STA_AL) {
 		rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
 		irqen = irqsta & ~RTC_IRQ_EN_AL;
 		mutex_lock(&rtc->lock);
-- 
2.7.4
