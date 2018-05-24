Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969968AbeEXWba (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:31:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38883 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966128AbeEXWb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:31:26 -0400
X-Google-Smtp-Source: AB8JxZpSxiQXdlQEyuXaAdyDRPtwDJ/mxZdzK+PMOrmwa4gRCcjfy6Q6Eu/6gk0BNOcqNXz76kkV7Q==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS
Date: Thu, 24 May 2018 15:31:22 -0700
Message-Id: <20180524223122.12601-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS host controller occationally (20%) fails to enable
gcc_ufs_axi_clk because the UFS GDSC is not enabled. In most cases it's
enabled through the UFS phy driver, but to make sure it's enabled let's
enable it directly from the UFS host controller directly as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 380e14591686..03c7904bda14 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -674,6 +674,8 @@
 			vccq-max-microamp = <450000>;
 			vccq2-max-microamp = <450000>;
 
+			power-domains = <&gcc UFS_GDSC>;
+
 			clock-names =
 				"core_clk_src",
 				"core_clk",
-- 
2.17.0
