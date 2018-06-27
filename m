Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E45C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0087250BF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfVJLa5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0087250BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934879AbeF0RPB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:15:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37691 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966011AbeF0RMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id c11-v6so2236223lja.4;
        Wed, 27 Jun 2018 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omdXM5someJmkLjQbCjbmMJ92kx7glPVAf/yqZD3KUY=;
        b=jfVJLa5YZjUCcP/TG+yM8iXJ5M2Z90hGJmAx27BwI/J8plts/yoGh315Znxrll8wXm
         DZ45PBHxLV+z2UJ5MYsgBH/u5/K2MDw3UA+ooxaNcTij5LuUPIrFbp6/POqy0+k5dBKy
         oUXmbajdvf/zjp622GIBxvRoGgdHw5L/EkZxexiyjIMxks4DnfUSUlWCBm2L5T5lOukx
         qM9PaW0w7+CaMoZ7ALS8KqvJd+R63blADMZHJB/QaZVZFdXFkp7ZsweouC03rJpVLHvR
         F/ZqcPfi3r1dpb/50UAJDohakjXnMYyLKEa7jlh7K5N8pgCm5tQzExxVEbz4LmlXEgVU
         9Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omdXM5someJmkLjQbCjbmMJ92kx7glPVAf/yqZD3KUY=;
        b=Efs4M9rQNeQD3N4mmdbIMvAe3J7SbcYK58zAAooXHBYKvYhnzZa4FmLQBgYe6j++kz
         Nxu7JrddAP8WigT1+s1bKBmal0TXJr9MvLYBqkf5FQTSdajX31sREezoAmNvG1/YCsK0
         GeMrZTauNoPguywG/ej+bVWg2es9Ubs9wEbut7nQb0GPvskhcwtl3XWDTzSViyhqkQdg
         bqs96BG1oi5RjwHlwD/luqcC3yaqAv6cu909bTMx7cTn5iaQg0SGaDyohNNcQfY3+Fq3
         oDEYzXwspjkMMCj1dkyBfKjV+L03dfLDnBmj+lJlk9dSaZtiGTEzJlvm7HHWJ5G/ZzTO
         3hWA==
X-Gm-Message-State: APt69E15pDcJsDK9RoNG140CgUMUsy7H358mZiDGzozDt7NfrhDs6SM/
        scXt1UQ6sO5cUg9zVxSVpks=
X-Google-Smtp-Source: AAOMgpcIM6vBjZVCqtz+0KK0CidgRoQTlrEoUHAr1Hf5oAQMJ9ZnLQtm4KM9iLf9YP95JkpjyOILsw==
X-Received: by 2002:a2e:8549:: with SMTP id u9-v6mr2413502ljj.10.1530119562768;
        Wed, 27 Jun 2018 10:12:42 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:42 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 04/10] ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
Date:   Wed, 27 Jun 2018 19:12:18 +0200
Message-Id: <1530119544-30023-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

This DTS file have initial support Samsung SGH-T959P phone,
also known as Samsung Galaxy S 4G or fascinate4g.
It belongs to Samsung Aries devices family.
Initial version have support for:
- sdcard
- max8998 pmic and rtc
- max17040 fuel gauge
- gpio keys
- fimd (no panel driver yet)
- usb (peripherial mode)
- wifi

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---

Changes from v1:
  - Added missing commit msg
  - Removed duplicated and unneeded headers
  - Added stdout-path
  - Added information why we hardcode bootargs
---
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 45 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 522ebdca1d3d..d00e995875bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
 	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-aquila.dtb \
+	s5pv210-fascinate4g.dtb \
 	s5pv210-galaxys.dtb \
 	s5pv210-goni.dtb \
 	s5pv210-smdkc110.dtb \
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
new file mode 100644
index 000000000000..ccf761b1babf
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "s5pv210-aries.dtsi"
+
+/ {
+	model = "Samsung Galaxy S Fascinate 4G (SGH-T959P) based on S5PV210";
+	compatible = "samsung,fascinate4g", "samsung,aries", "samsung,s5pv210";
+
+	chosen {
+		stdout-path = &uart2;
+		/*
+		 * It's hard to change those parameters in stock bootloader,
+		 * since it requires special hardware/cable.
+		 * Let's hardocde bootargs for now, till u-boot port is finished,
+		 * with which it should be easier.
+		 */
+		bootargs = "root=/dev/mmcblk1p1 rw rootwait ignore_loglevel earlyprintk";
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
+			gpios = <&gph3 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		vol-up {
+			label = "volume_up";
+			gpios = <&gph3 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
-- 
2.7.4

