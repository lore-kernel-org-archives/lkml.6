Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeEKC2S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:28:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37437 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752040AbeEKC2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:28:04 -0400
X-ME-Sender: <xms:s__0Wktuuwqm2NXnWPg49ieaUFFHWHw86G1HsMc4qW7Sit17LG9mIg>
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] arm64: dts: allwinner: a64: Enable A64 timer workaround
Date: Thu, 10 May 2018 21:27:51 -0500
Message-Id: <20180511022751.9096-3-samuel@sholland.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180511022751.9096-1-samuel@sholland.org>
References: <20180511022751.9096-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As instability in the architectural timer has been observed on multiple
devices using this SoC, inluding the Pine64 and the Orange Pi Win,
enable the workaround in the SoC's device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..5202b76e9684 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -152,6 +152,7 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
+		allwinner,sun50i-a64-unstable-timer;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14
-- 
2.16.1
