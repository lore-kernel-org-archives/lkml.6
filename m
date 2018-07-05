Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC977C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B7B2401B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B7B2401B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeGEHtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:49:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37320 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeGEHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:48:55 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so6152831lfb.4;
        Thu, 05 Jul 2018 00:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KZuPDxz/x1YS2l5jj2pJKP/Fx/IlT6bLBzVqIHNEMMw=;
        b=LbfXTK1Rv7y57eEwBuZfMFEmzA6Eu9ZZxsmTSMUUzoRBOVSTgVeT4s0bWA6gwmuSM0
         Wcsrac3tKI+KpRXOA2QXG299TOEW8FrtMqJI87deic5mhnhDDDoTwFFelbpd4H+45pjk
         O9dMQrXlEUzWjMZBi2m5p5tlkGFmdCl7PgQnwNRN0nxLohiYt8qoVkpay2IeWCwr7BEE
         fa0TLKVrgd1sGdlTcsFP1YFAkRAU3cQbh3zmwnd1eS9Qt3QOIOO/EcMACHgR2dNnAJSL
         wwNKgvorDH/nmChnmSCYL7J+86/XNRoH1yJRasgCD3YtP2JcQh4rp/ScHy3aBdP5Wswu
         Dw6g==
X-Gm-Message-State: APt69E0v7BwsSqqoXPSgTs95TZfPMtxXHoJ0aUs4JrW+PtJ3G083YzRc
        0BnhltD/CLr/wp+iJGKsOTQ=
X-Google-Smtp-Source: AAOMgpekS4VCs9f1cudgdMxlm12g6GSLCpSgLJ9lsuSlH1ls2yi0SSebv8mFuvJSLGABSWV2odPWJg==
X-Received: by 2002:a19:6308:: with SMTP id x8-v6mr3721610lfb.104.1530776933551;
        Thu, 05 Jul 2018 00:48:53 -0700 (PDT)
Received: from localhost.localdomain (82-203-185-123.bb.dnainternet.fi. [82.203.185.123])
        by smtp.gmail.com with ESMTPSA id t84-v6sm1276151lfi.55.2018.07.05.00.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:48:52 -0700 (PDT)
Date:   Thu, 5 Jul 2018 10:48:43 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Message-ID: <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC MFD.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
new file mode 100644
index 000000000000..67f2616288d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -0,0 +1,67 @@
+* ROHM BD71837 Power Management Integrated Circuit bindings
+
+BD71837MWV is a programmable Power Management IC for powering single-core,
+dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
+low BOM cost and compact solution footprint. It integrates 8 Buck
+egulators and 7 LDO’s to provide all the power rails required by the SoC and
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
+ - clocks		: The parent clock connected to PMIC. If this is missng
+			  32768 KHz clock is assumed.
+ - #clock-cells		: Should be 0
+ - regulators:		: List of child nodes that specify the regulators
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
+	/* PMIC node */
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
+			/* ... */
+		};
+	};
+
+	/* Clock consumer node */
+
+	foo@0 {
+		compatible = "bar,foo";
+		/* ... */
+		clock-names = "my-clock";
+		clocks = <&pmic>;
+	};
-- 
2.14.3

