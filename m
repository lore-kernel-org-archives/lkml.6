Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C48C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF7021A6C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJbTdLVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF7021A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeFUTKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:10:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36916 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFUTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so5903615lfb.4;
        Thu, 21 Jun 2018 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iFV8eCFIg+VwhRqKFPTcdsFRMN7vvo+OiP3HZNgw0Y=;
        b=mJbTdLVhOKeL9QciqTQ7VHyhplRin8fo6H5aYC1h09jo15vr07vfj0ELkTentAW87V
         vuCSeOw9Nhv+v2J1NxyYcVVi07e94hIpinLHUgR4ixPixh+aefWU7rp+dUokCoBtOTOH
         2g+X4yz7p+uVELyn8lxinzeNat3CkUc1pM7ks9w5xHVjTUFxFBxUYjP1Tx/ouVESLPTN
         L0NDopsRvV4yjfU9/pUhKr/2yy7K/USnCsexkpFqME1TFcOdnutOdlY8dQ1Z3lZnM76b
         d7wdVcJ5dFLcL1ZEFAvTqU1CSf7vdnk4mHUMDeFabjJGfMcHzEHEt39iZn/IG9nAj6FD
         1zWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iFV8eCFIg+VwhRqKFPTcdsFRMN7vvo+OiP3HZNgw0Y=;
        b=YGnmu91hbYuBMvtCn6IT/CHAfxHHZOS40aG5B7oZNfM8NdKxg6OLzl5KJYvh+i2/3i
         YbsTWKHYycfIyAcJBYplmVdfDU900NZIJDtMbLtrXHXoh/cjVqNuYbkH8EQd/Q9BJ6ml
         xi3RZ3bpMncVRRsqH27DCwOlAM1UYXYyBS+UJz4/a8odahvnsTAyMMejvJx+i26FloQO
         28yRqvPC0xUTaDuMatTwOiNim6Mw9r63SRA/GrawvsnJ4J9vQY7oYZB3OFOPXYV7QK+5
         /6hNEg27Pe52ojlzqG0LoXkJTxbTqgIG0eEH85veC8/G5vG4DDKgCJ4EI1r10i9DUAGz
         7EKg==
X-Gm-Message-State: APt69E04CXmsuQ+OEhcE5Ux0US17K+fFXtFumXiFWWdHgS6Ea+TEHAZ7
        JozkkV8+M/dSaOorZ6+dbgs=
X-Google-Smtp-Source: ADUXVKJvk67EydXlaBstho+61LPyiEg5J0CkNMu3NXaEqHT7Oupznigi96AVp02z48X5YPf24d6Y2A==
X-Received: by 2002:a19:c1c1:: with SMTP id r184-v6mr17521943lff.51.1529608224018;
        Thu, 21 Jun 2018 12:10:24 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:23 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 2/7] ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones.
Date:   Thu, 21 Jun 2018 21:09:54 +0200
Message-Id: <1529608199-5583-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DTS file have initial support Samsung Aries based phones.
Initial version have support for:
- sdcard
- internal memory (present only on non 4g variant)
- max8998 pmic and rtc
- max17040 fuel gauge
- gpio keys
- fimd (no panel driver yet)
- usb (peripherial mode)
- wifi

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 397 +++++++++++++++++++++++++++++++++++
 1 file changed, 397 insertions(+)
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
new file mode 100644
index 000000000000..6e8ac3615765
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's S5PV210 based Galaxy Aries board device tree source
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "s5pv210.dtsi"
+
+/ {
+	compatible = "samsung,aries", "samsung,s5pv210";
+
+	aliases {
+		i2c6 = &i2c_pmic;
+		i2c9 = &i2c_fuel;
+	};
+
+	memory@30000000 {
+		device_type = "memory";
+		reg = <0x30000000 0x05000000
+			0x40000000 0x10000000
+			0x50000000 0x08000000>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_gpio_rst>;
+		post-power-on-delay-ms = <500>;
+		power-off-delay-us = <500>;
+	};
+
+	i2c_pmic: i2c-pmic {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj4 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj4 3 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic@66 {
+			compatible = "maxim,max8998";
+			reg = <0x66>;
+			interrupt-parent = <&gph0>;
+			interrupts = <7 0>;
+
+			max8998,pmic-buck1-default-dvs-idx = <1>;
+			max8998,pmic-buck1-dvs-gpios = <&gph0 3 GPIO_ACTIVE_HIGH>,
+							<&gph0 4 GPIO_ACTIVE_HIGH>;
+			max8998,pmic-buck1-dvs-voltage = <1275000>, <1200000>,
+							<1050000>, <950000>;
+
+			max8998,pmic-buck2-default-dvs-idx = <0>;
+			max8998,pmic-buck2-dvs-gpio = <&gph0 5 GPIO_ACTIVE_HIGH>;
+			max8998,pmic-buck2-dvs-voltage = <1100000>, <1000000>;
+
+			regulators {
+				ldo2_reg: LDO2 {
+					regulator-name = "VALIVE_1.2V";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+
+					regulator-state-mem {
+						regulator-on-in-suspend;
+					};
+				};
+
+				ldo3_reg: LDO3 {
+					regulator-name = "VUSB_1.1V";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo4_reg: LDO4 {
+					regulator-name = "VADC_3.3V";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo5_reg: LDO5 {
+					regulator-name = "VTF_2.8V";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo7_reg: LDO7 {
+					regulator-name = "VLCD_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					/* Till we get panel driver */
+					regulator-always-on;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo8_reg: LDO8 {
+					regulator-name = "VUSB_3.3V";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo9_reg: LDO9 {
+					regulator-name = "VCC_2.8V_PDA";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-always-on;
+				};
+
+				ldo11_reg: LDO11 {
+					regulator-name = "CAM_AF_3.0V";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo12_reg: LDO12 {
+					regulator-name = "CAM_SENSOR_CORE_1.2V";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo13_reg: LDO13 {
+					regulator-name = "VGA_VDDIO_2.8V";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo14_reg: LDO14 {
+					regulator-name = "VGA_DVDD_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo15_reg: LDO15 {
+					regulator-name = "CAM_ISP_HOST_2.8V";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo16_reg: LDO16 {
+					regulator-name = "VGA_AVDD_2.8V";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				ldo17_reg: LDO17 {
+					regulator-name = "VCC_3.0V_LCD";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					/* Till we get panel driver */
+					regulator-always-on;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				buck1_reg: BUCK1 {
+					regulator-name = "vddarm";
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1500000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+						regulator-suspend-microvolt = <1250000>;
+					};
+				};
+
+				buck2_reg: BUCK2 {
+					regulator-name = "vddint";
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1500000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+						regulator-suspend-microvolt = <1100000>;
+					};
+				};
+
+				buck3_reg: BUCK3 {
+					regulator-name = "VCC_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				buck4_reg: BUCK4 {
+					regulator-name = "CAM_ISP_CORE_1.2V";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+
+					regulator-state-mem {
+						regulator-off-in-suspend;
+					};
+				};
+
+				safe1_sreg: ESAFEOUT1 {
+					regulator-name = "SAFEOUT1";
+				};
+			};
+		};
+	};
+
+	i2c_fuel: i2c-fuel {
+		compatible = "i2c-gpio";
+		sda-gpios = <&mp05 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&mp05 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fuel@36 {
+			compatible = "maxim,max17040";
+			interrupt-parent = <&vic0>;
+			interrupts = <7>;
+			reg = <0x36>;
+		};
+	};
+};
+
+&xusbxti {
+	clock-frequency = <24000000>;
+};
+
+&pinctrl0 {
+	wlan_bt_en: wlan-bt-en {
+		samsung,pins = "gpb-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-val = <1>;
+	};
+
+	wlan_gpio_rst: wlan-gpio-rst {
+		samsung,pins = "gpg1-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+	};
+
+	wifi_host_wake: wifi-host-wake {
+		samsung,pins = "gph2-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	tf_detect: tf-detect {
+		samsung,pins = "gph3-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	wifi_wake: wifi-wake {
+		samsung,pins = "gph3-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+	};
+
+	massmemory_en: massmemory-en {
+		samsung,pins = "gpj2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&sdhci1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	max-frequency = <38400000>;
+	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4 &wifi_wake &wifi_host_wake &wlan_bt_en>;
+	pinctrl-names = "default";
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&gph2>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&sdhci2 {
+	bus-width = <4>;
+	cd-gpios = <&gph3 4 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&ldo5_reg>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &tf_detect>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&hsotg {
+	vusb_a-supply = <&ldo8_reg>;
+	vusb_d-supply = <&ldo3_reg>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+	vbus-supply = <&safe1_sreg>;
+};
+
+&fimd {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_clk &lcd_data24>;
+	status = "okay";
+
+	samsung,invert-vden;
+	samsung,invert-vclk;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	display-timings {
+		native-mode = <&timing0>;
+
+		timing0: timing@0 {
+			/* 480x800@60Hz */
+			clock-frequency = <25628040>;
+			hactive = <480>;
+			vactive = <800>;
+			hfront-porch = <16>;
+			hback-porch = <16>;
+			hsync-len = <2>;
+			vfront-porch = <28>;
+			vback-porch = <1>;
+			vsync-len = <2>;
+		};
+	};
+};
-- 
2.7.4

