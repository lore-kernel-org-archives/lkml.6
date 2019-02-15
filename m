Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F69C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE59720700
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390848AbfBOP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:58:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33111 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389183AbfBOP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:58:53 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FFuY5s000918;
        Fri, 15 Feb 2019 16:58:43 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qmy1njc13-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 15 Feb 2019 16:58:43 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFABA31;
        Fri, 15 Feb 2019 15:58:42 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag5node5.st.com [10.75.127.78])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B0679599A;
        Fri, 15 Feb 2019 15:58:42 +0000 (GMT)
Received: from localhost (10.75.127.51) by GPXDAG5NODE5.st.com (10.75.127.78)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb 2019 16:58:42
 +0100
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Subject: [PATCH v1 1/3] ARM: dts: stm32: Add Vivante GPU support on STM32MP157c
Date:   Fri, 15 Feb 2019 16:58:34 +0100
Message-ID: <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append Vivante GPU DT configuration.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index f8bbfff..29540bc 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1106,6 +1106,16 @@
 			status = "disabled";
 		};
 
+		gpu: gpu@59000000 {
+			compatible = "vivante,gc";
+			reg = <0x59000000 0x800>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc GPU>, <&rcc GPU_K>;
+			clock-names = "bus" ,"core";
+			resets = <&rcc GPU_R>;
+			status = "disabled";
+		};
+
 		dsi: dsi@5a000000 {
 			compatible = "st,stm32-dsi";
 			reg = <0x5a000000 0x800>;
-- 
2.7.4

