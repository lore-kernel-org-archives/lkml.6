Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1ADC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EBE20855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t45TfQUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfBLQir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:38:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35386 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbfBLQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:38:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so3432657wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClTUzezi3cfuWIoAAbFTrjOhNUbiBoeL1rpDXNmQzB4=;
        b=t45TfQUBTPQ+9tg2cFrO4qK/7DJLyUHFwlXzvpynxsp4PrnN/0h9ZjidtgSuF1xuMw
         i1WmiU+eQLrvqbJfTBEWVEJ+jxcJu44n3Qkefc07sC/pzAePq+zIYieXrUksRb30gNqb
         wy6gNLVd+YQXMFP1jIXR92XeoNcZ8xL6KK7olZp+VeYeWn2jiseLnDdKXDm33nmm0p5D
         OaU2xUthA+UJjSJ0UINM7zU7SVUmtkS/kF/6jwjs2NZddUQtk2RmHu+f+YMOg7bBLfW0
         0S3mvIimyaHiU/Jwo72ANMpoXlfhKUolmRnbqZx3RKiH07eBYl7q3sIhYEapz9wGwi/6
         iKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClTUzezi3cfuWIoAAbFTrjOhNUbiBoeL1rpDXNmQzB4=;
        b=nnXwWOpo688YNOkuqjndAnF9lWdoMTPJN/gJ5UHsqxjCtFC74Ab4hSZSKdXjBtLxbk
         blHC6B2EUgrNcWyFAk1gDQ5i9hF+AQ8X1ES7MHn1glkiw0dS1wGxyaBKoWpfObOSPMV7
         wC0Pk+hetOzqRzWdxakB53aVhzdv3gy9lEkiGWXbB+uzt0PEjL3T3muDTwk/i6905Qtj
         +CNGrDDJuk3IvDVBIjPS+l42FVzy/4PGqUOSjQNszRbhkSessJT8liQcptoPLG3N5Lpn
         FJecpn0yrLr8/Qsmvm55n+PkoxZ0XcwV3PbiVzvgJyxGj2YkrnHkVu4MtmORVV+LuOmq
         zfDw==
X-Gm-Message-State: AHQUAub8EnNbc+8pMLxgYSdb7azcfHEg1wSp6UQIBzTqyg/0jAPP/fjN
        2MI69XoGxYpWwgkC0ZAdRcWoCg==
X-Google-Smtp-Source: AHgI3IYKvyjBpIFDL2NL4yYJsmSAtaHCmuisSBlNRPvAGGCeHH/otyUc+Rht553ENztIiMblhDsiZQ==
X-Received: by 2002:adf:eb07:: with SMTP id s7mr3670318wrn.158.1549989524502;
        Tue, 12 Feb 2019 08:38:44 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v6sm10325610wro.57.2019.02.12.08.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 08:38:43 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: gpu: add bindings for the ARM Mali Bifrost GPU
Date:   Tue, 12 Feb 2019 17:38:38 +0100
Message-Id: <20190212163838.22644-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the Bifrost family of ARM Mali GPUs.

The Bifrost GPU architecture is similar to the Midgard family,
but with a different Shader Core & Execution Engine structures.

Bindings are based on the Midgard family bindings, but the inner
architectural changes makes it a separate family needing separate
bindings.

The Bifrost GPUs are present in a number of recent SoCs, like the
Amlogic G12A Family, and many other vendors.
The Amlogic vendor specific compatible is added to handle the
specific IP integration differences and dependencies.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- adding missing G31 and G52
- fixed example

 .../bindings/gpu/arm,mali-bifrost.txt         | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
new file mode 100644
index 000000000000..04a1d63ee578
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
@@ -0,0 +1,96 @@
+ARM Mali Bifrost GPU
+====================
+
+Required properties:
+
+- compatible :
+  * Must contain one of the following:
+    + "arm,mali-g31"
+    + "arm,mali-g51"
+    + "arm,mali-g52"
+    + "arm,mali-g71"
+    + "arm,mali-g72"
+    + "arm,mali-g76"
+  * which must be preceded by one of the following vendor specifics:
+    + "amlogic,meson-g12a-mali"
+
+- reg : Physical base address of the device and length of the register area.
+
+- interrupts : Contains the three IRQ lines required by Mali Bifrost devices.
+
+- interrupt-names : Contains the names of IRQ resources in the order they were
+  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
+
+
+Optional properties:
+
+- clocks : Phandle to clock for the Mali Bifrost device.
+
+- mali-supply : Phandle to regulator for the Mali device. Refer to
+  Documentation/devicetree/bindings/regulator/regulator.txt for details.
+
+- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
+  for details.
+
+- resets : Phandle of the GPU reset line.
+
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+- "amlogic,meson-g12a-mali"
+  Required properties:
+  - resets : Should contain phandles of :
+    + GPU reset line
+    + GPU APB glue reset line
+
+Example for a Mali-G31:
+
+gpu@ffa30000 {
+	compatible = "amlogic,meson-g12a-mali", "arm,mali-g31";
+	reg = <0xffe40000 0x10000>;
+	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "job", "mmu", "gpu";
+	clocks = <&clk CLKID_MALI>;
+	mali-supply = <&vdd_gpu>;
+	operating-points-v2 = <&gpu_opp_table>;
+	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
+};
+
+gpu_opp_table: opp_table0 {
+	compatible = "operating-points-v2";
+
+	opp@533000000 {
+		opp-hz = /bits/ 64 <533000000>;
+		opp-microvolt = <1250000>;
+	};
+	opp@450000000 {
+		opp-hz = /bits/ 64 <450000000>;
+		opp-microvolt = <1150000>;
+	};
+	opp@400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <1125000>;
+	};
+	opp@350000000 {
+		opp-hz = /bits/ 64 <350000000>;
+		opp-microvolt = <1075000>;
+	};
+	opp@266000000 {
+		opp-hz = /bits/ 64 <266000000>;
+		opp-microvolt = <1025000>;
+	};
+	opp@160000000 {
+		opp-hz = /bits/ 64 <160000000>;
+		opp-microvolt = <925000>;
+	};
+	opp@100000000 {
+		opp-hz = /bits/ 64 <100000000>;
+		opp-microvolt = <912500>;
+	};
+};
-- 
2.20.1

