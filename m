Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeCWJQs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:16:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752069AbeCWJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:37 -0400
X-UUID: 83a830b4064d4762b30b0210ae769b9a-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 10/16] rtc: mediatek: add devm_of_platform_populate
Date: Fri, 23 Mar 2018 17:15:07 +0800
Message-ID: <2bf23f9f05b747674419be6008822bef43085626.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-3.025000-8.000000-10
X-TMASE-MatchedRID: K16+lmNpxx0xFdXyW/P+XUfhraIl1XgxQl/FdRYkUZLfUZT83lbkEBFx
        R5JQAS6O5PTdBxbUo2PxY0WGgfScA49oUcx9VMLgFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
        zmuoPCq1K0fn/pLyyN1WVpypmmXSUtewyr+gjll//7BNculdA7ZnE3LSMhIpPwijxkXPrl+E3Ej
        U2/O5tf9pMFLDxnlUsG4ZvF4u4vdWF15h6/oibNbKsWJ44GuEGPNxau39/BitFwHZmk+dWMmhnU
        CrcDtVn
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.025000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add devm_of_platform_populate to populate all child nodes according to
the dt-binding.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index bfc5d6f..d133d1f 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/jiffies.h>
@@ -349,7 +350,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return 0;
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.7.4
