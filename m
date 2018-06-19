Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D5520836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D5520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937709AbeFSK4a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:56:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35041 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937215AbeFSK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:56:27 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so29430966lfc.2;
        Tue, 19 Jun 2018 03:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KZuPDxz/x1YS2l5jj2pJKP/Fx/IlT6bLBzVqIHNEMMw=;
        b=bg1Ee3FpNf+e+BOheUwXowBcdbVpVtTEZUNQB3UOZNiJdEIrlm/Br5rv1Ez8s1rgYa
         NwgBAG35QsBlHGLiGZM7/dhrna4PLy3SohCscDveghe0HJiPiLMLa0gCdesS4FKWXFzO
         eTrfdUjoqhQH+TL4iUhDnoshGOK3eQc/Zw4YiigdMCk2eA4O76Gwgka3BiIrUqYqLEq3
         vYmnx7Q5A9uwtgan0oceqWcJV/K5kv9spdLWJ2y1CFu739/BTd3kk3zGGaa+y/tz/9Gy
         DUIUXfdq1y9GbQ333gfCmuhpAdKTW7JwJ/vQC5shWjZ4DSMhhjzwxAqLQk5FiO8582An
         nymg==
X-Gm-Message-State: APt69E2fW0C9bhFaau6Xvq0Tee7B7/J5tMQlyWFaluOvyaQLI7eNH1SY
        bkxyYsfvYErdT4u3TPfpA8o=
X-Google-Smtp-Source: ADUXVKI3ABZCKB60OKvodhST8v0snnOoA1Lveqrpxz//W8Gc0rkUlrdMiDpM6BLxcjX3kfi09Y92Cw==
X-Received: by 2002:a19:e497:: with SMTP id x23-v6mr9608817lfi.40.1529405786018;
        Tue, 19 Jun 2018 03:56:26 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id d2-v6sm3232869lfa.75.2018.06.19.03.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 03:56:25 -0700 (PDT)
Date:   Tue, 19 Jun 2018 13:56:17 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v7 2/4] mfd: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Message-ID: <80f7baefefce0a3a96e8b46e54cb84d803d6aa35.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
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

