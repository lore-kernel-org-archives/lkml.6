Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802AB2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvO67HdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBEA4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:56:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43269 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfBEA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:56:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so738372plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 16:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FGbv5rGsNPLzaN+JNsoPgeQyrtnJ9Y7yowXFJtAlGJQ=;
        b=KvO67HdL4WViYqsm6AmIA7iEJbuBlwBpmCNGmhiBN6V0nZFTNwGX36aZ9p9TLr3E5S
         dC4qRbGoo3++JdkXBH8ylw1FXWczpCecWiK21yJ2qK4dk4WSMYlL2abw2rhdc7/Bbkhi
         1DmV5KWBLjPVPNSdtT8fKKY3OTigXUVOh5j1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FGbv5rGsNPLzaN+JNsoPgeQyrtnJ9Y7yowXFJtAlGJQ=;
        b=iY/hLRMfZqE/reqMbO/mu7OZMbve7ePD5NCTiHv911fOOLzRXGM1H7tJN4V5M7XL/3
         MXewXw6lkgEA4kHuPjxmnVucdk3wHmEgu5o5756DdKxlSuVo9J/brnVAfLxKwlkwOGNk
         J9sdSi+VWDsAbNnNMtREGsZF8hefpquoVNNdklH2VDYZqiZyq1M/3R5ojIP1IfXPhJVb
         uVQSFD/tC15cnMfEbJPIuKYmFxoOR7T9D96UOaSLdumYGWfQkHLbvSwfVjy0qFQqKDZQ
         anmADvMkBdJLJUE4mKCHMGptTEHhG8huJxLM1Exks0WrIUqp5Dv89diXJ49Kaw8BiIhh
         JW6Q==
X-Gm-Message-State: AHQUAuZNSUDuOJpAedr6RV2y4FWakq4QXjU4AuJDC03A0AwTNQ/Nn0/I
        JfCkvOSsE/yImQDu/qKkxG44uA==
X-Google-Smtp-Source: AHgI3IbOTaVKJy/Kes6hRGxl08pRKw8jhvwCZBWMplR3L8Mt1lLhf10sH7+X/H6hFr3OvxT7XhyxhA==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr2281122plb.166.1549328175463;
        Mon, 04 Feb 2019 16:56:15 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w10sm1506095pgi.81.2019.02.04.16.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 16:56:14 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Zhuowei Zhang <zhuoweizhang@yahoo.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Define iommus for USB controllers
Date:   Mon,  4 Feb 2019 16:56:08 -0800
Message-Id: <20190205005608.21556-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controllers need to be associated with their respective IOMMU
bank, so define this on the dwc3 nodes.

Also add dma-ranges to the qcom-dwc3 nodes to make the bus' DMA mask
propagate to the dwc3 controller instances.

Fixes: 4429e57567bb ("arm64: dts: sdm845: Add node for arm,mmu-500")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 05577f08d18f..1deebf797636 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1659,6 +1659,7 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			dma-ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
@@ -1687,6 +1688,7 @@
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x740 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
@@ -1701,6 +1703,7 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			dma-ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
@@ -1729,6 +1732,7 @@
 				compatible = "snps,dwc3";
 				reg = <0 0x0a800000 0 0xcd00>;
 				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x760 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_2_hsphy>, <&usb_2_ssphy>;
-- 
2.18.0

