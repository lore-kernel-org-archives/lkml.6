Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt6RX3Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E178B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbeKIHja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbeKIHj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:39:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D6121486;
        Thu,  8 Nov 2018 22:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714520;
        bh=SHaZf5qieokGJmi7i14awTMCp1/Urhs+3hqYSvUjXU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vt6RX3Nw65cSvrMhDNB29C8/niNnvmmLPzDE1qyUyoybcXJnblpNmO0JAP6xmYB49
         3P2X2B+odWspp1TGTJaxDrH3Kd3E68Cl7g+x72pJoQlZ9Bri8X62N8bNxtRmOT4pDR
         X5LIhpJ0RCVE3C36T+se2ekNGDt2LdfEIlhk/lGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 010/171] ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
Date:   Thu,  8 Nov 2018 13:49:40 -0800
Message-Id: <20181108215127.991527487@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index d0560e8cd6de..547369c69e96 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -105,21 +105,23 @@
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
@@ -157,7 +159,7 @@
 		serial0: serial@600 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x600 0x1b>;
-			interrupts = <GIC_SPI 32 0>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -166,7 +168,7 @@
 		serial1: serial@620 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x620 0x1b>;
-			interrupts = <GIC_SPI 33 0>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -179,7 +181,7 @@
 			reg = <0x2000 0x600>, <0xf0 0x10>;
 			reg-names = "nand", "nand-int-base";
 			status = "disabled";
-			interrupts = <GIC_SPI 38 0>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nand";
 		};
 
-- 
2.17.1



