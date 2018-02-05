Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeBEOrX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:47:23 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35308 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeBEOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:46:56 -0500
X-Google-Smtp-Source: AH8x227ND5AgdArL4lIY7qjyi5pgmiBQDTxWjmqZqZYZEuy1Ln1X4QsBMiTH7+JkODeuuNqJU06mDQ==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: andy.gross@linaro.org
Cc: bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: msm8916: Probe the APCS mailbox driver
Date: Mon,  5 Feb 2018 16:46:49 +0200
Message-Id: <20180205144651.5934-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205144651.5934-1-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APCS block was exposed until now as a syscon, but now we have a
proper driver for this block. Add the compatible string of the new
driver to probe and register the mailbox functionality.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d3592b19cfc9..5414f53a0fa1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -332,9 +332,10 @@
 			#clock-cells = <0>;
 		};
 
-		apcs: syscon@b011000 {
-			compatible = "syscon";
-			reg = <0x0b011000 0x1000>;
+		apcs: mailbox@b011000 {
+			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
+			reg = <0xb011000 0x1000>;
+			#mbox-cells = <1>;
 		};
 
 		blsp1_uart2: serial@78b0000 {
