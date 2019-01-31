Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CE7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CB420881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4HmghPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfAaUoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:44:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42597 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfAaUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so2013033pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O4Wkf/nTzGhCJi9CXELH+Ct9zFnV1b01DW6mjLb2cg=;
        b=r4HmghPiEACL3jZTbzuhbf//i5OTjaIvGfUP84jBuHoS4y0uU/l12x1eGgVlfzj1th
         kUKDSA/+ChmUDt6rtz3rsauq1zEdOJAkcVaHtZCzEysaYjnnrBLP9geeD+yFQ2B60lDw
         hLqC0+EeXpPR6BPohsgbDM4Nhrftm11IPMBEzy2HyIS4bEniBEOqTS0fjk0u9CpKnPks
         bEFaHaUSCT5usQ612MkQUJW1MLdbWnm6Egj/gBkHFzVdRrmyH5JUZiHruEVayqyMcNkT
         nlWTQU6j2v1IyW63IZkMjKXnivBQVh4gLLX+5lcQ+UucS+jK94cVaoc63MBbxHnFLBhq
         7Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O4Wkf/nTzGhCJi9CXELH+Ct9zFnV1b01DW6mjLb2cg=;
        b=a1w6Ikn3uqac+jT4AoIXaGRFanLIxXb+wWlNN4nCG2Ki15CagPaF7LsziFObh0emkt
         hvfk3WnBo83hLsNieJs/5Yda60HXSQDERNPrXNqJf0yrcM6uqKs74dvWVyGQ2J/ORGXF
         VzRybHAdUTsptAUSAeePx9eoUpGMh/fQJHkEzL7E1XV18AtAPWUt3OzzaNoAVDe4OXH7
         FrizCUDf9xWZnCn9T5JXp6z+KO2eHnFl6mxeWA5had6k/oX4obF4++6Yl7Lsv5a1MEZC
         gGvCoNWjeBTytea4YQOuG8oEiOC6QjdLh9Hhr4nlmBNlRzQLdWntn77f5OaPqt3W+ztz
         lR7g==
X-Gm-Message-State: AJcUukfTdFY4Z0m84C4kmqCJaVS/v1FOc+vDq5bkJjxajBvE+5ukThHB
        skEjnO1idXTAWo738My5NoU=
X-Google-Smtp-Source: ALg8bN4PqYMh2gAEismlUevlkhrxw5JpXzgeTGrm4XIu8d9yHFXGZA5ywPVnl0i3bzsi0ghU9ANI1w==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr35466884pfi.95.1548967433536;
        Thu, 31 Jan 2019 12:43:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:43:52 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 4/5] arm64: dts: Add nodes for PCIe IP blocks
Date:   Thu, 31 Jan 2019 12:43:32 -0800
Message-Id: <20190131204333.31846-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for two PCIe controllers found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 89babc531380..d20e5c7e21a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8mq-clock.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx8mq-pinfunc.h"
@@ -539,6 +540,73 @@
 			};
 		};
 
+		pcie0: pcie@33800000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33800000 0x400000>,
+			      <0x1ff00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
+			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
+			         <&clk IMX8MQ_CLK_PCIE1_AUX>,
+			         <&clk IMX8MQ_CLK_PCIE1_PHY>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
+		pcie1: pcie@0x33c00000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33c00000 0x400000>,
+			      <0x27f00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
+				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
+				 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+				 <&clk IMX8MQ_CLK_PCIE2_PHY>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.20.1

