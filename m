Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D288DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E220844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895190;
	bh=89qU9cIlTqaRMDgw/aO1vPPmZkBzGA2eqlY8E/1Sqec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tv2f+tP5y2gV1zzvfXEQbZam3qBZ9qDH0bIcLFJh/WijBnVLJCHjJT3diocChE96A
	 0PXuegaepnYuFoBOwBznjxBZuuBTfRTU4AnWmprcq7gwpvVwVUfWwEIT/2hGoK+ZtJ
	 zgHEcYOb/+1cB2BSnAcGAbR4gyzNAtw4cO4AXtzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfBKO02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbfBKO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC0120821;
        Mon, 11 Feb 2019 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895184;
        bh=89qU9cIlTqaRMDgw/aO1vPPmZkBzGA2eqlY8E/1Sqec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcTmoiBrKTkvHnF5ojj+DHumSvSKtep8IbW5ZFZWdL+UcNwKkmlR1OggFSz4kTu4l
         BbfFg0QP1nA5ATZi7YmJNBvRRdKa4fMXY09kDxab1NYrJ0UYfojhLvaUdxjC4LYKUd
         qaPT++0PMgNLqm2+Zuwb9zxM6DaN5CdjaPFREjDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oskari Lemmela <oskari@lemmela.net>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 122/352] arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios
Date:   Mon, 11 Feb 2019 15:15:49 +0100
Message-Id: <20190211141853.932371833@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



