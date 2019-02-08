Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B14C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BB521907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="FgcTKjny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBHCRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:23 -0500
Received: from onstation.org ([52.200.56.107]:35010 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfBHCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:54 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A1BE0DAD;
        Fri,  8 Feb 2019 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592213;
        bh=iEW/o0Ppnsu7trh8tZMBEV37IYgFHJDHBMcusouE5W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgcTKjnyNnkfsN/II/0GxspY4JySNrSXKYhnV1yIINciyh0sJMu732oJ1vvIfRaHZ
         BJahIftx8BBHKYysCmqPdXBlpaQpPs/c97at6yoC8YUKjYzpe4Nm7hcoDlKZLi6HdF
         94JVdnPkaZEZi79k6hQ7eTvQ69YiXJRPpOtVYTz8=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 07/11] arm: dts: qcom: apq8064: add interrupt controller properties
Date:   Thu,  7 Feb 2019 21:16:27 -0500
Message-Id: <20190208021631.30252-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller properties now that ssbi-gpio is a proper
hierarchical IRQ chip. The interrupts property is no longer needed so
remove it.

This change was not tested on any hardware but the same change was
tested on an APQ8060 DragonBoard with no issues.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- None

 arch/arm/boot/dts/qcom-apq8064.dtsi | 46 ++---------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1374c2e52c20..bd6907db615b 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -711,50 +711,8 @@
 					compatible = "qcom,pm8921-gpio",
 						     "qcom,ssbi-gpio";
 					reg = <0x150>;
-					interrupts = <192 IRQ_TYPE_NONE>,
-						     <193 IRQ_TYPE_NONE>,
-						     <194 IRQ_TYPE_NONE>,
-						     <195 IRQ_TYPE_NONE>,
-						     <196 IRQ_TYPE_NONE>,
-						     <197 IRQ_TYPE_NONE>,
-						     <198 IRQ_TYPE_NONE>,
-						     <199 IRQ_TYPE_NONE>,
-						     <200 IRQ_TYPE_NONE>,
-						     <201 IRQ_TYPE_NONE>,
-						     <202 IRQ_TYPE_NONE>,
-						     <203 IRQ_TYPE_NONE>,
-						     <204 IRQ_TYPE_NONE>,
-						     <205 IRQ_TYPE_NONE>,
-						     <206 IRQ_TYPE_NONE>,
-						     <207 IRQ_TYPE_NONE>,
-						     <208 IRQ_TYPE_NONE>,
-						     <209 IRQ_TYPE_NONE>,
-						     <210 IRQ_TYPE_NONE>,
-						     <211 IRQ_TYPE_NONE>,
-						     <212 IRQ_TYPE_NONE>,
-						     <213 IRQ_TYPE_NONE>,
-						     <214 IRQ_TYPE_NONE>,
-						     <215 IRQ_TYPE_NONE>,
-						     <216 IRQ_TYPE_NONE>,
-						     <217 IRQ_TYPE_NONE>,
-						     <218 IRQ_TYPE_NONE>,
-						     <219 IRQ_TYPE_NONE>,
-						     <220 IRQ_TYPE_NONE>,
-						     <221 IRQ_TYPE_NONE>,
-						     <222 IRQ_TYPE_NONE>,
-						     <223 IRQ_TYPE_NONE>,
-						     <224 IRQ_TYPE_NONE>,
-						     <225 IRQ_TYPE_NONE>,
-						     <226 IRQ_TYPE_NONE>,
-						     <227 IRQ_TYPE_NONE>,
-						     <228 IRQ_TYPE_NONE>,
-						     <229 IRQ_TYPE_NONE>,
-						     <230 IRQ_TYPE_NONE>,
-						     <231 IRQ_TYPE_NONE>,
-						     <232 IRQ_TYPE_NONE>,
-						     <233 IRQ_TYPE_NONE>,
-						     <234 IRQ_TYPE_NONE>,
-						     <235 IRQ_TYPE_NONE>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
 					gpio-controller;
 					#gpio-cells = <2>;
 
-- 
2.17.2

