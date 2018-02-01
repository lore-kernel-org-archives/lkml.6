Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeBANpu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:45:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62987 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751508AbeBANpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:45:45 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: pwm-stm32-lp: add #pwm-cells
Date: Thu, 1 Feb 2018 14:44:36 +0100
Message-ID: <1517492678-767-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Baeza <gerald.baeza@st.com>

STM32 Low-Power Timer supports generic 3 cells pwm to encode
PWM number, period and polarity.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
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
