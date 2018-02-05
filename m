Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeBEOrL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:47:11 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44831 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeBEOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:46:57 -0500
X-Google-Smtp-Source: AH8x226UJYJtub5qdLybLfzWb0UHYL0aae/cQ5GT8qGHLSUyxu16y01IMQYkyr86hKRkQ70AIkSW5A==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: andy.gross@linaro.org
Cc: bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: msm8916: Add clock properties to the APCS node
Date: Mon,  5 Feb 2018 16:46:50 +0200
Message-Id: <20180205144651.5934-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205144651.5934-1-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are clock controller registers in the APCS block, which purpose
is to control the main CPU mux and divider. Add the clock properties as
part of the APCS device-tree node.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5414f53a0fa1..4539571a36b2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -336,6 +336,8 @@
 			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0xb011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&a53pll>;
+			#clock-cells = <0>;
 		};
 
 		blsp1_uart2: serial@78b0000 {
