Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290F9ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA0920838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA0920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeJaP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:58:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59176 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbeJaP6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:58:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C6AD9200081;
        Wed, 31 Oct 2018 08:01:47 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59F55200062;
        Wed, 31 Oct 2018 08:01:41 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 98382402C8;
        Wed, 31 Oct 2018 15:01:33 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     oss@buserror.net
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Tang Yuantian <andy.tang@nxp.com>
Subject: [PATCH 1/2 v3] powerpc/fsl: Use new clockgen binding
Date:   Wed, 31 Oct 2018 14:57:35 +0800
Message-Id: <20181031065736.32719-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <oss@buserror.net>

The driver retains compatibility with old device trees, but we don't
want the old nodes lying around to be copied, or used as a reference
(some of the mux options are incorrect), or even just being clutter.

Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v3:
  - update the commit message
  - split the dts and driver to different patchset

 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi     |    4 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi     |    8 ++--
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi       |   15 -----
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi    |   18 ------
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi     |    8 ++--
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi    |   18 ------
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi     |    8 ++--
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi    |   70 ------------------------
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi     |   16 +++---
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi     |    4 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi    |   18 ------
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi     |    8 ++--
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi |   55 +++----------------
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |   38 +++----------
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi    |   16 ------
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi     |    4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi    |   44 ---------------
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi     |    8 ++--
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi    |   22 --------
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi     |    8 ++--
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi    |   61 ---------------------
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi     |   24 ++++----
 22 files changed, 66 insertions(+), 409 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 88d8423..bb7b9b9 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -70,14 +70,14 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index f3f968c..388ba1b 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -75,28 +75,28 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 1b33f51..4f044b4 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -398,21 +398,6 @@
 	};
 
 /include/ "qoriq-clockgen2.dtsi"
-	clockgen: global-utilities@e1000 {
-		compatible = "fsl,b4-clockgen", "fsl,qoriq-clockgen-2.0";
-		reg = <0xe1000 0x1000>;
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux0";
-		};
-	};
 
 	rcpm: global-utilities@e2000 {
 		compatible = "fsl,b4-rcpm", "fsl,qoriq-rcpm-2.0";
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 51e975d..872e448 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -327,24 +327,6 @@
 /include/ "qoriq-clockgen1.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,p2041-clockgen", "fsl,qoriq-clockgen-1.0";
-
-		mux2: mux2@40 {
-			#clock-cells = <0>;
-			reg = <0x40 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux2";
-		};
-
-		mux3: mux3@60 {
-			#clock-cells = <0>;
-			reg = <0x60 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux3";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
index 941274c..6318962 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
@@ -89,7 +89,7 @@
 		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_0>;
 			fsl,portid-mapping = <0x80000000>;
 			L2_0: l2-cache {
@@ -99,7 +99,7 @@
 		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x40000000>;
 			L2_1: l2-cache {
@@ -109,7 +109,7 @@
 		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x20000000>;
 			L2_2: l2-cache {
@@ -119,7 +119,7 @@
 		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
-			clocks = <&mux3>;
+			clocks = <&clockgen 1 3>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x10000000>;
 			L2_3: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 187676f..81bc75a 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -354,24 +354,6 @@
 /include/ "qoriq-clockgen1.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
-
-		mux2: mux2@40 {
-			#clock-cells = <0>;
-			reg = <0x40 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux2";
-		};
-
-		mux3: mux3@60 {
-			#clock-cells = <0>;
-			reg = <0x60 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux3";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
index 50b73e8..db92f11 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
@@ -90,7 +90,7 @@
 		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_0>;
 			fsl,portid-mapping = <0x80000000>;
 			L2_0: l2-cache {
@@ -100,7 +100,7 @@
 		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x40000000>;
 			L2_1: l2-cache {
@@ -110,7 +110,7 @@
 		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x20000000>;
 			L2_2: l2-cache {
@@ -120,7 +120,7 @@
 		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
-			clocks = <&mux3>;
+			clocks = <&clockgen 1 3>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x10000000>;
 			L2_3: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index a025208..4da49b6 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -374,76 +374,6 @@
 /include/ "qoriq-clockgen1.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
-
-		pll2: pll2@840 {
-			#clock-cells = <1>;
-			reg = <0x840 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll2", "pll2-div2";
-		};
-
-		pll3: pll3@860 {
-			#clock-cells = <1>;
-			reg = <0x860 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll3", "pll3-div2";
-		};
-
-		mux2: mux2@40 {
-			#clock-cells = <0>;
-			reg = <0x40 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux2";
-		};
-
-		mux3: mux3@60 {
-			#clock-cells = <0>;
-			reg = <0x60 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux3";
-		};
-
-		mux4: mux4@80 {
-			#clock-cells = <0>;
-			reg = <0x80 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
-			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
-			clock-output-names = "cmux4";
-		};
-
-		mux5: mux5@a0 {
-			#clock-cells = <0>;
-			reg = <0xa0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
-			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
-			clock-output-names = "cmux5";
-		};
-
-		mux6: mux6@c0 {
-			#clock-cells = <0>;
-			reg = <0xc0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
-			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
-			clock-output-names = "cmux6";
-		};
-
-		mux7: mux7@e0 {
-			#clock-cells = <0>;
-			reg = <0xe0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
-			clock-names = "pll2", "pll2-div2", "pll3", "pll3-div2";
-			clock-output-names = "cmux7";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
index d56a546..0a7c65a 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
@@ -94,7 +94,7 @@
 		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_0>;
 			fsl,portid-mapping = <0x80000000>;
 			L2_0: l2-cache {
@@ -104,7 +104,7 @@
 		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x40000000>;
 			L2_1: l2-cache {
@@ -114,7 +114,7 @@
 		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x20000000>;
 			L2_2: l2-cache {
@@ -124,7 +124,7 @@
 		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
-			clocks = <&mux3>;
+			clocks = <&clockgen 1 3>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x10000000>;
 			L2_3: l2-cache {
@@ -134,7 +134,7 @@
 		cpu4: PowerPC,e500mc@4 {
 			device_type = "cpu";
 			reg = <4>;
-			clocks = <&mux4>;
+			clocks = <&clockgen 1 4>;
 			next-level-cache = <&L2_4>;
 			fsl,portid-mapping = <0x08000000>;
 			L2_4: l2-cache {
@@ -144,7 +144,7 @@
 		cpu5: PowerPC,e500mc@5 {
 			device_type = "cpu";
 			reg = <5>;
-			clocks = <&mux5>;
+			clocks = <&clockgen 1 5>;
 			next-level-cache = <&L2_5>;
 			fsl,portid-mapping = <0x04000000>;
 			L2_5: l2-cache {
@@ -154,7 +154,7 @@
 		cpu6: PowerPC,e500mc@6 {
 			device_type = "cpu";
 			reg = <6>;
-			clocks = <&mux6>;
+			clocks = <&clockgen 1 6>;
 			next-level-cache = <&L2_6>;
 			fsl,portid-mapping = <0x02000000>;
 			L2_6: l2-cache {
@@ -164,7 +164,7 @@
 		cpu7: PowerPC,e500mc@7 {
 			device_type = "cpu";
 			reg = <7>;
-			clocks = <&mux7>;
+			clocks = <&clockgen 1 7>;
 			next-level-cache = <&L2_7>;
 			fsl,portid-mapping = <0x01000000>;
 			L2_7: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
index bfba0b4..2d74ea8 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
@@ -96,7 +96,7 @@
 		cpu0: PowerPC,e5500@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_0>;
 			fsl,portid-mapping = <0x80000000>;
 			L2_0: l2-cache {
@@ -106,7 +106,7 @@
 		cpu1: PowerPC,e5500@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x40000000>;
 			L2_1: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index e2bd931..16b454b 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -319,24 +319,6 @@
 /include/ "qoriq-clockgen1.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
-
-		mux2: mux2@40 {
-			#clock-cells = <0>;
-			reg = <0x40 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux2";
-		};
-
-		mux3: mux3@60 {
-			#clock-cells = <0>;
-			reg = <0x60 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux3";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
index dbd5775..ed89dbb 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
@@ -102,7 +102,7 @@
 		cpu0: PowerPC,e5500@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_0>;
 			fsl,portid-mapping = <0x80000000>;
 			L2_0: l2-cache {
@@ -112,7 +112,7 @@
 		cpu1: PowerPC,e5500@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x40000000>;
 			L2_1: l2-cache {
@@ -122,7 +122,7 @@
 		cpu2: PowerPC,e5500@2 {
 			device_type = "cpu";
 			reg = <2>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x20000000>;
 			L2_2: l2-cache {
@@ -132,7 +132,7 @@
 		cpu3: PowerPC,e5500@3 {
 			device_type = "cpu";
 			reg = <3>;
-			clocks = <&mux3>;
+			clocks = <&clockgen 1 3>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x10000000>;
 			L2_3: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
index 88cd70d..5c89cfa 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
@@ -32,55 +32,16 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+sysclk: sysclk {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <100000000>;
+	clock-output-names = "sysclk";
+};
+
 clockgen: global-utilities@e1000 {
 	compatible = "fsl,qoriq-clockgen-1.0";
-	ranges = <0x0 0xe1000 0x1000>;
 	reg = <0xe1000 0x1000>;
-	clock-frequency = <0>;
-	#address-cells = <1>;
-	#size-cells = <1>;
 	#clock-cells = <2>;
-
-	sysclk: sysclk {
-		#clock-cells = <0>;
-		compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
-		clock-output-names = "sysclk";
-	};
-	pll0: pll0@800 {
-		#clock-cells = <1>;
-		reg = <0x800 0x4>;
-		compatible = "fsl,qoriq-core-pll-1.0";
-		clocks = <&sysclk>;
-		clock-output-names = "pll0", "pll0-div2";
-	};
-	pll1: pll1@820 {
-		#clock-cells = <1>;
-		reg = <0x820 0x4>;
-		compatible = "fsl,qoriq-core-pll-1.0";
-		clocks = <&sysclk>;
-		clock-output-names = "pll1", "pll1-div2";
-	};
-	mux0: mux0@0 {
-		#clock-cells = <0>;
-		reg = <0x0 0x4>;
-		compatible = "fsl,qoriq-core-mux-1.0";
-		clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-		clock-output-names = "cmux0";
-	};
-	mux1: mux1@20 {
-		#clock-cells = <0>;
-		reg = <0x20 0x4>;
-		compatible = "fsl,qoriq-core-mux-1.0";
-		clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-		clock-output-names = "cmux1";
-	};
-	platform_pll: platform-pll@c00 {
-		#clock-cells = <1>;
-		reg = <0xc00 0x4>;
-		compatible = "fsl,qoriq-platform-pll-1.0";
-		clocks = <&sysclk>;
-		clock-output-names = "platform-pll", "platform-pll-div2";
-	};
+	clocks = <&sysclk>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
index 6dfd7c5..bf649ce 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
@@ -32,38 +32,16 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+sysclk: sysclk {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <100000000>;
+	clock-output-names = "sysclk";
+};
+
 clockgen: global-utilities@e1000 {
 	compatible = "fsl,qoriq-clockgen-2.0";
-	ranges = <0x0 0xe1000 0x1000>;
 	reg = <0xe1000 0x1000>;
-	#address-cells = <1>;
-	#size-cells = <1>;
 	#clock-cells = <2>;
-
-	sysclk: sysclk {
-		#clock-cells = <0>;
-		compatible = "fsl,qoriq-sysclk-2.0", "fixed-clock";
-		clock-output-names = "sysclk";
-	};
-	pll0: pll0@800 {
-		#clock-cells = <1>;
-		reg = <0x800 0x4>;
-		compatible = "fsl,qoriq-core-pll-2.0";
-		clocks = <&sysclk>;
-		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
-	};
-	pll1: pll1@820 {
-		#clock-cells = <1>;
-		reg = <0x820 0x4>;
-		compatible = "fsl,qoriq-core-pll-2.0";
-		clocks = <&sysclk>;
-		clock-output-names = "pll1", "pll1-div2", "pll1-div4";
-	};
-	platform_pll: platform-pll@c00 {
-		#clock-cells = <1>;
-		reg = <0xc00 0x4>;
-		compatible = "fsl,qoriq-platform-pll-2.0";
-		clocks = <&sysclk>;
-		clock-output-names = "platform-pll", "platform-pll-div2";
-	};
+	clocks = <&sysclk>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 4908af5..d552044 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -345,22 +345,6 @@
 /include/ "qoriq-clockgen2.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,t1023-clockgen", "fsl,qoriq-clockgen-2.0";
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 4>;
-			compatible = "fsl,core-mux-clock";
-			clocks = <&pll0 0>, <&pll0 1>;
-			clock-names = "pll0_0", "pll0_1";
-			clock-output-names = "cmux0";
-		};
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 4>;
-			compatible = "fsl,core-mux-clock";
-			clocks = <&pll0 0>, <&pll0 1>;
-			clock-names = "pll0_0", "pll0_1";
-			clock-output-names = "cmux1";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
index 9d08a36..d87ea13 100644
--- a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
@@ -74,7 +74,7 @@
 		cpu0: PowerPC,e5500@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
 			L2_1: l2-cache {
@@ -84,7 +84,7 @@
 		cpu1: PowerPC,e5500@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_2>;
 			#cooling-cells = <2>;
 			L2_2: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 145c7f4..315d055 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -425,50 +425,6 @@
 /include/ "qoriq-clockgen2.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,t1040-clockgen", "fsl,qoriq-clockgen-2.0";
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll1-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll1-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux1";
-		};
-
-		mux2: mux2@40 {
-			#clock-cells = <0>;
-			reg = <0x40 4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll1-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux2";
-		};
-
-		mux3: mux3@60 {
-			#clock-cells = <0>;
-			reg = <0x60 4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0_0", "pll0_1", "pll0_2",
-				"pll1_0", "pll1_1", "pll1_2";
-			clock-output-names = "cmux3";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
index 6db0ee8..dd59e4b 100644
--- a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
@@ -74,7 +74,7 @@
 		cpu0: PowerPC,e5500@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
 			L2_1: l2-cache {
@@ -84,7 +84,7 @@
 		cpu1: PowerPC,e5500@1 {
 			device_type = "cpu";
 			reg = <1>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_2>;
 			#cooling-cells = <2>;
 			L2_2: l2-cache {
@@ -94,7 +94,7 @@
 		cpu2: PowerPC,e5500@2 {
 			device_type = "cpu";
 			reg = <2>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_3>;
 			#cooling-cells = <2>;
 			L2_3: l2-cache {
@@ -104,7 +104,7 @@
 		cpu3: PowerPC,e5500@3 {
 			device_type = "cpu";
 			reg = <3>;
-			clocks = <&mux3>;
+			clocks = <&clockgen 1 3>;
 			next-level-cache = <&L2_4>;
 			#cooling-cells = <2>;
 			L2_4: l2-cache {
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index a97296c..ecbb447 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -535,28 +535,6 @@
 /include/ "qoriq-clockgen2.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,t2080-clockgen", "fsl,qoriq-clockgen-2.0";
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4";
-			clock-output-names = "cmux1";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
index c2e5720..3f745de 100644
--- a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
@@ -81,28 +81,28 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 68c4ead..fcac734 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -950,67 +950,6 @@
 /include/ "qoriq-clockgen2.dtsi"
 	global-utilities@e1000 {
 		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
-
-		pll2: pll2@840 {
-			#clock-cells = <1>;
-			reg = <0x840 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
-		};
-
-		pll3: pll3@860 {
-			#clock-cells = <1>;
-			reg = <0x860 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll3", "pll3-div2", "pll3-div4";
-		};
-
-		pll4: pll4@880 {
-			#clock-cells = <1>;
-			reg = <0x880 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll4", "pll4-div2", "pll4-div4";
-		};
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>,
-				<&pll2 0>, <&pll2 1>, <&pll2 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4",
-				"pll2", "pll2-div2", "pll2-div4";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>,
-				<&pll2 0>, <&pll2 1>, <&pll2 2>;
-			clock-names = "pll0", "pll0-div2", "pll0-div4",
-				"pll1", "pll1-div2", "pll1-div4",
-				"pll2", "pll2-div2", "pll2-div4";
-			clock-output-names = "cmux1";
-		};
-
-		mux2: mux2@40 {
-			#clock-cells = <0>;
-			reg = <0x40 0x4>;
-			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll3 0>, <&pll3 1>, <&pll3 2>,
-				<&pll4 0>, <&pll4 1>, <&pll4 2>;
-			clock-names = "pll3", "pll3-div2", "pll3-div4",
-				"pll4", "pll4-div2", "pll4-div4";
-			clock-output-names = "cmux2";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 038cf8f..632314c 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -90,84 +90,84 @@
 		cpu0: PowerPC,e6500@0 {
 			device_type = "cpu";
 			reg = <0 1>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
-			clocks = <&mux0>;
+			clocks = <&clockgen 1 0>;
 			next-level-cache = <&L2_1>;
 			fsl,portid-mapping = <0x80000000>;
 		};
 		cpu4: PowerPC,e6500@8 {
 			device_type = "cpu";
 			reg = <8 9>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu5: PowerPC,e6500@10 {
 			device_type = "cpu";
 			reg = <10 11>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu6: PowerPC,e6500@12 {
 			device_type = "cpu";
 			reg = <12 13>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu7: PowerPC,e6500@14 {
 			device_type = "cpu";
 			reg = <14 15>;
-			clocks = <&mux1>;
+			clocks = <&clockgen 1 1>;
 			next-level-cache = <&L2_2>;
 			fsl,portid-mapping = <0x40000000>;
 		};
 		cpu8: PowerPC,e6500@16 {
 			device_type = "cpu";
 			reg = <16 17>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu9: PowerPC,e6500@18 {
 			device_type = "cpu";
 			reg = <18 19>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu10: PowerPC,e6500@20 {
 			device_type = "cpu";
 			reg = <20 21>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x20000000>;
 		};
 		cpu11: PowerPC,e6500@22 {
 			device_type = "cpu";
 			reg = <22 23>;
-			clocks = <&mux2>;
+			clocks = <&clockgen 1 2>;
 			next-level-cache = <&L2_3>;
 			fsl,portid-mapping = <0x20000000>;
 		};
-- 
1.7.1

