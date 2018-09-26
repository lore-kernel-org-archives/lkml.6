Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1EE214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1EE214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeIZTgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:36:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59780 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbeIZTgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:36:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 44ED01A0262;
        Wed, 26 Sep 2018 15:23:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3811E1A025D;
        Wed, 26 Sep 2018 15:23:04 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 91ED7203C2;
        Wed, 26 Sep 2018 15:23:03 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 21/22] arm64: dts: ls104x: make dma-coherent global to the SoC
Date:   Wed, 26 Sep 2018 16:22:46 +0300
Message-Id: <20180926132247.10971-22-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These SoCs are really completely dma coherent in their entirety so add
the dma-coherent property at the soc level in the device tree and drop
the instances where it's specifically added to a few select devices.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 5 +----
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index ccadc40a36f4..9fb3ac0fa87c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -215,6 +215,7 @@
 		#size-cells = <2>;
 		ranges;
 		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
+		dma-coherent;
 
 		clockgen: clocking@1ee1000 {
 			compatible = "fsl,ls1043a-clockgen";
@@ -680,7 +681,6 @@
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 69 0x4>;
 			clocks = <&clockgen 4 0>;
-			dma-coherent;
 		};
 
 		msi1: msi-controller1@1571000 {
@@ -715,7 +715,6 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <4>;
 			bus-range = <0x0 0xff>;
@@ -741,7 +740,6 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
@@ -767,7 +765,6 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index a12d33362554..f19cf6087235 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -188,6 +188,7 @@
 		#size-cells = <2>;
 		ranges;
 		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
+		dma-coherent;
 
 		ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
-- 
2.17.1

