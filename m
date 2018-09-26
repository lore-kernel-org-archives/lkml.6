Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C024FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC22214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC22214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeIZTgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:36:00 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57918 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbeIZTgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:36:00 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15BAA2002A2;
        Wed, 26 Sep 2018 15:23:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 132A72002D5;
        Wed, 26 Sep 2018 15:23:02 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D3F0203C2;
        Wed, 26 Sep 2018 15:23:01 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 18/22] arm64: dts: ls104xa: set mask to drop TBU ID from StreamID
Date:   Wed, 26 Sep 2018 16:22:43 +0300
Message-Id: <20180926132247.10971-19-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The StreamID entering the SMMU is actually a concatenation of the
SMMU TBU ID and the ICID configured in software.
Since the TBU ID is internal to the SoC and since we want that the
actual the ICID configured in software to enter the SMMU witout any
additional set bits, mask out the TBU ID bits and leave only the
relevant ICID bits to enter SMMU.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7eea2bace171..1f9b385007a8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -226,6 +226,7 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x9000000 0 0x400000>;
 			dma-coherent;
+			stream-match-mask = <0x7f00>;
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 07a853a0aeaa..22bf3975492a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -232,6 +232,7 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x9000000 0 0x400000>;
 			dma-coherent;
+			stream-match-mask = <0x7f00>;
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

