Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162665AbeE1Kjh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162648AbeE1Kjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:39:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilia Lin <ilialin@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 297/329] arm64: dts: qcom: Fix SPI5 config on MSM8996
Date: Mon, 28 May 2018 12:03:46 +0200
Message-Id: <20180528100306.150234257@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilia Lin <ilialin@codeaurora.org>

[ Upstream commit e723795c702b52cfceb3bb3faa63059eb4658313 ]

Set correct clocks and interrupt values.
Fixes the incorrect SPI master configuration. This is
mandatory to make the SPI5 interface functional.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -326,8 +326,8 @@
 		blsp2_spi5: spi@075ba000{
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x075ba000 0x600>;
-			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP2_QUP5_SPI_APPS_CLK>,
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			pinctrl-names = "default", "sleep";
