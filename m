Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBWNg4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:36:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15842 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751581AbeBWNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:36:53 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <alexandre.torgue@st.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: [RESEND PATCH 1/3] dt-bindings: pwm-stm32-lp: add #pwm-cells
Date: Fri, 23 Feb 2018 14:36:03 +0100
Message-ID: <1519392965-28235-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Baeza <gerald.baeza@st.com>

STM32 Low-Power Timer supports generic 3 cells pwm to encode
PWM number, period and polarity.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index f8338d1..bd23302 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -7,6 +7,8 @@ See ../mfd/stm32-lptimer.txt for details about the parent node.
 
 Required parameters:
 - compatible:		Must be "st,stm32-pwm-lp".
+- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
+			bindings defined in pwm.txt.
 
 Optional properties:
 - pinctrl-names: 	Set to "default".
@@ -18,6 +20,7 @@ Example:
 		...
 		pwm {
 			compatible = "st,stm32-pwm-lp";
+			#pwm-cells = <3>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&lppwm1_pins>;
 		};
-- 
1.9.1
