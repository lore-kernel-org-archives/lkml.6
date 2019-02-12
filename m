Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A1220823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xwTOHJme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfBLODN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:03:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:03:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so2803998wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jN5KUzfKX2ndr6TNL6ZWjgGyp82IoCOhgEMTMPUGQYI=;
        b=xwTOHJmeN1oYM8JlE57RDbdCpUcSAWOeO9lHTdXDTKiVHQiIa+5MBD5cuOrtV+0BHf
         mMQbWeeGTZpryJnbTRQvgb8Dd0l4MIxbnkR/BtWzOsXqqPf9ZYD8dVToUAz04ksTJnwr
         HlwbJRaQTmmZHasPLGYwDUVxMsFJ2HNQqTJKc38+zJmF+q+5dWh0IEvOo9/ilMYqiHRh
         abPQ79/KOJz3yNucAqOb59c76LpLe5kMbO6nBh6TsVbXKHXlgrNr1fqwyhhAMiRkpGM4
         Mp5tPJ/Ow2L5EcksZWxkKAtCSO4qN6OCeGdkck59td7MhioNMYzAN71KbGTfY7XKgMa7
         GBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jN5KUzfKX2ndr6TNL6ZWjgGyp82IoCOhgEMTMPUGQYI=;
        b=tyDvT4t5zB7Ou5ZmKwID4veNr8e5MgZykkSHdf5RO07ndgO/Bm5tVggFHtPFocqvgQ
         24quFt1nMdwSK+8EgGMcOfds6rBQyH/5lbv7v89OtKXYEOt9/EKqtYVLy9AsF9OriN0q
         Ao1iOj6sa7dx/LlIPFC2zbMFdsnG8/2bjd5YrOVoDOZeq42EFwJHG6tTxA92cRia+90f
         PO74unbOEWmkWsYifsZfjJDhzI6BYH/WTPcICytmvtZ3RIjN6U1NbRYlTBgmT4BwYuZp
         sgRihicBvIHE88urMZqaU7ocEE8WT7VFvf/e5ReombaoSj8y4ymamYfQar5GNeNLsv5U
         FW0Q==
X-Gm-Message-State: AHQUAuYkmdmXIQzHCkZs9lI5ZsVsMTToctPvcsuS502LxD43YTmrEoqI
        suRhfOCRc6VuMT1/Bs7ooSIB9w==
X-Google-Smtp-Source: AHgI3IZX1WfsdFtWbVrcdrN2oLFP3xvftMrl/I8QnMfuGABwxEYTBvnxag+iyshx+3R1mAnqm4jStA==
X-Received: by 2002:adf:9083:: with SMTP id i3mr3030823wri.124.1549980184261;
        Tue, 12 Feb 2019 06:03:04 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm23435678wrq.81.2019.02.12.06.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:03:03 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: Add SEI Robotics SEI510 Board
Date:   Tue, 12 Feb 2019 15:02:59 +0100
Message-Id: <20190212140259.9537-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212140259.9537-1-narmstrong@baylibre.com>
References: <20190212140259.9537-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEI Robotics SEI510 Board is based on the Amlogic G12A S905X2
and has the following features :
- Amlogic G12A S905X2 SoC
- 10/100 Ethernet
- USB2 + USB3 ports
- Micro SDCard Port
- Audio + CVBS AV Jack port
- HDMI 2.1 + CEC Port
- ADC Touch Button
- Far-Field Microphone Array + Mono HP
- IR Sensor
- IR Emmiter LED Array
- RGB Led

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/arm/amlogic.txt       |  1 +
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 38 +++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 7f40cb5f490b..061f7b98a07f 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -110,6 +110,7 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,u200" (Meson g12a s905d2)
   - "amediatech,x96-max" (Meson g12a s905x2)
+  - "seirobotics,sei510" (Meson g12a s905x2)
 
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0821fed4c074..2709f7ede908 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
new file mode 100644
index 000000000000..6a7c3241862a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre SAS. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-g12a.dtsi"
+
+/ {
+	compatible = "seirobotics,sei510", "amlogic,g12a";
+	model = "SEI Robotics SEI510";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		/* TEE Reserved Memory */
+		bl32_reserved: bl32@5000000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
-- 
2.20.1

