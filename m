Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbeBLOo7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:44:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40231 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933843AbeBLOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:43:56 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 07/12] ARM: dts: STi: Add fake reg for restart, powerdown and picophy/softreset
Date: Mon, 12 Feb 2018 15:43:05 +0100
Message-ID: <1518446590-16800-8-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add fake reg property for restart, powerdown, picophyreset
and softreset.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ add a fake reg property to node without reg property

 arch/arm/boot/dts/stih407-family.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 5a0bad07da9e..00a3838236d1 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -125,24 +125,28 @@
 		ranges;
 		compatible = "simple-bus";
 
-		restart {
+		restart: restart-controller@0 {
 			compatible = "st,stih407-restart";
+			reg = <0 0>;
 			st,syscfg = <&syscfg_sbc_reg>;
 			status = "okay";
 		};
 
-		powerdown: powerdown-controller {
+		powerdown: powerdown-controller@0 {
 			compatible = "st,stih407-powerdown";
+			reg = <0 0>;
 			#reset-cells = <1>;
 		};
 
-		softreset: softreset-controller {
+		softreset: softreset-controller@0 {
 			compatible = "st,stih407-softreset";
+			reg = <0 0>;
 			#reset-cells = <1>;
 		};
 
-		picophyreset: picophyreset-controller {
+		picophyreset: picophyreset-controller@0 {
 			compatible = "st,stih407-picophyreset";
+			reg = <0 0>;
 			#reset-cells = <1>;
 		};
 
-- 
1.9.1
