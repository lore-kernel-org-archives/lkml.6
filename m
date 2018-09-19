Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E3020877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E3020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeISUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:24:54 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:33186 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbeISUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:24:54 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g2djP-0004oV-Gf from Akash_Gajjar@mentor.com ; Wed, 19 Sep 2018 07:45:31 -0700
Received: from eyas.local (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 19 Sep
 2018 15:45:24 +0100
From:   Akash Gajjar <Akash_Gajjar@mentor.com>
To:     <heiko@sntech.de>
CC:     <Deepak_Das@mentor.com>, <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: rockchip: update pinmux setting in rk3399.dtsi
Date:   Wed, 19 Sep 2018 20:15:15 +0530
Message-ID: <1537368317-22170-1-git-send-email-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace pin numbers with equivalent pin macro in rk3399.dtsi

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 252 ++++++++++++++++---------------
 1 file changed, 134 insertions(+), 118 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c88e603..d4db989 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1985,14 +1985,15 @@
 
 		clock {
 			clk_32k: clk-32k {
-				rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
+				rockchip,pins =
+					<0 RK_PA0 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		edp {
 			edp_hpd: edp-hpd {
 				rockchip,pins =
-					<4 23 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC7 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
@@ -2000,167 +2001,178 @@
 			rgmii_pins: rgmii-pins {
 				rockchip,pins =
 					/* mac_txclk */
-					<3 17 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PC1 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_rxclk */
-					<3 14 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB6 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_mdio */
-					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB5 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txen */
-					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PB4 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_clk */
-					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB3 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxdv */
-					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB1 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_mdc */
-					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB0 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd1 */
-					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA7 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd0 */
-					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txd1 */
-					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA5 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_txd0 */
-					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA4 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_rxd3 */
-					<3 3 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA3 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd2 */
-					<3 2 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA2 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txd3 */
-					<3 1 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA1 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_txd2 */
-					<3 0 RK_FUNC_1 &pcfg_pull_none_13ma>;
+					<3 RK_PA0 RK_FUNC_1
+						&pcfg_pull_none_13ma>;
 			};
 
 			rmii_pins: rmii-pins {
 				rockchip,pins =
 					/* mac_mdio */
-					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB5 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txen */
-					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PB4 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_clk */
-					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB3 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxer */
-					<3 10 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB2 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxdv */
-					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB1 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_mdc */
-					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB0 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd1 */
-					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA7 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd0 */
-					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txd1 */
-					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA5 RK_FUNC_1
+						&pcfg_pull_none_13ma>,
 					/* mac_txd0 */
-					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>;
+					<3 RK_PA4 RK_FUNC_1
+						&pcfg_pull_none_13ma>;
 			};
 		};
 
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins =
-					<1 15 RK_FUNC_2 &pcfg_pull_none>,
-					<1 16 RK_FUNC_2 &pcfg_pull_none>;
+					<1 RK_PB7 RK_FUNC_2 &pcfg_pull_none>,
+					<1 RK_PC0 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c1 {
 			i2c1_xfer: i2c1-xfer {
 				rockchip,pins =
-					<4 2 RK_FUNC_1 &pcfg_pull_none>,
-					<4 1 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PA2 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA1 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2c2 {
 			i2c2_xfer: i2c2-xfer {
 				rockchip,pins =
-					<2 1 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<2 0 RK_FUNC_2 &pcfg_pull_none_12ma>;
+					<2 RK_PA1 RK_FUNC_2
+						&pcfg_pull_none_12ma>,
+					<2 RK_PA0 RK_FUNC_2
+						&pcfg_pull_none_12ma>;
 			};
 		};
 
 		i2c3 {
 			i2c3_xfer: i2c3-xfer {
 				rockchip,pins =
-					<4 17 RK_FUNC_1 &pcfg_pull_none>,
-					<4 16 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC1 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PC0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2c4 {
 			i2c4_xfer: i2c4-xfer {
 				rockchip,pins =
-					<1 12 RK_FUNC_1 &pcfg_pull_none>,
-					<1 11 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PB4 RK_FUNC_1 &pcfg_pull_none>,
+					<1 RK_PB3 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2c5 {
 			i2c5_xfer: i2c5-xfer {
 				rockchip,pins =
-					<3 11 RK_FUNC_2 &pcfg_pull_none>,
-					<3 10 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PB3 RK_FUNC_2 &pcfg_pull_none>,
+					<3 RK_PB2 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c6 {
 			i2c6_xfer: i2c6-xfer {
 				rockchip,pins =
-					<2 10 RK_FUNC_2 &pcfg_pull_none>,
-					<2 9 RK_FUNC_2 &pcfg_pull_none>;
+					<2 RK_PB2 RK_FUNC_2 &pcfg_pull_none>,
+					<2 RK_PB1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c7 {
 			i2c7_xfer: i2c7-xfer {
 				rockchip,pins =
-					<2 8 RK_FUNC_2 &pcfg_pull_none>,
-					<2 7 RK_FUNC_2 &pcfg_pull_none>;
+					<2 RK_PB0 RK_FUNC_2 &pcfg_pull_none>,
+					<2 RK_PA7 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c8 {
 			i2c8_xfer: i2c8-xfer {
 				rockchip,pins =
-					<1 21 RK_FUNC_1 &pcfg_pull_none>,
-					<1 20 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PC5 RK_FUNC_1 &pcfg_pull_none>,
+					<1 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2s0 {
 			i2s0_2ch_bus: i2s0-2ch-bus {
 				rockchip,pins =
-					<3 24 RK_FUNC_1 &pcfg_pull_none>,
-					<3 25 RK_FUNC_1 &pcfg_pull_none>,
-					<3 26 RK_FUNC_1 &pcfg_pull_none>,
-					<3 27 RK_FUNC_1 &pcfg_pull_none>,
-					<3 31 RK_FUNC_1 &pcfg_pull_none>,
-					<4 0 RK_FUNC_1 &pcfg_pull_none>;
+					<3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD1 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
-					<3 24 RK_FUNC_1 &pcfg_pull_none>,
-					<3 25 RK_FUNC_1 &pcfg_pull_none>,
-					<3 26 RK_FUNC_1 &pcfg_pull_none>,
-					<3 27 RK_FUNC_1 &pcfg_pull_none>,
-					<3 28 RK_FUNC_1 &pcfg_pull_none>,
-					<3 29 RK_FUNC_1 &pcfg_pull_none>,
-					<3 30 RK_FUNC_1 &pcfg_pull_none>,
-					<3 31 RK_FUNC_1 &pcfg_pull_none>,
-					<4 0 RK_FUNC_1 &pcfg_pull_none>;
+					<3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD1 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD4 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD5 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD6 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2s1 {
 			i2s1_2ch_bus: i2s1-2ch-bus {
 				rockchip,pins =
-					<4 3 RK_FUNC_1 &pcfg_pull_none>,
-					<4 4 RK_FUNC_1 &pcfg_pull_none>,
-					<4 5 RK_FUNC_1 &pcfg_pull_none>,
-					<4 6 RK_FUNC_1 &pcfg_pull_none>,
-					<4 7 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PA3 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA4 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA5 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA7 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
@@ -2251,18 +2263,20 @@
 
 		sleep {
 			ap_pwroff: ap-pwroff {
-				rockchip,pins = <1 5 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins =
+					<1 RK_PA5 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			ddrio_pwroff: ddrio-pwroff {
-				rockchip,pins = <0 1 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins =
+					<0 RK_PA1 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		spdif {
 			spdif_bus: spdif-bus {
 				rockchip,pins =
-					<4 21 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC5 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			spdif_bus_1: spdif-bus-1 {
@@ -2274,229 +2288,231 @@
 		spi0 {
 			spi0_clk: spi0-clk {
 				rockchip,pins =
-					<3 6 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA6 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_cs0: spi0-cs0 {
 				rockchip,pins =
-					<3 7 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA7 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_cs1: spi0-cs1 {
 				rockchip,pins =
-					<3 8 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PB0 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_tx: spi0-tx {
 				rockchip,pins =
-					<3 5 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA5 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_rx: spi0-rx {
 				rockchip,pins =
-					<3 4 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA4 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		spi1 {
 			spi1_clk: spi1-clk {
 				rockchip,pins =
-					<1 9 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PB1 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi1_cs0: spi1-cs0 {
 				rockchip,pins =
-					<1 10 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PB2 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi1_rx: spi1-rx {
 				rockchip,pins =
-					<1 7 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PA7 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi1_tx: spi1-tx {
 				rockchip,pins =
-					<1 8 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PB0 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		spi2 {
 			spi2_clk: spi2-clk {
 				rockchip,pins =
-					<2 11 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB3 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi2_cs0: spi2-cs0 {
 				rockchip,pins =
-					<2 12 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB4 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi2_rx: spi2-rx {
 				rockchip,pins =
-					<2 9 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB1 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi2_tx: spi2-tx {
 				rockchip,pins =
-					<2 10 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB2 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
 		spi3 {
 			spi3_clk: spi3-clk {
 				rockchip,pins =
-					<1 17 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PC1 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi3_cs0: spi3-cs0 {
 				rockchip,pins =
-					<1 18 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PC2 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi3_rx: spi3-rx {
 				rockchip,pins =
-					<1 15 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PB7 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi3_tx: spi3-tx {
 				rockchip,pins =
-					<1 16 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PC0 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
 		spi4 {
 			spi4_clk: spi4-clk {
 				rockchip,pins =
-					<3 2 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA2 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi4_cs0: spi4-cs0 {
 				rockchip,pins =
-					<3 3 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA3 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi4_rx: spi4-rx {
 				rockchip,pins =
-					<3 0 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA0 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi4_tx: spi4-tx {
 				rockchip,pins =
-					<3 1 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA1 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		spi5 {
 			spi5_clk: spi5-clk {
 				rockchip,pins =
-					<2 22 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC6 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi5_cs0: spi5-cs0 {
 				rockchip,pins =
-					<2 23 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC7 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi5_rx: spi5-rx {
 				rockchip,pins =
-					<2 20 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC4 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi5_tx: spi5-tx {
 				rockchip,pins =
-					<2 21 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC5 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		testclk {
 			test_clkout0: test-clkout0 {
 				rockchip,pins =
-					<0 0 RK_FUNC_1 &pcfg_pull_none>;
+					<0 RK_PA0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			test_clkout1: test-clkout1 {
 				rockchip,pins =
-					<2 25 RK_FUNC_2 &pcfg_pull_none>;
+					<2 RK_PD1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			test_clkout2: test-clkout2 {
 				rockchip,pins =
-					<0 8 RK_FUNC_3 &pcfg_pull_none>;
+					<0 RK_PB0 RK_FUNC_3 &pcfg_pull_none>;
 			};
 		};
 
 		tsadc {
 			otp_gpio: otp-gpio {
-				rockchip,pins = <1 6 RK_FUNC_GPIO &pcfg_pull_none>;
+				rockchip,pins =
+					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 
 			otp_out: otp-out {
-				rockchip,pins = <1 6 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins =
+					<1 RK_PA6 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins =
-					<2 16 RK_FUNC_1 &pcfg_pull_up>,
-					<2 17 RK_FUNC_1 &pcfg_pull_none>;
+					<2 RK_PC0 RK_FUNC_1 &pcfg_pull_up>,
+					<2 RK_PC1 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			uart0_cts: uart0-cts {
 				rockchip,pins =
-					<2 18 RK_FUNC_1 &pcfg_pull_none>;
+					<2 RK_PC2 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			uart0_rts: uart0-rts {
 				rockchip,pins =
-					<2 19 RK_FUNC_1 &pcfg_pull_none>;
+					<2 RK_PC3 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uart1 {
 			uart1_xfer: uart1-xfer {
 				rockchip,pins =
-					<3 12 RK_FUNC_2 &pcfg_pull_up>,
-					<3 13 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PB4 RK_FUNC_2 &pcfg_pull_up>,
+					<3 RK_PB5 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart2a {
 			uart2a_xfer: uart2a-xfer {
 				rockchip,pins =
-					<4 8 RK_FUNC_2 &pcfg_pull_up>,
-					<4 9 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PB0 RK_FUNC_2 &pcfg_pull_up>,
+					<4 RK_PB1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart2b {
 			uart2b_xfer: uart2b-xfer {
 				rockchip,pins =
-					<4 16 RK_FUNC_2 &pcfg_pull_up>,
-					<4 17 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC0 RK_FUNC_2 &pcfg_pull_up>,
+					<4 RK_PC1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart2c {
 			uart2c_xfer: uart2c-xfer {
 				rockchip,pins =
-					<4 19 RK_FUNC_1 &pcfg_pull_up>,
-					<4 20 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up>,
+					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uart3 {
 			uart3_xfer: uart3-xfer {
 				rockchip,pins =
-					<3 14 RK_FUNC_2 &pcfg_pull_up>,
-					<3 15 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PB6 RK_FUNC_2 &pcfg_pull_up>,
+					<3 RK_PB7 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			uart3_cts: uart3-cts {
 				rockchip,pins =
-					<3 18 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			uart3_rts: uart3-rts {
 				rockchip,pins =
-					<3 19 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PC3 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart4 {
 			uart4_xfer: uart4-xfer {
 				rockchip,pins =
-					<1 7 RK_FUNC_1 &pcfg_pull_up>,
-					<1 8 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PA7 RK_FUNC_1 &pcfg_pull_up>,
+					<1 RK_PB0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uarthdcp {
 			uarthdcp_xfer: uarthdcp-xfer {
 				rockchip,pins =
-					<4 21 RK_FUNC_2 &pcfg_pull_up>,
-					<4 22 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC5 RK_FUNC_2 &pcfg_pull_up>,
+					<4 RK_PC6 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
-- 
1.9.1

