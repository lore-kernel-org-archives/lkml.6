Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F21C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37321104
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/O5OBR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED37321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeKITZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKITZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:25:04 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F3820892;
        Fri,  9 Nov 2018 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541756718;
        bh=bA/whSOB8u+IYNU5S+5mde0Nk4XCa/UXp+l2yB1x778=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/O5OBR9EPKNJCyBtgMzH8YP1LYBjfLKfvCAp3MChsRKgQaKMzhHbk2dBQjDDas/9
         p2tQa6YZTPrDW3zb0WVhN/jL91n17+FPVRvwwikFDexEZ/MV9GuR5DGzdMzQR6inHB
         PST9fWKKZVVoZhv/woA+rekm/AsphqVGV0NKMqAg=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 10/18] arm64: dts: qcom: qcs404: add spmi node
Date:   Fri,  9 Nov 2018 15:14:09 +0530
Message-Id: <20181109094417.12109-11-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMS405 is used in QCS405-EVB so include that with SPMI nodes

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 358d6d5f7d85..db035fef67d9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -2,6 +2,7 @@
 // Copyright (c) 2018, Linaro Limited
 
 #include "qcs404.dtsi"
+#include "pms405.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 1b3e21c1fed9..0101cd5896b3 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -181,6 +181,24 @@
 			reg = <0x01905000 0x20000>;
 		};
 
+		spmi_bus: spmi@200f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0200f000 0x001000>,
+			      <0x02400000 0x800000>,
+			      <0x02c00000 0x800000>,
+			      <0x03800000 0x200000>,
+			      <0x0200a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
 		sdcc1: sdcc@7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
-- 
2.14.4

