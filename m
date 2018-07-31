Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0F208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kLojeWB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF0F208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeGaIum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:15294 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeGaIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021105;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wb9GUVDBUPBqVrKu2Kw5cfkbPHUSSjd1I9vEXuwCyBA=;
        b=kLojeWB0PvfmuetquyZvrxnC132WMYUyvNl10/eyzm9ai6R7boOoJgUUU6Se4f4eZ7
        McA6IL49/tCucugAztQL3NgG2WELSntuPqcN8WWuYCPkXueQ6yLSEUwjZmwMtKLjltOZ
        /B186cEJ/ngWeOJoDVws+/udJbih3U2cH5I61WHxRxptH4aaIGNkjl8dxqVgeIo0drb4
        m75VAmZHCYkx9iRIUAoKPBQVYZSS2g7iGGJosUQ0s1Es9LoXgJgSYgM9cUftjZnXotWF
        VrOQtjCw5KoVgXEK6XMEv/QjHRzMQqabPPoAB30HbARZy98maJ6u0Mh4S73IYjMwERvA
        K3mQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BdwOW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:39 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 05/32] ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
Date:   Tue, 31 Jul 2018 09:11:08 +0200
Message-Id: <67f5cb7d89001e0a3172844bad3e4150b6053afe.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VENC with external OPA362 amplifier needs a special
"pinmux" setup in DEVCONF1 (TVOUTBYPASS and TVOUTACEN).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ed8aff515703..654faa7773a8 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -169,6 +169,24 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&tca6507 0 GPIO_ACTIVE_LOW>;	/* W2CBW003 reset through tca6507 */
 	};
+
+	/* devconf1 setup for tvout pins */
+	pinmux_tv_out@480022d8 {
+		compatible = "pinctrl-single";
+		reg = <0x480022d8 4>;	/* CONTROL_DEVCONF1 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,bit-per-mux;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x81>;	/* TV out pin control */
+		#pinctrl-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tv_acbias_devconf1_pins>;
+		tv_acbias_devconf1_pins: pinmux_tv_acbias_devconf1_pins {
+			/*			offset	bits	mask */
+			pinctrl-single,bits = <0x00 0x40800 0x40800>;	/* set TVOUTBYPASS and TVOUTACEN */
+		};
+	};
 };
 
 &omap3_pmx_core {
-- 
2.12.2

