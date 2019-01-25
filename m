Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6846AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360BF217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFR665rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfAYLa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfAYLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so9953766wrp.1;
        Fri, 25 Jan 2019 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Apo6kyI4moXkz5y+JmbgDq/SbREeohTrEGMe1T3mus=;
        b=hFR665rCmboVrJ1uXor+IwNsFOMhct3XBl0Y3+UlQ4alNU8DB3EHGA6P9PId3IgYXs
         +sXbkMSpSeTYoFn9MdHeAsj7VWIivA3M0ahHXL0MyrlfrraU4fibobGBliFl9/Nvdah5
         h62hor5isHvUTo8L6HIcEE1chwVRCOITlE1dIWp05BK2IExJlaQ+GIcjnFgSyVIVtaLK
         fV9lmBZD1OHKk6MWBsdSlKHtkJWmNUuiZasRmAkOBN9V7B04P8xlaWMtU/iMzikNETTP
         gXupn1vkjSIw83gEff/TLSgNnddJLZKePWmwEMJXUwUwUDecu/2+RwHJj3y5yPpQ4Lc4
         TIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Apo6kyI4moXkz5y+JmbgDq/SbREeohTrEGMe1T3mus=;
        b=Q0m+xkFhbTbBJ08wFYZqyaIHl0HprMhi7lbguxO+Pw8Q2Sa7G+ZOWm8H129QhqIjwl
         NL65pltRR79Lno3iijvK7HqLMIJKvYvJ55G11t9KKlO0rPSj16L6GwpoMzDJsurcGnn8
         l/94E8vMGeSdEk4KCXw064KbdhPpjEv14A/BLEeviDh8j5TV04ZdyQUPhnRD8E/3Db+r
         jvVhdqLzByAo6hk6Q25XVxrOsclzIc16zTQ2FBuTI5w1tzDMqDK+1JZzy4++XjajogEq
         iOuhtGexw5l1Xtq9vMXylAKMJ0hWrmDUGisC5IsqyHzNO2MATs6CCVB1hlXMsm/KfD+T
         UvjA==
X-Gm-Message-State: AHQUAuZUWtaZqmexTqIBGC+e6uqN7BcKRf0Ly3dMCZMLs6FBEUsPlzVy
        p90KzPYlmW0Qa+UbllWx0RA=
X-Google-Smtp-Source: AHgI3IaejyOtgVv5k9CLMqd/kAuD/egtpGXFyvbpVeSw157TKHoRY1ysGmUhJ8sa6aysaugKIhWq7A==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr3109771wro.194.1548415821817;
        Fri, 25 Jan 2019 03:30:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v6sm95535316wrd.88.2019.01.25.03.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:30:21 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: tegra: Enable XUSB on P2771
Date:   Fri, 25 Jan 2019 12:30:12 +0100
Message-Id: <20190125113013.11447-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Enable the relevant pads for XUSB support on P2771-0000 and hook up the
USB supply voltage regulators to the ports.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../boot/dts/nvidia/tegra186-p2771-0000.dts   | 115 ++++++++++++++++++
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  19 ++-
 2 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 65487eee2ce6..ab9e4e42b4dc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -55,6 +55,93 @@
 		status = "okay";
 	};
 
+	padctl@3520000 {
+		status = "okay";
+
+		avdd-pll-erefeut-supply = <&vdd_1v8_pll>;
+		avdd-usb-supply = <&vdd_3v3_sys>;
+		dvdd-pex-supply = <&vdd_pex>;
+		dvdd-pex-pll-supply = <&vdd_pex>;
+		hvdd-pex-supply = <&vdd_1v8>;
+		hvdd-pex-pll-supply = <&vdd_1v8>;
+		vclamp-usb-supply = <&vdd_1v8>;
+		vddio-hsic-supply = <&gnd>;
+
+		pads {
+			usb2 {
+				status = "okay";
+
+				lanes {
+					usb2-0 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb2-1 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb2-2 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+				};
+			};
+
+			usb3 {
+				status = "okay";
+
+				lanes {
+					usb3-0 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb3-1 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb3-2 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "okay";
+				mode = "otg";
+
+				vbus-supply = <&vdd_usb0>;
+			};
+
+			usb2-1 {
+				status = "okay";
+				mode = "host";
+
+				vbus-supply = <&vdd_usb1>;
+			};
+
+			usb3-0 {
+				nvidia,usb2-companion = <1>;
+				status = "okay";
+			};
+		};
+	};
+
+	usb@3530000 {
+		status = "okay";
+
+		phys = <&{/padctl@3520000/pads/usb2/lanes/usb2-0}>,
+		       <&{/padctl@3520000/pads/usb2/lanes/usb2-1}>,
+		       <&{/padctl@3520000/pads/usb3/lanes/usb3-0}>;
+		phy-names = "usb2-0", "usb2-1", "usb3-0";
+	};
+
 	pcie@10003000 {
 		status = "okay";
 
@@ -177,5 +264,33 @@
 
 			vin-supply = <&vdd_5v0_sys>;
 		};
+
+		vdd_usb0: regulator@102 {
+			compatible = "regulator-fixed";
+			reg = <102>;
+
+			regulator-name = "VDD_USB0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+
+			gpio = <&gpio TEGRA_MAIN_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+
+			vin-supply = <&vdd_5v0_sys>;
+		};
+
+		vdd_usb1: regulator@103 {
+			compatible = "regulator-fixed";
+			reg = <103>;
+
+			regulator-name = "VDD_USB1";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+
+			gpio = <&gpio TEGRA_MAIN_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+
+			vin-supply = <&vdd_5v0_sys>;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index b539561e7877..eb64d9be3231 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -289,7 +289,7 @@
 						regulator-boot-on;
 					};
 
-					ldo0 {
+					vdd_1v8_pll: ldo0 {
 						regulator-name = "VDD_1V8_AP_PLL";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
@@ -358,10 +358,21 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		vdd_5v0_sys: regulator@0 {
+		gnd: regulator@0 {
 			compatible = "regulator-fixed";
 			reg = <0>;
 
+			regulator-name = "GND";
+			regulator-min-microvolt = <0>;
+			regulator-max-microvolt = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vdd_5v0_sys: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+
 			regulator-name = "VDD_5V0_SYS";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
@@ -369,9 +380,9 @@
 			regulator-boot-on;
 		};
 
-		vdd_1v8_ap: regulator@1 {
+		vdd_1v8_ap: regulator@2 {
 			compatible = "regulator-fixed";
-			reg = <1>;
+			reg = <2>;
 
 			regulator-name = "VDD_1V8_AP";
 			regulator-min-microvolt = <1800000>;
-- 
2.19.1

