Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE1520645
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE1520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeJEOl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:41:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52701 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728382AbeJEOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:41:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w957dsFd013010;
        Fri, 5 Oct 2018 09:44:04 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh71ngr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 09:44:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4887231;
        Fri,  5 Oct 2018 07:44:04 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12CD81BC7;
        Fri,  5 Oct 2018 07:44:04 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 09:44:04 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct 2018
 09:44:03 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 1/2] dt-bindings: spi: add stm32 qspi controller
Date:   Fri, 5 Oct 2018 09:43:02 +0200
Message-ID: <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
References: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds the documentation of device tree bindings
for the STM32 QSPI controller. It is a specialized communication
interface targeting single, dual or quad SPI Flash memories (NOR/NAND).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
new file mode 100644
index 0000000..adeeb63
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
@@ -0,0 +1,44 @@
+* STMicroelectronics Quad Serial Peripheral Interface(QSPI)
+
+Required properties:
+- compatible: should be "st,stm32f469-qspi"
+- reg: the first contains the register location and length.
+       the second contains the memory mapping address and length
+- reg-names: should contain the reg names "qspi" "qspi_mm"
+- interrupts: should contain the interrupt for the device
+- clocks: the phandle of the clock needed by the QSPI controller
+- A pinctrl must be defined to set pins in mode of operation for QSPI transfer
+
+Optional properties:
+- resets: must contain the phandle to the reset controller.
+
+A spi flash (NOR/NAND) must be a child of spi node and could have some
+properties. Also see jedec,spi-nor.txt.
+
+Required properties:
+- reg: chip-Select number (QSPI controller may connect 2 flashes)
+- spi-max-frequency: max frequency of spi bus
+
+Optional property:
+- spi-rx-bus-width: see ./spi-bus.txt for the description
+
+Example:
+
+qspi: spi@a0001000 {
+	compatible = "st,stm32f469-qspi";
+	reg = <0xa0001000 0x1000>, <0x90000000 0x10000000>;
+	reg-names = "qspi", "qspi_mm";
+	interrupts = <91>;
+	resets = <&rcc STM32F4_AHB3_RESET(QSPI)>;
+	clocks = <&rcc 0 STM32F4_AHB3_CLOCK(QSPI)>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+		...
+	};
+};
-- 
2.7.4

