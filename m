Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B01C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B784D2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B784D2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJQN6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:58:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46700 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbeJQN6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:58:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6F9F20019B;
        Wed, 17 Oct 2018 08:04:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 962AA200292;
        Wed, 17 Oct 2018 08:04:01 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BF6724032B;
        Wed, 17 Oct 2018 14:03:48 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
        Wen He <wen.he_1@nxp.com>
Subject: [v9 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller bindings
Date:   Wed, 17 Oct 2018 13:59:57 +0800
Message-Id: <20181017055957.542-7-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181017055957.542-1-peng.ma@nxp.com>
References: <20181017055957.542-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the devicetree bindings for NXP Layerscape qDMA controller
which could be found on NXP QorIQ Layerscape SoCs.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
change in v9:
	- add required properties such as interrupts,block-number,block-offset
	etc.

 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..283372a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,57 @@
+NXP Layerscape SoC qDMA Controller
+==================================
+
+This device follows the generic DMA bindings defined in dma/dma.txt.
+
+Required properties:
+
+- compatible:		Must be one of
+			 "fsl,ls1021a-qdma": for LS1021A Board
+			 "fsl,ls1043a-qdma": for ls1043A Board
+			 "fsl,ls1046a-qdma": for ls1046A Board
+- reg:			Should contain the register's base address and length.
+- interrupts:		Should contain a reference to the interrupt used by this
+			device.
+- interrupt-names:	Should contain interrupt names:
+			 "qdma-queue0": the block0 interrupt
+			 "qdma-queue1": the block1 interrupt
+			 "qdma-queue2": the block2 interrupt
+			 "qdma-queue3": the block3 interrupt
+			 "qdma-error":  the error interrupt
+- fsl,dma-queues:	Should contain number of queues supported.
+- dma-channels:	Number of DMA channels supported
+- block-number:	the virtual block number
+- block-offset:	the offset of different virtual block
+- status-sizes:	status queue size of per virtual block
+- queue-sizes:		command queue size of per virtual block, the size number
+			based on queues
+
+Optional properties:
+
+- dma-channels:		Number of DMA channels supported by the controller.
+- big-endian:		If present registers and hardware scatter/gather descriptors
+			of the qDMA are implemented in big endian mode, otherwise in little
+			mode.
+
+Examples:
+
+	qdma: dma-controller@8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
+			      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-error",
+				"qdma-queue0", "qdma-queue1";
+			dma-channels = <8>;
+			block-number = <2>;
+			block-offset = <0x1000>;
+			fsl,dma-queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
1.7.1

