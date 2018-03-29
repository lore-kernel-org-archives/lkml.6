Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeC2LMZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:12:25 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:19024 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeC2LLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:11:23 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517900400";
   d="scan'208";a="13376169"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 7/9] pwm: add push-pull mode support
Date: Thu, 29 Mar 2018 14:10:33 +0300
Message-ID: <1522321835-6460-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add push-pull mode support. In push-pull mode the channels' outputs have
same polarities and the edges are complementary delayed for one period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 1 +
 include/linux/pwm.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 59a9df9120de..5fde2e685ca7 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -348,6 +348,7 @@ const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
 		"invalid",
 		"normal",
 		"complementary",
+		"push-pull",
 	};
 
 	if (!pwm_mode_valid(pwm, mode))
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c4aa997489f3..9a99d5659331 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -29,11 +29,14 @@ enum pwm_polarity {
  * PWM modes capabilities
  * @PWMC_MODE_NORMAL_BIT: PWM has one output
  * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
+ * @PWMC_MODE_PUSH_PULL_BIT: PWM has 2 outputs with same polarities and the
+ * edges are complementary delayed for one period
  * @PWMC_MODE_CNT: PWM modes count
  */
 enum {
 	PWMC_MODE_NORMAL_BIT,
 	PWMC_MODE_COMPLEMENTARY_BIT,
+	PWMC_MODE_PUSH_PULL_BIT,
 	PWMC_MODE_CNT,
 };
 
-- 
2.7.4
