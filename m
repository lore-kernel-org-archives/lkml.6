Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98424C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A3721450
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4erqi2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A3721450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934580AbeGFSdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:33:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46184 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934335AbeGFSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so9799893lju.13;
        Fri, 06 Jul 2018 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omdXM5someJmkLjQbCjbmMJ92kx7glPVAf/yqZD3KUY=;
        b=a4erqi2yrHkjVQ8wNyZTTgfwLWEQULLdOT53VrhkoiuiaODP9099znCvGbAjk/Y8aZ
         3eYorLQEbV//ZApWl/N4bdtXXrGRlTXdVLNJiIlHRyq15EI4U2Pz/L7p3ftNRRHkiCpJ
         0WGwPjY8b3BTL7vC/N850HsDyDT/SQi9o1qu0vBcGbXjXMF0MnbUDJ3FzhksN4SMnqUP
         vicWXNrnmrU9fn8HTcohltYbGXsVyj7qjJEqJccY5vNEJZifZY+K2AT+0xxp18U7lEnE
         eTY4UCL8QIn+2pdVYyRyJEHgINNiCFfZHH98XTaWgEw32QxYURUq6p50HnePMAVyaH0B
         NU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omdXM5someJmkLjQbCjbmMJ92kx7glPVAf/yqZD3KUY=;
        b=K9F/sBNhsDFVGz06b58RUKMOsPIKEsr9VP47pRlS47CrwBPrrIPReVXY7sQQ79A0nk
         kufRBmcIJWosRLKuu5XBJORgixEYiA8gsUoaEPyDvT18YCpbdLjFTGqLiWBBQkuHE+lI
         R5HHO95pNzkizP4vdFjJIcdKdZxlEtE2quaWU8PYnGNzV8sXpV4Zi/azMTgbkGvlk9pY
         0tdybF+t5mJGyPSA8bKAOmzySGab4ClJxjpRY6MHH3vcqT1DYPSEKT50D8xzGy0K99AX
         OFcT4PSEN4etTbt/3pq9bnAC4Ua9eZ7qEZiXZyJ1ZPDTf9NdxaYvhUpXSrzLt8Qqw9tr
         1vzw==
X-Gm-Message-State: APt69E2LyKK2iLIMFWFlUUmt7q4z1VDy8H9/8gswcPr+0wKNhrRrlupG
        jfBFJH7gHf3a8bjz6abRNYo=
X-Google-Smtp-Source: AAOMgpfjbK+t7Tpj/z6s5Ui+hMlrdEWNYlHE9Y3hh2RGodEs4SAIsYP6doGIIaWeV7v/gAeBlnpP6Q==
X-Received: by 2002:a2e:991:: with SMTP id 139-v6mr5628985ljj.150.1530902008154;
        Fri, 06 Jul 2018 11:33:28 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:27 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 4/9] ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
Date:   Fri,  6 Jul 2018 20:32:45 +0200
Message-Id: <1530901970-14972-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

