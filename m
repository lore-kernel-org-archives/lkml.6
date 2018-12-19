Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C41EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2744F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeLSJqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:46:25 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37564 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeLSJqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:46:19 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A2EC1A0351;
        Wed, 19 Dec 2018 10:46:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23C7E1A00EE;
        Wed, 19 Dec 2018 10:46:12 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 15C0F402AE;
        Wed, 19 Dec 2018 17:46:06 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 1/2] arm64: dts: layerscape: Add incr-burst-type-adjustment property to USB3 node
Date:   Wed, 19 Dec 2018 17:41:08 +0800
Message-Id: <20181219094109.3836-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this property to all layerscape platforms to improve USB read write performance.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    2 ++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |    2 ++
 6 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 816f3a4..ab7a8ce 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -446,6 +446,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 70057b4..1fff054 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -611,6 +611,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3000000 {
@@ -620,6 +621,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb3@3100000 {
@@ -629,6 +631,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 9a2106e..160fb1c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -572,6 +572,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb@3000000 {
@@ -581,6 +582,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb@3100000 {
@@ -590,6 +592,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index de93b42..550f9b5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -377,6 +377,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 6d6ca16..476cdf8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -727,6 +727,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3110000 {
@@ -737,6 +738,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		ccn@4000000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1..14e6eb7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -658,6 +658,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
@@ -668,6 +669,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
-- 
1.7.1

