Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FFDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5F222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSmuiGaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394946AbfBMVlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:41:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43204 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfBMVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:41:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so1780303pgk.10;
        Wed, 13 Feb 2019 13:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irYv0xqfxLq9eyi1hZL6+OFFikwsolagLNKzHmLmsDI=;
        b=fSmuiGaLyJQY2gMc8QKrxHYpM/QBJuMTPyej4qwJ4LBaAEOrEQixJ/O93WT+TdRN4C
         QNHGo79Rc6gvUeSHCJlns1okxy7sFWx/UG3XrPUq46OlI0C9jhOlaQkr7wALsOV9RWe0
         ZresE/vLbLm+8+CU88rXXKJSroDhs43s46dM9SLR9jj3qmXYl3RAocpv7FzOX337ArAO
         we1RulDUcgyMWmmeCcB0pQ9KcvaXlCXVquoENEXkQASGxupARbDvojUR4A1o3qXpOt+x
         RF1ThrQPvmIuL1hoj2xunaNUzvf3W53ewlA8u/TlRgdIID3ntd3ivs+iFjcKV0bb0Iss
         Zicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irYv0xqfxLq9eyi1hZL6+OFFikwsolagLNKzHmLmsDI=;
        b=XDIbl/8rkyigqRJ+nve+UBiK3FQc2mVtFrH2Uv2A5KE+c/mRCtlFTOQxUIoEpj9CxY
         qvcc4IkZ+JDgJVkQSVFflDMm9s0RdPgd9LC3BNSIMGzp/G0597bJF4q2oVeBVzJOQRpO
         KFewt8jL8SO3uvWhZML6htxf6lrGAmru9dklxuzZ4ovDXIFVfXXVVfGDdOwoq7zXNnDX
         p7T+i01ktH9VXRAjTBI23Jtyu2QwDCQ6F6vs1kBVpyeFSkfD2KSCfBo+4jlwwD4rtGES
         uZIy0wXwD8S06JltP6xnpNx/Q94X0pu5cIKQ+UNeGr5wX66oLFHA8SXmn1nrV13/Ehmr
         X8bw==
X-Gm-Message-State: AHQUAuZ47oWN+mz69Zkf6J1P6Mvsgb4uhBIyVdyxn6Vpk5wrBP8bdYmQ
        6zq+ygSc03TWN9qmdQjASNCcKbD+
X-Google-Smtp-Source: AHgI3IYyzFpAT4H0kv5rJUFUvP0YLTaqWAkByRWTtEuPVJlryBPzkD7gPOtHjQ9fKGj9WkLAw979Qw==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr253368pgr.333.1550094076803;
        Wed, 13 Feb 2019 13:41:16 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.137])
        by smtp.gmail.com with ESMTPSA id w128sm335321pfw.79.2019.02.13.13.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:41:16 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFC 1/2] ARM: dts: exynos: Add proper regulator states for suspend-to-mem for odroid-u3
Date:   Wed, 13 Feb 2019 21:40:51 +0000
Message-Id: <20190213214052.2427-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213214052.2427-1-linux.amoon@gmail.com>
References: <20190213214052.2427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend-to-mem node to regulator core to be enabled or disabled
during system suspend and also support changing the regulator operating
mode during runtime and when the system enter sleep mode.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---

Changes from previos patch
[0] https://patchwork.kernel.org/patch/10712549/

Set all the WAKEUP source regulator in suspend-on state.
LD04, LD012, LD015, LD020, LD022
Set all the non used regulator in suspend-odd state
LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016

BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator

Tested on microSD card and it resumes correcly after suspend.
eMMC is not able to resume after entering into suspend state,
which need to be investigated and how to debug more.
---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 63 +++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 08d3a0a7b4eb..e984461c37d9 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -288,6 +288,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo3_reg: LDO3 {
@@ -295,6 +298,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo4_reg: LDO4 {
@@ -302,6 +308,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo5_reg: LDO5 {
@@ -310,6 +319,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo6_reg: LDO6 {
@@ -317,6 +329,9 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -324,18 +339,27 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
 				regulator-name = "VDD10_HDMI_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
 				regulator-name = "VDDQ_MIPIHSI_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -343,6 +367,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo12_reg: LDO12 {
@@ -351,6 +378,9 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo13_reg: LDO13 {
@@ -359,6 +389,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
@@ -367,6 +400,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo15_reg: LDO15 {
@@ -375,6 +411,9 @@
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
@@ -383,6 +422,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -396,6 +438,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo22_reg: LDO22 {
@@ -405,6 +450,9 @@
 				 */
 				regulator-name = "LDO22";
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo25_reg: LDO25 {
@@ -413,6 +461,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck1_reg: BUCK1 {
@@ -421,6 +472,9 @@
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -429,6 +483,9 @@
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -437,6 +494,9 @@
 				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -444,6 +504,9 @@
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-microvolt-offset = <50000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 2bdf899df436..4ebde09fc51d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -82,6 +82,9 @@
 	regulator-name = "LDO22_VDDQ_MMC4_2.8V";
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
+	regulator-state-mem {
+		regulator-on-in-suspend;
+	};
 };
 
 &mshc_0 {
-- 
2.20.1

