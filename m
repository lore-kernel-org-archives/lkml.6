Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E489C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F920817
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Pxf+1fBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60F920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeK1Nnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:43:55 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:26884 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeK1Nnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:43:55 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAS2h2Nc017200;
        Wed, 28 Nov 2018 11:43:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAS2h2Nc017200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543372982;
        bh=MLm54/hlBwHayBrPJEK83yP0Kov80dckgzbn1AG5asY=;
        h=From:To:Cc:Subject:Date:From;
        b=Pxf+1fBQje6J+ykRwUr++jGxsVllVZUd1n+K/JC/sBt260pBkHqQ7rkLGx0oqon3Y
         BNujwZ6Y8bxaFybaXPqpG9Kn55n7LN+OGyxkihbnKrAfqtcKJ4laUromGi2EChn4Ou
         4DEjXwPUKmuOeaekoNKYIZ76DNor2DhWktUySWrIW75ZRxzSx4SjIPA0W4AjCS5gew
         Q6hijxdq8sIdtjbIk8nt7bh1P8rHvEwVg95n766s9ZdsM7AVvP0/v22fLkYKZr5+7u
         1Pc414swK66bBPIUE0Y9iZoDOY7VmV7mZOYlsDVD63epto9pEVU+6uVQzn5130V+Yn
         LgrJl94w6c93g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ARM: dts: uniphier: add MIO DMAC nodes
Date:   Wed, 28 Nov 2018 11:42:30 +0900
Message-Id: <1543372950-16122-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIO-DMAC (Media IO DMA Controller) nodes, and use them as
the DMA engine of SD/eMMC controllers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 14 ++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index b73d594..c2706ce 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -235,6 +235,16 @@
 			};
 		};
 
+		dmac: dma-controller@5a000000 {
+			compatible = "socionext,uniphier-mio-dmac";
+			reg = <0x5a000000 0x1000>;
+			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+				     <0 71 4>, <0 72 4>, <0 73 4>;
+			clocks = <&mio_clk 7>;
+			resets = <&mio_rst 7>;
+			#dma-cells = <1>;
+		};
+
 		sd: sdhc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
@@ -246,6 +256,8 @@
 			clocks = <&mio_clk 0>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 0>, <&mio_rst 3>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 4>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 			sd-uhs-sdr12;
@@ -263,6 +275,8 @@
 			clocks = <&mio_clk 1>;
 			reset-names = "host", "bridge", "hw";
 			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 6>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			cap-mmc-hw-reset;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 0beb606..97d051e 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -269,6 +269,16 @@
 			};
 		};
 
+		dmac: dma-controller@5a000000 {
+			compatible = "socionext,uniphier-mio-dmac";
+			reg = <0x5a000000 0x1000>;
+			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+				     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+			clocks = <&mio_clk 7>;
+			resets = <&mio_rst 7>;
+			#dma-cells = <1>;
+		};
+
 		sd: sdhc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
@@ -280,6 +290,8 @@
 			clocks = <&mio_clk 0>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 0>, <&mio_rst 3>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 4>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 			sd-uhs-sdr12;
@@ -297,6 +309,8 @@
 			clocks = <&mio_clk 1>;
 			reset-names = "host", "bridge", "hw";
 			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 5>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			cap-mmc-hw-reset;
@@ -313,6 +327,8 @@
 			clocks = <&mio_clk 2>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 2>, <&mio_rst 5>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 6>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 		};
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index f7fcf6b..efce027 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -239,6 +239,16 @@
 			};
 		};
 
+		dmac: dma-controller@5a000000 {
+			compatible = "socionext,uniphier-mio-dmac";
+			reg = <0x5a000000 0x1000>;
+			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+				     <0 71 4>, <0 72 4>, <0 73 4>;
+			clocks = <&mio_clk 7>;
+			resets = <&mio_rst 7>;
+			#dma-cells = <1>;
+		};
+
 		sd: sdhc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
@@ -250,6 +260,8 @@
 			clocks = <&mio_clk 0>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 0>, <&mio_rst 3>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 4>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 			sd-uhs-sdr12;
@@ -267,6 +279,8 @@
 			clocks = <&mio_clk 1>;
 			reset-names = "host", "bridge", "hw";
 			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 6>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			cap-mmc-hw-reset;
-- 
2.7.4

