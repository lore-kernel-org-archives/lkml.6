Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD52C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfAVJqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:46:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38643 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfAVJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:46:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so17580715lfk.5;
        Tue, 22 Jan 2019 01:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGuNC5HIBq5Rve4BqBd6GYcYJvhCCif4tf0YOJDzKGk=;
        b=Mj2ATxdiAJGNtb4Hl7h93eY7sopT/IojikVUiwXm7KgmZiJkoLHKHf2lKZMeiJv4C3
         HqqQYKrwzonxX7pkmvlJZVQwzFuvagMWGbGNA8wLBYKIKkY3AxB6B7baJTqdgNXSwBnL
         CYvHdU1n1uXgekcazOxXpo9/Zo7/LlnQyKeoyzjSyUz7NuuK1A4qdWLFe8tAmP9OmVEZ
         rOJYc4wK2vxhEdhvZCc4rr99zBbnjlaywr1jQNBcqCL2T/x6nujPBPKva1bRt+2xOJnj
         zy2UReWVzkvCE1+Xozgn1ayQByJq4xQBwiQdZEXxksLXCvSujcYsLHkW21FfLeqqv0o1
         upxg==
X-Gm-Message-State: AJcUukfuU576k/QV6RNPBhfTbofnBicIaX5RGdxt3PlvRmduFob/JdsZ
        Up7IVN6RSssaxEWdWAWrzzE=
X-Google-Smtp-Source: ALg8bN56JS1xzICuOA/471adS6/l6cSUFRyz1pvID1bxrlC5GKw9duKj54BQsrw0ABoA351iFVzD6w==
X-Received: by 2002:a19:c396:: with SMTP id t144mr19650620lff.110.1548150411449;
        Tue, 22 Jan 2019 01:46:51 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a2-v6sm2781288lji.13.2019.01.22.01.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:46:50 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:46:37 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 09/13] devicetree: bindings: ROHM bd70528 regulator
 bindings
Message-ID: <4818d84fe334e9f68f3968663cddce8e45c87c6c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM bd70528 is a ultra low power PMIC which includes
3 bucks, 3 LDOs and 2 LED drivers. Document the bindings
for them.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/regulator/rohm,bd70528-regulator.txt  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
new file mode 100644
index 000000000000..698cfc3bc3dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
@@ -0,0 +1,68 @@
+ROHM BD70528 Power Management Integrated Circuit regulator bindings
+
+Required properties:
+ - regulator-name: should be "buck1", "buck2", "buck3", "ldo1", "ldo2", "ldo3",
+		   "led_ldo1", "led_ldo2"
+
+List of regulators provided by this controller. BD70528 regulators node
+should be sub node of the BD70528 MFD node. See BD70528 MFD bindings at
+Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+
+The valid names for BD70528 regulator nodes are:
+BUCK1, BUCK2, BUCK3, LDO1, LDO2, LDO3, LED_LDO1, LED_LDO2
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+regulators {
+	buck1: BUCK1 {
+		regulator-name = "buck1";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3400000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <125>;
+	};
+	buck2: BUCK2 {
+		regulator-name = "buck2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <125>;
+	};
+	buck3: BUCK3 {
+		regulator-name = "buck3";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <250>;
+	};
+	ldo1: LDO1 {
+		regulator-name = "ldo1";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+	ldo2: LDO2 {
+		regulator-name = "ldo2";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	ldo3: LDO3 {
+		regulator-name = "ldo3";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	led_ldo1: LED_LDO1 {
+		regulator-name = "led_ldo1";
+		regulator-min-microvolt = <200000>;
+		regulator-max-microvolt = <300000>;
+	};
+	led_ldo2: LED_LDO2 {
+		regulator-name = "led_ldo2";
+		regulator-min-microvolt = <200000>;
+		regulator-max-microvolt = <300000>;
+	};
+};
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
