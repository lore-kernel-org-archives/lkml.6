Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EBB2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EBB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeH2AjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:39:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60635 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH2AjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:39:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3ADF222A3C; Tue, 28 Aug 2018 22:45:58 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 105EB20795;
        Tue, 28 Aug 2018 22:45:48 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] arm64: dts: fsl: ls1046a: disable uarts by default
Date:   Tue, 28 Aug 2018 22:45:42 +0200
Message-Id: <20180828204544.10815-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
References: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the UARTs by defaultto avoid registering unused UARTs. This
effectively change the number of registered UARTS for the RDB and QDS from
4 to 2 but this seems the right thing to do.

It is especially useful when connecting other 8250 uart on PCIe for example
as the default maximum number of 8250 UARTs that can be registered is 4.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 2d8122019cd8..62ae3ee19d6f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -423,6 +423,7 @@
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		duart1: serial@21c0600 {
@@ -430,6 +431,7 @@
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		duart2: serial@21d0500 {
@@ -437,6 +439,7 @@
 			reg = <0x0 0x21d0500 0x0 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		duart3: serial@21d0600 {
@@ -444,6 +447,7 @@
 			reg = <0x0 0x21d0600 0x0 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		gpio0: gpio@2300000 {
-- 
2.18.0

