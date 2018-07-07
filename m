Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCCC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97776223B8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfJzHEWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97776223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeGGKKE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:10:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37822 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeGGKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:09:55 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8-v6so11699119lfb.4;
        Sat, 07 Jul 2018 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omdXM5someJmkLjQbCjbmMJ92kx7glPVAf/yqZD3KUY=;
        b=nfJzHEWd+bJG7azAWyTWTloQ3h2SxiEaqGBhU1EH07PD/a7HhaYh2JhyRcXS1rnxWa
         pE4oC+1aFvt5916UdT4g7vzmgYvaGYIWI3eYnayZVi6LWPQIm7fW9PDf4zUw+gMutYkp
         HNhdCEO/FwKxgxT+bed4urnGUaAJZeAc6ZJVzjhRcGJFBHwKWM5n46CD4TsRr12rIyyG
         /YGRntlql55Ae13SGumDsg6p2y2t3RlF6tFnRCUPhNwrXhrDzkyfEItODQrnkEl4hNp/
         n5AMcFQfkIYu8EUnlCGdLg3jjZDlwPXddzAJpTH4DqAGh5I0cucbUol7AlYvxdcLQvkl
         aN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omdXM5someJmkLjQbCjbmMJ92kx7glPVAf/yqZD3KUY=;
        b=XASvlAHPWnALe83XPjAJBtp8i84cnphKcn+azHdTgkZiVzZvQAoYIMmMt17MWhH8jj
         pAu+kypR1vUFQIoyrUgqFsqYR9f/vYpw8D3kIpm7nePyXjdsnP67kwp0qChgEVDP5Xl4
         hDxgOJ+SFfUR9ftybAzYrPIvjpzThj5v8S8hPPW5yyegR5w73NdVzIVYO8NuBIVrfo4c
         ClkUx1SNdqFjelTfbZjyAIRCEXAAUHqHoJCUxs2n7otc2dBH4btolzIMswb/ChMxtj8p
         +EYRHZW6QpAYzj1lV9dugf3/d6d3jmlz0KJFcKbopfYL7YwN1dsTgvOoRJD5zDrr4gyp
         drmw==
X-Gm-Message-State: APt69E1+P05c7vT3PF0u4qBX1CIowLAIQzeBm6grRnKnuSSsLUEjZ3nA
        Ca7dKGLBa4wi1hsZ2bJ4fBY=
X-Google-Smtp-Source: AAOMgpfruHIbFpWjVn3Igzd6t12qGdBVM0uZMvcw+DJe4mzvzvNMth8uUWu4ZbgubNcSxr2Ok7WyZQ==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr10099611lfj.47.1530958193335;
        Sat, 07 Jul 2018 03:09:53 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id k77-v6sm1321292lfi.46.2018.07.07.03.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Jul 2018 03:09:52 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v4 3/5] ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
Date:   Sat,  7 Jul 2018 12:09:41 +0200
Message-Id: <1530958183-10956-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

