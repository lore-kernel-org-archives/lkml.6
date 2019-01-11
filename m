Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDD92063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217343;
	bh=/eEdjvRa4JY8122gooKw2SqZ8ArFFe02qPFsKjyXE+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xJNvYblztqKAslJ1WdtwANsPf/hmySCU22ekhZtzW1QVWAmwx2i1gh013j9k02HuS
	 9ZpscL32vMPMU7CT0KuII2XYxrsXgaF0XJG95PAVkHBIlqBC0HUDszhCw8CHW9QF2n
	 DSOLoL7jWfEIGLJ3cSwSll7EMCZqZqYwfb+qVcGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbfAKOfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390192AbfAKOfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3C82063F;
        Fri, 11 Jan 2019 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217336;
        bh=/eEdjvRa4JY8122gooKw2SqZ8ArFFe02qPFsKjyXE+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTxvwMn7P5bg/UrBSHzcIhkNdzvG1MCbKj0QKQHMf2F+3lGiV8+nwWyFmwV0wSzZy
         fTfE6qzOv4R779Y4itz0bayUCdpg/SjCeaaegGxhyOtYRMBshqQy7Wb7eb0cDS9/9b
         XkNt85xc60dBHoMfBv9H7U/BU9WXl626xN2/Eibo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/148] ARM: dts: imx7d-pico: Describe the Wifi clock
Date:   Fri, 11 Jan 2019 15:13:05 +0100
Message-Id: <20190111131114.627286972@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



