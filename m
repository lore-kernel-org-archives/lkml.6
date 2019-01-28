Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697408;
	bh=Tj6dVCLgBVfarp/190zpv/HxDdo5BFRxnYiyV7RE0P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yQuPp9Oh5adT7eUoMzn13qLxOAXmOG4iXC5Z3HZoF8n9cSdDule5NacLu5GsETjjI
	 axsJmN+Nw4SxYcqtr9peJ4kwysTdSh+03Db/eyDaDVPzEbioNEvVUz2PWWKoZUW41O
	 xQaqITyQpGmgj8SMkT+hA2PTmyO8wVQ+IXrrrDV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfA1Ptw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfA1Ptt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD402147A;
        Mon, 28 Jan 2019 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690589;
        bh=Tj6dVCLgBVfarp/190zpv/HxDdo5BFRxnYiyV7RE0P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSOIrw8myzVntuhvuoHkKlyc/7aSeicU3aFPXgr62IL9D6Q/SQpSnnzU4DwWgERWw
         wQkuXEc1m/L/g7dOEcHJWG9vjJYsQpltmwtSnGSXGPHtqv5ihrOlmllIuiYINcMDFM
         V+h8RHmUmBEpmTBghJJYJ/zSV+xwQEdR6jhENxkw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 131/304] arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios
Date:   Mon, 28 Jan 2019 10:40:48 -0500
Message-Id: <20190128154341.47195-131-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oskari Lemmela <oskari@lemmela.net>

[ Upstream commit 690e16bada6029694740d5501025faf483d14339 ]

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
Acked-by: Akash Gajjar <Akash_Gajjar@mentor.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

