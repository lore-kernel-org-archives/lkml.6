Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90628215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90628215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1T0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:26:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43110 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726430AbeI1T0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:26:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8SCwpPO020977;
        Fri, 28 Sep 2018 15:02:16 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mncmewhrf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 15:02:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E74F438;
        Fri, 28 Sep 2018 13:02:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C01352A23;
        Fri, 28 Sep 2018 13:02:15 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 28 Sep 2018 15:02:14
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 3/7] dt-bindings: stm32-mdma: Add DMA/MDMA chaining support bindings
Date:   Fri, 28 Sep 2018 15:01:51 +0200
Message-ID: <1538139715-24406-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

This patch adds the description of the 2 properties needed to support M2M
transfer triggered by STM32 DMA when his transfer is complete.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v3:
    v2:
       * rework content
    v1:
       * Initial
---
---
 Documentation/devicetree/bindings/dma/stm32-mdma.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
index d18772d..27c2812 100644
--- a/Documentation/devicetree/bindings/dma/stm32-mdma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
@@ -10,7 +10,7 @@ Required properties:
 - interrupts: Should contain the MDMA interrupt.
 - clocks: Should contain the input clock of the DMA instance.
 - resets: Reference to a reset controller asserting the DMA controller.
-- #dma-cells : Must be <5>. See DMA client paragraph for more details.
+- #dma-cells : Must be <6>. See DMA client paragraph for more details.
 
 Optional properties:
 - dma-channels: Number of DMA channels supported by the controller.
@@ -26,7 +26,7 @@ Example:
 		interrupts = <122>;
 		clocks = <&timer_clk>;
 		resets = <&rcc 992>;
-		#dma-cells = <5>;
+		#dma-cells = <6>;
 		dma-channels = <16>;
 		dma-requests = <32>;
 		st,ahb-addr-masks = <0x20000000>, <0x00000000>;
@@ -35,8 +35,8 @@ Example:
 * DMA client
 
 DMA clients connected to the STM32 MDMA controller must use the format
-described in the dma.txt file, using a five-cell specifier for each channel:
-a phandle to the MDMA controller plus the following five integer cells:
+described in the dma.txt file, using a six-cell specifier for each channel:
+a phandle to the MDMA controller plus the following six integer cells:
 
 1. The request line number
 2. The priority level
@@ -76,6 +76,10 @@ a phandle to the MDMA controller plus the following five integer cells:
    if no HW ack signal is used by the MDMA client
 5. A 32bit mask specifying the value to be written to acknowledge the request
    if no HW ack signal is used by the MDMA client
+6. A bitfield value specifying if the MDMA client wants to generate M2M
+   transfer with HW trigger (1) or not (0). This bitfield should be only
+   enabled for M2M transfer triggered by STM32 DMA client. The memory devices
+   involved in this kind of transfer are SRAM and DDR.
 
 Example:
 
-- 
2.7.4

