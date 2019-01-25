Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F8C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B5A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8TV1liq";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8TV1liq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfAYCzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:55:49 -0500
Received: from node.akkea.ca ([192.155.83.177]:52164 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbfAYCzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:55:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 73B934E204E;
        Fri, 25 Jan 2019 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384940; bh=ixvNVeF1Cz3AKqfX15lAQdMhkXdlfdPWW1FxryLNR5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b8TV1liqTwL8ktdK6mmTzXnWJdLb2cWPWGTwkNEkuNTpxGwj2qXv9qw2Q4XN/DpJw
         eqEd6mzk0Y9Y+ZGG76Rld3ebdL0Fg4zbEnWb0X3Hm0E+ZseEDNkB4H65k34JBqI0ot
         nJgU701tthu6yRbmKKxlNSgQzfGJBtHo1HlTyK4I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KqoVl4IQzJnH; Fri, 25 Jan 2019 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 83D214E204B;
        Fri, 25 Jan 2019 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384940; bh=ixvNVeF1Cz3AKqfX15lAQdMhkXdlfdPWW1FxryLNR5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b8TV1liqTwL8ktdK6mmTzXnWJdLb2cWPWGTwkNEkuNTpxGwj2qXv9qw2Q4XN/DpJw
         eqEd6mzk0Y9Y+ZGG76Rld3ebdL0Fg4zbEnWb0X3Hm0E+ZseEDNkB4H65k34JBqI0ot
         nJgU701tthu6yRbmKKxlNSgQzfGJBtHo1HlTyK4I=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v4 5/5] imx8mq.dtsi: add the sdma nodes
Date:   Thu, 24 Jan 2019 19:55:28 -0700
Message-Id: <20190125025528.15645-6-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sdma nodes to the base devicetree for the imx8mq

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index c0402375e7c1..f0cd3675ead0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -336,6 +336,17 @@
 				clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
 				status = "disabled";
 			};
+
+			sdma2: sdma@302c0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x302c0000 0x10000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					<&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
 		};
 
 		bus@30400000 { /* AIPS2 */
@@ -370,6 +381,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
 				         <&clk IMX8MQ_CLK_UART3_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -381,6 +394,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
 				         <&clk IMX8MQ_CLK_UART2_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -432,6 +447,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
 				         <&clk IMX8MQ_CLK_UART4_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -465,6 +482,17 @@
 				status = "disabled";
 			};
 
+			sdma1: sdma@30bd0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					<&clk IMX8MQ_CLK_AHB>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.17.1

