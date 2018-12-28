Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF7FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5773C20855
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FTfLsvjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeL1KvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:51:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36304 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbeL1KvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:51:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so17258685edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wA3sLETIlRKxDeeXR4+xPBu2iPGUxyZdr6J70dBcBMc=;
        b=FTfLsvjp9wAwTpVKEXYFpHakm258olb010572UoKlhqZu+eFd2M96e1o8sklL+FVwY
         z/8HWJXAg304i1r2AIAw2SOh8BR4bxqmtQdmaQ+V6o7pf9ImG1CFy2OzKhsgFrNYRcG2
         fMnkp2aK6/MHsw3+OC9jutXDlcd/BDtP66GYfy8SX7S4WJQhdAhIuHnwo0QbvHG2vIEc
         P8Nqwyibc+FuFWoQCkMbzhxidBN0t1jvv8KmJTQs79PZMTaCFFaGlvnbq+W3yHk396MC
         +UIUxUSXaEv73vUgKfCM4PrAfp8TtE+irTB8IRkmRacKz1KUr/af3BtUEcop8cDVHnP4
         wOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wA3sLETIlRKxDeeXR4+xPBu2iPGUxyZdr6J70dBcBMc=;
        b=K1FY9imvQOOVOQaQk0TQWcU5D2jkwMMKbByYsY/ODWPqd2Wi3W7GfI4wStUiHaTlDh
         CFNLMx3AledGspHNojcTI+dQD1ugNmxuMXJYN5MutoX0fAtU4ZAtg1kFqsPgfzP01Iq9
         /N16ShOQbMgywwo3NqFCnitJZapiVrXvZAbjpCqL7h6ATqoDsCEUeLC8L+o+aIcqncoF
         W4FKhMNKEC9S2ubCNI7AD+iLQUma6F1Ug3K0b/rev1xeOwLjLDAKHloVPQlS4sCwGy1E
         i/pgOlEAxjHtIW7WU4cOWEidSBSgZevM0NiuNpt2tVNj0eRJpAcQNCJP9+lHs+rdNMTC
         rUJQ==
X-Gm-Message-State: AA+aEWavU8qqQ/4HdJ/cBiu7qn5GqYr3PVgpLSsLecfA4SAc31tdK/K9
        NA5+n0XXU301MWR/wC2r4fRE+w==
X-Google-Smtp-Source: AFSGD/V0yeIx+cijKHQpfNYsgWe4yjvozMJgCgY0/4AQWOY/CSuayOl8aKpd4gZrrXxEbouMFg7VEg==
X-Received: by 2002:a50:b006:: with SMTP id i6mr22275869edd.84.1545994270947;
        Fri, 28 Dec 2018 02:51:10 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.home (anice-157-1-157-17.w83-201.abo.wanadoo.fr. [83.201.132.17])
        by smtp.googlemail.com with ESMTPSA id b45sm12919494eda.34.2018.12.28.02.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 02:51:10 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/4] Add driver for globaltop GNSS receivers
Date:   Fri, 28 Dec 2018 11:50:31 +0100
Message-Id: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

This patch series adds a new GNSS driver for the globaltop GNSS receivers.
These receivers transmits NMEA output sequence as soon as they have booted.
Power management can be done via the main supply and optional backup supply
as defined in the device tree.

The driver has been tested using a GlobalTop pa6h chipset on a Libretech-cc
board using the expansion header. Changes made in the board device tree can
be found below for reference and testing.

Loys

Loys Ollivier (4):
  dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
  dt-bindings: gnss: add gtop binding
  gnss: add gtop receiver type support
  gnss: add driver for globaltop receivers

 Documentation/devicetree/bindings/gnss/gtop.txt    |  33 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gnss/Kconfig                               |  13 ++
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/core.c                                |   1 +
 drivers/gnss/gtop.c                                | 152 +++++++++++++++++++++
 include/linux/gnss.h                               |   1 +
 7 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/gtop.txt
 create mode 100644 drivers/gnss/gtop.c

---
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af967a7..3b3d4dcc47aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -17,6 +17,7 @@
 
        aliases {
                serial0 = &uart_AO;
+               serial1 = &uart_A;
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

