Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2CC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA5F2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHG2enN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA5F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbeKFBHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbeKFBHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:07:18 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 541262085B;
        Mon,  5 Nov 2018 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541432819;
        bh=PLSkKy3KNdIeSHxk1cBdfroXm5WFGT3FSUIq7QQa3wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHG2enN0z5o1mlcEyOAUb4eoFBbjcrRsL2T0yZFtTszMTkMguq96KiX6pCn+slILE
         BKAiyfASEJZ0BO6p3jFK0dOV4yanj5odzgU3SIEKKNjKqfBq0LAaLQPJwqudmeonN/
         UtqffavTnzdvZT8vCLNQubOz9JFBBpMQsJpmttfQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 15/17] arm64: dts: qcom: qcs404: Add BAM DMA node
Date:   Mon,  5 Nov 2018 21:15:27 +0530
Message-Id: <20181105154529.7614-16-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181105154529.7614-1-vkoul@kernel.org>
References: <20181105154529.7614-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BAM DMA instance found in BLSP1 node of the QCS404

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a37930639b8d..88e04a0ee67f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -276,6 +276,19 @@
 			status = "okay";
 		};
 
+		blsp1_dma: dma@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x25000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,controlled-remotely = <1>;
+			qcom,ee = <0>;
+
+			status = "okay";
+		};
+
 		apcs_glb: mailbox@b011000 {
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0xb011000 0x1000>;
-- 
2.14.4

