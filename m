Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271ABC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCDD23EE5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCDD23EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeGFIEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:04:25 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:46882 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeGFIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:04:21 -0400
Received: from huibin.hong?rock-chips.com (unknown [192.168.167.208])
        by regular1.263xmail.com (Postfix) with ESMTP id 68B226202;
        Fri,  6 Jul 2018 16:04:07 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 3BF233EE;
        Fri,  6 Jul 2018 16:04:06 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: huibin.hong@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: huibin.hong@rock-chips.com
X-UNIQUE-TAG: <2f5dc75b5612b94290a2921bcb6fdceb>
X-ATTACHMENT-NUM: 0
X-SENDER: hhb@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 17628UT3YQI;
        Fri, 06 Jul 2018 16:04:08 +0800 (CST)
From:   Huibin Hong <huibin.hong@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        sugar.zhang@rock-chips.com, david.wu@rock-chips.com,
        finley.xiao@rock-chips.com, robin.murphy@arm.com,
        william.wu@rock-chips.com, rocky.hao@rock-chips.com,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Huibin Hong <huibin.hong@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: corrected uart1 clock-names for rk3328
Date:   Fri,  6 Jul 2018 16:03:57 +0800
Message-Id: <1530864237-14891-1-git-send-email-huibin.hong@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the uart clock-names or the uart driver might fail.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 2f38ff2..3f5a294 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -297,7 +297,7 @@
 		reg = <0x0 0xff120000 0x0 0x100>;
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-		clock-names = "sclk_uart", "pclk_uart";
+		clock-names = "baudclk", "apb_pclk";
 		dmas = <&dmac 4>, <&dmac 5>;
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
-- 
1.9.1


