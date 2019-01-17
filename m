Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB18C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF7120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zQVadgvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfAQQyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:54:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35451 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfAQQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:54:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so1834269wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=guam8jHzK8TRYRb78oVM8jQvkOc1edl/EV41EjO5ZPI=;
        b=zQVadgvmWN0kg3Iw41u1o+AFKjzYiVvu5IErM0gsdf7HBWaomZcj9Cbu+DvMMXtkU2
         Gl1QkYG8Q4/CgFIzWF00/ZNjQzkxAMQ0M3s+y/mN44f1C/h+srIh4XFYFhuXCA/6jKV+
         sXOmGgi/+GJmhzh2K2RtIclu1x10IGToNgAcIiea8HYJ/czOFD+2fJB5pM15oVDssMtC
         K9Te7dX9uqcFGozw2N0XPPAvvKyhImPY7AfFWjMtZSfSPk7XnWzP+qU2uBqnowlxZcL1
         BEqc7UZI5et5DHfBR+0zPsiZR8BNXWdNYdsvWXQRvJActaOdmwmxXV2yI4/0qFdniIdY
         odlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=guam8jHzK8TRYRb78oVM8jQvkOc1edl/EV41EjO5ZPI=;
        b=pu7tTL11uqcHfqYQUB1TZKwAI9sNav7r910Sdo3plD1azY9DCEGbzxd9W78LT83Qvm
         xOZP4JOwySkma+lNyJM0aPhbSn3q/Oug06RpqNb3gyY3quOIGHb6NebbNOoNrwF+ekJB
         wZWwWbic8YKjwOEcL882pXM2dYc1Z5UXgMx7fIYAHTEFCMPHVtk7bsfT6k6BMW5ONvHx
         pYb3FZGn/NKkMwoJfflz/GQwW9JOcMc87OE1rvheELjGFD9/NgHTlIpTwfa4FdtMTQBf
         d9t8kWGnJk9QKP/8j4purBgUMg4ZCwy5Tmr4xIijQ3+1W+wd+E2flMXcBA0IzTTzFjVT
         JfLA==
X-Gm-Message-State: AJcUukdAtFRm7bzxd0vctZsKJdQc/e6/1a8PI6sTx9v/ikkVUuMpjBUV
        hM8xHiCrplMBScnu9aa/FkI9Fg==
X-Google-Smtp-Source: ALg8bN7vrQfMtSrk/vXxv8n8yhIkmaujikkGXUBK5XR9asB5O1uN5DUXPrZjJhuNDW9uz17jVJURWw==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr12732023wmi.10.1547744080858;
        Thu, 17 Jan 2019 08:54:40 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:54:39 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] Add driver for Mediatek-based GNSS receivers
Date:   Thu, 17 Jan 2019 17:54:30 +0100
Message-Id: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds a new GNSS driver for the Mediatek-based GNSS receivers.
These receivers transmits NMEA output sequence after boot.
Power management can be done via the main supply and optional backup supply
as defined in the device tree.

The driver has been tested using a GlobalTop pa6h chipset on a Libretech-cc
board using the expansion header. Changes made in the board device tree can
be found below for reference and testing.

Loys

Sorry it took so long for the v2. Rebased that serie on 5.0-rc1 and had to send
some fixes for the board before testing.

Version 2 changes:
- driver: Renamed driver from Globaltop/gtop to Mediatek/mtk
- driver: Added "mediatek,mt3339" compatible
- dt: Renamed bindings from Globaltop to Mediatek
- dt: Moved the current-speed property as optional
- dt: removed the status line in example
- cover-letter: removed the alias that is not needed anymore

Loys Ollivier (4):
  dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
  dt-bindings: gnss: add mediatek binding
  gnss: add mtk receiver type support
  gnss: add driver for mediatek receivers

 .../devicetree/bindings/gnss/mediatek.txt          |  39 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gnss/Kconfig                               |  13 ++
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/core.c                                |   1 +
 drivers/gnss/mtk.c                                 | 153 +++++++++++++++++++++
 include/linux/gnss.h                               |   1 +
 7 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 drivers/gnss/mtk.c

---
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af967a7..3b3d4dcc47aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -17,6 +17,7 @@
 
        aliases {
                serial0 = &uart_AO;
                ethernet0 = &ethmac;
        };
 
@@ -269,7 +270,20 @@
        pinctrl-names = "default";
 };
 
+/* This is brought out on the UART_A_TX (8) and UART_A_RX (10) pins: */
+&uart_A {
+       status = "okay";
+       pinctrl-0 = <&uart_a_pins>;
+       pinctrl-names = "default";
+
+       gnss {
+               compatible = "globaltop,pa6h";
+               v-bckp-supply = <&vcc_3v3>;
+               vcc-supply = <&vcc_3v3>;
+               current-speed = <9600>;
+       };
+};
+
 &usb0 {
        status = "okay";
 };

-- 
2.7.4

