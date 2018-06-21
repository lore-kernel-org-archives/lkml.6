Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEA821A84
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMEEnibA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEA821A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbeFUTLE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:11:04 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33223 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754341AbeFUTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id y20-v6so5917716lfy.0;
        Thu, 21 Jun 2018 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNz8nlVDqilVmA28R7vdJQIe4zhv2tnGYJmTOxbNMhw=;
        b=NMEEnibACz3xPoSCGVGWID8TtXwyUmE00q7aO/nPdhVWt3MjgFERFjr3oLv+B04Yrj
         ODgOLGCUN9WR+nterNkc976rqh1DIkjoN7HdW3V89LDYsyPfilgGktaKnvGQbhJjl01S
         dbzBwBvTO2jmRfY2VK2XYf0Gfnn8KMMw3S0z1g9nUZEqbQNdUgwwzQVuyy+EUYTZJRpZ
         TDlpWal8J3uHnCaz/SdHUQFcJAFtih/2gQgUM6zcAIu/ZuUDKkxn6Z7vn1Nn3oLFETsy
         mF+Xx9FdI0LEp+dL67VPKvvrM4c8+iuoCH7a5gl+JoYlvAaBNkfkMDuj9O80YXYV03od
         3/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNz8nlVDqilVmA28R7vdJQIe4zhv2tnGYJmTOxbNMhw=;
        b=RmgchdLmScKli+cS0ZGrN6kGfeOZIkeXtRAelaFq6x+ViU1z9uFXkL/W6zaRaRtqr7
         5d7eeNBQL3N0xDyXZAhNwFCQXU1mj8OR3TilnIdoOwFbMjypUJAp+ePzsoR/SYkBN6ix
         6YPQ8EvsaAuyu15OnnSSinZifqerJRH34SCKkn1cKlIi6eWKVal/mWy7PI29CvO5S9Bl
         UOaJIb2qDxg7XXxSZRWkg9embg8tShvZJr21wM72oaW7Ovx6xbVuIDq+XX94l75sCF5d
         jSw3QSRW73N0SuxGthgc1hGb83QIQSRTlyxwDMOxPMwdjcyUapI1l6gdcVCyPPytshDd
         7c1Q==
X-Gm-Message-State: APt69E1nXUWNOEyau01ZzZia62Lq5eetSMSt6v2JgAiA6CTRfePgjI+E
        tF2t9TFI4nSYOqDfHY/uZcI=
X-Google-Smtp-Source: ADUXVKJZmdVqIJ9zhogDXh97xZ8VSWHiIKEKr4qfJ1OQQPJO5p/fEhOgoapfWy6sspSYmpjOoP3XzA==
X-Received: by 2002:a2e:21c7:: with SMTP id h68-v6mr17492560lji.108.1529608230298;
        Thu, 21 Jun 2018 12:10:30 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:29 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 6/7] ARM: dts: s5pv210: Add initial DTS config for SGH-T959P phone
Date:   Thu, 21 Jun 2018 21:09:58 +0200
Message-Id: <1529608199-5583-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 40 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
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
index 000000000000..37967f57c7b7
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -0,0 +1,40 @@
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
+	model = "Samsung Galaxy S Fascinate 4G (SGH-T959P) based on S5PV210";
+	compatible = "samsung,fascinate4g", "samsung,aries", "samsung,s5pv210";
+
+	chosen {
+		bootargs = "console=ttySAC2,115200n8 root=/dev/mmcblk1p1 rw rootwait ignore_loglevel earlyprintk";
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

