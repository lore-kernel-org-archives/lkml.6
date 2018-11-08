Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE2ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BB420827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xt5YPTOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BB420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKIESg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbeKIESf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:18:35 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F93B20857;
        Thu,  8 Nov 2018 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541702508;
        bh=TcYFzMWMSYNZj68h+BcYZxThxJDTNRO2699e1cI79c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xt5YPTOwr/6p/NbyUT9oBemXCB0eQhFjbp4EI34n6F4bIQTZjU3mpSuEieX3SWoAQ
         GOLszsRgHnBy29/17nfRbUviPrECxp9pQOw6iJ/uDXYJW6+iLVx2/DvLbUkEtlxJnI
         cJBAZ0SdRV5ZlFcP+shfY/ehdbzEGkbh5ll3ACYk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 13/18] arm64: dts: qcom: qcs404: Add scm firmware node
Date:   Fri,  9 Nov 2018 00:10:04 +0530
Message-Id: <20181108184009.18430-14-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108184009.18430-1-vkoul@kernel.org>
References: <20181108184009.18430-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the scm firmware node to QCS404

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index df07c494c47b..373d514eb147 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,6 +62,13 @@
 		};
 	};
 
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-qcs404", "qcom,scm";
+			#reset-cells = <1>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the reg */
-- 
2.14.4

