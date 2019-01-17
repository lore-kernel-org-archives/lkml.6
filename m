Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78864C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE2C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="vOzN5hvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfAQAde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:33:34 -0500
Received: from onstation.org ([52.200.56.107]:54506 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfAQAdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:31 -0500
Received: from localhost.localdomain (mobile-166-171-186-103.mycingular.net [166.171.186.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id BE59F1A54;
        Thu, 17 Jan 2019 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547685210;
        bh=euCMaGl1yOZENuwWraDWToBqc4JG/0vv/3/pgCkqOKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOzN5hvGCkYpTTucERLGXlYpGT5qCC8iS8biyjqV11u+SIH8PgjNHuG7a2ALfXyOu
         Dzjykqqz3ceZbc852ELwE/7kuFO6TowoGTMkwdsiUmsq503PCswE1XiQfzObndENSP
         Snw5t86R0Y7VAk6sM3vgXHF1yXzXdPSt8gZ9GWy8=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 12/14] arm64: dts: qcom: pmi8994: add interrupt controller properties
Date:   Wed, 16 Jan 2019 19:32:32 -0500
Message-Id: <20190117003234.22127-13-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117003234.22127-1-masneyb@onstation.org>
References: <20190117003234.22127-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller properties now that spmi-gpio is a proper
hierarchical IRQ chip. The interrupts property is no longer needed so
remove it.

This change was not tested on any hardware but the same change was
tested on qcom-pm8941.dtsi using a LG Nexus 5 (hammerhead) phone with
no issues.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v4:
- None

Patch introduced in v4.

 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index dae1cdc23f54..3aee10e3f921 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -15,16 +15,8 @@
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <2 0xc0 0 IRQ_TYPE_NONE>,
-				     <2 0xc1 0 IRQ_TYPE_NONE>,
-				     <2 0xc2 0 IRQ_TYPE_NONE>,
-				     <2 0xc3 0 IRQ_TYPE_NONE>,
-				     <2 0xc4 0 IRQ_TYPE_NONE>,
-				     <2 0xc5 0 IRQ_TYPE_NONE>,
-				     <2 0xc6 0 IRQ_TYPE_NONE>,
-				     <2 0xc7 0 IRQ_TYPE_NONE>,
-				     <2 0xc8 0 IRQ_TYPE_NONE>,
-				     <2 0xc9 0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
-- 
2.17.2

