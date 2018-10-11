Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF46C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE1F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE1F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJKOFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:05:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58510 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeJKOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:05:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E150200049;
        Thu, 11 Oct 2018 08:39:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBAFA200186;
        Thu, 11 Oct 2018 08:39:05 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C9B15402E2;
        Thu, 11 Oct 2018 14:38:59 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     yinbo.zhu@nxp.com, yangbo.lu@nxp.com, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        ulf.hansson@linaro.org, leoyang.li@nxp.com
Cc:     xiaobo.xie@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
Date:   Thu, 11 Oct 2018 14:35:22 +0800
Message-Id: <20181011063522.7767-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two eSDHC controllers in lx2160a. This patch is to
enable eSDHC for RDB and QDS board.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		squash all lx2160a esdhc dts patch into the original patch

 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |    8 ++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   15 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   25 +++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index bc30173..b58b96c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -294,6 +294,14 @@
 	status = "okay";
 };
 
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
 &dspi0 {
 	dflash0: n25q128a {
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 53b0e80..cbe8919 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -170,6 +170,21 @@
 	status = "okay";
 };
 
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &fspi {
 	status = "okay";
 	nxp,fspi-has-second-chip;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index fa4a1f8..174544a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -356,6 +356,31 @@
 			little-endian;
 		};
 
+		esdhc0: esdhc@2140000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x2140000 0x0 0x10000>;
+			interrupts = <0 28 0x4>; /* Level high type */
+			clocks = <&clockgen 4 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		esdhc1: esdhc@2150000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x2150000 0x0 0x10000>;
+			interrupts = <0 63 0x4>; /* Level high type */
+			clocks = <&clockgen 4 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
1.7.1

