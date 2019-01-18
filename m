Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C2B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="keXb1I5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfARQch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40731 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfARQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so6574996plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEijnCjicnGILwhFrMB461TXW1hBMByoFGuErMag6m8=;
        b=keXb1I5xHNipIFO8YRYvl5Nyt0I+bizBTULJaWrA4rQm1UTphElVztLCeiyRPWnDZa
         gfmjgAbgCkzsmg9UeMmSyFfb5E19kz331Byl3LWtd9d7W83CzwOfnQJoSgiG+kzeFmI0
         dOZCDgF+AqyC/+HvzloFyrp2j+F7q7Ec8NdoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEijnCjicnGILwhFrMB461TXW1hBMByoFGuErMag6m8=;
        b=bbbymBoOOa4sV2MOOgsgbf7c69q9lN7DQGk0Z5GuVza40LbReXt+77FBP6rHsW0kIB
         Y6dzvnnX/Hwhh2PbCidbiwhac5sSxtfDUHF++t+qlXIL9DG5gFZeC/SmNitkVDV4dUa7
         z8W3Ducd8JewxAEj66AmHzWSc6Q1kbn4r8gTNrMmAYIyPo4gUeZ4uty+0gPbTmizpSb8
         K2l792V2TYl95GGeXTOUZ1IEWSx3skhRPktLGW7QgNmwTrcYEDODaq+4iJS9dFreTgo5
         ZaBhmM8xo/UayRPXbrEp89j+FV2MnDl+DRgPogo1xcDQSKtQS83fe+fvJ8n+nQdmqkT4
         horw==
X-Gm-Message-State: AJcUukczj5MB3cpBkPbGJy9GsCWs6+VeZNMcYod9uukP4L9/ndEIZs9c
        Gq36Vbb0UPaS/sxc8kd8E2xbIw==
X-Google-Smtp-Source: ALg8bN6fHwMOirgmCp/MatwdUw0W+yNrleJqgmFxCrB5I1IkCJEvbH9Fhfua8S0ST+/g3+MHqA9YEA==
X-Received: by 2002:a17:902:4601:: with SMTP id o1mr19802483pld.243.1547829154895;
        Fri, 18 Jan 2019 08:32:34 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:32:34 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 6/6][DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module
Date:   Fri, 18 Jan 2019 22:01:58 +0530
Message-Id: <20190118163158.21418-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bananapi M64 comes with an optional sensor based on the ov5640,
add support for it with below pin information.

- PE13, PE12 via i2c-gpio bitbanging
- CLK_CSI_MCLK as external clock
- PE1 as external clock pin muxing
- DLDO3 as AVDD supply
- ALDO1 as DOVDD supply
- ELDO3 as DVDD supply
- PE16 gpio for reset pin
- PE17 gpio for powerdown pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 83e30e0afe5b..c185ceec8c81 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -60,6 +60,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* CSI0-SDA: PE13 */
+		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>; /* CSI0-SCK: PE12 */
+		i2c-gpio,delay-us = <5>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ov5640: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_mclk_pin>;
+			clocks = <&ccu CLK_CSI_MCLK>;
+			clock-names = "xclk";
+
+			AVDD-supply = <&reg_dldo3>;
+			DOVDD-supply = <&reg_aldo1>;
+			DVDD-supply = <&reg_eldo3>;
+			reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* CSI0-RST: PE16 */
+			powerdown-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* CSI0-PWDN: PE17 */
+
+			port {
+				ov5640_ep: endpoint {
+					remote-endpoint = <&csi_ep>;
+					bus-width = <8>;
+					hsync-active = <1>; /* Active high */
+					vsync-active = <0>; /* Active low */
+					data-active = <1>;  /* Active high */
+					pclk-sample = <1>;  /* Rising */
+				};
+			};
+		};
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -106,6 +141,24 @@
 	status = "okay";
 };
 
+&csi {
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi_ep: endpoint {
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &dai {
 	status = "okay";
 };
@@ -296,6 +349,12 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
 &reg_dldo4 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <3300000>;
@@ -313,6 +372,12 @@
 	regulator-name = "cpvdd";
 };
 
+&reg_eldo3 {
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "dvdd-csi";
+};
+
 &reg_fldo1 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.18.0.321.gffc6fa0e3

