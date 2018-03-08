Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965071AbeCHKW5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:22:57 -0500
Received: from regular1.263xmail.com ([211.150.99.132]:44713 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934899AbeCHKWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:22:23 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <bb8520129f3b20da8080e6162f58ed65>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] rtc: at91sam9: Pass pdev->dev to regmap_init_mmio()
Date: Thu,  8 Mar 2018 18:21:52 +0800
Message-Id: <20180308102154.25686-3-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
References: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it would use "dummy*" to create regmap debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None

 drivers/rtc/rtc-at91sam9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7418a763ce52..0d6a17a77841 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -402,7 +402,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		if (IS_ERR(gpbr))
 			return PTR_ERR(gpbr);
 
-		rtc->gpbr = regmap_init_mmio(NULL, gpbr,
+		rtc->gpbr = regmap_init_mmio(&pdev->dev, gpbr,
 					     &gpbr_regmap_config);
 	} else {
 		struct of_phandle_args args;
-- 
2.11.0
