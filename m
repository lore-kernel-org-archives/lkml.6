Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14DFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5291B208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RDz/78JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5291B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbeKPTvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:51:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37466 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389353AbeKPTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:51:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so20372939wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+x4gZldggHlzdHQz00b/cyfGAcoEovGq8uvpx7mJ1tA=;
        b=RDz/78JT26abdatdXVolxZLdV1ghf7MXHTqxoZtXLAtlEjfs3utgBNVbOhZWTx21ml
         7zcqLBWUaq5dCQSCScWe8/HDJP6RYVkyV2jkZbeYLBWDp4kaz+1wJ8nKDlGiBIm+rsGU
         pUIozRozeb2olYF0MOIRvDi/BeTR/4DHEGquf4/y6fZisCTmjJ+TMicv2wyo2iFHqO81
         dRIMtWJvsAFxe0/Q5dnwhK0Y4VNvB+1spM3gEKNFe0fXFUjC3J5raLr6wpttjSAtkZKl
         6iaxw+ihMVwkT5TL3dmMDrmMuO4NNOl6qCRbf8JRwNbpsB/alLXMNdeNy8dfw/0RxKR6
         hXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+x4gZldggHlzdHQz00b/cyfGAcoEovGq8uvpx7mJ1tA=;
        b=L1filVXMYrfDMoL3oZLJQZjmOHETMAcx1+S7oV2+d2q+6pO1CUGwrQ/zpuKeLt+mqq
         7FfM+iYZUK4wuHOOETZvhC6SrOM7WbToNctR8E145KgVo6/B8TBxh/Al9UEmWimvdb93
         qmho4IAvs5QIlnWDse3mPrDn9vvBPi+UPXSRw88puWOPTnINBRPReNa47Mtfidg9407n
         B8XwVfmrmne8qGmIS3+PlPlHU5thN9e5ktok4a/kbCIlvUCZ5/SlOtVpsZXs68C88U/O
         DWicUlx2z/1WjPBBxXT5ZyfkaNk1nVSR85bAQGt3m7RfHxoVDaGZOJTA3d3Ia4pziZTA
         6lbQ==
X-Gm-Message-State: AGRZ1gL94OIlERc+/yQvZVou0CveijqwV4naPD5F9meGsPwuwBK0hFZR
        mVD3He2r0jTu3eUPCsXJ5P2QaQ==
X-Google-Smtp-Source: AJdET5flBFuibyQWEzf0fkoLHu8vXCMIH9gYqVuqzAeVmG6b1pPoLbOa0ip9OW+XzOrgJD23rvIKLw==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr2100601wme.44.1542361187344;
        Fri, 16 Nov 2018 01:39:47 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id o15sm12760780wrp.12.2018.11.16.01.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 01:39:46 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 2/2] arm64: dts: meson: add libretech aml-s805x-ac board
Date:   Fri, 16 Nov 2018 10:39:38 +0100
Message-Id: <20181116093938.26373-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116093938.26373-1-jbrunet@baylibre.com>
References: <20181116093938.26373-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

Add Libretech aml-s805x-ac board (aka 'La Frite') support

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  | 248 ++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index c31f29d660de..bc41629c5df4 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-libretech-ac.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
new file mode 100644
index 000000000000..dc025b6c3199
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "meson-gxl-s905x.dtsi"
+
+/ {
+	compatible = "libretech,aml-s805x-ac", "amlogic,s805x",
+		     "amlogic,meson-gxl";
+	model = "Libre Computer Board AML-S805X-AC";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		spi0 = &spifc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cvbs-connector {
+		/*
+		 * The pads are present but no connector is soldered on
+		 * 2J2, so keep this off by default.
+		 */
+		status = "disabled";
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	dc_5v: regulator-dc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x20000000>;
+	};
+
+	vcck: regulator-vcck {
+		compatible = "regulator-fixed";
+		regulator-name = "VCCK";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_5v>;
+
+		/*
+		 * This is controlled by GPIOAO_9 we reserve this but
+		 * claiming it as done bellow reset the board anyway
+		 * Need to investigate this
+		 *
+		 * gpio = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+		 * enable-active-high;
+		 */
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_5v>;
+		regulator-always-on;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+};
+
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&ethmac {
+	status = "okay";
+};
+
+&internal_phy {
+	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names = "default";
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&gpio_ao {
+	gpio-line-names = "UART TX",
+			  "UART RX",
+			  "7J1 Header Pin31",
+			  "", "", "", "",
+			  "IR In",
+			  "HDMI CEC",
+			  "5V VCCK Regulator",
+			  /* GPIO_TEST_N */
+			  "";
+};
+
+&gpio {
+	gpio-line-names = /* Bank GPIOZ */
+			  "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "",
+			  "Eth Link LED", "Eth Activity LED",
+			  /* Bank GPIOH */
+			  "HDMI HPD", "HDMI SDA", "HDMI SCL",
+			  "", "7J1 Header Pin13",
+			  "7J1 Header Pin15",
+			  "7J1 Header Pin7",
+			  "7J1 Header Pin12",
+			  "7J1 Header Pin16",
+			  "7J1 Header Pin18",
+			  /* Bank BOOT */
+			  "eMMC D0", "eMMC D1", "eMMC D2", "eMMC D3",
+			  "eMMC D4", "eMMC D5", "eMMC D6", "eMMC D7",
+			  "eMMC Clk", "eMMC Reset", "eMMC CMD",
+			  "SPI NOR MOSI", "SPI NOR MISO", "SPI NOR Clk",
+			  "", "SPI NOR Chip Select",
+			  /* Bank CARD */
+			  "", "", "", "", "", "", "",
+			  /* Bank GPIODV */
+			  "", "", "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "", "", "",
+			  "7J1 Header Pin27", "7J1 Header Pin28", "",
+			  "7J1 Header Pin29",
+			  "VCCK Regulator", "VDDEE Regulator",
+			  /* Bank GPIOX */
+			  "7J1 Header Pin22", "7J1 Header Pin26",
+			  "7J1 Header Pin36", "7J1 Header Pin38",
+			  "7J1 Header Pin40", "7J1 Header Pin37",
+			  "7J1 Header Pin33", "7J1 Header Pin35",
+			  "7J1 Header Pin19", "7J1 Header Pin21",
+			  "7J1 Header Pin24", "7J1 Header Pin23",
+			  "7J1 Header Pin8", "7J1 Header Pin10",
+			  "", "", "7J1 Header Pin32", "", "",
+			  /* Bank GPIOCLK */
+			  "", "";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_boot>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+&spifc {
+	status = "okay";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	w25q32: spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <3000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb0 {
+	status = "okay";
+};
-- 
2.19.1

