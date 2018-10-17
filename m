Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3ABC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACADE2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACADE2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJQN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:58:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46654 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeJQN6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:58:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DB0B2002A4;
        Wed, 17 Oct 2018 08:04:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D031D2002B6;
        Wed, 17 Oct 2018 08:04:00 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CE0A4032A;
        Wed, 17 Oct 2018 14:03:47 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
        Wen He <wen.he_1@nxp.com>
Subject: [v9 6/7] arm64: dts: ls1046a: add qdma device tree nodes
Date:   Wed, 17 Oct 2018 13:59:56 +0800
Message-Id: <20181017055957.542-6-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181017055957.542-1-peng.ma@nxp.com>
References: <20181017055957.542-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the qDMA device tree nodes for LS1046A devices.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v9:
	- add interrupts for each virtual block 
	- add block-number
	- add block-offset

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ef83786..2a48d9b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -704,6 +704,27 @@
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		qdma: dma-controller@8380000 {
+			compatible = "fsl,ls1046a-qdma", "fsl,ls1021a-qdma";
+			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
+			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
+			interrupts = <0 153 0x4>,
+				     <0 39 0x4>,
+				     <0 40 0x4>,
+				     <0 41 0x4>,
+				     <0 42 0x4>;
+			interrupt-names = "qdma-error", "qdma-queue0",
+				"qdma-queue1", "qdma-queue2", "qdma-queue3";
+			dma-channels = <8>;
+			block-number = <1>;
+			block-offset = <0x10000>;
+			fsl,dma-queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
 	};
 
 	reserved-memory {
-- 
1.7.1

