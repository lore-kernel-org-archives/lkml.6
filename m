Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4835F218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeLRQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:08:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36497 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbeLRQIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:08:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ED97520AA0; Tue, 18 Dec 2018 17:08:10 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1069A20A66;
        Tue, 18 Dec 2018 17:07:59 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] arm64: dts: fsl: ls1046a: disable uarts by default
Date:   Tue, 18 Dec 2018 17:07:49 +0100
Message-Id: <20181218160750.6766-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 90dc3b616ea7..4caf4df1c7b1 100644
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
2.20.0

