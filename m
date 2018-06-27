Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD15C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CAE23D0D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLlEfcnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CAE23D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966052AbeF0RMv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:12:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33046 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964947AbeF0RMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id t21-v6so2247507lji.0;
        Wed, 27 Jun 2018 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhdMifM/YB8iVb8rljZOtIMxhHzeqo39+zZMZO0ROAo=;
        b=mLlEfcnZSdW5KCfzOFuA8y4hcxN1ZwUWThX/UlTZjH3lIcJu1oGQWHNzb/IpZjWlRQ
         27gHEIQeTFX4ktTV9lBrd+K8sAIPMGig6a8Tusw7YXMceNhHdxZHnVvsaElzFAYUFZxE
         RWkx6hWLlbvrqPFuO9z7Cz7q//PA36RgZXHfl5zuOVowcBkWvQflArno5R2G6KawEU3H
         EfAaQoqer5hstBS4tOKJu3d4uDrGGy9rr46649hs66Td92rvPSOcl0TCPak6QOrNeBmB
         Gdd8kb9uqFQRvQYMEK2qR8G4usqmjO4/Jb8Ml7dbPKVrN+92ggnA6rpzbvnLALnem/81
         ozYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhdMifM/YB8iVb8rljZOtIMxhHzeqo39+zZMZO0ROAo=;
        b=fMm5aAyJCKnzQ/xIfZOWIuLW27IcWOMgSl/Zmb/0Zq01x7nomgy4sFdLH+Ef5xYV//
         4CsbhQSBcf09j1nP69PKgZqj81w9pTiw9XwqqMiBFU4IejyF5KIU7PGdSnmTmQV9zNtL
         9zAaqn6me8rF3hkGkxvJwpi8eOgzWSVZ9qP4Tby+0MBp/UakJOrytF6uXT/tJL6OjTa0
         klMDVEiLzvc8WrlAlZ3/DK93zFYEvATHrC478eOot9BPiJ/AFvyw2IUWKv0jYbKBqoC9
         GjQ9jZxK5Mo/3aV8tXrJs3o59xmL5GQrRXafvO9CvRjaWt7dm5EhCoSthcGd6GMwkmaq
         ugTA==
X-Gm-Message-State: APt69E1kxuckQ5jTmcMYMUII7ySWp0682OsxIbBAuVNcwXJddJbzGAvB
        AKAwLDOPw6G8rh+HgS9GhGo=
X-Google-Smtp-Source: AAOMgpc2jvi1RXW1l1QVjA6OSwgyV+NHQHk/y4g1gke9ddU3tyVQgRoH2TLElQPuOA6iJXXGxSMMfg==
X-Received: by 2002:a2e:5c4:: with SMTP id 187-v6mr4671773ljf.28.1530119561263;
        Wed, 27 Jun 2018 10:12:41 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:40 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 03/10] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
Date:   Wed, 27 Jun 2018 19:12:17 +0200
Message-Id: <1530119544-30023-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

