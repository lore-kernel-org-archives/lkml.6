Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AC9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1E32087F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865352;
	bh=DdfeOpuo5TBNqMgYCrsuYp8Tl1OalkvZs/xaxRIl9Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fsRgCM6H71rTSM2saPOuIjG0qdlNq77EzgtB+pGYdiQ7V4j/i8at0IV1j1B+GkHcF
	 f2yO1NWoEIkKKZWWuKE9f3wCCAzt8vw83Rs/bMDhVxBbzF/yBBA3w+ubH4FHBy42pJ
	 KeG7vxfMYgper//ZubxkLZkHhJQYByZc0T4ZRfrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbeLZXCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeLZWgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3630218FE;
        Wed, 26 Dec 2018 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863770;
        bh=DdfeOpuo5TBNqMgYCrsuYp8Tl1OalkvZs/xaxRIl9Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/LetX4KYP//s7JuDeCSpuKYDQUlnwjJ6fpjteBXyvvJ0/fN6DReEq7eKEht3a9pp
         xH2+p0vSV3iw8FHjI/Gj1VlWdfkg+TIZDIflmW1aqGvSgmb/8H9RuLMAn1glptV1hy
         hXkFOrpGUB/zpQtuJ65sCn7WOVGMtlwgZcHp9gsE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/97] ARM: dts: imx7d-pico: Describe the Wifi clock
Date:   Wed, 26 Dec 2018 17:34:27 -0500
Message-Id: <20181226223557.149329-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit c3b9ab5db11d8098ca7674175f12ab21cdce1bbb ]

The Wifi chip should be clocked by a 32kHz clock coming from i.MX7D
CLKO2 output pin, so describe the pinmux and clock hierarchy in the
device tree to allow the Wifi chip to be properly clocked.

Managed to successfully test Wifi with such change. Used the standard
nvram.txt file provided by TechNexion, which selects an external 32kHz
clock for the Wifi chip by default.

Fixes: 99a52450c707 ("ARM: dts: imx7d-pico: Add Wifi support")
Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Tested-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7d-pico.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 21973eb55671..f27b3849d3ff 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -100,6 +100,19 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "ext_clock";
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
+			  <&clks IMX7D_CLKO2_ROOT_DIV>;
+	assigned-clock-parents = <&clks IMX7D_CKIL>;
+	assigned-clock-rates = <0>, <32768>;
 };
 
 &i2c4 {
@@ -199,12 +212,13 @@
 
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
 	no-1-8-v;
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
 	vmmc-supply = <&reg_ap6212>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	status = "okay";
 };
 
@@ -301,6 +315,12 @@
 };
 
 &iomuxc_lpsr {
+	pinctrl_wifi_clk: wificlkgrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2	0x7d
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
-- 
2.19.1

