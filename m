Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeDTP5h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:57:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49789 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755966AbeDTP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:57:08 -0400
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 5/5] ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage
Date: Fri, 20 Apr 2018 17:54:44 +0200
Message-ID: <1524239684-25463-6-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
References: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG6NODE5.st.com (10.75.127.81) To GPXDAG6NODE6.st.com
 (10.75.127.82)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index c67edb1a8121..4dedfcb0fcb3 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -154,8 +154,8 @@
 			reg		= <0x08a20000 0x10000>,
 					  <0x08a00000 0x4000>;
 			reg-names	= "c8sectpfe", "c8sectpfe-ram";
-			interrupts	= <GIC_SPI 34 IRQ_TYPE_NONE>,
-					  <GIC_SPI 35 IRQ_TYPE_NONE>;
+			interrupts	= <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+					  <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names	= "c8sectpfe-error-irq",
 					  "c8sectpfe-idle-irq";
 			pinctrl-0	= <&pinctrl_tsin0_serial>;
-- 
1.9.1
