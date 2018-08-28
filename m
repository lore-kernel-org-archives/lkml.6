Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C49320869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C49320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeH1Qxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:53:53 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4725 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Qxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:53:52 -0400
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="16756400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Aug 2018 06:02:08 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Tue, 28 Aug 2018 06:02:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <shc_work@mail.ru>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH v5 7/9] pwm: add push-pull mode support
Date:   Tue, 28 Aug 2018 16:01:24 +0300
Message-ID: <1535461286-12308-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index a4ce4ad7edf0..eb170e2ab431 100644
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

