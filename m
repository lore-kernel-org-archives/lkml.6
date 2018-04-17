Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeDQNsU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:48:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57125 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753383AbeDQNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:45:53 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH 3/4] ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
Date: Tue, 17 Apr 2018 15:45:29 +0200
Message-ID: <1523972730-29240-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG4NODE5.st.com (10.75.127.75) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32mp157c evaluation board has TIM2_CH4, TIM8_CH4 and TIM12_CH1
available on GPIO expansion connector.
Add PWM and associated triggers (for ADC/DAC) on these timers.
Keep them disabled so these pins can be used as GPIOs by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 57e6dbc..2109558 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,3 +19,39 @@
 		serial0 = &uart4;
 	};
 };
+
+&timers2 {
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm2_pins_a>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+	timer@1 {
+		status = "okay";
+	};
+};
+
+&timers8 {
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm8_pins_a>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+	timer@7 {
+		status = "okay";
+	};
+};
+
+&timers12 {
+	status = "disabled";
+	pwm {
+		pinctrl-0 = <&pwm12_pins_a>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+	timer@11 {
+		status = "okay";
+	};
+};
-- 
1.9.1
