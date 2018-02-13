Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935255AbeBMMyq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:54:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46695 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935087AbeBMMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:54:43 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 03/11] ARM: dts: STi: Add fake reg property for sti-display-subsystem
Date: Tue, 13 Feb 2018 13:53:29 +0100
Message-ID: <1518526417-11919-4-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

As sti-display-subsystem sub-nodes (sti-compositor, sti-tvout
sti-hdmi, sti-hda and sti-hqvdp) are SoC's IP, we add a fake
reg property.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sti-display-subsystem/sti-hda@8d02000 has a unit name, but no reg property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none
v2: _ add a fake reg property to node without reg property

 arch/arm/boot/dts/stih407.dtsi      | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 2 +-
 arch/arm/boot/dts/stih410.dtsi      | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 11fdecd9312e..4f01777082f5 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -11,11 +11,11 @@
 #include <dt-bindings/gpio/gpio.h>
 / {
 	soc {
-		sti-display-subsystem {
+		sti-display-subsystem@0 {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
 			#size-cells = <1>;
-
+			reg = <0 0>;
 			assigned-clocks	= <&clk_s_d2_quadfs 0>,
 					  <&clk_s_d2_quadfs 1>,
 					  <&clk_s_c0_pll1 0>,
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 37a42afa0dd1..23199b1b0991 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -61,7 +61,7 @@
 			status = "okay";
 		};
 
-		sti-display-subsystem {
+		sti-display-subsystem@0 {
 			sti-hda@8d02000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index e4b7e3ddc9ee..d9f964702933 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -102,11 +102,12 @@
 			status = "disabled";
 		};
 
-		sti-display-subsystem {
+		sti-display-subsystem@0 {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			reg = <0 0>;
 			assigned-clocks	= <&clk_s_d2_quadfs 0>,
 					  <&clk_s_d2_quadfs 1>,
 					  <&clk_s_c0_pll1 0>,
-- 
1.9.1
