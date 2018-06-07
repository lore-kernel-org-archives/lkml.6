Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KBSvLy35GFsLZQAAmS7hNA
	; Thu, 07 Jun 2018 09:25:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 22D63608CA; Thu,  7 Jun 2018 09:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1983E608CD;
	Thu,  7 Jun 2018 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1983E608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeFGJYm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:24:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54727 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932866AbeFGJWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:22:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A817C200239;
        Thu,  7 Jun 2018 11:22:36 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AD6F200037;
        Thu,  7 Jun 2018 11:22:36 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 9AA0740A56;
        Thu,  7 Jun 2018 02:22:35 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w579MJ4k020959;
        Thu, 7 Jun 2018 02:22:33 -0700
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 04/10] powerpc/mpc85xx: move ptp timer out of fman in dts
Date: Thu,  7 Jun 2018 17:20:44 +0800
Message-Id: <20180607092050.46128-5-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to move ptp timer node out of fman.
Because ptp timer will be probed by ptp_qoriq driver,
it should be an independent device in case of conflict
memory mapping.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- None.
---
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi   |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi   |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi  |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi  |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |   14 ++++++++------
 5 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
index abd01d4..6b124f7 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x40 0xc>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -93,9 +94,10 @@ fman0: fman@400000 {
 		reg = <0x87000 0x1000>;
 		status = "disabled";
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
index debea75..b80aaf5 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
@@ -37,12 +37,13 @@ fman1: fman@500000 {
 	#size-cells = <1>;
 	cell-index = <1>;
 	compatible = "fsl,fman";
-	ranges = <0 0x500000 0x100000>;
-	reg = <0x500000 0x100000>;
+	ranges = <0 0x500000 0xfe000>;
+	reg = <0x500000 0xfe000>;
 	interrupts = <97 2 0 0>, <16 2 1 0>;
 	clocks = <&clockgen 3 1>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x60 0xc>;
+	ptimer-handle = <&ptp_timer1>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -93,9 +94,10 @@ fman1: fman@500000 {
 		reg = <0x87000 0x1000>;
 		status = "disabled";
 	};
+};
 
-	ptp_timer1: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer1: ptp-timer@5fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x5fe000 0x1000>;
+	interrupts = <97 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
index 3a20e0d..d3720fd 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -98,9 +99,10 @@ fman0: fman@400000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
index 82750ac..ae34c20 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
@@ -37,12 +37,13 @@ fman1: fman@500000 {
 	#size-cells = <1>;
 	cell-index = <1>;
 	compatible = "fsl,fman";
-	ranges = <0 0x500000 0x100000>;
-	reg = <0x500000 0x100000>;
+	ranges = <0 0x500000 0xfe000>;
+	reg = <0x500000 0xfe000>;
 	interrupts = <97 2 0 0>, <16 2 1 0>;
 	clocks = <&clockgen 3 1>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x820 0x10>;
+	ptimer-handle = <&ptp_timer1>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -98,9 +99,10 @@ fman1: fman@500000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer1: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer1: ptp-timer@5fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x5fe000 0x1000>;
+	interrupts = <97 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 7f60b60..02f2755 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -86,9 +87,10 @@ fman0: fman@400000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
-- 
1.7.1
