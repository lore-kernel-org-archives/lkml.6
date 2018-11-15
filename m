Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C289C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEC9223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEC9223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeKOS7v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:59:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53056 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728519AbeKOS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:59:51 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAF8nJmX012034;
        Thu, 15 Nov 2018 09:52:31 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nr7d8rg5r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 15 Nov 2018 09:52:31 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B56773D;
        Thu, 15 Nov 2018 08:52:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F5ED128E;
        Thu, 15 Nov 2018 08:52:29 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 15 Nov
 2018 09:52:29 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Thu, 15 Nov 2018 09:52:29 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/3] ARM: dts: stm32: change CAN RAM mapping on stm32mp157c
Thread-Topic: [PATCH 1/3] ARM: dts: stm32: change CAN RAM mapping on
 stm32mp157c
Thread-Index: AQHUfMCK5BYbFusytE6iCO2SRs0lIQ==
Date:   Thu, 15 Nov 2018 08:52:29 +0000
Message-ID: <1542271942-28130-2-git-send-email-bich.hemon@st.com>
References: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the 10Kbytes CAN message RAM to be able to use simultaneously
FDCAN1 and FDCAN2 instances.
First 5Kbytes are allocated to FDCAN1 and last 5Kbytes are used for
FDCAN2. To do so, set the offset to 0x1400 in mram-cfg for FDCAN2.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 8bf1c17..ffd7457 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -684,7 +684,7 @@
 
 		m_can1: can@4400e000 {
 			compatible = "bosch,m_can";
-			reg = <0x4400e000 0x400>, <0x44011000 0x2800>;
+			reg = <0x4400e000 0x400>, <0x44011000 0x1400>;
 			reg-names = "m_can", "message_ram";
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +704,7 @@
 			interrupt-names = "int0", "int1";
 			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
-			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+			bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
 			status = "disabled";
 		};
 
-- 
1.9.1
