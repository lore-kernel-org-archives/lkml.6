Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15971C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE05B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfAQCRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:17:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:47772 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfAQCRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:17:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CDB12001F4;
        Thu, 17 Jan 2019 03:17:50 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 403012001EA;
        Thu, 17 Jan 2019 03:17:46 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F9BF402EE;
        Thu, 17 Jan 2019 10:17:40 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.tang@nxp.com,
        Peng Ma <peng.ma@nxp.com>
Subject: [v3] arm64: dts: lx2160a: add sata node support
Date:   Thu, 17 Jan 2019 02:12:24 +0000
Message-Id: <20190117021224.19021-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SATA device nodes for fsl-lx2160a and enable support
for QDS and RDB boards.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V3:
	- updated the commit log 

 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |   16 +++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 99a22ab..1a5acf6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -95,6 +95,22 @@
 	};
 };
 
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f..5b6799e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -102,6 +102,22 @@
 	};
 };
 
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1..592034b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -671,6 +671,50 @@
 			status = "disabled";
 		};
 
+		sata0: sata@3200000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata1: sata@3210000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3210000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata2: sata@3220000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3220000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata3: sata@3230000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3230000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
1.7.1

