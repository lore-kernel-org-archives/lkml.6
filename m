Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A10C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6182081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy9o5RPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6182081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeKCDqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeKCDqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2E32081B;
        Fri,  2 Nov 2018 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183913;
        bh=9nouJqm2F6j4tFg/6L3Wb4DgahgaL8BHXhdEIVFza1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cy9o5RPARfNQvObkwgZ9AskxcvHCaWx7B9LrnRuMTc3A7jSBUsrH5FjQXY+JbcaCN
         9EjcmYY0vBo/dNBsl4uYVWKTozJYHG3PtUqbIZ5UUtb/Yn6LvlcvaUKRTv3dWMf0En
         +CE966opzjTY65kNABcknbp8HaJebiutBvRAJgdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 019/150] ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
Date:   Fri,  2 Nov 2018 19:33:01 +0100
Message-Id: <20181102182904.310592773@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3ab97942d0213b6583a5408630a8cbbfbf54730f ]

A number of our interrupts were incorrectly specified, fix both the PPI
and SPI interrupts to be correct.

Fixes: b5762cacc411 ("ARM: bcm63138: add NAND DT support")
Fixes: 46d4bca0445a ("ARM: BCM63XX: add BCM63138 minimal Device Tree")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm63138.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index 43ee992ccdcf..6df61518776f 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -106,21 +106,23 @@
 		global_timer: timer@1e200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x1e200 0x20>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&axi_clk>;
 		};
 
 		local_timer: local-timer@1e600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x1e600 0x20>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&axi_clk>;
 		};
 
 		twd_watchdog: watchdog@1e620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x1e620 0x20>;
-			interrupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		armpll: armpll {
@@ -158,7 +160,7 @@
 		serial0: serial@600 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x600 0x1b>;
-			interrupts = <GIC_SPI 32 0>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -167,7 +169,7 @@
 		serial1: serial@620 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x620 0x1b>;
-			interrupts = <GIC_SPI 33 0>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -180,7 +182,7 @@
 			reg = <0x2000 0x600>, <0xf0 0x10>;
 			reg-names = "nand", "nand-int-base";
 			status = "disabled";
-			interrupts = <GIC_SPI 38 0>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nand";
 		};
 
-- 
2.17.1



