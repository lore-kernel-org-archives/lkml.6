Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B17C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8965F23F4B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8965F23F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeGEOdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:33:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40630 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeGEOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:33:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id a6-v6so6842380ljj.7;
        Thu, 05 Jul 2018 07:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfoyDTC8uQsrI84ZsQkeiDgKEC3rRRmYX4P3Rgm69oQ=;
        b=oqE12j1A0EuQCWrGapKOrvNesGLeQzAdd0/U6lcIKP01L/eojAEAFOk0CdOtHMxX/f
         clQa6zIzr31KBWj+qkpLZNr0pn1txB24a1M2gH1aQhe9VTJyWdE+ayLcnhrjyA1k4Nxz
         70R1UNx0KucUCJb9X5u/QeW5IRMOdqiwrdvOgPi5wGjs20xpBpXaHRGZzmGjUz3YroB5
         jvEesl2eGUlwJ9b5nL2PT4/Yc+WuZcBBnX2+AoE+fP+xiiIn3x62ULKAUYHILXCJQrOH
         r9UQUeTxMJ6Q3IPw9zSjT6n83yFL8rhettoICDoBMZs9DpyAkqaeZ+au1Bux4Y+iL6WB
         n6Xg==
X-Gm-Message-State: APt69E0HJldM03WabdDrSyI6IbTk6rWySp3laVHZq4NxuBGv/D5dmYCR
        AhJ1bidZkuRKse6JRFF2oM8=
X-Google-Smtp-Source: AAOMgpfL28Jfl4lkeFl9Sz2qK6PZ5cGQrsjmdpcrFMe3NY9PzhXZQsWICAunzmlhClag3A2SrgST0g==
X-Received: by 2002:a2e:558e:: with SMTP id g14-v6mr4441196lje.4.1530801191012;
        Thu, 05 Jul 2018 07:33:11 -0700 (PDT)
Received: from localhost.localdomain (82-203-172-137.bb.dnainternet.fi. [82.203.172.137])
        by smtp.gmail.com with ESMTPSA id k22-v6sm986490lji.14.2018.07.05.07.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 07:33:10 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:32:58 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org, eballetbo@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v10 2/2] mfd: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Message-ID: <8ef84806b7152a4da2bffa0456052e98f4c6e1c6.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC MFD.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
new file mode 100644
index 000000000000..3ca56fdb5ffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -0,0 +1,62 @@
+* ROHM BD71837 Power Management Integrated Circuit bindings
+
+BD71837MWV is a programmable Power Management IC for powering single-core,
+dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
+low BOM cost and compact solution footprint. It integrates 8 Buck
+egulators and 7 LDOs to provide all the power rails required by the SoC and
+the commonly used peripherals.
+
+Datasheet for PMIC is available at:
+https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
+
+Required properties:
+ - compatible		: Should be "rohm,bd71837".
+ - reg			: I2C slave address.
+ - interrupt-parent	: Phandle to the parent interrupt controller.
+ - interrupts		: The interrupt line the device is connected to.
+ - clocks		: The parent clock connected to PMIC. If this is missing
+			  32768 KHz clock is assumed.
+ - #clock-cells		: Should be 0.
+ - regulators:		: List of child nodes that specify the regulators.
+			  Please see ../regulator/rohm,bd71837-regulator.txt
+
+Optional properties:
+- clock-output-names	: Should contain name for output clock.
+
+Example:
+
+	/* external oscillator node */
+	osc: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <1>;
+		clock-frequency  = <32768>;
+		clock-output-names = "osc";
+	};
+
+	pmic: pmic@4b {
+		compatible = "rohm,bd71837";
+		reg = <0x4b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 GPIO_ACTIVE_LOW>;
+		interrupt-names = "irq";
+		#clock-cells = <0>;
+		clocks = <&osc 0>;
+		clock-output-names = "bd71837-32k-out";
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <1250>;
+			};
+		};
+	};
+
+	/* Clock consumer node */
+	rtc@0 {
+		compatible = "company,my-rtc";
+		clock-names = "my-clock";
+		clocks = <&pmic>;
+	};
-- 
2.14.3

