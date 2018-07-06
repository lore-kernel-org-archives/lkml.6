Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2896C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A000A208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv2Roynm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A000A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeGFSde (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:33:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38095 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933978AbeGFSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so9810992ljc.5;
        Fri, 06 Jul 2018 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhdMifM/YB8iVb8rljZOtIMxhHzeqo39+zZMZO0ROAo=;
        b=gv2RoynmBaJccvnMzmbZ4L5OcKE3F89tEKMvPOmYoJtvwJ1Haj8Inpo/QZgP0rWftL
         qrf77MyGl8istGYpiUM1dgb0YOBjcwdXWH4Tk76tbvQRxRVoA9d+xUgOuVdXZ7lfnyZg
         MqLoFxo82N2+zqo51TrtDkqnzKX+vzCA/QWkrpC/+O82YKt1NFAu4F73K6gdJDunwm1I
         EHMWckSlumngH+7BDnnEm5sw9KSIl9J88X/ntpPskMYzbjAYArowsryS1AnT+DUzsfnS
         FUeJkfIwBuTW3YpLudEZf3skhCrxM+LH3rU6iGN0dUG5E6QmQUPwORXTqpg/WmEMwLsZ
         1+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhdMifM/YB8iVb8rljZOtIMxhHzeqo39+zZMZO0ROAo=;
        b=pNZRGWJEj4OwM4yWb9QquC6QM017r6jZcYRfBwh0U70IP3YrhKFIm/+mO05l2DDxop
         jCEHy8GDhydVgGkmAI0+tgh3kRlWesAUWyinpzprJFiGX+gRZUjJhyYtDbnnRKLpju5/
         dlaDyJPfbSZ1oZLJ6VzuK++ETDpzBYmVAqHKki+5CJeOyg7gbvSgnVNa5jNsceMRRNNx
         ZOv+dCbLlHzr1sqnK0pE/nSOIpqP6x1DPDL7RSFxoefdiP35UQ2iPBFGUqDdsYHODUG9
         Z0vEndTtXy3fbV+b4+RaHqTMSaQpUKoi/0K4lQvJL2ZH/rjxmsYnBj3dH17Gr+9omud1
         MRNQ==
X-Gm-Message-State: APt69E0IlpZna/H9Ekj+x6ZFwJ5jghcHI/1ZdcliorlxFCV7L7XsBWch
        Ld/nnLhfxQ3PGRkQHnns7dE=
X-Google-Smtp-Source: AAOMgpfLfO5O0jL1Y7htVUquaFOLsfD81c5leSGFXV0NtwP9i5ITvdjQDTsnweI044Ka5ku9W/gi6Q==
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr7201465ljr.38.1530902006809;
        Fri, 06 Jul 2018 11:33:26 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:26 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 3/9] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
Date:   Fri,  6 Jul 2018 20:32:44 +0200
Message-Id: <1530901970-14972-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DTS file have initial support Samsung Galaxy S phone,
also known as i9000.
It belongs to Samsung Aries devices family.
Initial version have support for:
- sdcard
- internal memory
- max8998 pmic and rtc
- max17040 fuel gauge
- gpio keys
- fimd (no panel driver yet)
- usb (peripherial mode)
- wifi

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

--
Changes from v1:
  - Added missing commit msg
  - Removed duplicated and unneeded headers
  - Added stdout-path
  - Added information why we hardcode bootargs
---
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/s5pv210-galaxys.dts | 77 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
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
index 000000000000..842276749717
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "s5pv210-aries.dtsi"
+
+/ {
+	model = "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
+	compatible = "samsung,galaxys", "samsung,aries", "samsung,s5pv210";
+
+	chosen {
+		stdout-path = &uart2;
+		/*
+		 * It's hard to change those parameters in stock bootloader,
+		 * since it requires special hardware/cable.
+		 * Let's hardocde bootargs for now, till u-boot port is finished,
+		 * with which it should be easier.
+		 */
+		bootargs = "root=/dev/mmcblk2p1 rw rootwait ignore_loglevel earlyprintk";
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

