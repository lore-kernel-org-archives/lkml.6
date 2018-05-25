Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935938AbeEYHrc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:47:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1879 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935235AbeEYHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:47:31 -0400
From: Christophe Roullier <christophe.roullier@st.com>
To: <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <peppe.cavallaro@st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <christophe.roullier@st.com>
Subject: [PATCH V0:net-next 4/4] dt-bindings: stm32: add compatible for syscon
Date: Fri, 25 May 2018 09:46:41 +0200
Message-ID: <1527234401-15812-5-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
References: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch describes syscon DT bindings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/stm32/stm32-syscon.txt         | 14 ++++++++++++++
 .../devicetree/bindings/arm/{ => stm32}/stm32.txt          |  0
 2 files changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 rename Documentation/devicetree/bindings/arm/{ => stm32}/stm32.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
new file mode 100644
index 0000000..99980ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
@@ -0,0 +1,14 @@
+STMicroelectronics STM32 Platforms System Controller
+
+Properties:
+   - compatible : should contain two values. First value must be :
+                 - " st,stm32mp157-syscfg " - for stm32mp157 based SoCs,
+                 second value must be always "syscon".
+   - reg : offset and length of the register set.
+
+ Example:
+         syscfg: syscon@50020000 {
+                 compatible = "st,stm32mp157-syscfg", "syscon";
+                 reg = <0x50020000 0x400>;
+         };
+
diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/stm32.txt
rename to Documentation/devicetree/bindings/arm/stm32/stm32.txt
-- 
1.9.1
