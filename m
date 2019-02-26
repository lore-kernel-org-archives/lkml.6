Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABE8213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C3FGAZLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfBZGDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:03:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36091 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZGDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:03:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id k2so5695957plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoctKyKOJPjwr3EAkL6gWK5ijQTvzyYNQS64venG094=;
        b=C3FGAZLPzmAjF1ZcQOyqCoWyAcb6dBdTeYSzX/AAqbkxy2Sdc7JcovaXc0w4ClNSjC
         ACfBpypzdAHiD9j/AFoRIlymqdwtBqZwO9M9IMcG5EKJTDG2iyLNlfkD/QeF857ojckO
         cEA/LSlDvtOUAMvnwyRuu8o2yWBEpICJs5tws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoctKyKOJPjwr3EAkL6gWK5ijQTvzyYNQS64venG094=;
        b=UBWqkZFHCVAcK5hU5rUXJUZ9d1bMYC8rhhwvIvLZDPLP6OMrJ+MSMzyE9DXfMYh+pz
         kkurPGbWKEI/FFQgevxNb3vOMGvaGWkLc8uled66qwuNhNGYBSVlH17rsP5S3jn9qMNd
         P6ztNMi12QZKEXZ61uAznCTFmSCdBmihxbeZSm0HV/sYr1VoA9VwPRk6G9vxlZoyIyIb
         Vz9CVvaKHP9xpMS1faCg9yLisPD9SwdnV553zHkOg8gKLZnPwoanrsAyNy1jJ2Qgsir2
         KmjgvZHp2CMgYlrcuOrQCDetM6nWtJtDrrMe0vXKQs/QR+ajMZoOF6tefiihlK2FJmzF
         prtg==
X-Gm-Message-State: AHQUAuYxDeV2ICAUqkt1a/dzaPYzQc9GtsSxzYkuFMyBmlaksZz1UFst
        CidM7Uz0PcQEpJWbYqrsZzvUPw==
X-Google-Smtp-Source: AHgI3IZmbI+ZRwN2agqDLCvvlLp3XMhd2DbP985ztD4qjH2c2Ceu0PgTtEPBLlEMuJiQ8Uip/LcDuQ==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9mr23212416pln.303.1551160980968;
        Mon, 25 Feb 2019 22:03:00 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm18976940pfa.75.2019.02.25.22.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:03:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD initial support
Date:   Tue, 26 Feb 2019 11:32:40 +0530
Message-Id: <20190226060240.8783-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190226060240.8783-1-jagan@amarulasolutions.com>
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
designed to mount SoPine SOM.

Key features:
- Allwinner A64 Cortex-A53
- Mali-400MP2 GPU
- AXP803 PMIC
- 2GB DDR3 RAM
- SD Slot
- SPI-NOR flash
- EMAC, RTL8211E
- MCP2515 CAN
- MIPI-DSI
- Goodix 911 CTP
- USB Host
- 12V DC power supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index a5fb1eaa8acf..ec39fe856117 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb sun50i-a64-bananapi-m64-icn6211.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5inmfd.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
new file mode 100644
index 000000000000..d73d1f55acb9
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
+ * Copyright (C) 2019 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a64-sopine.dtsi"
+
+/ {
+	model = "Oceanic A64-5inMFD";
+	compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.18.0.321.gffc6fa0e3

