Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339E620834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5XIAotS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339E620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLDTkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:40:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34097 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:40:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so8809635plz.1;
        Tue, 04 Dec 2018 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LD9RiW/w/AsFU5z2eVVV/9ELhBDspcusWDXKoRIDE+8=;
        b=C5XIAotSFsUpeFjn0oACPmsEbp51GG/lP+lorXbEurmk7KRpgRIC2LWPV/+BuHytFV
         whvhOjSiEdR3MmlvI7LILK/jlNO0V0FKp6Ju8u2wwZJwJ7bNP+jrjGYoXrZ5Df+b94w3
         IjrwBltbuXpOs7j+3RoES5390kUp7BapHDjCwm/CjUM1cPndhPv97mL/lKkRknaOHCRX
         kOrYLZYU5v+TWowwy9+2nvzcHcKtr5K+3r3X+26QF+Q5zR29PJCRZDJ1nR/jnReX1hwK
         EyVgOuN563m11r+t21dSbpRDNtt6Gz7DocgmDm7LujA6OtvGcK/iLKgM5Y7I4cyJJHFA
         E+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LD9RiW/w/AsFU5z2eVVV/9ELhBDspcusWDXKoRIDE+8=;
        b=d2Wu4n/2aW70B+EoUxP2kjVJDQ/xK+G0LrTaNJ0MsHjH9aT1zIyh7pMuxo0UWKYM7B
         Ci/QF9ZvMem07+SpPFZErcNH6aodRf7JlFH1cUcRWo83CxNCDbh4jHr+0VWB0BdMvgJn
         yRSMMzghfV2nwQ8iRoAwT85fZ6kHgDa0V2heBkPPKEb9MS9jexDxBtcw/+rqu7Bg4Rpj
         MewlMtzJzH2b8aubrmu/SXiTZ8Vr6klpfcUow/IaN8cVsjWy++nFnUbKmeORAI+ADoGl
         jhciW5dDqgJFUmGBRY6i0WEsStVD8WSsLFU8iawG0MTIepOFDPMv/UiuLazuy7bx+s9B
         TF+A==
X-Gm-Message-State: AA+aEWYe9ZJteV5QqJOOUzvoiy42mPtQiHim0t5a1iBchBxx9OWMScNI
        6Ien3W3YLLz6Bfwo9YynRiz0SOg8
X-Google-Smtp-Source: AFSGD/U9j/H3zTbdJWvfJwZ8vKn8aNPLVBAttjL6pyHgJqY975wBKlpoxF7fJvi/Ds2I3MDDs2HnDw==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr21398195plb.192.1543952434181;
        Tue, 04 Dec 2018 11:40:34 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.91])
        by smtp.gmail.com with ESMTPSA id u137sm36108381pfc.140.2018.12.04.11.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:40:33 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: dts: exynos: Add proper regulator states for suspend-to-mem for odroid-u3
Date:   Tue,  4 Dec 2018 19:40:25 +0000
Message-Id: <20181204194025.2719-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend-to-mem node to regulator core to be enabled or disabled
during system suspend and also support changing the regulator operating
mode during runtime and when the system enter sleep mode.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid U3+
---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 2caa3132f34e..837713a2ec3b 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -285,6 +285,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo3_reg: LDO3 {
@@ -292,6 +295,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo4_reg: LDO4 {
@@ -299,6 +305,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo5_reg: LDO5 {
@@ -307,6 +316,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo6_reg: LDO6 {
@@ -314,6 +326,9 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -321,18 +336,27 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
 				regulator-name = "VDD10_HDMI_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
 				regulator-name = "VDDQ_MIPIHSI_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -340,6 +364,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo12_reg: LDO12 {
@@ -348,6 +375,9 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo13_reg: LDO13 {
@@ -356,6 +386,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
@@ -364,6 +397,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo15_reg: LDO15 {
@@ -372,6 +408,9 @@
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
@@ -380,6 +419,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -387,6 +429,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo21_reg: LDO21 {
@@ -394,6 +439,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo22_reg: LDO22 {
@@ -411,6 +459,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck1_reg: BUCK1 {
@@ -419,6 +470,9 @@
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -427,6 +481,9 @@
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -435,6 +492,9 @@
 				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -442,6 +502,9 @@
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-microvolt-offset = <50000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
@@ -450,6 +513,9 @@
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck6_reg: BUCK6 {
@@ -458,6 +524,9 @@
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck7_reg: BUCK7 {
@@ -465,6 +534,9 @@
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck8_reg: BUCK8 {
-- 
2.19.2

