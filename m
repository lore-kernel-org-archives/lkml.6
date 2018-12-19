Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7F120811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeLSX4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:56:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42566 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbeLSXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so10163889pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXxeztkvnTPrUp8Mh5hCSNZcHtzvPvc1DezVXLHEkIU=;
        b=uW6B+qNMMeHCcAf5rvAQQCy/Yd/+w7uXHMX+ZhKMMaM9vtzCIHB8QvpDRx3G4pM0RO
         30Gi09kl+Lt1SD5PkzRMtpZGxG4euy5e3gten0QCVctgFMPrIkYGZfWKu7NjBAghQHN0
         FUu7nciEMnSE35D0cOzYn+un5RFPLmVbT6+3HFKk9l7I3Bd4c3ctMfp2pPFwDgAmjaLd
         MO7mGwBtPgJaC2FysW0l2ouXDBX1EIsPrZIvLJs/BgGmQBjNAeIj+EoAPqN0Sa2MO+ov
         hfUuqTaHS8UUQf/x/xG8g/+FdVuiKsGUHH1Yoc3TjpXYXaf2iZG1JllpjbuQlexx0VH9
         JPog==
X-Gm-Message-State: AA+aEWYFySm6kKf6TYjGWbGZ8hMpA8FWTRHJx3mVfc2HtyPdfr1rseJe
        aLK3DRyRBUWsa9wapp65MNybgg==
X-Google-Smtp-Source: AFSGD/VxMIvkKMJN20PrlNmfRQsnh87soyoztJ0soSmpfPjVKjwELaTQjCWXdKAYpnkQNJyv1EA85g==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr22188333pfb.19.1545263754440;
        Wed, 19 Dec 2018 15:55:54 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:53 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 7/8] arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
Date:   Wed, 19 Dec 2018 15:55:27 -0800
Message-Id: <20181219235528.114830-8-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181219235528.114830-1-mka@chromium.org>
References: <20181219235528.114830-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'bi_tcxo' as ref clock for the DSI PHYs, it was previously
hardcoded in the PLL 'driver' for the 10nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
based on "[v6] arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file"
  (https://patchwork.kernel.org/patch/10712827/)

Changes in v5:
- rebased on v6 of DPU DT patch

Changes in v4:
- added 'Reviewed-by: Stephen Boyd <swboyd@chromium.org>' tag

Changes in v3:
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- patch added to the series
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 3e3ffe096f18a..f278f08906d21 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1378,8 +1378,9 @@
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>;
-				clock-names = "iface";
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
 
 				status = "disabled";
 			};
@@ -1444,8 +1445,9 @@
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>;
-				clock-names = "iface";
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
 
 				status = "disabled";
 			};
-- 
2.20.1.415.g653613c723-goog

