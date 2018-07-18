Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41527ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE9D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="emCvHQCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE9D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeGRPbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:31:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44806 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbeGRPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:31:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so4352224ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YNwEiPeQenBIgkIJAPqjnPKnLqfn+L84QfxxEQxGdBQ=;
        b=emCvHQCrL0Pm664V0uex/LWhlfr/oYtpu09VsEAb9erTLcZf7OKsrb3ThNpHvOC0Ei
         ZajWEpLw9VyVsjvBRmSW1nE0kw3XrYUJs3CMb86pfVN3+Z5oKEu427Id+if0TtefILKn
         jvdbL40Gi1MWsQkFY5Ht2i0RdRxAeh+sO8A9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YNwEiPeQenBIgkIJAPqjnPKnLqfn+L84QfxxEQxGdBQ=;
        b=tuselX9CT2UBsKtgjV+8TpQ2lLjdGkEn5nlNsstGUnJbUXD0IDqomfoELWWoOxFDcF
         h8qIkFB+ODhrlRSseryzoxMSkoKibuiPeuFs4XtWrZWuMpiOj8SsZvFCtRgxz+n58EQ0
         2loJ6LyLekPL2v6LGAyd6xHOOz5OA39J1PvL7fJzG8sUBleNuX9Kc4vgljvjJAIPIarB
         1tk+WRb2k8lfEM5bEFXJlQ6kTygHnW8cJtnNyYT42Wk/Zbr4KLW/D3dPykVzf9oDEn58
         74wcMYAlKCGz3ITYDA59x0WpDKAfLfpdaTFHe6y0bq2Ldxi992kdzPC+ZPREd+pzrSMs
         eLJw==
X-Gm-Message-State: AOUpUlEscNrOZcCEZGCAdCJGOM1qaEtfNeSwKQSPusbaSxJimsltOSUu
        8IlfOp3aNdvpW99U4J1kDf9EkQ==
X-Google-Smtp-Source: AAOMgpeiuLnk5Wl8zhUgkOndvUVkO98uh69wRRZkU3HPUoFeow41DqBAN3Hj+ZV6U7jmoO26WuevUQ==
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr5233947ljj.52.1531925600639;
        Wed, 18 Jul 2018 07:53:20 -0700 (PDT)
Received: from localhost.localdomain ([90.228.168.81])
        by smtp.gmail.com with ESMTPSA id l141-v6sm575727lfg.55.2018.07.18.07.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 07:53:20 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: msm8916: drop legacy suffix for clocks used by MSM DRM driver
Date:   Wed, 18 Jul 2018 16:52:57 +0200
Message-Id: <20180718145258.15254-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop legacy suffix for clocks used by MSM DRM driver.
Fixes the following warnings:

msm_dsi_phy 1a98300.dsi-phy: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm 1a00000.mdss: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm 1a00000.mdss: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
msm 1a00000.mdss: Using legacy clk name binding.  Use "vsync" instead of "vsync_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "core" instead of "core_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "vsync" instead of "vsync_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "mdp_core" instead of "mdp_core_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "byte" instead of "byte_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "pixel" instead of "pixel_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "core" instead of "core_clk"

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c2625d15a8c0..7b32b8990d62 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -858,9 +858,9 @@
 			clocks = <&gcc GCC_MDSS_AHB_CLK>,
 				 <&gcc GCC_MDSS_AXI_CLK>,
 				 <&gcc GCC_MDSS_VSYNC_CLK>;
-			clock-names = "iface_clk",
-				      "bus_clk",
-				      "vsync_clk";
+			clock-names = "iface",
+				      "bus",
+				      "vsync";
 
 			interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -883,10 +883,10 @@
 					 <&gcc GCC_MDSS_AXI_CLK>,
 					 <&gcc GCC_MDSS_MDP_CLK>,
 					 <&gcc GCC_MDSS_VSYNC_CLK>;
-				clock-names = "iface_clk",
-					      "bus_clk",
-					      "core_clk",
-					      "vsync_clk";
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "vsync";
 
 				iommus = <&apps_iommu 4>;
 
@@ -922,12 +922,12 @@
 					 <&gcc GCC_MDSS_BYTE0_CLK>,
 					 <&gcc GCC_MDSS_PCLK0_CLK>,
 					 <&gcc GCC_MDSS_ESC0_CLK>;
-				clock-names = "mdp_core_clk",
-					      "iface_clk",
-					      "bus_clk",
-					      "byte_clk",
-					      "pixel_clk",
-					      "core_clk";
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core";
 				phys = <&dsi_phy0>;
 				phy-names = "dsi-phy";
 
@@ -963,7 +963,7 @@
 				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_MDSS_AHB_CLK>;
-				clock-names = "iface_clk";
+				clock-names = "iface";
 			};
 		};
 
-- 
2.17.1

