Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeEQPsG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:48:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752547AbeEQPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:48:02 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1
Date: Thu, 17 May 2018 17:47:32 +0200
Message-ID: <1526572052-17155-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
References: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables USB OTG HS on stm32mp157c-ev1 in Peripheral mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 9382d80..5a0b77e 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -103,6 +103,13 @@
 	};
 };
 
+&usbotg_hs {
+	dr_mode = "peripheral";
+	phys = <&usbphyc_port1 0>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
 &usbphyc {
 	status = "okay";
 };
-- 
2.7.4
