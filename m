Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeBSMsN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:48:13 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:33036 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeBSMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:48:08 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, maxime.ripard@bootlin.com,
        jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v4 01/13] ARM: dtsi: axp209: add node for ADC
Date: Mon, 19 Feb 2018 13:47:24 +0100
Message-Id: <f9ae0852cbb8f902197c6e9f7d1c372408cd0ee0.1519044068.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DT node for the ADC of the PMIC so that there can be
consumers of its IIO channels declaring their consumptions via DT.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 897103e..0d9ff12 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -58,6 +58,11 @@
 		status = "disabled";
 	};
 
+	axp_adc: adc {
+		compatible = "x-powers,axp209-adc";
+		#io-channel-cells = <1>;
+	};
+
 	axp_gpio: gpio {
 		compatible = "x-powers,axp209-gpio";
 		gpio-controller;
-- 
git-series 0.9.1
