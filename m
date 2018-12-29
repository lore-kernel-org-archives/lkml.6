Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2253DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CE4218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Q6Jb9bx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeL2LsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:48:19 -0500
Received: from onstation.org ([52.200.56.107]:46202 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeL2LsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:48:05 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 7DBC357D;
        Sat, 29 Dec 2018 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546084085;
        bh=ewszpKzAvLMSVzChNh9BPOU1W88KAmQyRXQCrk+uOyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6Jb9bx+kBB/r3GFINIMdmFuHaFhYGkX5aFYZmZ8/zVl4B5tSgiZ7lK93XP2RnMXA
         SzTEidrYChlfoszPHBR556w9j/IXT6/YyuT0ca3HYJnK1ftCirnTz5Q6s8Ssmh7+SZ
         LD/GoI0mOxUqqfj2jN5S9KNLQ4NnyVqitVu4BEcA=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: qcom: msm8974: add interrupt properties
Date:   Sat, 29 Dec 2018 06:47:55 -0500
Message-Id: <20181229114755.8711-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181229114755.8711-1-masneyb@onstation.org>
References: <20181229114755.8711-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt properties now that spmi-gpio is a proper hierarchical IRQ
chip.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 9a91b758f7aa..d0b7f0eff288 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -65,6 +65,9 @@
 			gpio-controller;
 			gpio-ranges = <&pm8941_gpios 0 0 36>;
 			#gpio-cells = <2>;
+			interrupt-parent = <&spmi_bus>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
 				     <0 0xc1 0 IRQ_TYPE_NONE>,
 				     <0 0xc2 0 IRQ_TYPE_NONE>,
-- 
2.17.2

