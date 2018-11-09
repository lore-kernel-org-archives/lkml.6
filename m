Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD48C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452420883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcladGJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6452420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeKITZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKITZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:25:08 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD283208E3;
        Fri,  9 Nov 2018 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541756722;
        bh=Vmkqou79WmRLrEomv4mnMaRTiRR3SbbBm6+tMgIeaVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcladGJRfNfpJdfI1ph3beToP8xTqqOCmgH1TKhiAgcHwKvBMVo2krE4j0/xaS5Rl
         zUIknYFST6ceUrUY+W75hb7vjPSxANFqieVd5wydJZQYQe8c1k4p5mYyLaYrsV/BGP
         fAZ4SJvApMYzGuzibBDEiN8jKNcgAs/Xvi3yBox0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 12/18] arm64: dts: qcom: pms405: add gpios
Date:   Fri,  9 Nov 2018 15:14:11 +0530
Message-Id: <20181109094417.12109-13-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GPIOs present on PMS405 chip.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 2b275bbdafa3..8e5a8573430e 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -10,6 +10,25 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pms405_gpios: gpio@c000 {
+			compatible = "qcom,pms405-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
+				<0 0xc1 0 IRQ_TYPE_NONE>,
+				<0 0xc2 0 IRQ_TYPE_NONE>,
+				<0 0xc3 0 IRQ_TYPE_NONE>,
+				<0 0xc4 0 IRQ_TYPE_NONE>,
+				<0 0xc5 0 IRQ_TYPE_NONE>,
+				<0 0xc6 0 IRQ_TYPE_NONE>,
+				<0 0xc7 0 IRQ_TYPE_NONE>,
+				<0 0xc8 0 IRQ_TYPE_NONE>,
+				<0 0xc9 0 IRQ_TYPE_NONE>,
+				<0 0xca 0 IRQ_TYPE_NONE>,
+				<0 0xcb 0 IRQ_TYPE_NONE>;
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
-- 
2.14.4

