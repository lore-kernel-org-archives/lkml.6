Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8555EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B698214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Uvj9Zusn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfAJBNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:13:23 -0500
Received: from onstation.org ([52.200.56.107]:34266 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfAJBNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:13:17 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3485F1A0;
        Thu, 10 Jan 2019 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547082796;
        bh=tsspXCSecel0zCzLg9ijWEz31jLT51UinWRg4SHdMVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uvj9ZusnWAHCglDjFl7clAteSh5ndILRFmy0cXZVx00UBVvJVC8V6xmTYaYT40xvq
         sUuhV5pr4TJawoieWRkAeUEOYJs+62eFewVy6AqlvqcQkXhwpRok6U98IblYeEBF3W
         qUHu548cl9iUSa8qfHhprL6wBKc5CEDy5E1lMUso=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 6/6] ARM: dts: qcom: pma8084: add interrupt controller properties
Date:   Wed,  9 Jan 2019 20:12:58 -0500
Message-Id: <20190110011258.17227-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190110011258.17227-1-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org>
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
---
 arch/arm/boot/dts/qcom-pma8084.dtsi | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index aac7e73b6872..8f5ea7add20f 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -32,28 +32,8 @@
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
-				     <0 0xd5 0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		pma8084_mpps: mpps@a000 {
-- 
2.17.2

