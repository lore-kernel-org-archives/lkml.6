Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FEF21A8F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pba78wPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FEF21A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeFUTL2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:11:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:47078 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeFUTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id m4-v6so4434855lfj.13;
        Thu, 21 Jun 2018 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUAkPz/9MzwOVBmZQmeZi7tDiklyss4IEehpahJ33iw=;
        b=Pba78wPbtgOInfp5PPuY+EsR0brwYNUBniEDLuhVLub5+qflyklF3TceMBmJpNPPnQ
         OhP37yA+Yt4YX8ZaKYfUTU5v4abYCiW3bivvvT9Q+8oveyEZX3dCd8YPPu3LmtHNu+mO
         mCGR0GXs0MpEnUFVfNU8zDxQUbrz2i7iKhCZu9NlHDyic567qbf0xP9ZshSCE27ODoTj
         1d9QG1z3P/WW7jEpjfcVu8TcD2h9dYpQUOpI8iXyW3/YgmA5/NYV2gf8VqUtoHs7PYy/
         nGPgWX/u7g1+0+mNv0DEut8zlPxYYI1UXKJOAqiwpoFQRVlOkWrN2YBHvbWfZk6HMUoK
         gFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUAkPz/9MzwOVBmZQmeZi7tDiklyss4IEehpahJ33iw=;
        b=LK45Ud5UgYV7wa8OdycIzkC41F3Zex/wDQxBTEg9XmUGEFlTpp3aBmOPmNYZVRHrNy
         P5UpkZwWZKFUBVxwKoqq9IZqQXw8zFxRwKg0tdn9tFmWzAJADHbBM+ibZ6nG//R3mgz7
         /hgyrrJ7F3vlqeKY6r8ENwQkf6fRRAQO7cELEsyDCzVwEa4WLnTmYztINZRU5aMvpWhT
         np/MgQnH+kOr2M5Pbl62SI/kYnq4A36dGQOtWARMZ0BK9mVbHUv2Tj988d+uhBVG1luD
         /HWJWW1aBcOLZxhQhYntumha0OzqSQ4x8ip0sQEH/hKZcyPQACsctI2r9XsyY5XKtNHu
         EAww==
X-Gm-Message-State: APt69E0or98VPZSLYexKuOZvxn4kR6yv/vdBQNr4iEtXgdgVDPXaQkqm
        ggZjJEoS67YGm2MiYXjSM2M=
X-Google-Smtp-Source: ADUXVKIk90mea0bgBwBMr4IYlSp3C7CAED9Sk3yB+Ji9+YbqCu97O8V95INbOrfJkRlLR/+3CFKgtw==
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr11594110lfg.119.1529608225426;
        Thu, 21 Jun 2018 12:10:25 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:24 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 3/7] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone.
Date:   Thu, 21 Jun 2018 21:09:55 +0200
Message-Id: <1529608199-5583-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/s5pv210-galaxys.dts | 72 +++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e2424957809..522ebdca1d3d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
 	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-aquila.dtb \
+	s5pv210-galaxys.dtb \
 	s5pv210-goni.dtb \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
new file mode 100644
index 000000000000..d435032541a9
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "s5pv210-aries.dtsi"
+
+/ {
+	model = "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
+	compatible = "samsung,galaxys", "samsung,aries", "samsung,s5pv210";
+
+	chosen {
+		bootargs = "console=ttySAC2,115200n8 root=/dev/mmcblk2p1 rw rootwait ignore_loglevel earlyprintk";
+	};
+
+	nand_pwrseq: nand-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpj2 7 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&massmemory_en>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "power";
+			gpios = <&gph2 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		vol-down {
+			label = "volume_down";
+			gpios = <&gph3 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		vol-up {
+			label = "volume_up";
+			gpios = <&gph3 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		home {
+			label = "home";
+			gpios = <&gph3 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			wakeup-source;
+		};
+	};
+};
+
+&pinctrl0 {
+	massmemory_en: massmemory-en {
+		samsung,pins = "gpj2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+};
+
+&sdhci0 {
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&nand_pwrseq>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4

