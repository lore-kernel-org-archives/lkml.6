Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967517AbeCAKyZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:54:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43678 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966899AbeCAKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:54:22 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@st.com>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH v2 6/6] ARM: dts: stm32: Fix sdio2 rcc hard coded value
Date: Thu, 1 Mar 2018 11:53:43 +0100
Message-ID: <1519901623-23216-7-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Replace sdio2 rcc hard coded clock value by its macro.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 07c29658696c..2c5704f96801 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -432,7 +432,7 @@
 			compatible = "arm,pl180", "arm,primecell";
 			arm,primecell-periphid = <0x00880180>;
 			reg = <0x40011c00 0x400>;
-			clocks = <&rcc 0 167>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SDMMC2)>;
 			clock-names = "apb_pclk";
 			interrupts = <103>;
 			max-frequency = <48000000>;
-- 
1.9.1
