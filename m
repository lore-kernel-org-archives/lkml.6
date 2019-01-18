Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E963C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HUWWzki7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfARNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:44:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39453 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfARNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so4525258wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/KRarYfj/1Ot/ceWKaBAxhNsDNgQGntcu1QYSAIn/A=;
        b=HUWWzki7QY8XTTdiXgnlWwU+7SovCBSG11aK9A2Mo+vbMn+NJRQUZuNoYlfkCbU7If
         wtORLLa6/ZzHOMaJdq3JxcycqtcWlSGpqGd6hnqZGbmvbomb1QPWIFvtRfH1zPsLXxj/
         EQ7Fzl4XXYijOB55zP6qjp5bXKnSsL33a3V4/0/TatIV2SOJdm1NkP5+QpwpeAE4ghqK
         4n5QgS7m41MbHZ8uIcwsGFN8GA63RzjpUNsH8c4c6HJzn2z9Q1jEdZ9ST72fb64VUXVB
         pn9nkt3c4X/q9xuc/PCJ8AF3bkwLY7coyqkEvkxDtk8GbyZvWLC54VUB962zYYPPM/uF
         BqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/KRarYfj/1Ot/ceWKaBAxhNsDNgQGntcu1QYSAIn/A=;
        b=BIt4pVQRDEsuAHZLsy2AnvdQE6AF5eNgQfrfUBFLR2lJs3ETAefK1JVozuElYT6sN2
         EUorVMaVd8EjN3R3M5IpqKOFILtcgGBsTggFDRNkOE7kIX3YF2i0GQgjBEOF4lqJ1Dd4
         nW2/g85+reUm5N4iQG7VhZKcCAAT54AshYJAQ78ItgEdrEh+yzfa98BeqNuO/voRpMSb
         EiAkBsOR+QWw330LYMgMto913bYJdBEeg/4JV908pgt7nuRR+BmlFWdUGIB9gSUxXvkj
         3piEYTRulxXHr3FuS+cfc3CkBIZVHOaO0lGYYpyvcFeeCQiHAKAEG0buwwjjjFyPlReI
         +J0Q==
X-Gm-Message-State: AJcUukdUaa60//Xz7ZyLIb1VBjvlSUP/tc7imZk+qX/5/zg2SMsXxfUM
        zQg9JHNYzLEaQVGjZB12lqlmJg==
X-Google-Smtp-Source: ALg8bN7cAHZJMZpcqo85p29mshJGwK9LI2Wy1crq7nT1awe7X7IsxEPXKOya9ZJUlddQFkkOt5hREg==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr16018369wmc.113.1547818990421;
        Fri, 18 Jan 2019 05:43:10 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/13] dt-bindings: leds: add DT bindings for max77650
Date:   Fri, 18 Jan 2019 14:42:36 +0100
Message-Id: <20190118134244.22253-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190118134244.22253-1-brgl@bgdev.pl>
References: <20190118134244.22253-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
new file mode 100644
index 000000000000..822b8893bc20
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -0,0 +1,57 @@
+LED driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The LED controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has three current sinks.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-leds"
+- #address-cells:	Must be <1>.
+- #size-cells:		Must be <0>.
+
+Each LED is represented as a sub-node of the LED-controller node. Up to
+three sub-nodes can be defined.
+
+Required properties of the sub-node:
+------------------------------------
+
+- reg:			Must be <0>, <1> or <2>.
+
+Optional properties of the sub-node:
+------------------------------------
+
+- label:		See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	leds {
+		compatible = "maxim,max77650-leds";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led0 {
+			reg = <0>;
+			label = "max77650:blue:usr0";
+		};
+
+		led1 {
+			reg = <1>;
+			label = "max77650:red:usr1";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led2 {
+			reg = <2>;
+			label = "max77650:green:usr2";
+		};
+	};
-- 
2.19.1

