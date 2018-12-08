Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE1D20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iF4U0Dsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE1D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeLHRNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:13:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43431 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLHRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:13:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so6555909wrs.10;
        Sat, 08 Dec 2018 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CKwmb26jrhBLBt3QpwRPRe3U3/77uADy4gMJnqH2Dc=;
        b=iF4U0Dsy22CATFhzUilDo3CA4AGa0ooH8buA9bFahQ2WxXGenn7SykJf1aPB5rmjSF
         mtLq1RBaP/O1lg5oFAU7GePAet5stjS/Zf3Wq+8zEftMGK8CInR2YTtPyT77axgE49QA
         NNxzGBMMJudHPKOcSD7gakWFY8xX7IHVDLOOY74RHo18nVNrKYFmczYPNbJDn43TH0Wh
         uWhwNmUHjoFFIxlsHyBHstZAjUAAKMWVNNmmLqtXhz5H1w9L2y4wcnuDcCf0wp/RfM02
         Wodk2B8gj7L5ZiDsGceyhmLQ3kSSlYts6oX8PG0id50HT4jA6tbpLm2FN9FRUH6PNCyH
         VR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CKwmb26jrhBLBt3QpwRPRe3U3/77uADy4gMJnqH2Dc=;
        b=ceEO4tpGRE18GoTQOE14iFKNrtf6NoIsCs/nWyHg81Q0prR4BiQQznFE7KEkN1xntJ
         O+PecoGhj+Gq/rDUMgOH/cNLNYytqAfUvVgZ9HMKj1JCI9wDv/z6V+uTTpos/lRccKqK
         EBeXzj8/wcU6HpFb1eK+ap2dlDPyjT3CCp+I5q+F7Q0+VoHnb+JSFapBr5dknuRAgUeN
         yaDKijhCRQpGzXJjfrltJo+ua9WlaOgY1roSfedz6O9m8Q522G1X0W5g+c5YufgUbvuH
         2j/xZsToIsZR224hl3sfIhiMswG30H+rUwZWe3x1hybZxXUKizp5OCYIuNSnjSBSyjFb
         oX/w==
X-Gm-Message-State: AA+aEWYRVHIxItvJYAtRippxWStgwq/fhRbxHEsr59B1Fm2vdV6MYhaE
        tP8kdgAgRkFVsKSadH7QPbo=
X-Google-Smtp-Source: AFSGD/Xt/gYdaEq443dIwgz6+RZMT51zJkRJfreev114eQ/oJxHbAf2Eg1si4RKHoWt1jARc5qOabg==
X-Received: by 2002:a5d:46c2:: with SMTP id g2mr5313106wrs.49.1544289194507;
        Sat, 08 Dec 2018 09:13:14 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 09:13:13 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/5] ARM: dts: meson8b: add the Mali-450 MP2 GPU
Date:   Sat,  8 Dec 2018 18:12:47 +0100
Message-Id: <20181208171247.22238-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Mali-450 GPU and it's OPP table for Meson8. The GPU uses two
pixel processors in this configuration. The OPP table is taken from the
3.10 vendor kernel which uses the following table:
  FCLK_DEV5 | 1,     /* 255 Mhz */
  FCLK_DEV7 | 0,     /* 364 Mhz */
  FCLK_DEV3 | 1,     /* 425 Mhz */
  FCLK_DEV5 | 0,     /* 510 Mhz */
  FCLK_DEV4 | 0,     /* 637.5 Mhz */
This describes the mux (FCLK_DEVx) and a 0-based divider in the clock
controller. "FCLK" is "fixed_pll" which is running at 2550MHz.
The "turbo" setting is described by "turbo_clock = 4" where 4 is the
index of the table above.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 5d036842c355..dd498e681939 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -158,6 +158,32 @@
 		};
 	};
 
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-255000000 {
+			opp-hz = /bits/ 64 <255000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-364300000 {
+			opp-hz = /bits/ 64 <364300000>;
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
 		compatible = "arm,cortex-a5-pmu";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
@@ -185,6 +211,26 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0xd0000000 0x200000>;
+
+		mali: gpu@c0000 {
+			compatible = "amlogic,meson8b-mali", "arm,mali-450";
+			reg = <0xc0000 0x40000>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp", "gpmmu", "pp", "pmu",
+					  "pp0", "ppmmu0", "pp1", "ppmmu1";
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

