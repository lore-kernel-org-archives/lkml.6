Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A402220834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A402220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeLCLhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:37:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14915 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbeLCLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:37:15 -0500
X-UUID: 5597227dba774bf7b7ee081506a8b3e2-20181203
X-UUID: 5597227dba774bf7b7ee081506a8b3e2-20181203
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 287662571; Mon, 03 Dec 2018 19:36:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:28 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 19:36:28 +0800
From:   YT Shen <yt.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH 5/8] arm64: dts: add pwm nodes for MT2712
Date:   Mon, 3 Dec 2018 19:35:59 +0800
Message-ID: <1543836962-18293-6-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 4843376..e9856fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -418,6 +418,34 @@
 		status = "disabled";
 	};
 
+	pwm: pwm@11006000 {
+		compatible = "mediatek,mt2712-pwm";
+		reg = <0 0x11006000 0 0x1000>;
+		#pwm-cells = <2>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_PWM_SEL>,
+			 <&pericfg CLK_PERI_PWM>,
+			 <&pericfg CLK_PERI_PWM0>,
+			 <&pericfg CLK_PERI_PWM1>,
+			 <&pericfg CLK_PERI_PWM2>,
+			 <&pericfg CLK_PERI_PWM3>,
+			 <&pericfg CLK_PERI_PWM4>,
+			 <&pericfg CLK_PERI_PWM5>,
+			 <&pericfg CLK_PERI_PWM6>,
+			 <&pericfg CLK_PERI_PWM7>;
+		clock-names = "top",
+			      "main",
+			      "pwm1",
+			      "pwm2",
+			      "pwm3",
+			      "pwm4",
+			      "pwm5",
+			      "pwm6",
+			      "pwm7",
+			      "pwm8";
+		status = "disabled";
+	};
+
 	i2c0: i2c@11007000 {
 		compatible = "mediatek,mt2712-i2c";
 		reg = <0 0x11007000 0 0x90>,
-- 
1.9.1

