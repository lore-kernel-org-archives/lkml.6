Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039DDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10C420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10C420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeGWEFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:05:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37428 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbeGWEFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:05:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 65C3420005B;
        Mon, 23 Jul 2018 05:06:46 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F11F20008C;
        Mon, 23 Jul 2018 05:06:46 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 679F840C72;
        Sun, 22 Jul 2018 20:06:45 -0700 (MST)
Received: from mega.am.freescale.net ([10.192.208.232])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6N36WSh017523;
        Sun, 22 Jul 2018 20:06:42 -0700
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradeadorg,
        ran.wang_1@nxp.com, pengbo.mu@nxp.com
Subject: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst type adjustment
Date:   Mon, 23 Jul 2018 11:06:24 +0800
Message-Id: <1532315184-22985-4-git-send-email-pengbo.mu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532315184-22985-1-git-send-email-pengbo.mu@nxp.com>
References: <1532315184-22985-1-git-send-email-pengbo.mu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0
DWC3.When only one value means INCRx mode with fix burst type.
When more than one value, means undefined length burst mode, USB
controller can use the length less than or equal to the largest
enabled burst length.

While enabling undefined length INCR burst type and INCR16 burst type,
get better write performance on NXP Layerscape platforms: around 3%
improvement (from 364MB/s to 375MB/s).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v6:
 - delete snps,incr-burst-type-adjustment = <1>
Changes in v5:
 - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
 - update ls208xa support according to code base change
Changes in v4:
 - change definition for this property.
Changes in v3:
 - add new property for INCR burst in usb node.
---
 arch/arm/boot/dts/ls1021a.dtsi                 | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479..7c328f3 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -706,6 +706,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		pcie@3400000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 205f0f4..8e3d66f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -482,6 +482,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 1109f22..f826d20 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -643,6 +643,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3000000 {
@@ -652,6 +653,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb3@3100000 {
@@ -661,6 +663,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa..9226be8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -604,6 +604,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb@3000000 {
@@ -613,6 +614,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb@3100000 {
@@ -622,6 +624,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 1c6556b..34671ee0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -479,6 +479,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			status = "disabled";
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3110000 {
@@ -489,6 +490,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			status = "disabled";
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..c0762cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -754,6 +754,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3110000 {
@@ -764,6 +765,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		ccn@4000000 {
-- 
2.7.4

