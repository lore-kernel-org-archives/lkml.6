Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649CC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD112086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD112086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIKMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:25:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10010 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727793AbeIKMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:25:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8B7OI0m026390;
        Tue, 11 Sep 2018 09:27:06 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2me62r0yce-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 09:27:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 228BF34;
        Tue, 11 Sep 2018 07:27:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6AAB1E40;
        Tue, 11 Sep 2018 07:27:05 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 11 Sep 2018 09:27:05
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
Subject: [PATCH v1 2/7] dt-bindings: stm32-dmamux: Add one cell to support DMA/MDMA chain
Date:   Tue, 11 Sep 2018 09:26:55 +0200
Message-ID: <1536650820-16076-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one cell to support DMA/MDMA chaining.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 Documentation/devicetree/bindings/dma/stm32-dmamux.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
index 1b893b2..8e092d2 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
@@ -4,9 +4,6 @@ Required properties:
 - compatible:	"st,stm32h7-dmamux"
 - reg:		Memory map for accessing module
 - #dma-cells:	Should be set to <3>.
-		First parameter is request line number.
-		Second is DMA channel configuration
-		Third is Fifo threshold
 		For more details about the three cells, please see
 		stm32-dma.txt documentation binding file
 - dma-masters:	Phandle pointing to the DMA controllers.
@@ -53,7 +50,7 @@ dma2: dma@40020400 {
 		     <68>,
 		     <69>,
 		     <70>;
-	clocks = <&timer_clk>;
+	clocks = <&clk_hclk>;
 	#dma-cells = <4>;
 	st,mem2mem;
 	resets = <&rcc 150>;
-- 
2.7.4

