Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED9520700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfBVI3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:29:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45062 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbfBVI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:28:51 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M8QYPV005498;
        Fri, 22 Feb 2019 09:28:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc75hehk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Feb 2019 09:28:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68BDA31;
        Fri, 22 Feb 2019 08:28:35 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4224B28A8;
        Fri, 22 Feb 2019 08:28:35 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb
 2019 09:28:35 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb 2019 09:28:34
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH V2 8/8] ARM: dts: stm32: add syscfg clock support for Ethernet on STM32F429 SoC
Date:   Fri, 22 Feb 2019 09:28:09 +0100
Message-ID: <1550824089-19961-9-git-send-email-christophe.roullier@st.com>
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

This patch add syscfg clock support for Ethernet of the STM32F429 SoC.
Needed if bootloader do not manage it.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8d6f028..6f78346 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -657,10 +657,12 @@
 			reg-names = "stmmaceth";
 			interrupts = <61>;
 			interrupt-names = "macirq";
-			clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
+			clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx",
+			"syscfg-clk";
 			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(ETHMAC)>,
 					<&rcc 0 STM32F4_AHB1_CLOCK(ETHMACTX)>,
-					<&rcc 0 STM32F4_AHB1_CLOCK(ETHMACRX)>;
+					<&rcc 0 STM32F4_AHB1_CLOCK(ETHMACRX)>,
+					<&rcc 0 STM32F4_APB2_CLOCK(SYSCFG)>;
 			st,syscon = <&syscfg 0x4>;
 			snps,pbl = <8>;
 			snps,mixed-burst;
-- 
2.7.4

