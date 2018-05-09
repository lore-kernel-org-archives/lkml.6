Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965016AbeEIPTl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:19:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34483 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935065AbeEIPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:18:43 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: update rtc st,syscfg property on stm32f746
Date: Wed, 9 May 2018 17:18:14 +0200
Message-ID: <1525879094-19562-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
References: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fit with latest rtc driver updates, rtc st,syscfg property must contain
the control register offset of pwrcfg and the mask corresponding to the
DBP (Disable Backup Protection) bit.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 1479e3e..f48d06a 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -297,7 +297,7 @@
 			interrupt-parent = <&exti>;
 			interrupts = <17 1>;
 			interrupt-names = "alarm";
-			st,syscfg = <&pwrcfg>;
+			st,syscfg = <&pwrcfg 0x00 0x100>;
 			status = "disabled";
 		};
 
-- 
2.7.4
