Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E73C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFF620811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yzIDRLO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbfA1QiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:38:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbfA1QiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:38:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so18785164wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=L7bmc/MKBpCEs68YcmIGpGX/6J5igsqYwSDPtXbpF5I=;
        b=yzIDRLO9X+802YPKhcWAQgT3HiXDB380oqYdqf6CP1G19Qkvqfbs58ODce5fIKqtNa
         eDnwsGju3DQS4WTAt09TRz+ANV1Wi+Ti1M9Ajro2biB5h3AbGNeHOATtrroDIwBfM8FJ
         z3U2ckMCCPgEYHVoqsLKtmtQHO4RJD9wGqQX+nxlEC80cMLJtyLZhdUDC+fkR13/mvpM
         YJTUK4Aa74JoWrl0LpImzYg0mdrfcgNAq76di6GBU0q+2SEal1IUcPR2fyqfIEtk5G1N
         hoCj+M/CpkRVFiLa8K+q0g0zu7c+UOiQvY39wngNKGB8IyFCO9n+346yAcy93jGXn9bb
         XN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L7bmc/MKBpCEs68YcmIGpGX/6J5igsqYwSDPtXbpF5I=;
        b=IFg4jp/QCBTYw7QnrPmRWHzTRe+NnMyW8A5tVHYLtzVUSqSWTcQ/wBLjGQDpp4s2FW
         4L/eh+STiXVMC78XgiHD0TKcfrZLBPC2dA6GglYkl4N6GrmV5Hmv0epolkZ73bie+9Zm
         0Q8OkObk4dC3oVWAxTBO0qWowvtu7sOwcd2aKFbDvlPpxPNTl5OC2gpD8Jf24Hgvcrb+
         nj13DrB4nFygLdxdqL1IZ+umLFfL2At7RHTu+o0zesQ4EAmQ/kITtrYcjud+1e+3pHSM
         /v55bv7PQ2PWkZg6mYe3rmiO1UkL4NCkv9hUykoTYtCg+tucCmRN/te9DAlMMrA75Mw2
         cdyA==
X-Gm-Message-State: AJcUukfgx6TQ0tRgXMBi2/PmSYYeRhPcj2SquikccfAYrkPEvi13kwop
        GJD87NFp5Z/gp+Ts9c1f/LgTuA==
X-Google-Smtp-Source: ALg8bN6/AeMbB9ztw2/OPA4aRkoO7jNQPii37d8PbkqqGlfnMk8N/2tBzzZxaU1owHOurlYxWl9Q3Q==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr24066949wrx.149.1548693485628;
        Mon, 28 Jan 2019 08:38:05 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:d40b])
        by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 08:38:05 -0800 (PST)
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
Subject: [PATCH v3 0/4] Add driver for Mediatek-based GNSS receivers
Date:   Mon, 28 Jan 2019 17:37:57 +0100
Message-Id: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
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

Version 3 changes:
- driver: Removed "mediatek,mt3339" compatible
- driver: moved gnss_types_names string diff in the GNSS_TYPE patch
- driver: edited [patch 3/4] commit message to remove ref to vendor protocol
- driver: retained the original copyright
- dt: removed interfaces that are not available on the globaltop SoC
- dt: Added missing pins documentation
- dt: added optional properties pin names

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

 .../devicetree/bindings/gnss/mediatek.txt          |  37 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gnss/Kconfig                               |  13 ++
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/core.c                                |   1 +
 drivers/gnss/mtk.c                                 | 152 +++++++++++++++++++++
 include/linux/gnss.h                               |   1 +
 7 files changed, 208 insertions(+)
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
