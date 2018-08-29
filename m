Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA87C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466420850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6466420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeH2HM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:12:56 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:33294 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2HMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:12:55 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.239])
        by regular1.263xmail.com (Postfix) with ESMTP id 49246318;
        Wed, 29 Aug 2018 11:17:34 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id D4B5E39E;
        Wed, 29 Aug 2018 11:17:31 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <418e81eb8d494ed68a8d9afc045f75bc>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 29251CUC6IL;
        Wed, 29 Aug 2018 11:17:33 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: perfection vop property define for px30
Date:   Wed, 29 Aug 2018 11:17:13 +0800
Message-Id: <1535512642-81253-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add display ports for display-subsystem and add reset property
for vop node, if missing this two define, drm driver can't
probe sucess.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index dc3b22c..b2f1716 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -157,6 +157,7 @@
 
 	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
+		ports = <&vopb_out>, <&vopl_out>;
 		status = "disabled";
 	};
 
@@ -795,10 +796,16 @@
 		clocks = <&cru ACLK_VOPB>, <&cru DCLK_VOPB>,
 			 <&cru HCLK_VOPB>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_VOPB_A>, <&cru SRST_VOPB_H>, <&cru SRST_VOPB>;
+		reset-names = "axi", "ahb", "dclk";
 		iommus = <&vopb_mmu>;
 		power-domains = <&power PX30_PD_VO>;
 		rockchip,grf = <&grf>;
 		status = "disabled";
+		vopb_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	vopb_mmu: iommu@ff460f00 {
@@ -820,10 +827,16 @@
 		clocks = <&cru ACLK_VOPL>, <&cru DCLK_VOPL>,
 			 <&cru HCLK_VOPL>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_VOPL_A>, <&cru SRST_VOPL_H>, <&cru SRST_VOPL>;
+		reset-names = "axi", "ahb", "dclk";
 		iommus = <&vopl_mmu>;
 		power-domains = <&power PX30_PD_VO>;
 		rockchip,grf = <&grf>;
 		status = "disabled";
+		vopl_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	vopl_mmu: iommu@ff470f00 {
-- 
2.7.4


