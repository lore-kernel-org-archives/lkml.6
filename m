Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeDSNWq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:22:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27931 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753059AbeDSNWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:22:43 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for st,syscfg property
Date: Thu, 19 Apr 2018 15:21:42 +0200
Message-ID: <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC driver should not be aware of the PWR registers offset and bits
position. Furthermore, we can imagine that Disable Backup Protection (DBP)
relative register and bit mask could change depending on the SoC. So this
patch moves st,syscfg property from single pwrcfg phandle to pwrcfg
phandle/offset/mask triplet.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
index a66692a..00f8b5d 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -14,8 +14,10 @@ Required properties:
     It is required only on stm32h7.
 - interrupt-parent: phandle for the interrupt controller.
 - interrupts: rtc alarm interrupt.
-- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
-  (RTC registers) write protection.
+- st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
+  access control register at offset, and change the dbp (Disable Backup
+  Protection) bit represented by the mask, mandatory to disable/enable backup
+  domain (RTC registers) write protection.
 
 Optional properties (to override default rtc_ck parent clock):
 - assigned-clocks: reference to the rtc_ck clock entry.
@@ -31,7 +33,7 @@ Example:
 		assigned-clock-parents = <&rcc 1 CLK_LSE>;
 		interrupt-parent = <&exti>;
 		interrupts = <17 1>;
-		st,syscfg = <&pwrcfg>;
+		st,syscfg = <&pwrcfg 0x00 0x100>;
 	};
 
 	rtc: rtc@58004000 {
@@ -44,5 +46,5 @@ Example:
 		interrupt-parent = <&exti>;
 		interrupts = <17 1>;
 		interrupt-names = "alarm";
-		st,syscfg = <&pwrcfg>;
+		st,syscfg = <&pwrcfg 0x00 0x100>;
 	};
-- 
2.7.4
