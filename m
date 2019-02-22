Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3481C20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfBVI2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:28:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17213 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfBVI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:28:49 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M8QFhF012441;
        Fri, 22 Feb 2019 09:28:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qt9c594f1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Feb 2019 09:28:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 391C33F;
        Fri, 22 Feb 2019 08:28:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB1A928AC;
        Fri, 22 Feb 2019 08:28:25 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb
 2019 09:28:25 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb 2019 09:28:24
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH V2 0/8] stmmac: add some fixes for stm32
Date:   Fri, 22 Feb 2019 09:28:01 +0100
Message-ID: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For common stmmac:
	- Add support to set CSR Clock range selection in DT
For stm32mpu:
	- Glue codes to support magic packet
	- Glue codes to support all PHY config :
		PHY_MODE (MII,GMII, RMII, RGMII) and in normal,
		PHY wo crystal (25Mhz),
		PHY wo crystal (50Mhz), No 125Mhz from PHY config
For stm32mcu:
	- Add Ethernet support for stm32h7
	- Add syscfg clk support for stm32f4

Changes in V2:
  Apply remarks from andrew lunn
	- add all interfaces RGMII* 
	- reg value should be the same as ethernet-phy@X	

Christophe Roullier (8):
  net: ethernet: stmmac: manage Ethernet WoL for stm32mp157c.
  net: ethernet: stmmac: update to support all PHY config for
    stm32mp157c.
  dt-bindings: net: stmmac: add phys config properties
  net: ethernet: stmmac: add management of clk_csr property
  net: ethernet: stmmac: update to be compatible with MCU family
    (stm32f4, stm32h7)
  dt-bindings: net: stmmac: add syscfg clock property
  ARM: dts: stm32: Add Ethernet support on stm32h7 SOC and activate it
    for eval and disco boards
  ARM: dts: stm32: add syscfg clock support for Ethernet on STM32F429
    SoC

 .../devicetree/bindings/net/stm32-dwmac.txt        |  10 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   6 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  15 ++
 arch/arm/boot/dts/stm32h743.dtsi                   |  19 +++
 arch/arm/boot/dts/stm32h743i-disco.dts             |  17 ++
 arch/arm/boot/dts/stm32h743i-eval.dts              |  17 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 182 +++++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +
 8 files changed, 233 insertions(+), 36 deletions(-)

-- 
2.7.4

