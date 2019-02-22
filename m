Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7330FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C911207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBVI33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:29:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45057 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbfBVI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:28:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M8QYPP005498;
        Fri, 22 Feb 2019 09:28:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc75heh1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Feb 2019 09:28:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9721C3D;
        Fri, 22 Feb 2019 08:28:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FE1428B0;
        Fri, 22 Feb 2019 08:28:29 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb
 2019 09:28:29 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb 2019 09:28:28
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config properties
Date:   Fri, 22 Feb 2019 09:28:04 +0100
Message-ID: <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties to support all Phy config
 PHY_MODE	(MII,GMII, RMII, RGMII) and in normal, PHY wo crystal (25Mhz),
 PHY wo crystal (50Mhz), No 125Mhz from PHY config.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
index 1341012..f42dc68 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
@@ -24,9 +24,9 @@ Required properties:
 	       encompases the glue register, and the offset of the control register.
 
 Optional properties:
-- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz
-- st,int-phyclk (boolean) :  valid only where PHY do not have quartz and need to be clock
-	           by RCC
+- clock-names:     For MPU family "eth-ck" for PHY without quartz
+- st,eth_clk_sel (boolean) : set this property in RGMII PHY when you do not want use 125Mhz
+- st,eth_ref_clk_sel (boolean) :  set this property in RMII mode when you have PHY without crystal 50MHz
 
 Example:
 
-- 
2.7.4

