Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B5AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8D0204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpuSef93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8D0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbeKGHfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45042 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbeKGHfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so47647lfe.11;
        Tue, 06 Nov 2018 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SMzLuSs+AoD/owzTff6Faany4qtD8zZKeazdfsy8Lcg=;
        b=rpuSef93POB+pWBoqTDow4B/TwETWWGP75gl8S5e1DH9JWIv4t7RmBGae1CqeRp3L7
         S/JruDQl6lwft4c9Fck7xJHgiSptnGjCjobdXhFItZ7x34R5D8+62KUPoIH5OyvO3TcX
         KjilKikbrucP4riCg8hCSZ5GtHO2Ty8zYuJEubkOQO9pT14FRHgdw2wmBBJMjygunGDv
         fE+7KI5S9Koqq9UYK0xZvtPC9lF+fQaT9zcMeOkCHCHLqWiJksVq9rQQ2VFAJ2YsotLS
         kUJNPGTQZaVwieTeXtI86OaTo4zgxnrpZkmPE80a6NQDrjONpf9jX6VVxhdEP7i2LN9F
         NbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SMzLuSs+AoD/owzTff6Faany4qtD8zZKeazdfsy8Lcg=;
        b=DNDJumKgAGBEACErNJQQ6pXhtYRPIzIXLIiEJf61CeN7vQ2uLA+7i5vYJYKdCpbEq7
         Qsoto8YvFIe8ZSt1DdImwjLIfU3TZTRL772EGHBlVHNlWDaa4+TnH5xyL7ol0JiIc5xb
         qImdjI8NMMuAx8Lf6X/79hGGPpXsfgk/GspRkKAi62/uEtsLwDNsqCuD03oIjNscDzSd
         8jGzES1hXaUMxKXEnogSX8imOcaxu6xTWypF2KVhlwsEMRFV+jReOYnNflb2yaBIS6Kf
         AvGVfh8aT3PeZBQ24vQ7pttnETFig5jMTLplNmWRAXKcaEkunt5H6Y5mieW7XAyOqH1A
         rRUg==
X-Gm-Message-State: AGRZ1gLfvgdtqAeaRzHGeOhQQITg0dy7j6fakp/h7zgkn0CYikhCezEa
        jzKkJI3Fgv7fhH9KPGBN7yetjkOq
X-Google-Smtp-Source: AJdET5dZMLy8NQdHYlmbCZngngl2OyB9Lcqbsprr8j5nQPqnSRGGWZCJTR8JeMJq110Cw/C5ibtqkw==
X-Received: by 2002:a19:920a:: with SMTP id u10mr6278884lfd.122.1541542072171;
        Tue, 06 Nov 2018 14:07:52 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:51 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: [PATCH 04/24] dt-bindings: leds: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:12 +0100
Message-Id: <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce dedicated properties for conveying information about
LED function and color. Mark old "label" property as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
---
 Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index aa13998..3efc826 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
 have to be tightly coupled with the LED device binding. They are represented
 by child nodes of the parent LED device binding.
 
+
 Optional properties for child nodes:
 - led-sources : List of device current outputs the LED is connected to. The
 		outputs are identified by the numbers that must be defined
 		in the LED device binding documentation.
+- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
+	    from the header include/dt-bindings/leds/functions.h.
+	    If there is no matching LED_FUNCTION available, add a new one.
+- color : Color of the LED.
 - label : The label for this LED. If omitted, the label is taken from the node
 	  name (excluding the unit address). It has to uniquely identify
 	  a device, i.e. no other LED class device can be assigned the same
-	  label.
+	  label. This property is deprecated - use 'function' and 'color'
+	  properties instead.
 
 - default-state : The initial state of the LED. Valid values are "on", "off",
   and "keep". If the LED is already on or off and the default-state property is
@@ -87,29 +93,59 @@ Required properties for trigger source:
 
 * Examples
 
-gpio-leds {
+#include <dt-bindings/leds/functions.h>
+
+led-controller@0 {
 	compatible = "gpio-leds";
 
-	system-status {
-		label = "Status";
+	led0 {
+		function = LED_FUNCTION_STATUS;
 		linux,default-trigger = "heartbeat";
 		gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb {
+	led1 {
+		function = LED_FUNCTION_USB;
 		gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
 		trigger-sources = <&ohci_port1>, <&ehci_port1>;
 	};
 };
 
-max77693-led {
+led-controller@0 {
 	compatible = "maxim,max77693-led";
 
-	camera-flash {
-		label = "Flash";
+	led {
+		function = LED_FUNCTION_FLASH;
+		color = "white";
 		led-sources = <0>, <1>;
 		led-max-microamp = <50000>;
 		flash-max-microamp = <320000>;
 		flash-max-timeout-us = <500000>;
 	};
 };
+
+led-controller@68 {
+	compatible = "ti,tlc59116";
+	reg = <0x68>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	led@0 {
+		function = LED_FUNCTION_WAN;
+		color = "amber";
+		reg = <0x0>;
+	};
+
+	led@2 {
+		function = LED_FUNCTION_2G;
+		color = "white";
+		reg = <0x2>;
+	};
+
+	led@9 {
+		function = LED_FUNCTION_ALIVE;
+		color = "green";
+		reg = <0x9>;
+		linux,default_trigger = "heartbeat";
+	};
+};
-- 
2.1.4

