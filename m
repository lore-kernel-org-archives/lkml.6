Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF835217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="oiDyAptw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfAGNYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:24:09 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40892 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfAGNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:24:05 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6596A5C11D1;
        Mon,  7 Jan 2019 14:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546867443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9kSgtB+6bwBO2+ezniVgU9XTsFZAzPwnM/wMIv4bq4=;
        b=oiDyAptwamZ1YjIWD/fLsgaE+c4v+xHxd5ELkI5OO4KHcd7Zs4ia4b8mOZyiMPX0BFPH5O
        ha1W5XZYSq4wsW9kN3AfNkmz1mxM6dnr6rKCLZ/uF7NGs3V6U+YAiGvrO7To1e1g3Rcg4v
        r5QojwcXkGrWpvebHUX2P9dIrzBmuGI=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Date:   Mon,  7 Jan 2019 14:22:26 +0100
Message-Id: <20190107132226.16216-2-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107132226.16216-1-stefan@agner.ch>
References: <20190107132226.16216-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to use DMA for SPI by adding the appropriate DMA properites
to the ecspi nodes.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198f6e96..b9330176c3af 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -653,6 +653,8 @@
 				clocks = <&clks IMX7D_ECSPI4_ROOT_CLK>,
 					<&clks IMX7D_ECSPI4_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 6 7 1>, <&sdma 7 7 2>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -734,6 +736,8 @@
 					clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
 						<&clks IMX7D_ECSPI1_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 0 7 1>, <&sdma 1 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -746,6 +750,8 @@
 					clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
 						<&clks IMX7D_ECSPI2_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 2 7 1>, <&sdma 3 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -758,6 +764,8 @@
 					clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
 						<&clks IMX7D_ECSPI3_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 4 7 1>, <&sdma 5 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
2.20.1

