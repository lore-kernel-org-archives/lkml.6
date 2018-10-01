Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB5C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F802089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz9Z1MsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F802089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeJAM6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbeJAM6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:58:47 -0400
Received: from localhost.localdomain (unknown [106.201.51.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C382089D;
        Mon,  1 Oct 2018 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538374959;
        bh=9v1AD4P5KLBMF6U5MWTm6l4XnTzBG0TDScCNGozdsXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cz9Z1MsLM9E4QNf3wV2y/KT3TNaDKtQMdkUIE7JQJn7ZkhlWy70wTOD+y2CPzMR05
         koAsmfS/hyDiTek5UVISrQbHGssSdGThvyGPeR28tqfM7gbWhBQoAq8z953BFuuZRu
         lgBKTCnlSo7dq5TjsW4Asic1QV1yKzs9cUCQe4Q4=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v6 1/2] arm64: dts: msm8996: add prng-ee node
Date:   Mon,  1 Oct 2018 11:51:50 +0530
Message-Id: <20181001062151.27607-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181001062151.27607-1-vkoul@kernel.org>
References: <20181001062151.27607-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RNG hardware in 8996 features (Execution Environment) EE for
HLOS to use, add the node for prng-ee for msm8996.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cd3865e7a270..40e52a43f670 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -729,6 +729,13 @@
 			};
 		};
 
+		rng: rng@83000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x00083000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
 		mmcc: clock-controller@8c0000 {
 			compatible = "qcom,mmcc-msm8996";
 			#clock-cells = <1>;
-- 
2.14.4

