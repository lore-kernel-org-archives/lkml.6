Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB823C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60C42081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="HdwFqe9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60C42081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLAVVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:21:20 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:59398 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeLAVVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:21:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 68A621F99C;
        Sat,  1 Dec 2018 11:09:06 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1543658944; x=
        1546250945; bh=Zd/AWxIfbWdt/qWvfiCuUYpYVi3/kqdU2pohdc2Cix4=; b=H
        dwFqe9z7LbbDSVYpvN61g8vY6l8sfAIY1b9NI64Ub/19+FkVmyrSb96pxjWcccJb
        eYuYVK9H8VopRqBM2vAjp3i3qfiiCGKDzlIcJohBHQ3dD/hfZ3vG7EPaxKGoRODZ
        iILKhPq+7cNSUqqG4kvTnkvDHJI/uKeBl2Smjp/iWzF9ITSb/2/PNGC0qGzecXFR
        L6VEr6VomNKzfhMFVvfKLx56Bor1Nv4JefVcAlU+vCVTr3FeKkeyv7Yeh77lKy0p
        HCUIVEBcFVOu9Eas4l0OH1tbsWN85ADZCTYNLmJyZ1lPDWWMg1zZxue99OZdZ5vg
        Mx9l+cRh52OpNghDtOFnxSAX+Nr/4ikeRJiNG5X4UjLDFIxtV5CRd7kyJWR3Q/Cv
        WXxZpYm9ZgFCDp/O/GIQ7zP2LHHEu6Xh51fnn4WnyYqLCehRD7f0/7HxwHUXsCBt
        +SJ167dgJWLhoGGCfQu3CEaBKOyuuLiU557qDqQestl18ifM5ltc66mg7KUVcJ3A
        kzFqtDpgTxT4cGz6TUJm7/ROj61lcbgqPnjnLWzFQiHGafxk4vP51F0B77xwVI1w
        8X8O1ekjrLEVkzv1h6giAuXgeFzCUj5tpzlmfKIHCm5FVwYKU3tvbAcjZoM75zZ2
        rE0M0Zucqdxjjmv8jHaXDCRdosUJJ0AsS4rAMQYiNI=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HN7-eesPge4d; Sat,  1 Dec 2018 11:09:04 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 2F3911F955;
        Sat,  1 Dec 2018 11:09:04 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Akash Gajjar <Akash_Gajjar@mentor.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 1/2] arm64: dts: rockchip: rockpro64 fix regulator gpios
Date:   Sat,  1 Dec 2018 12:08:16 +0200
Message-Id: <20181201100817.20688-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181201100817.20688-1-oskari@lemmela.net>
References: <20181201100817.20688-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockpro64 is not able boot if GPIO1_C1 pin is pulled high
before loading linux kernel.

In rockpro64 GPIO1_C1 pin is connected vdd_cpu_b regulator
VSEL pin. Pin should be pulled down in normal operation and
pulled high in suspend.

PMIC LDO_REG2 is connected to touch panel connector.
Rename regulator and set it to correct voltage.

PCIe power is controller by GPIO1_D0.

Schematics can be downloaded from:
http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 1d35f5406b5e..5bd4d69914bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -97,7 +97,7 @@
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_pwr_en>;
 		regulator-name = "vcc3v3_pcie";
@@ -293,12 +293,12 @@
 				};
 			};
 
-			vcc2v8_dvp: LDO_REG2 {
-				regulator-name = "vcc2v8_dvp";
+			vcc3v0_touch: LDO_REG2 {
+				regulator-name = "vcc3v0_touch";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -397,7 +397,9 @@
 	vdd_cpu_b: regulator@40 {
 		compatible = "silergy,syr827";
 		reg = <0x40>;
-		fcs,suspend-voltage-selector = <0>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel1_gpio>;
 		regulator-name = "vdd_cpu_b";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
@@ -415,6 +417,8 @@
 		compatible = "silergy,syr828";
 		reg = <0x41>;
 		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel2_gpio>;
 		regulator-name = "vdd_gpu";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
@@ -519,7 +523,7 @@
 
 	pcie {
 		pcie_pwr_en: pcie-pwr-en {
-			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
@@ -529,7 +533,7 @@
 		};
 
 		vsel1_gpio: vsel1-gpio {
-			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 
 		vsel2_gpio: vsel2-gpio {
-- 
2.17.1

