Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeDRPjm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:39:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25973 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753279AbeDRPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:39:12 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: [PATCH 1/3] dt-bindings: iio: stm32-adc: add support for STM32MP1.
Date: Wed, 18 Apr 2018 17:37:52 +0200
Message-ID: <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
References: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG3NODE4.st.com (10.75.127.71) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
Introduce "st,stm32mp1-adc" compatible to handle variants of this
hardware such as vregready flag, interrupts, clock rate.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index e8bb824..9994384 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -24,8 +24,11 @@ Required properties:
 - compatible: Should be one of:
   "st,stm32f4-adc-core"
   "st,stm32h7-adc-core"
+  "st,stm32mp1-adc-core"
 - reg: Offset and length of the ADC block register set.
-- interrupts: Must contain the interrupt for ADC block.
+- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
+  and stm32h7 share a common ADC interrupt line. stm32mp1 has separate
+  lines for each ADC within ADC block.
 - clocks: Core can use up to two clocks, depending on part used:
   - "adc" clock: for the analog circuitry, common to all ADCs.
     It's required on stm32f4.
@@ -53,6 +56,7 @@ Required properties:
 - compatible: Should be one of:
   "st,stm32f4-adc"
   "st,stm32h7-adc"
+  "st,stm32mp1-adc"
 - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
 - clocks: Input clock private to this ADC instance. It's required only on
   stm32f4, that has per instance clock input for registers access.
-- 
1.9.1
