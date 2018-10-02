Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3AC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B982089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yW/0Fuy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B982089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJCFqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:46:30 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29590 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJCFqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:46:30 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w92N00jd014310;
        Wed, 3 Oct 2018 08:00:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w92N00jd014310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538521202;
        bh=/uUAllClpFBg8ySGkr2z93ad3NIJtZ2VLjZ7KrQ2hB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yW/0Fuy/gCf12qVIszVTxdrVeTypHrX9cVqe1MXU22k/OT0Qlw/dfitKOE8KwiBhu
         AGsOWIq8G3xGM7kbINynymYI2a+vpyhUzNrCqPazna76L6zz5scHAFlpmv3QUWqpda
         QmyfeUcNVe+R1xoAHLVRVr0omiB+Y80Tp6tMYe/Rl4yhEFswaZs9xdUIMwCQfbsemX
         Bp7z9j7Z/A39QZHwa+0C4Ut2vKPg7/vin0Xe86Dt75iX5dMwLViGo44CXUES7bhUTQ
         atAfelyoSTg76JWjVf+vPr2LbFz0dABAa7vFcBP1Jb2SnZVOAkvqr9zaNgfSQl5cpS
         26LRsbjtBgXIA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm64: dts: uniphier: add SD controller nodes
Date:   Wed,  3 Oct 2018 07:59:51 +0900
Message-Id: <1538521191-16333-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD controller nodes for LD20 and PXs3.
LD20 does not support the UHS mode, while PXs3 supports it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 14 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |  4 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 6932cef..ee92605 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -528,6 +528,20 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
+		sd: sdhc@5a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a400000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
 		soc_glue: soc-glue@5f800000 {
 			compatible = "socionext,uniphier-ld20-soc-glue",
 				     "simple-mfd", "syscon";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index c1bb607..1ad149c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -75,6 +75,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &eth0 {
 	status = "okay";
 	phy-handle = <&ethphy0>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index fd2bcd4..f3f19f5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -341,6 +341,24 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
+		sd: sdhc@5a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a400000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
 		soc_glue: soc-glue@5f800000 {
 			compatible = "socionext,uniphier-pxs3-soc-glue",
 				     "simple-mfd", "syscon";
-- 
2.7.4

