Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDPQU0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:20:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18509 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753176AbeDPQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:20:14 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <alexandre.torgue@st.com>
CC: <thierry.reding@gmail.com>, <benjamin.gaignard@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v4 6/6] ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
Date: Mon, 16 Apr 2018 18:19:21 +0200
Message-ID: <1523895561-4073-7-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523895561-4073-1-git-send-email-fabrice.gasnier@st.com>
References: <1523895561-4073-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG4NODE5.st.com (10.75.127.75) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pwm3 input capture on stm32f429i-eval, by using DMA.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 7eb786a..88d878a 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -290,6 +290,9 @@
 &timers3 {
 	status = "okay";
 
+	/* Enable PWM input capture by using dma */
+	dmas = <&dma1 4 5 0x400 0x0>;
+	dma-names = "ch1";
 	pwm {
 		pinctrl-0 = <&pwm3_pins>;
 		pinctrl-names = "default";
-- 
1.9.1
