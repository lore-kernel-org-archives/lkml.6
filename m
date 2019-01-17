Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292ED205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="janTDzK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfAQAdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:33:21 -0500
Received: from onstation.org ([52.200.56.107]:54452 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfAQAdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:20 -0500
Received: from localhost.localdomain (mobile-166-171-186-103.mycingular.net [166.171.186.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2E64B47;
        Thu, 17 Jan 2019 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547685198;
        bh=d311ggP8kJJGey6rkEiK9Nr2DC2Kumjo6srKw6P2yWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=janTDzK3RFPaXW/JzLIsBbg7ZULrhl3VGrIxgUPTsTNfAwa8UTECwvxHZ+YzSoe5P
         I7q5/e0I3VW+pv1lfKakxwcRkmiOY/zkXhyPI7eOsmFuEzk3etMClnw7VBqHhwKFag
         DgznozWmVbU7P6lWG/iaWvZNeHVX0cr0AabbzIUQ=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 08/14] ARM: dts: qcom: pm8941: add interrupt controller properties
Date:   Wed, 16 Jan 2019 19:32:28 -0500
Message-Id: <20190117003234.22127-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117003234.22127-1-masneyb@onstation.org>
References: <20190117003234.22127-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller properties now that spmi-gpio is a proper
hierarchical IRQ chip. The interrupts property is no longer needed so
remove it. Code was tested on the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v4:
- None

Changes since v3:
- None

Changes since v2:
- Remove interrupt-parent property

Changes since v1:
- Interrupts are now two cells instead of four cells.
- Drop unnecessary interrupts property.

 arch/arm/boot/dts/qcom-pm8941.dtsi | 38 ++----------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 2515c5c217ac..e65049e0fb45 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -64,42 +64,8 @@
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
-				     <0 0xc1 0 IRQ_TYPE_NONE>,
-				     <0 0xc2 0 IRQ_TYPE_NONE>,
-				     <0 0xc3 0 IRQ_TYPE_NONE>,
-				     <0 0xc4 0 IRQ_TYPE_NONE>,
-				     <0 0xc5 0 IRQ_TYPE_NONE>,
-				     <0 0xc6 0 IRQ_TYPE_NONE>,
-				     <0 0xc7 0 IRQ_TYPE_NONE>,
-				     <0 0xc8 0 IRQ_TYPE_NONE>,
-				     <0 0xc9 0 IRQ_TYPE_NONE>,
-				     <0 0xca 0 IRQ_TYPE_NONE>,
-				     <0 0xcb 0 IRQ_TYPE_NONE>,
-				     <0 0xcc 0 IRQ_TYPE_NONE>,
-				     <0 0xcd 0 IRQ_TYPE_NONE>,
-				     <0 0xce 0 IRQ_TYPE_NONE>,
-				     <0 0xcf 0 IRQ_TYPE_NONE>,
-				     <0 0xd0 0 IRQ_TYPE_NONE>,
-				     <0 0xd1 0 IRQ_TYPE_NONE>,
-				     <0 0xd2 0 IRQ_TYPE_NONE>,
-				     <0 0xd3 0 IRQ_TYPE_NONE>,
-				     <0 0xd4 0 IRQ_TYPE_NONE>,
-				     <0 0xd5 0 IRQ_TYPE_NONE>,
-				     <0 0xd6 0 IRQ_TYPE_NONE>,
-				     <0 0xd7 0 IRQ_TYPE_NONE>,
-				     <0 0xd8 0 IRQ_TYPE_NONE>,
-				     <0 0xd9 0 IRQ_TYPE_NONE>,
-				     <0 0xda 0 IRQ_TYPE_NONE>,
-				     <0 0xdb 0 IRQ_TYPE_NONE>,
-				     <0 0xdc 0 IRQ_TYPE_NONE>,
-				     <0 0xdd 0 IRQ_TYPE_NONE>,
-				     <0 0xde 0 IRQ_TYPE_NONE>,
-				     <0 0xdf 0 IRQ_TYPE_NONE>,
-				     <0 0xe0 0 IRQ_TYPE_NONE>,
-				     <0 0xe1 0 IRQ_TYPE_NONE>,
-				     <0 0xe2 0 IRQ_TYPE_NONE>,
-				     <0 0xe3 0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 
 			boost_bypass_n_pin: boost-bypass {
 				pins = "gpio21";
-- 
2.17.2

