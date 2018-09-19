Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D18C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF84E2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF84E2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeISSPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:15:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50278 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbeISSOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:14:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 474111A0205;
        Wed, 19 Sep 2018 14:36:45 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B9B11A01FF;
        Wed, 19 Sep 2018 14:36:45 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6564F20618;
        Wed, 19 Sep 2018 14:36:43 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 16/21] arm64: dts: ls1046a: add smmu node
Date:   Wed, 19 Sep 2018 15:36:08 +0300
Message-Id: <20180919123613.15092-17-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This allows for the SMMU device to be probed by the SMMU kernel driver.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ef83786b8b90..06863d3e4a7d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -228,6 +228,48 @@
 			bus-width = <4>;
 		};
 
+		mmu: iommu@9000000 {
+			compatible = "arm,mmu-500";
+			reg = <0 0x9000000 0 0x400000>;
+			dma-coherent;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+			interrupts = <0 142 4>, /* global secure fault */
+				     <0 143 4>, /* combined secure interrupt */
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>;
+		};
+
 		scfg: scfg@1570000 {
 			compatible = "fsl,ls1046a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
-- 
2.17.1

