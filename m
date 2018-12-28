Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F22C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F9B20856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlTubREK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbeL1QSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45943 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733302AbeL1QSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so14831083lfa.12;
        Fri, 28 Dec 2018 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9w1ZLlGE2cGCBHYzebw54rG+E3I6QSZ6vGjxLu+2/ag=;
        b=DlTubREKfeCa9aZ7+uXRCp2OLRHkwN+4g7dbtuv/t8IW0kHRCAzVGpZAlWOD5+Yn1A
         yv2snEKvGbmkKWmpx0jDX7pRwfQ9q5DfRTDDwsVTj2wxAQU/Bc/EkU4mPrNf3weRgJBZ
         uBsRFGZ43flBbW330lKkcF7m09ZYiccQJVmYz+b7D6rC2IbXssH2bYqzaYWgRslRQPwo
         tswxDZRZ3IAOG0oYxqPNIZlBy1D2bwvTOjrlWUmUpvTxu+dn0rw5QDGQKgQPSV/cFYZ0
         QjZNFpQyU1rbQd5AEmhc0WR4i1ZIZZFOTMJgO7aPOOcp+6IB4JCEWv8IX7/QnajnqYD9
         3NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9w1ZLlGE2cGCBHYzebw54rG+E3I6QSZ6vGjxLu+2/ag=;
        b=NxBQywiFAGc4yDwBPG5gNXHYje84UFkc2NoNT/KeVAhNX+OPfJwegh71DoMzo3HJN5
         3IWmjSQ1v6YpVAGNyQrx8Za12z/9wZyFxVdFd8iieVFpnZxAEYWrg/gga95Wcel/fJ98
         Lh5u3dtEQzPA+O4KncrMNKLTlRbGAUbc2MKbwJm2uNv+XZuf8+iwFLjmc6d8bxyrxkzr
         Q459N0r7BAjV027dXZeiREtWz8LHHgsbPj52cI9Ll7jOxrXnWzvZh21IDxashmWa0NW3
         lr8ibSnNi60CXSwRcATpyRrFvJkvEMHtkRIK5gDd7F0LmAR+LW4GTwmDED6MhJ6mrZdJ
         8cqg==
X-Gm-Message-State: AA+aEWZJX6ehYlAaLazNdF1n6PWS1r6zEAUC7V3Pi3NuyBM3NE+rItGn
        AzLEssk2KCX9VT94Wf7ny43IjDowPLILRw==
X-Google-Smtp-Source: AFSGD/VqNmnd7QxMAHgjYqgsVPVR0SfathW41kJZPHSuNDz4Oh6rUjU/2v25yVz+Bc22fhDMHJwtyw==
X-Received: by 2002:a19:982:: with SMTP id 124mr13778240lfj.138.1546013919384;
        Fri, 28 Dec 2018 08:18:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:38 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: dts: s5pv210: aries: Support for more devices present on Aries
Date:   Fri, 28 Dec 2018 17:18:18 +0100
Message-Id: <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
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
- Atmel maXTouch touchscreen. It's connected to i2c2
- Broadcom BCM4329 bluetooth over uart0

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 35ba009a1a33..b7246f879648 100644
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
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
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
+		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
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

