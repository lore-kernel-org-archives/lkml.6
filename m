Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F313C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50282222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I8nkF1Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbfBMPJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:09:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34762 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfBMPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:09:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so2246876ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mi2mVO/IJ0Uh7+nXJ3rnWhD82EEtsEXYmxE78KRe3ZM=;
        b=I8nkF1FiJxzndm/qA8SZLIzVcJjdecl3ZazI0iWa0o8ycJ8/AKOhamKC1l0uqkbpm0
         UtLth7fQrN+O9JCyRYeo1m3v9kwqmrs5gHfOI1JZBm4f7ZgGlNEwyh8UJDTMkbIDvUvx
         u83v+zfX3OF8jzrKRmr0987RfX8KxnIGYDRIhBydp4S8+awIfe4UqZCeMKldreLvozRx
         BgjU6CoUYZvR4h5LyACk81U1psflIsok0ft39/QTSYX2HUG15OGWtJe+EH+Flskk5t+B
         Rn99NHTsZnMEvM9LzDpw+xk3ZBSovsL5usLz9Bh6VRgbyIy5xDgf/q2CI7pwcxL90JdO
         RRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mi2mVO/IJ0Uh7+nXJ3rnWhD82EEtsEXYmxE78KRe3ZM=;
        b=EAG26OQhrVTgD5FDSp3ER5GnckjpGS8C0VqS3twTN2y2UWuUU8RQSV3WJ1SkarXpOz
         Ga9oqDq3oMvq1pLO4tAHwOly/4MNyeR5V20xD9wBCwVXBSRVr+ZYeODuxTIZmG6xEkW0
         5QN4J2PUfo3RuJ00QCyAbv7/okutFlxc0EzKxxNy8HVGrLwiJBG8hDH/lSUwMzMsLnMn
         sZ7ez2lLZ+jV8bDAa0nxwEg4aFeZc3jOIUF7fO09IixnbUsimv/xqRHRhjYpL6g5IqOV
         XxTJTwOOcLM8t8SMlkR2JYLnAFV5dHFIdvUNKDPQ5v9kBtKEl0XlD8Mykm946GYYpq4v
         +2ww==
X-Gm-Message-State: AHQUAuZ8hKy7egUZkGGU1PaP7obQbCMaqtZCWeXvnvNGQBRS4YJ1BH6t
        NdrCn7sDZcryoCRCOak9HAr1rg==
X-Google-Smtp-Source: AHgI3IYrToBTVbuymH9nBQVGfsAKwDtKVKpFVDGMYMHu+JadPkEDHCthNxuAzpLOroxNh7tq/4H9Hg==
X-Received: by 2002:a50:c408:: with SMTP id v8mr778469edf.144.1550070576370;
        Wed, 13 Feb 2019 07:09:36 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:4505])
        by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 07:09:35 -0800 (PST)
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
Subject: [PATCH v4 0/4] Add driver for Mediatek-based GNSS receivers
Date:   Wed, 13 Feb 2019 16:09:25 +0100
Message-Id: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
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

Version 4 changes:
- dt: bindings: use standard name "reset-gpios"
- dt: bindings: use standard name "gnss-fix-gpios"
- dt: bindings: s/an/a UART

Version 3 changes [0]:
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

[0]: https://lkml.kernel.org/r/1548693481-1162-1-git-send-email-lollivier@baylibre.com

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

