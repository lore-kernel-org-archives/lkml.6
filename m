Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1220869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F1220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeH1Qx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:53:59 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4736 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Qx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:53:58 -0400
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="16756411"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Aug 2018 06:02:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Tue, 28 Aug 2018 06:02:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <shc_work@mail.ru>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull mode
Date:   Tue, 28 Aug 2018 16:01:25 +0300
Message-ID: <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
 Documentation/pwm.txt                         | 16 ++++++++++++++++
 include/dt-bindings/pwm/pwm.h                 |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 7c8aaac43f92..6a60c0fca112 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of flags (defined in
 - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channels
 with two outputs); if not specified, the default for PWM channel will be
 used
+- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
+two outputs); if not specified the default for PWM channel will be used
 
 Example with optional PWM specifier for inverse polarity and complementary
 mode:
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 912c43da8b48..675f9351fed1 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -128,6 +128,22 @@ channel that was exported. The following properties will then be available:
     PWML1   |__|  |__|  |__|  |__|
             <--T-->
 
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel in push-pull mode, with normal polarity looks like
+        this:
+            __          __
+    PWMH __|  |________|  |________
+                  __          __
+    PWML ________|  |________|  |__
+           <--T-->
+
+    If polarity is inversed:
+         __    ________    ________
+    PWMH   |__|        |__|
+         ________    ________    __
+    PWML         |__|        |__|
+           <--T-->
+
     Where T is the signal period.
 
 Implementing a PWM driver
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index b82279cc1787..cd4265bce968 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -12,5 +12,6 @@
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
 #define PWM_MODE_COMPLEMENTARY			(1 << 1)
+#define PWM_MODE_PUSH_PULL			(1 << 2)
 
 #endif
-- 
2.7.4

