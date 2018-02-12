Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936055AbeBLOqD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:46:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57498 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754350AbeBLOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:43:54 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 09/12] ARM: dts: STi: Add fake reg property for sound related nodes
Date: Mon, 12 Feb 2018 15:43:07 +0100
Message-ID: <1518446590-16800-10-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add fake reg property to sound, simple-audio-card, dai-link and
sti_sasg_codec nodes, this allows to fix the following warning
when compiling dtb with W=1 option:

arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@1 has a unit name, but no reg property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@2 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@1 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@2 has a unit name, but no reg property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/sound missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/sound missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ add a fake reg property to node without reg property.

 arch/arm/boot/dts/stih407-family.dtsi |  3 ++-
 arch/arm/boot/dts/stih410-b2260.dts   |  5 +++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi  | 11 ++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 5df827b00eb6..df1a3f1dc5a7 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -894,8 +894,9 @@
 			status = "disabled";
 		};
 
-		sti_sasg_codec: sti-sasg-codec {
+		sti_sasg_codec: sti-sasg-codec@0 {
 			compatible = "st,stih407-sas-codec";
+			reg = <0 0>;
 			#sound-dai-cells = <1>;
 			status = "disabled";
 			st,syscfg = <&syscfg_core>;
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 8bcd58118dba..03d05a98b7fc 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -181,12 +181,13 @@
 			status = "okay";
 		};
 
-		sound {
+		sound: sound@0 {
 			compatible = "simple-audio-card";
+			reg = <0 0>;
 			simple-audio-card,name = "STI-B2260";
 			status = "okay";
 
-			simple-audio-card,dai-link@0 {
+			simple-audio-card,dai-link0 {
 				/* DAC */
 				format = "i2s";
 				mclk-fs = <128>;
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 66c1c6a5eb76..eeae161fc69b 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -147,18 +147,19 @@
 			status = "okay";
 		};
 
-		sti_sasg_codec: sti-sasg-codec {
+		sti_sasg_codec: sti-sasg-codec@0 {
 			status = "okay";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spdif_out>;
 		};
 
-		sound {
+		sound: sound@0 {
 			compatible = "simple-audio-card";
+			reg = <0 0>;
 			simple-audio-card,name = "STI-B2120";
 			status = "okay";
 
-			simple-audio-card,dai-link@0 {
+			simple-audio-card,dai-link0 {
 				/* HDMI */
 				format = "i2s";
 				mclk-fs = <128>;
@@ -170,7 +171,7 @@
 					sound-dai = <&sti_hdmi>;
 				};
 			};
-			simple-audio-card,dai-link@1 {
+			simple-audio-card,dai-link1 {
 				/* DAC */
 				format = "i2s";
 				mclk-fs = <256>;
@@ -183,7 +184,7 @@
 					sound-dai = <&sti_sasg_codec 1>;
 				};
 			};
-			simple-audio-card,dai-link@2 {
+			simple-audio-card,dai-link2 {
 				/* SPDIF */
 				format = "left_j";
 				mclk-fs = <128>;
-- 
1.9.1
