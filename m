Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD3C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112542083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JCUbcy8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112542083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLHRNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:13:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55496 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLHRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:13:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so7068837wmc.5;
        Sat, 08 Dec 2018 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufWx9PbgvHd9u7lf9dIhnJP1Zesf1aI0AT2ABxZ8FWo=;
        b=JCUbcy8fbbriT57TP9EbGaiaRen5dOCaEiISWaE3Vds2FvaKPFRRP/8G0KisekQrml
         seG1pJZd4ccrt+6vjQ7L16FxkbcsLYdIy0+xA3TwGVq2xYQCVbp+D5Sy78X0JzCdpio4
         l3StGo6j5L9BBFtrRRYXn+fay+aYMqAv33V/K/ijB/KnBjxFXHKkkUgPoEtxrCoVPgfj
         IJkQXg90NqfYeqOcUxGDLqCrJkIUdUqWXDVVaVU9ZPo4Rt3kchilKMxLvbPn3MTWrSXP
         UPxq4duDD0bEprwNPxWZVPztSnw1/3bcDCpE380NO+hCz/4cDCcRyOj9xKsq8V2b+1Oz
         VuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufWx9PbgvHd9u7lf9dIhnJP1Zesf1aI0AT2ABxZ8FWo=;
        b=Db1DYsFhnFHIHLzzjycVzumLa5Zbeqku7WtfHQDWkC3F163TMsdTPw8jMBuKLyZtRl
         RdatDib7KICe2BMXLW/mIbxf9d3k0vFctvWg8hym9AW35RSc9rYKqqxM+rtXME9JkgSs
         UGKKpJ7dWpQRTuXocCTjf7Ud/Ldj4aaLR6/bqx92Phwjd3Xc5diuuwpm1r7GWK/vZn3W
         6SktDj4vmKb/FbGNAq+zTutSbP8rep+lRYMu8s2LIitM0cmmRfBs+P+A6DVpyqpTggeC
         t5z1uSKpWdheZpn1rX0p5xjyHVTzoX3VCNakDvM0IkvmoBngUuktPhHoXGkw0HQ2Qoj3
         Vnmg==
X-Gm-Message-State: AA+aEWabOYDtjgIDCfUkyG9Ft+eZASbPzRF1N6a5YhNB5/doOX+tqG0W
        Ir+q7LulEDe9QjchNI9sbZw=
X-Google-Smtp-Source: AFSGD/V6NFAWTfGZ5JvBUa068LACjLxWCimV72QfskWrn1em9hf1ynaHN1tLJ6ZdJ5uUDtKMbv20TQ==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr5656692wmb.23.1544289193388;
        Sat, 08 Dec 2018 09:13:13 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 09:13:12 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/5] ARM: dts: meson8: add the Mali-450 MP6 GPU
Date:   Sat,  8 Dec 2018 18:12:46 +0100
Message-Id: <20181208171247.22238-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Mali-450 GPU and it's OPP table for the Meson8 and Meson8m2 (the
latter inherits meson8.dtsi).
These SoCs have a Mali-450 GPU with six pixel processors. The OPP table
is taken from the 3.10 vendor kernel which uses the following table:
  FCLK_DEV7 | 1,     /* 182.1 Mhz */
  FCLK_DEV4 | 1,     /* 318.7 Mhz */
  FCLK_DEV3 | 1,     /* 425 Mhz */
  FCLK_DEV5 | 0,     /* 510 Mhz */
  FCLK_DEV4 | 0,     /* 637.5 Mhz */
This describes the mux (FCLK_DEVx) and a 0-based divider in the clock
controller. "FCLK" is "fixed_pll" which is running at 2550MHz.
The "turbo" setting is described by "turbo_clock = 4" where 4 is the
index of the table above.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 3fd8260eba92..1ea5a36c5040 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -166,6 +166,32 @@
 		};
 	};
 
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-182150000 {
+			opp-hz = /bits/ 64 <182150000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-318750000 {
+			opp-hz = /bits/ 64 <318750000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-425000000 {
+			opp-hz = /bits/ 64 <425000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-510000000 {
+			opp-hz = /bits/ 64 <510000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-637500000 {
+			opp-hz = /bits/ 64 <637500000>;
+			opp-microvolt = <1150000>;
+			turbo-mode;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
@@ -208,6 +234,38 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0xd0000000 0x200000>;
+
+		mali: gpu@c0000 {
+			compatible = "amlogic,meson8-mali", "arm,mali-450";
+			reg = <0xc0000 0x40000>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp", "gpmmu", "pp", "pmu",
+					  "pp0", "ppmmu0", "pp1", "ppmmu1",
+					  "pp2", "ppmmu2", "pp4", "ppmmu4",
+					  "pp5", "ppmmu5", "pp6", "ppmmu6";
+			resets = <&reset RESET_MALI>;
+			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
+			clock-names = "bus", "core";
+			operating-points-v2 = <&gpu_opp_table>;
+			switch-delay = <0xffff>;
+		};
 	};
 }; /* end of / */
 
-- 
2.19.2

