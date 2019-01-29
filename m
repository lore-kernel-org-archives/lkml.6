Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B0DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237B321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esy4jdEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfA2KZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:25:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2KZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:25:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so9462990pfb.4;
        Tue, 29 Jan 2019 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFWGUl7z7nhwQNXynQb9n7uk9a+BMTH31BB1HMIVpnY=;
        b=Esy4jdELg3IUjWKjkOkBTrFtfTK6XK7o7SY17QtpxSCDy7rUMyYUJ7QZIRH2U3S17E
         SM5Qk+NbOABCq5Ic+xxn7k0aianbOfgjw3DpOZwM9B9mIZV2oc3/l6QhDH+0M7rkWiUs
         V91SJ1JKmNsM+9e3XR150xCEM8OLKxXsCWc6NzKwOS1aFfxL2BcNhbZSCLSQagwHm8E3
         CFIPoGNCGgz8ey65N6AnSQUA16PzZdwP5fBeKcoL9X6M2fsY2F8C1pdT9efk+MfFP5YO
         yeajrSoy0mdu8GKA1EUTP3uQy+pa2DLvV8jTmTIlXUf+Npw/s9uy4Zz8hvMH3pHEK/Lt
         6HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFWGUl7z7nhwQNXynQb9n7uk9a+BMTH31BB1HMIVpnY=;
        b=ZPHZ1nwZwCnnLa6BF0eu0BFeWDkIpdWrp4fNzcCkA0uFo8JaIQOtBwoocRLSowBRcW
         k2rNdjgy/G4vEdI3An1ogISr9/zCCRyt9KoA/+22yY/7qpDLnro4+75NSESHeVHQ3tXE
         acGqh7uSlzNli/Q5DIx36Rv3WEsfaL9k/+eIo0gl0yeXPW7SAG6+OBBcDGEqHy3E+sTl
         ODJDkjHRyYBYXTEl8VpkRNrkAkNnWnbTfYSPt7VaEC0EuTmOmPw+jMCkZON2TklRAP9L
         OpBEFUM8w0g92sTGVbgRYk5BOGhKYCCgO72p+Bvwz7kv44IMPueN8RMJMakjOktCB9OX
         68Tg==
X-Gm-Message-State: AJcUukecbSMy678Q8CSmQPqzYh/sDq+MiClC/2BonUO5KPlMnIQ3fWmT
        w583H/rBmZKIqGkpgXlsueFJLME6
X-Google-Smtp-Source: ALg8bN76tj21xfEaQOzkqF3IXWsMe04uN8p/Ac2pYKS5tK/MRnEeakbWBAV9AfRk/iq1ZLX3DDrqDw==
X-Received: by 2002:a63:e21:: with SMTP id d33mr23070880pgl.272.1548757541849;
        Tue, 29 Jan 2019 02:25:41 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.149])
        by smtp.gmail.com with ESMTPSA id d21sm47744462pfo.162.2019.01.29.02.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:25:41 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
Date:   Tue, 29 Jan 2019 10:25:20 +0000
Message-Id: <20190129102521.4141-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129102521.4141-1-linux.amoon@gmail.com>
References: <20190129102521.4141-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing vin-supply node 5.0V regulator setting to power
to usb ports, changes help fix the usb reset warning.

[  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2

Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
Tested-by: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
changes from prevoius

 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
 P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
    USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c0000020.phy.1         2                                 0mA     0mV     0mV
       phy-c0000000.phy.0         2                                 0mA     0mV     0mV
--
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2e1cd5e3a246..da729ed00408 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -28,6 +28,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	usb_otg_pwr: regulator-usb-pwrs {
 		compatible = "regulator-fixed";
 
@@ -36,6 +43,8 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		vin-supply = <&p5v0>;
+
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
-- 
2.20.1

