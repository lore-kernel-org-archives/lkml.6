Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2805C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3462075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfBMRJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:09:11 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:59462 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBMRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:09:10 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gty20-00047V-KU from Akash_Gajjar@mentor.com ; Wed, 13 Feb 2019 09:09:08 -0800
Received: from eyas.local (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 13 Feb
 2019 17:09:02 +0000
From:   Akash Gajjar <Akash_Gajjar@mentor.com>
To:     <heiko@sntech.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Levin Du <djw@t-chip.com.cn>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused node
Date:   Wed, 13 Feb 2019 22:36:38 +0530
Message-ID: <20190213170651.3210-3-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lcd panel pinmux and vcc1v8_s3 regulator is redundant and has a no impact, so
removing it.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 49e83ba64045..c9a2b26d7cad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -83,17 +83,6 @@
 		regulator-max-microvolt = <12000000>;
 	};
 
-	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v8_s3";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_1v8>;
-	};
-
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -522,12 +511,6 @@
 		};
 	};
 
-	lcd-panel {
-		lcd_panel_reset: lcd-panel-reset {
-			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
 	pcie {
 		pcie_pwr_en: pcie-pwr-en {
 			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -576,7 +559,7 @@
 };
 
 &saradc {
-	vref-supply = <&vcca1v8_s3>;
+	vref-supply = <&vcca_1v8>;
 	status = "okay";
 };
 
-- 
2.17.1

