Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7791DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D9F206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfAJKLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:11:04 -0500
Received: from inva021.nxp.com ([92.121.34.21]:50090 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfAJKK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:10:58 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E96502000B9;
        Thu, 10 Jan 2019 11:10:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C4DB200059;
        Thu, 10 Jan 2019 11:10:51 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2569D402C8;
        Thu, 10 Jan 2019 18:10:45 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     shawnguo@kernel.org, axboe@kernel.dk
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 2/2] arm64: dts: lx2160a: add sata node support
Date:   Thu, 10 Jan 2019 18:05:33 +0800
Message-Id: <20190110100533.33333-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190110100533.33333-1-peng.ma@nxp.com>
References: <20190110100533.33333-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sata node support and Enable sata support

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f..aacca27 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -117,3 +117,19 @@
 &usb1 {
 	status = "okay";
 };
+
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
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1..e857a14 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,49 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		sata0: sata@3200000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
+
+		sata1: sata@3210000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3210000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
+
+		sata2: sata@3220000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3220000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
+
+		sata3: sata@3230000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3230000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
 	};
 };
-- 
1.7.1

