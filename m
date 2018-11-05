Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50290C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166AD2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiLK4Iwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166AD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbeKFBGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbeKFBGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:06:49 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E12C20866;
        Mon,  5 Nov 2018 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541432791;
        bh=e9P7ZvPfWZWzJxQgAhYCEvjFOpApL/bMk5kOs/ywmoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiLK4IwzHbzey5Bp1nfQTzirJh+vPV2qIIpryFCymhvXUjbBIV86lbvL7vQEO46ZW
         VDaOO0Be9l0b6AMvRF+WjrrN+iPUT6oz71hYaBAvTika/MyGXFLCt+LNLqnZcYPggR
         3A1TOGF1FQrKJTYTou2T0jaWtvNFjuM0iaV0xRlQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 06/17] arm64: dts: qcom: qcs404: Add TLMM pinctrl node
Date:   Mon,  5 Nov 2018 21:15:18 +0530
Message-Id: <20181105154529.7614-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181105154529.7614-1-vkoul@kernel.org>
References: <20181105154529.7614-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the QCS404 TLMM pinctrl node with its three tiles.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index c87b0440584a..58afdd83e7a9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -256,6 +256,20 @@
 			reg = <0xb011000 0x1000>;
 			#mbox-cells = <1>;
 		};
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,qcs404-pinctrl";
+			reg = <0x01000000 0x200000>,
+			      <0x01300000 0x200000>,
+			      <0x07b00000 0x200000>;
+			reg-names = "south", "north", "east";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&tlmm 0 0 120>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	smp2p-adsp {
-- 
2.14.4

