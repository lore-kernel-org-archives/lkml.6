Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36002C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11B72183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gnUq7/ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfAGN0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:26:11 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40884 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbfAGNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:24:05 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 229215C07CF;
        Mon,  7 Jan 2019 14:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546867443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=p18V2ScE8bfhgyOb+Y6Vk9eLEW/2z29TyXa17JP8ZKc=;
        b=gnUq7/gajPai7SJk3saBLGRfdXHtD12YFN7r/bILFd5YA05X0WP8+9cGd6A6LfLGnJSGz3
        /Sw3qbgbCAzqfYaayQfuBZz9aSvQquoPHVPR5Vdaq73dciBoZz+gCBQX+F37jJNsIbO+EG
        qvP6abmQE+Rjbk64YI3ZFzkCDXnbVnc=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: dts: imx6ul: add DMA properties for ECSPI
Date:   Mon,  7 Jan 2019 14:22:25 +0100
Message-Id: <20190107132226.16216-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
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
 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6dc0b569acdf..b0193abf7005 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -227,6 +227,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI1>,
 						 <&clks IMX6UL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -239,6 +241,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI2>,
 						 <&clks IMX6UL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -251,6 +255,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI3>,
 						 <&clks IMX6UL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -263,6 +269,8 @@
 					clocks = <&clks IMX6UL_CLK_ECSPI4>,
 						 <&clks IMX6UL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
2.20.1

