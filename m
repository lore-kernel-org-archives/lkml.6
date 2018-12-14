Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8A208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA8A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeLNJ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:59:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42895 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728269AbeLNJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:59:08 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBE9v00f012188;
        Fri, 14 Dec 2018 10:58:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p85qkjk89-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Dec 2018 10:58:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5A1D538;
        Fri, 14 Dec 2018 09:58:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 267602B42;
        Fri, 14 Dec 2018 09:58:22 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec 2018 10:58:21
 +0100
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v4 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND controller documentation
Date:   Fri, 14 Dec 2018 10:58:06 +0100
Message-ID: <1544781488-18723-2-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
References: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation of the device tree bindings for the STM32
FMC2 NAND controller.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
new file mode 100644
index 0000000..ad2bef8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
@@ -0,0 +1,61 @@
+STMicroelectronics Flexible Memory Controller 2 (FMC2)
+NAND Interface
+
+Required properties:
+- compatible: Should be one of:
+              * st,stm32mp15-fmc2
+- reg: NAND flash controller memory areas.
+       First region contains the register location.
+       Regions 2 to 4 respectively contain the data, command,
+       and address space for CS0.
+       Regions 5 to 7 contain the same areas for CS1.
+- interrupts: The interrupt number
+- pinctrl-0: Standard Pinctrl phandle (see: pinctrl/pinctrl-bindings.txt)
+- clocks: The clock needed by the NAND flash controller
+
+Optional properties:
+- resets: Reference to a reset controller asserting the FMC controller
+- dmas: DMA specifiers (see: dma/stm32-mdma.txt)
+- dma-names: Must be "tx", "rx" and "ecc"
+
+* NAND device bindings:
+
+Required properties:
+- reg: describes the CS lines assigned to the NAND device.
+
+Optional properties:
+- nand-on-flash-bbt: see nand.txt
+- nand-ecc-strength: see nand.txt
+- nand-ecc-step-size: see nand.txt
+
+The following ECC strength and step size are currently supported:
+ - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Hamming)
+ - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
+ - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8) (default)
+
+Example:
+
+	fmc: nand-controller@58002000 {
+		compatible = "st,stm32mp15-fmc2";
+		reg = <0x58002000 0x1000>,
+		      <0x80000000 0x1000>,
+		      <0x88010000 0x1000>,
+		      <0x88020000 0x1000>,
+		      <0x81000000 0x1000>,
+		      <0x89010000 0x1000>,
+		      <0x89020000 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&rcc FMC_K>;
+		resets = <&rcc FMC_R>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fmc_pins_a>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			nand-on-flash-bbt;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
-- 
1.9.1

