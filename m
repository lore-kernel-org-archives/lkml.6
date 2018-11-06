Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4629DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F720862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZ1Qb7+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081F720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbeKGHfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35082 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so12959290ljb.2;
        Tue, 06 Nov 2018 14:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A3JiDjreYluC5kjA2GvN1/ZGgxpDa7yPtmulPJNyof0=;
        b=qZ1Qb7+k6VJM5it2Vp+yBUAoCcmoFCIF0/jHAbzl3Dsi8d3FKRL10yYp0fRljvuENB
         3I1BM50OXjUcS8uuvFCrwEVZCHn7ov5QXcwWjIY7WlT3aRJ2HMmZaTwbO/SMfccUfUwj
         rKgu1koR5FGjeEuPo8WX4gqjpLgf3iWCrfBDFINUY6gx/vZJIMgfuc0HXLaD5crEUF0+
         +DfbZWPr9BQqIs8Ovlk5N6Wgh4wyb5+Fyi46fkrpTTlICzphR+0Oea9kB1leGCmUWLJj
         jyJd7fcd38FfB6PSg8n5Rk+09gxX1oqFQsLzQ/JU6QR9tB1d+Fe8kt8WAYUzpLewj1cW
         1YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A3JiDjreYluC5kjA2GvN1/ZGgxpDa7yPtmulPJNyof0=;
        b=YO1sma0eyPimvub/gSSaO/TLt+KchULspHcUVogZMXJl8VJ9n0yV0tqdzVqKzeyOzu
         jSJTOWaYpAJSPoLHlh7B4qr1rDvkOxr6obaJ3Zr99Qy+U8Nu5R6XWvJWwWaDawFYkbss
         LiP6DzuMGbPQ3ZPvF4xDIS+IyoMP0RCgWYT9kU7KsyhB6HI6Hro0MQSwC8in5k1yV47P
         HonBdjYhEtSGatvKe7p/R9tSEZwA/u9h0spTB9Rx1cgOZOuYQtYp9roIq+XFX3stlMha
         Gwmz6lKtG88+vg4+mrE+jT2jhr0cbPpf+2ynDhpsZXg/17rK9bIy3O4C2hJf9I4f/OjF
         NcyA==
X-Gm-Message-State: AGRZ1gKXJvlfAXzF0TVoLo+LW4icSXJQbzY3/QrG2Q83RyCrTdEiZEsm
        N7X1o9tVToHMACpVnSFWMX5/r5pZFiU=
X-Google-Smtp-Source: AJdET5cCELBNwxyUGNJgsqayi2+HIsE1C4Tz5efbcFXC0VkQuoyK3cfApHK1fJHSMv7dUyw+eNruyQ==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr18248916ljm.72.1541542102161;
        Tue, 06 Nov 2018 14:08:22 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:21 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 21/24] dt-bindings: leds-gpio: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:29 +0100
Message-Id: <1541542052-10081-22-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/leds/leds-gpio.txt         | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Documentation/devicetree/bindings/leds/leds-gpio.txt
index a48dda2..c34cb64 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
@@ -10,8 +10,12 @@ LED sub-node properties:
 - gpios :  Should specify the LED's GPIO, see "gpios property" in
   Documentation/devicetree/bindings/gpio/gpio.txt.  Active low LEDs should be
   indicated using flags in the GPIO specifier.
-- label :  (optional)
+- function :  (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- color :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
+- label :  (optional)
+  see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 - linux,default-trigger :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
 - default-state:  (optional) The initial state of the LED.
@@ -30,27 +34,30 @@ Examples:
 
 leds {
 	compatible = "gpio-leds";
-	hdd {
-		label = "Disk Activity";
+	led@0 {
 		gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
 		linux,default-trigger = "disk-activity";
+		function = LED_FUNCTION_HDD;
 	};
 
-	fault {
+	led@1 {
 		gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
 		/* Keep LED on if BIOS detected hardware fault */
 		default-state = "keep";
+		function = LED_FUNCTION_FAULT;
 	};
 };
 
 run-control {
 	compatible = "gpio-leds";
-	red {
+	led@0 {
 		gpios = <&mpc8572 6 GPIO_ACTIVE_HIGH>;
+		color = "red";
 		default-state = "off";
 	};
-	green {
+	led@1 {
 		gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
+		color = "green";
 		default-state = "on";
 	};
 };
@@ -58,9 +65,10 @@ run-control {
 leds {
 	compatible = "gpio-leds";
 
-	charger-led {
+	led@0 {
 		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		linux,default-trigger = "max8903-charger-charging";
 		retain-state-suspended;
+		function = LED_FUNCTION_CHRG;
 	};
 };
-- 
2.1.4

