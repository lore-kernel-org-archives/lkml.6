Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1FAC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5FD21907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="mNmi4I9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfBHCRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:38 -0500
Received: from onstation.org ([52.200.56.107]:34976 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfBHCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:54 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5C614DAE;
        Fri,  8 Feb 2019 02:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592213;
        bh=vRg9BVlwOM/fP07s/D9mrGqHSN0B9o4k4F4kLjgTcGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNmi4I9e+z6bOV8FTG/zqzoqCMtZbjLpp80txU8rEL/zM97PyDbPQr1cem9ipr/TC
         mDwJgylj6K7W/9GBOfS6inT5545LJoKgDRfvgHd3gOFQ8HOlx4s62yuk4gjd2xJ5QQ
         VjLFTGrZw7VdXghlJZ/KlSYyPSrVagZlpmJfLSe8=
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
Subject: [PATCH v2 08/11] arm: dts: qcom: msm8660: add interrupt controller properties
Date:   Thu,  7 Feb 2019 21:16:28 -0500
Message-Id: <20190208021631.30252-9-masneyb@onstation.org>
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

This change was tested on an APQ8060 DragonBoard.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since v1:
- None

 arch/arm/boot/dts/qcom-msm8660.dtsi | 47 ++---------------------------
 1 file changed, 2 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 993107ed1476..65a994f0e09b 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -292,51 +292,8 @@
 					compatible = "qcom,pm8058-gpio",
 						     "qcom,ssbi-gpio";
 					reg = <0x150>;
-					interrupt-parent = <&pm8058>;
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

