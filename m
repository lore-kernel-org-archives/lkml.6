Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13661C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8062595D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8062595D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933948AbeFYMj2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:39:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42148 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933663AbeFYMj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:39:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2473F2000D8;
        Mon, 25 Jun 2018 14:39:24 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D902C200078;
        Mon, 25 Jun 2018 14:39:23 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 4F72840C8A;
        Mon, 25 Jun 2018 05:39:23 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w5PCd34Q025070;
        Mon, 25 Jun 2018 05:39:20 -0700
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 05/10] arm64: dts: fsl: move ptp timer out of fman
Date:   Mon, 25 Jun 2018 20:37:11 +0800
Message-Id: <20180625123716.28993-6-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180625123716.28993-1-yangbo.lu@nxp.com>
References: <20180625123716.28993-1-yangbo.lu@nxp.com>
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
Acked-by: Richard Cochran <richardcochran@gmail.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
Changes for v2:
	- Fixed address-cells for ptp-timer.
Changes for v3:
	- None.
Changes for v4:
	- Added ACKs.
---
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index 4dd0676..a56a408 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -11,13 +11,14 @@ fman0: fman@1a00000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0x0 0x0 0x1a00000 0x100000>;
-	reg = <0x0 0x1a00000 0x0 0x100000>;
+	ranges = <0x0 0x0 0x1a00000 0xfe000>;
+	reg = <0x0 0x1a00000 0x0 0xfe000>;
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -73,9 +74,10 @@ fman0: fman@1a00000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@1afe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x0 0x1afe000 0x0 0x1000>;
+	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
1.7.1

