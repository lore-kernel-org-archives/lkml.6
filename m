Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C83C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812B72086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fLb8poL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfAaN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:29:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36723 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbfAaN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:29:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so3309157wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBv+ePDnjlJOS70jVWx32cfATbisSYPzzmaKr5EYuvM=;
        b=fLb8poL941xh3DQtCqT7bvVri6EmV83l7xUb3njpfuobp1/nczWkIOyFQsFm3wHUaG
         o9wwXX3mxbmUrsatznFfulXH/yVJIAhB6FcEzVk9vU+ypIeGHK9Ml/vDyiu2nBfs99Qn
         mLkdigB0j4tzYeYfiyDVAFbhwfgJ47Xyl12Vx8jmtw2bd6iOptQ6b9HLLt/c/R8vyu+f
         fpnqiDuV71h+BTmrT86wJQoWCHS5ZSBbw/yVPK6pvkVi+1IxVo68AYgOHjfdVZiv3WSP
         QsZQQBynCDFpHWqhH8fOxa2e07MGcpBtyGHR8sXWjCfVmkSlaNFLphPA97dbsdduxLon
         z5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBv+ePDnjlJOS70jVWx32cfATbisSYPzzmaKr5EYuvM=;
        b=tOIL2Huc4T4SZK6zWD4z/X9cnWhmGqzvZQYLySUpAVEZkWBjndTTYULMC+kYMPlFNN
         koyGGZCKiOBXtUj7RP9rcsnp27eqaLsrRyf27J81HqFUQKpPGxztth+nIFtaDyN3T9LD
         670aLPbPM5RnuxWOc7F6cT1umf3vGe3gpDlSxUQCd5TlGcQfhaPVx+ojhy7M/B/dwPRV
         gECY1NAOIJ+J+qOhTytsf/BrG+z9sQKjkK8sHsbApYJyQzRkHwpc7qO7vMj6oEtAsUSW
         qmhFe3qyhN+1D9oBtBJhLJiS6Y5PEeNnrLjctq3EgoTL7a70KSB5ZfFkcyv9Bf+3FPQ6
         0/xg==
X-Gm-Message-State: AJcUuke4EvRXw8/tCSYa82teVfyut50ZXGkCS+ksbXNZZSVYnZ3xsa1Y
        /v5thWgJ83UBu5QpW/EocRJorNAn6SXA5w==
X-Google-Smtp-Source: ALg8bN7fBEKDYKgNRyBhWN5hcFQNAO+4vbQz6Z9J8eY4+gBzHmClZe+TC5dsqGKAwC9EadXnimhbrg==
X-Received: by 2002:adf:9c01:: with SMTP id f1mr35750825wrc.286.1548941381163;
        Thu, 31 Jan 2019 05:29:41 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t199sm4978584wmt.1.2019.01.31.05.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 05:29:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: add bindings for the ARM Mali Bifrost GPU
Date:   Thu, 31 Jan 2019 14:29:39 +0100
Message-Id: <20190131132939.2263-1-narmstrong@baylibre.com>
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
 .../bindings/gpu/arm,mali-bifrost.txt         | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
new file mode 100644
index 000000000000..a632f5136b08
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
@@ -0,0 +1,94 @@
+ARM Mali Bifrost GPU
+====================
+
+Required properties:
+
+- compatible :
+  * Must contain one of the following:
+    + "arm,mali-g71"
+    + "arm,mali-g51"
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
+Example for a Mali-G71:
+
+gpu@ffa30000 {
+	compatible = "amlogic,meson-g12a-mali", "arm,mali-g71";
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

