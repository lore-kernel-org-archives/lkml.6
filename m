Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968242AbeEYSpd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:45:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45256 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968212AbeEYSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:45:29 -0400
X-Google-Smtp-Source: AB8JxZp1cmJlH1OtXuUqrb3Dk/uY+d+8RTAG0VXw3Y6h+Blqmm02EECH0GCi+z1KX80t5lcAIrNGdg==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: msm8996: Move UFS_GDSC to UFS HCD
Date: Fri, 25 May 2018 11:45:25 -0700
Message-Id: <20180525184525.355-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524223122.12601-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS_GDSC backs the resources needed by the UFS HCD, rather than the
PHY. This results in the UFS HCD occationally failing to enable some of
its clocks.

Move the UFS_GDSC reference to the UFS HCD node instead, to correct
this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped UFS_GDSC from phy node

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 380e14591686..8c7f9ca25b53 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -654,8 +654,6 @@
 			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
 				 <&gcc GCC_UFS_CLKREF_CLK>;
 			status = "disabled";
-
-			power-domains = <&gcc UFS_GDSC>;
 		};
 
 		ufshc@624000 {
@@ -674,6 +672,8 @@
 			vccq-max-microamp = <450000>;
 			vccq2-max-microamp = <450000>;
 
+			power-domains = <&gcc UFS_GDSC>;
+
 			clock-names =
 				"core_clk_src",
 				"core_clk",
-- 
2.17.0
