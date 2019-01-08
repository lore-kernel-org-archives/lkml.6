Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3FDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E65420883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTARVH//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfAHQ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39544 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so4012544ljh.6;
        Tue, 08 Jan 2019 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qm3kH8GLO1p5FL1um7ZtOZvte6VCmWdydXR6NoeZ7Es=;
        b=PTARVH//VPLb0I7s9ocf3yJDeoJ04KDwRavID8/SLagPu12NsGewW+ABBZ6oHvJTSD
         91D4Ccl8o6lvT4vrtcTFs+CJTlKHItURlb7tpgZnWGYRgsGRPLmaReJfOdFEufZrs68w
         nyFj7U7QC83xEVwh2xePFImRJNo5fA2jL4dJ+VWFx8RQqNBt9RUa8dhW65PPjlG/ZffE
         kYR+fk6XHXwYdr8HGhf6ezATOPewu9dEkOcvAVQAtv4Ki6vdXEKLVXzKCAwWSrcnJkzW
         r0UKOFPBkgB5iViAH8GmQlI7ynH7P4MR0YPPB7lBjlNCpIwPVTgTeqBTr7oDA5c84N0O
         d71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qm3kH8GLO1p5FL1um7ZtOZvte6VCmWdydXR6NoeZ7Es=;
        b=ALIWJveKmaIX4PFnqp3cH6k7Y7ibGUn0N3mwSqZXQAL7dvPhg/FeJlnDXOsGyJ9++O
         61mOsnW2N6ZlgcIiT13UvUmtWXKPvf+wr+NPBej+eMYN/nM4ih0JMTQXQos2nTqeqD/F
         DWXjSP0kUobSI9Mo9RpYY9UWw5x86/lD92jgz38/0pf4mez7n1j8999nD8hnTHbiloP9
         6vx7uUKDeE86rs7g65oW1p9/xHKv44a05pRrQwn92cS/Q6JT7SmZggMyudCqXcGoZ6Hm
         WRhcHiUOSVyVx5iE0oe9eA4XwM+68uM1XiMZPWRv2OX+PzXGHhefrAYLEdqZkPfhVUW1
         Vtrw==
X-Gm-Message-State: AJcUukdnUtTeb2I6BBLEm+T84SC1n67lR6qKkt0/zQn4zYyomUL1IkXQ
        2IQSv77iP9TaqyCQjow+jJQ=
X-Google-Smtp-Source: ALg8bN5ypCyCaYzp2SMDRfXA5h7gGHj23xEwXr7w7+m7MR6ORyDTkUXHkyqkZeO4NVSH0INbnkPjyA==
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr1558880lje.105.1546966570457;
        Tue, 08 Jan 2019 08:56:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:09 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: s5pv210: aries: Support for more devices present on Aries
Date:   Tue,  8 Jan 2019 17:55:59 +0100
Message-Id: <20190108165601.25708-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

This commit enables following devices present on Aries based phones:
- pwm-vibrator attached to PWM 1
- poweroff support
- Atmel maXTouch touchscreen, connected to i2c2
- Broadcom BCM4329 bluetooth over uart0

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
   - Touchscreen irq pin should have PULL_NONE, since it's already
     pulled up with 2.8v
   - Touchscreen irq should be edge failing (like in vendor sources)
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 89525e56cc7c..8ff70b856334 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -41,6 +41,13 @@
 		};
 	};
 
+	vibrator_pwr: regulator-fixed-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vibrator-en";
+		enable-active-high;
+		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
@@ -314,6 +321,22 @@
 			reg = <0x36>;
 		};
 	};
+
+	vibrator: pwm-vibrator {
+		compatible = "pwm-vibrator";
+		pwms = <&pwm 1 44642 0>;
+		pwm-names = "enable";
+		vcc-supply = <&vibrator_pwr>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_out>;
+	};
+
+	poweroff: syscon-poweroff {
+		compatible = "syscon-poweroff";
+		regmap = <&pmu_syscon>;
+		offset = <0x681c>; /* PS_HOLD_CONTROL */
+		value = <0x5200>;
+	};
 };
 
 &fimd {
@@ -347,6 +370,23 @@
 	status = "okay";
 };
 
+&i2c2 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <400000>;
+	samsung,i2c-slave-addr = <0x10>;
+	status = "okay";
+
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&gpj0>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_irq>;
+		reset-gpios = <&gpj1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &mfc {
 	memory-region = <&mfc_left>, <&mfc_right>;
 };
@@ -372,6 +412,13 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	bt_host_wake: bt-host-wake {
+		samsung,pins = "gph2-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	tf_detect: tf-detect {
 		samsung,pins = "gph3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
@@ -384,6 +431,17 @@
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
+
+	ts_irq: ts-irq {
+		samsung,pins = "gpj0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+};
+
+&pwm {
+	samsung,pwm-outputs = <1>;
 };
 
 &sdhci1 {
@@ -421,6 +479,16 @@
 
 &uart0 {
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <115200>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart0_data &uart0_fctl &bt_host_wake>;
+		shutdown-gpios = <&gpb 3 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpg3 4 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gph2 5 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &uart1 {
-- 
2.17.1

