Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002E208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqxu4Xo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8002E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJAM6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbeJAM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:58:52 -0400
Received: from localhost.localdomain (unknown [106.201.51.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DC52083C;
        Mon,  1 Oct 2018 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538374964;
        bh=jAzCR10EvyD88VJFFwEPBGXnBKn1UFZk6zK3N+oFbfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqxu4Xo69sUDCKvevodTNpRppLppHnHG4lT/9w/tAsURlezoFFD2XoqWgnvy2+yQx
         slDpndacnK0Kp5s8b6Z1q8Wh+XN39E84UFBPYvG4Je6JGBLWqFNHNQgMIvSK9JFSCW
         lLG5GtZxaF9j5PCwiA86AbYFC/ydHE2eojKggTvk=
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
Subject: [PATCH v6 2/2] arm64: dts: sdm845: add prng-ee node
Date:   Mon,  1 Oct 2018 11:51:51 +0530
Message-Id: <20181001062151.27607-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181001062151.27607-1-vkoul@kernel.org>
References: <20181001062151.27607-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RNG hardware in SDM845 features (Execution Environment) EE for
HLOS to use, add the node for prng-ee for sdm845.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa6a1b5..9d8109761fe8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -997,6 +998,13 @@
 			cell-index = <0>;
 		};
 
+		rng: rng@793000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x00793000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
 		apss_shared: mailbox@17990000 {
 			compatible = "qcom,sdm845-apss-shared";
 			reg = <0x17990000 0x1000>;
-- 
2.14.4

