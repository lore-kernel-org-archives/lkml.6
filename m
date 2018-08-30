Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36350C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BBD20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSl/Vax1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeH3TsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40864 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeH3TsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id 207-v6so2491373wme.5;
        Thu, 30 Aug 2018 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQMFFCtjVJMB79OboK16hKVLwCLSA0PsOx2A/8CBESc=;
        b=uSl/Vax1IuA+CFRUIKwTxxFUvJfRWakNh5g16Kc0q07Q68gw45yu6ugu2nZm/dMKko
         QadCBK52Wf+8QPU4hVqpjMsnFMfMhPxGReEQknxirOo1kHhARPI0a1btuB90dm730IkN
         1OO6dsLT8qznPCn7cgcBZ93F0MWNoU2Kle15pJEe73mC8+Osqt/9YiQnijDe87Z7c7Ov
         AFNXVGKcDcnmBvVQyuGcR6n/G6zuYTX7MOItqnR9zmK8pmklbB0+m+sz43o2YD4D9DTF
         hSj+RBgWWLsMkwnaE/tcMpPG1EignyUBXHtPfw1XPE4H74HINyNmEPeZMLQkUcn57dja
         nHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KQMFFCtjVJMB79OboK16hKVLwCLSA0PsOx2A/8CBESc=;
        b=KW6h+rmxQNH/Y+HfGlf3uv/U+/2aF2VWoPeXOrtT5hZaGnqKbppYiEr/MUNDtV6e3d
         +Mr1bV4K1CplLGqWvNIpvGwKAqtZUA2bUKaDrPh6ZxF7Ev8YFL9+8bYHufTwugod5aUx
         mj6PhtLUFkcc/veZ5iNtQwM23rcLJD0C1NSewiQD927FpsTTxOpDzILnqSaNN584cZ7n
         dYNgKPndQVl4g10VYwq+jMR9BIWjPtr1unCj4L5CY//nO5kIy59CtVqgQCWExlT3QSrC
         YRGrXw7RERA6yTIj1ya6yIdq0XSWK3KO91a4DA9LtyuILr/tAeVa+Gh4e3T6VvykQWXB
         mAyg==
X-Gm-Message-State: APzg51DMaUCSMD+1Ya2PAAeBgQou6ej2TSnFhQrnLfOxwnKmFsoDVkmR
        xxeNwN1/XXhOap8Oh07WaJY=
X-Google-Smtp-Source: ANB0VdYDy7wn0q0bTBfQwfLF4nhftHhBI9Gwyly1JXh4FK3AUDx60kkf66i1PFdimUNMVOn1/QjC9A==
X-Received: by 2002:a1c:ba84:: with SMTP id k126-v6mr2051153wmf.96.1535643933705;
        Thu, 30 Aug 2018 08:45:33 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:33 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 14/30] dt-bindings: update the Allwinner GPADC device tree binding for H3 & A83T
Date:   Thu, 30 Aug 2018 17:45:02 +0200
Message-Id: <20180830154518.29507-15-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H3 features a thermal sensor like the one in A33, but has its
register re-arranged, the clock divider moved to CCU (originally the
clock divider is in ADC) and added a pair of bus clock and reset.

Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
the bus clock and the reset was removed from the CCU. The THS in A83T
has a clock that is directly connected and runs with 24 MHz.

Update the binding document to cover H3 and A83T.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 .../devicetree/bindings/iio/adc/sun4i-gpadc.txt    | 41 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc.txt
index a7ef9dd21f04..9116ad308cf1 100644
--- a/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc.txt
@@ -4,12 +4,35 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
 and sometimes as a touchscreen controller.
 
 Required properties:
-  - compatible: "allwinner,sun8i-a33-ths",
+  - compatible: must contain one of the following compatibles:
+		- "allwinner,sun8i-a33-ths"
+		- "allwinner,sun8i-h3-ths"
+		- "allwinner,sun8i-a83t-ths"
   - reg: mmio address range of the chip,
-  - #thermal-sensor-cells: shall be 0,
+  - #thermal-sensor-cells:
+		Please refer <devicetree/bindings/thermal/thermal.txt>,
   - #io-channel-cells: shall be 0,
 
-Example:
+Required properties for the following compatibles:
+		- "allwinner,sun8i-h3-ths"
+		- "allwinner,sun8i-a83t-ths"
+  - interrupts: the sampling interrupt of the ADC,
+
+Required properties for the following compatibles:
+		- "allwinner,sun8i-h3-ths"
+  - clocks: the bus clock and the input clock of the ADC,
+  - clock-names: should be "bus" and "mod",
+  - resets: the bus reset of the ADC,
+
+Optional properties for the following compatibles:
+		- "allwinner,sun8i-h3-ths"
+		- "allwinner,sun8i-a83t-ths"
+  - nvmem-cells: A phandle to the calibration data provided by a nvmem device.
+  - nvmem-cell-names: Should be "calibration".
+
+Details see: bindings/nvmem/nvmem.txt
+
+Example for A33:
 	ths: ths@1c25000 {
 		compatible = "allwinner,sun8i-a33-ths";
 		reg = <0x01c25000 0x100>;
@@ -17,6 +40,18 @@ Example:
 		#io-channel-cells = <0>;
 	};
 
+Example for H3:
+	ths: thermal-sensor@1c25000 {
+		compatible = "allwinner,sun8i-h3-ths";
+		reg = <0x01c25000 0x400>;
+		clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+		clock-names = "bus", "mod";
+		resets = <&ccu RST_BUS_THS>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+	};
+
 sun4i, sun5i and sun6i SoCs are also supported via these bindings:
 
 Required properties:
-- 
2.11.0

