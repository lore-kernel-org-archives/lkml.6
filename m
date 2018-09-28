Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57FB2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57FB2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeI1RKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:10:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41140 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbeI1RKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:10:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so4059513pfi.8;
        Fri, 28 Sep 2018 03:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIsQbDqt3rXqO6MKbrjUMhn197Xf08Tf8fSXtr8SYwc=;
        b=TTtyVvvBrQhdyGqXADlfQWDzTHfwEW+LLAtCly0eh5qvpYSLTTj4vxwCiD+OCpoU0G
         u2q81pl7tup5AOoy2sMoTich0jmHYxoBScJ4IRtpSa3qdxbp5cOxUPUBGcUabxfM9NZS
         yF1xZbjEhhU/qg27B1atQqn4sb9sAcPGsa55jkedG1OWRbbCi+DJZIRKE/wxSul/UvS3
         A83HcnnEWrVgOVwMKuZqp+B2QAM9EUXQA48ICrdrvcu3Prvwtr2cn/zlv2yTdozMXGFp
         ISo+eID5muVBBZ+I+M/VWFytnqb12PyVr1wf3cjhO6db/fpCrAm9eaxXrbKK6zEimh8p
         lU8A==
X-Gm-Message-State: ABuFfoiMHOfc2rqAFjY+jXW4lubYSrPKpcr0QmESF7nzlryXbPW/i7Xf
        JlYqe1bGRxzG0EMGGigzw4k=
X-Google-Smtp-Source: ACcGV63Sdrn5XoGEFWkNarXLaqL/2G47MDQUEmyPkRvnuPiV3BzRWhxGcOMWdSRnqIi6e9O0qwxHkQ==
X-Received: by 2002:a63:3e06:: with SMTP id l6-v6mr14268578pga.96.1538131651736;
        Fri, 28 Sep 2018 03:47:31 -0700 (PDT)
Received: from szlin-TW ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id p3-v6sm7087339pfo.130.2018.09.28.03.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 03:47:31 -0700 (PDT)
Received: from root by szlin-TW with local (Exim 4.91)
        (envelope-from <root@localhost>)
        id 1g5qJ0-0007zU-3u; Fri, 28 Sep 2018 18:47:30 +0800
From:   =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
Cc:     =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>, Wes Huang <wes.huang@moxa.com>,
        Fero JD Zhou <FeroJD.Zhou@moxa.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: am335x: add common file for UC-2100 series
Date:   Fri, 28 Sep 2018 18:47:16 +0800
Message-Id: <20180928104718.30661-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UC-2100 series consists many boards with different peripheral
devices and wireless modules, hence we fetch common items and
create a common dtsi file to increase reusability. All boards in
UC-2100 series will include this common dtsi file.

Signed-off-by: Wes Huang (黃淵河) <wes.huang@moxa.com>
Signed-off-by: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
---
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi

diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
new file mode 100644
index 000000000000..14f781953475
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MOXA Inc. - https://www.moxa.com/
+ *
+ * Authors: SZ Lin (林上智) <sz.lin@moxa.com>
+ *          Wes Huang (黃淵河) <wes.huang@moxa.com>
+ *          Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
+ */
+
+#include "am33xx.dtsi"
+
+/ {
+	vbat: vbat-regulator {
+		compatible = "regulator-fixed";
+	};
+
+	/* Power supply provides a fixed 3.3V @3A */
+	vmmcsd_fixed: vmmcsd-regulator {
+	      compatible = "regulator-fixed";
+	      regulator-name = "vmmcsd_fixed";
+	      regulator-min-microvolt = <3300000>;
+	      regulator-max-microvolt = <3300000>;
+	      regulator-boot-on;
+	};
+
+	buttons: push_button {
+		compatible = "gpio-keys";
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+		>;
+	};
+
+	push_button_pins: pinmux_push_button {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.gpio2_23 */
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
+
+	mmc1_pins_default: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			/* eMMC */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad12.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad13.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad14.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad15.mmc1_dat3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad8.mmc1_dat4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad9.mmc1_dat5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad10.mmc1_dat6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad11.mmc1_dat7 */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+		>;
+	};
+
+	spi0_pins: pinmux_spi0 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	 /* spi0_d1.spi0_d1 */
+		>;
+	};
+};
+
+&uart0 {
+	/* Console */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c16";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+
+	rtc_wdt: rtc_wdt@68 {
+		compatible = "dallas,ds1374";
+		reg = <0x68>;
+	};
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&cppi41dma  {
+	status = "okay";
+};
+
+/* Power */
+&vbat {
+	regulator-name = "vbat";
+	regulator-min-microvolt = <5000000>;
+	regulator-max-microvolt = <5000000>;
+};
+
+&mac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_default>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&davinci_mdio_default>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	status = "okay";
+};
+
+&cpsw_emac1 {
+	status = "okay";
+};
+
+&phy_sel {
+	reg= <0x44e10650 0xf5>;
+	rmii-clock-ext;
+};
+
+&sham {
+	status = "okay";
+};
+
+&aes {
+	status = "okay";
+};
+
+&gpio0 {
+	ti,no-reset-on-init;
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <8>;
+	pinctrl-0 = <&mmc1_pins_default>;
+	ti,non-removable;
+	status = "okay";
+};
+
+&buttons {
+	pinctrl-names = "default";
+	pinctrl-0 = <&push_button_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	button@0 {
+		label = "push_button";
+		linux,code = <0x100>;
+		gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+	};
+};
+
+/* SPI Busses */
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+
+	m25p80@0 {
+		compatible = "mx25l6405d";
+		spi-max-frequency = <40000000>;
+
+		reg = <0>;
+		spi-cpol;
+		spi-cpha;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* reg : The partition's offset and size within the mtd bank. */
+			partitions@0 {
+				label = "MLO";
+				reg = <0x0 0x80000>;
+			};
+
+			partitions@1 {
+				label = "U-Boot";
+				reg = <0x80000 0x100000>;
+			};
+
+			partitions@2 {
+				label = "U-Boot Env";
+				reg = <0x180000 0x40000>;
+			};
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+
+	tpm_spi_tis@0 {
+		compatible = "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+	};
+};
-- 
2.19.0

