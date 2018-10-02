Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C2C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0247F20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HB4EZjdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0247F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJCFqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:46:30 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29591 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:46:29 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w92N00jc014310;
        Wed, 3 Oct 2018 08:00:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w92N00jc014310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538521201;
        bh=yEsb14f4hVUbguno0soZFpNPLgdGdEZlqgznKIHEs3E=;
        h=From:To:Cc:Subject:Date:From;
        b=HB4EZjdnVCjoiQTCoYgivTARxMbU8LJZmKqNv1a11OJ7GKIoRf6zpgTYQQBLXituh
         lWvBrrdUva6qFtXYXGj61RjmBvd32UakC147uXT4WtSdi2tsXbdRJ4xa4RiCzbs71a
         /J9L82k5X6dc3028ORic77mnPLS7tea0+l5lF3JfvhM4LX+Q0RPh+7bVkunzlGMJ41
         bG9E0HATKApcR3pmDoJ+Ck21bD5k09LCPHg0OAHOy+ChSARuEuLt6qEEnMJ8Nm6ZYf
         GA95aIcsFCxN/WC3azOnBrw2A/1aFVTAxqnZguZHaLkRdJfX830esUUTa3InRZGV3j
         eQujy+LsvoH0g==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] ARM: dts: uniphier: add SD/eMMC controller nodes
Date:   Wed,  3 Oct 2018 07:59:50 +0900
Message-Id: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD controller nodes for LD4, Pro4, sLD8, Pro5, and PXs2.
This is also used as an eMMC controller for LD4, Pro4, and sLD8.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts     |  4 +++
 arch/arm/boot/dts/uniphier-ld4.dtsi        | 34 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    |  4 +++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi    |  5 ++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts    |  4 +++
 arch/arm/boot/dts/uniphier-pro4-ref.dts    |  4 +++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  |  4 +++
 arch/arm/boot/dts/uniphier-pro4.dtsi       | 48 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi       | 34 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts |  4 +++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  |  4 +++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 34 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8-ref.dts    |  4 +++
 arch/arm/boot/dts/uniphier-sld8.dtsi       | 34 +++++++++++++++++++++
 14 files changed, 221 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 21407e1..3aaca10 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -63,6 +63,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 2a17066..fa00ec8 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -224,6 +224,40 @@
 			};
 		};
 
+		sd: sdhc@5a400000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a400000 0x200>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&mio_clk 0>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 0>, <&mio_rst 3>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
+		emmc: sdhc@5a500000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a500000 0x200>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&mio_clk 1>;
+			reset-names = "host", "bridge", "hw";
+			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
 		usb0: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index a0a44a4..e505a94 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -65,6 +65,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 51f0e69..aeb47b0 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -121,6 +121,11 @@
 		function = "sd";
 	};
 
+	pinctrl_sd_uhs: sd-uhs {
+		groups = "sd";
+		function = "sd";
+	};
+
 	pinctrl_sd1: sd1 {
 		groups = "sd1";
 		function = "sd1";
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index db1b089..46e0917 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -68,6 +68,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index efb0849..1429908 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -65,6 +65,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index dac4d66..eaca4a7 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -71,6 +71,10 @@
 	status = "okay";
 };
 
+&emmc {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index da88ccc..e2e13de 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -258,6 +258,54 @@
 			};
 		};
 
+		sd: sdhc@5a400000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a400000 0x200>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&mio_clk 0>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 0>, <&mio_rst 3>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
+		emmc: sdhc@5a500000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a500000 0x200>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&mio_clk 1>;
+			reset-names = "host", "bridge", "hw";
+			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
+		sd1: sdhc@5a600000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a600000 0x200>;
+			interrupts = <0 85 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd1>;
+			clocks = <&mio_clk 2>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 2>, <&mio_rst 5>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
 		usb2: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 40a84f2..cabee2d 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -443,6 +443,40 @@
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
+
+		emmc: sdhc@68400000 {
+			compatible = "socionext,uniphier-sd-v3.1";
+			status = "disabled";
+			reg = <0x68400000 0x800>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&sd_clk 1>;
+			reset-names = "host", "hw";
+			resets = <&sd_rst 1>, <&sd_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
+		sd: sdhc@68800000 {
+			compatible = "socionext,uniphier-sd-v3.1";
+			status = "disabled";
+			reg = <0x68800000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index bed26b8..3a34694 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -76,6 +76,10 @@
 	};
 };
 
+&emmc {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index b13d2d1..545cc3e 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -77,6 +77,10 @@
 	status = "okay";
 };
 
+&emmc {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 79f5c2d..c7e5175 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -422,6 +422,40 @@
 			};
 		};
 
+		emmc: sdhc@5a000000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a000000 0x800>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&sd_clk 1>;
+			reset-names = "host", "hw";
+			resets = <&sd_rst 1>, <&sd_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
+		sd: sdhc@5a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a400000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
 		soc_glue: soc-glue@5f800000 {
 			compatible = "socionext,uniphier-pxs2-soc-glue",
 				     "simple-mfd", "syscon";
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index fe386fa..01bf94c 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -63,6 +63,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index dc723bf..388109d 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -228,6 +228,40 @@
 			};
 		};
 
+		sd: sdhc@5a400000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a400000 0x200>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&mio_clk 0>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 0>, <&mio_rst 3>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
+		emmc: sdhc@5a500000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a500000 0x200>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&mio_clk 1>;
+			reset-names = "host", "bridge", "hw";
+			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
 		usb0: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
-- 
2.7.4

