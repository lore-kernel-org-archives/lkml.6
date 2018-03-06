Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeCFJKv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:10:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:63803 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753316AbeCFJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:10:04 -0500
X-UUID: 8831089cab69444f97d221923656bb37-20180306
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 6/6] arm: dts: mediatek: modify audio related nodes for both MT2701 and MT7623
Date: Tue, 6 Mar 2018 17:09:31 +0800
Message-ID: <a431bb8f9c203227b14845058a27d690691d0c20.1520327262.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify audio related nodes to reflect the actual usage in binding documents.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 188 ++++++++++++++++++++---------------------
 arch/arm/boot/dts/mt7623.dtsi | 190 ++++++++++++++++++++----------------------
 2 files changed, 182 insertions(+), 196 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 05557fc..05cf65c 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -426,104 +426,96 @@
 		status = "disabled";
 	};
 
-	afe: audio-controller@11220000 {
-		compatible = "mediatek,mt2701-audio";
-		reg = <0 0x11220000 0 0x2000>,
-		      <0 0x112a0000 0 0x20000>;
-		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
-			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names	= "afe", "asys";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
-
-		clocks = <&infracfg CLK_INFRA_AUDIO>,
-			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-			 <&topckgen CLK_TOP_AUD_MUX1_DIV>,
-			 <&topckgen CLK_TOP_AUD_MUX2_DIV>,
-			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
-			 <&topckgen CLK_TOP_AUD_44K_TIMING>,
-			 <&topckgen CLK_TOP_AUDPLL_MUX_SEL>,
-			 <&topckgen CLK_TOP_APLL_SEL>,
-			 <&topckgen CLK_TOP_AUD1PLL_98M>,
-			 <&topckgen CLK_TOP_AUD2PLL_90M>,
-			 <&topckgen CLK_TOP_HADDS2PLL_98M>,
-			 <&topckgen CLK_TOP_HADDS2PLL_294M>,
-			 <&topckgen CLK_TOP_AUDPLL>,
-			 <&topckgen CLK_TOP_AUDPLL_D4>,
-			 <&topckgen CLK_TOP_AUDPLL_D8>,
-			 <&topckgen CLK_TOP_AUDPLL_D16>,
-			 <&topckgen CLK_TOP_AUDPLL_D24>,
-			 <&topckgen CLK_TOP_AUDINTBUS_SEL>,
-			 <&clk26m>,
-			 <&topckgen CLK_TOP_SYSPLL1_D4>,
-			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K5_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K6_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K5_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K6_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S5_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S6_MCLK>,
-			 <&topckgen CLK_TOP_ASM_M_SEL>,
-			 <&topckgen CLK_TOP_ASM_H_SEL>,
-			 <&topckgen CLK_TOP_UNIVPLL2_D4>,
-			 <&topckgen CLK_TOP_UNIVPLL2_D2>,
-			 <&topckgen CLK_TOP_SYSPLL_D5>;
-
-		clock-names = "infra_sys_audio_clk",
-			 "top_audio_mux1_sel",
-			 "top_audio_mux2_sel",
-			 "top_audio_mux1_div",
-			 "top_audio_mux2_div",
-			 "top_audio_48k_timing",
-			 "top_audio_44k_timing",
-			 "top_audpll_mux_sel",
-			 "top_apll_sel",
-			 "top_aud1_pll_98M",
-			 "top_aud2_pll_90M",
-			 "top_hadds2_pll_98M",
-			 "top_hadds2_pll_294M",
-			 "top_audpll",
-			 "top_audpll_d4",
-			 "top_audpll_d8",
-			 "top_audpll_d16",
-			 "top_audpll_d24",
-			 "top_audintbus_sel",
-			 "clk_26m",
-			 "top_syspll1_d4",
-			 "top_aud_k1_src_sel",
-			 "top_aud_k2_src_sel",
-			 "top_aud_k3_src_sel",
-			 "top_aud_k4_src_sel",
-			 "top_aud_k5_src_sel",
-			 "top_aud_k6_src_sel",
-			 "top_aud_k1_src_div",
-			 "top_aud_k2_src_div",
-			 "top_aud_k3_src_div",
-			 "top_aud_k4_src_div",
-			 "top_aud_k5_src_div",
-			 "top_aud_k6_src_div",
-			 "top_aud_i2s1_mclk",
-			 "top_aud_i2s2_mclk",
-			 "top_aud_i2s3_mclk",
-			 "top_aud_i2s4_mclk",
-			 "top_aud_i2s5_mclk",
-			 "top_aud_i2s6_mclk",
-			 "top_asm_m_sel",
-			 "top_asm_h_sel",
-			 "top_univpll2_d4",
-			 "top_univpll2_d2",
-			 "top_syspll_d5";
+	audsys: clock-controller@11220000 {
+		compatible = "mediatek,mt2701-audsys", "syscon";
+		reg = <0 0x11220000 0 0x2000>;
+		#clock-cells = <1>;
+
+		afe: audio-controller {
+			compatible = "mediatek,mt2701-audio";
+			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names	= "afe", "asys";
+			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+
+			clocks = <&infracfg CLK_INFRA_AUDIO>,
+				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
+				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
+				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
+				 <&audsys CLK_AUD_I2SO1>,
+				 <&audsys CLK_AUD_I2SO2>,
+				 <&audsys CLK_AUD_I2SO3>,
+				 <&audsys CLK_AUD_I2SO4>,
+				 <&audsys CLK_AUD_I2SIN1>,
+				 <&audsys CLK_AUD_I2SIN2>,
+				 <&audsys CLK_AUD_I2SIN3>,
+				 <&audsys CLK_AUD_I2SIN4>,
+				 <&audsys CLK_AUD_ASRCO1>,
+				 <&audsys CLK_AUD_ASRCO2>,
+				 <&audsys CLK_AUD_ASRCO3>,
+				 <&audsys CLK_AUD_ASRCO4>,
+				 <&audsys CLK_AUD_AFE>,
+				 <&audsys CLK_AUD_AFE_CONN>,
+				 <&audsys CLK_AUD_A1SYS>,
+				 <&audsys CLK_AUD_A2SYS>,
+				 <&audsys CLK_AUD_AFE_MRGIF>;
+
+			clock-names = "infra_sys_audio_clk",
+				      "top_audio_mux1_sel",
+				      "top_audio_mux2_sel",
+				      "top_audio_a1sys_hp",
+				      "top_audio_a2sys_hp",
+				      "i2s0_src_sel",
+				      "i2s1_src_sel",
+				      "i2s2_src_sel",
+				      "i2s3_src_sel",
+				      "i2s0_src_div",
+				      "i2s1_src_div",
+				      "i2s2_src_div",
+				      "i2s3_src_div",
+				      "i2s0_mclk_en",
+				      "i2s1_mclk_en",
+				      "i2s2_mclk_en",
+				      "i2s3_mclk_en",
+				      "i2so0_hop_ck",
+				      "i2so1_hop_ck",
+				      "i2so2_hop_ck",
+				      "i2so3_hop_ck",
+				      "i2si0_hop_ck",
+				      "i2si1_hop_ck",
+				      "i2si2_hop_ck",
+				      "i2si3_hop_ck",
+				      "asrc0_out_ck",
+				      "asrc1_out_ck",
+				      "asrc2_out_ck",
+				      "asrc3_out_ck",
+				      "audio_afe_pd",
+				      "audio_afe_conn_pd",
+				      "audio_a1sys_pd",
+				      "audio_a2sys_pd",
+				      "audio_mrgif_pd";
+
+			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
+					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
+			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
+						 <&topckgen CLK_TOP_AUD2PLL_90M>;
+			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
+		};
 	};
 
 	mmsys: syscon@14000000 {
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b750da5..e4dd31d 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -538,105 +538,99 @@
 		status = "disabled";
 	};
 
-	afe: audio-controller@11220000 {
-		compatible = "mediatek,mt7623-audio",
-			     "mediatek,mt2701-audio";
-		reg = <0 0x11220000 0 0x2000>,
-		      <0 0x112a0000 0 0x20000>;
-		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
-			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names	= "afe", "asys";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+	audsys: clock-controller@11220000 {
+		compatible = "mediatek,mt7623-audsys",
+			     "mediatek,mt2701-audsys",
+			     "syscon";
+		reg = <0 0x11220000 0 0x2000>;
+		#clock-cells = <1>;
 
-		clocks = <&infracfg CLK_INFRA_AUDIO>,
-			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-			 <&topckgen CLK_TOP_AUD_MUX1_DIV>,
-			 <&topckgen CLK_TOP_AUD_MUX2_DIV>,
-			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
-			 <&topckgen CLK_TOP_AUD_44K_TIMING>,
-			 <&topckgen CLK_TOP_AUDPLL_MUX_SEL>,
-			 <&topckgen CLK_TOP_APLL_SEL>,
-			 <&topckgen CLK_TOP_AUD1PLL_98M>,
-			 <&topckgen CLK_TOP_AUD2PLL_90M>,
-			 <&topckgen CLK_TOP_HADDS2PLL_98M>,
-			 <&topckgen CLK_TOP_HADDS2PLL_294M>,
-			 <&topckgen CLK_TOP_AUDPLL>,
-			 <&topckgen CLK_TOP_AUDPLL_D4>,
-			 <&topckgen CLK_TOP_AUDPLL_D8>,
-			 <&topckgen CLK_TOP_AUDPLL_D16>,
-			 <&topckgen CLK_TOP_AUDPLL_D24>,
-			 <&topckgen CLK_TOP_AUDINTBUS_SEL>,
-			 <&clk26m>,
-			 <&topckgen CLK_TOP_SYSPLL1_D4>,
-			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K5_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K6_SRC_SEL>,
-			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K5_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_K6_SRC_DIV>,
-			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S5_MCLK>,
-			 <&topckgen CLK_TOP_AUD_I2S6_MCLK>,
-			 <&topckgen CLK_TOP_ASM_M_SEL>,
-			 <&topckgen CLK_TOP_ASM_H_SEL>,
-			 <&topckgen CLK_TOP_UNIVPLL2_D4>,
-			 <&topckgen CLK_TOP_UNIVPLL2_D2>,
-			 <&topckgen CLK_TOP_SYSPLL_D5>;
-
-		clock-names = "infra_sys_audio_clk",
-			 "top_audio_mux1_sel",
-			 "top_audio_mux2_sel",
-			 "top_audio_mux1_div",
-			 "top_audio_mux2_div",
-			 "top_audio_48k_timing",
-			 "top_audio_44k_timing",
-			 "top_audpll_mux_sel",
-			 "top_apll_sel",
-			 "top_aud1_pll_98M",
-			 "top_aud2_pll_90M",
-			 "top_hadds2_pll_98M",
-			 "top_hadds2_pll_294M",
-			 "top_audpll",
-			 "top_audpll_d4",
-			 "top_audpll_d8",
-			 "top_audpll_d16",
-			 "top_audpll_d24",
-			 "top_audintbus_sel",
-			 "clk_26m",
-			 "top_syspll1_d4",
-			 "top_aud_k1_src_sel",
-			 "top_aud_k2_src_sel",
-			 "top_aud_k3_src_sel",
-			 "top_aud_k4_src_sel",
-			 "top_aud_k5_src_sel",
-			 "top_aud_k6_src_sel",
-			 "top_aud_k1_src_div",
-			 "top_aud_k2_src_div",
-			 "top_aud_k3_src_div",
-			 "top_aud_k4_src_div",
-			 "top_aud_k5_src_div",
-			 "top_aud_k6_src_div",
-			 "top_aud_i2s1_mclk",
-			 "top_aud_i2s2_mclk",
-			 "top_aud_i2s3_mclk",
-			 "top_aud_i2s4_mclk",
-			 "top_aud_i2s5_mclk",
-			 "top_aud_i2s6_mclk",
-			 "top_asm_m_sel",
-			 "top_asm_h_sel",
-			 "top_univpll2_d4",
-			 "top_univpll2_d2",
-			 "top_syspll_d5";
+		afe: audio-controller {
+			compatible = "mediatek,mt7623-audio",
+				     "mediatek,mt2701-audio";
+			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names	= "afe", "asys";
+			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+
+			clocks = <&infracfg CLK_INFRA_AUDIO>,
+				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
+				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
+				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
+				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
+				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
+				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
+				 <&audsys CLK_AUD_I2SO1>,
+				 <&audsys CLK_AUD_I2SO2>,
+				 <&audsys CLK_AUD_I2SO3>,
+				 <&audsys CLK_AUD_I2SO4>,
+				 <&audsys CLK_AUD_I2SIN1>,
+				 <&audsys CLK_AUD_I2SIN2>,
+				 <&audsys CLK_AUD_I2SIN3>,
+				 <&audsys CLK_AUD_I2SIN4>,
+				 <&audsys CLK_AUD_ASRCO1>,
+				 <&audsys CLK_AUD_ASRCO2>,
+				 <&audsys CLK_AUD_ASRCO3>,
+				 <&audsys CLK_AUD_ASRCO4>,
+				 <&audsys CLK_AUD_AFE>,
+				 <&audsys CLK_AUD_AFE_CONN>,
+				 <&audsys CLK_AUD_A1SYS>,
+				 <&audsys CLK_AUD_A2SYS>,
+				 <&audsys CLK_AUD_AFE_MRGIF>;
+
+			clock-names = "infra_sys_audio_clk",
+				      "top_audio_mux1_sel",
+				      "top_audio_mux2_sel",
+				      "top_audio_a1sys_hp",
+				      "top_audio_a2sys_hp",
+				      "i2s0_src_sel",
+				      "i2s1_src_sel",
+				      "i2s2_src_sel",
+				      "i2s3_src_sel",
+				      "i2s0_src_div",
+				      "i2s1_src_div",
+				      "i2s2_src_div",
+				      "i2s3_src_div",
+				      "i2s0_mclk_en",
+				      "i2s1_mclk_en",
+				      "i2s2_mclk_en",
+				      "i2s3_mclk_en",
+				      "i2so0_hop_ck",
+				      "i2so1_hop_ck",
+				      "i2so2_hop_ck",
+				      "i2so3_hop_ck",
+				      "i2si0_hop_ck",
+				      "i2si1_hop_ck",
+				      "i2si2_hop_ck",
+				      "i2si3_hop_ck",
+				      "asrc0_out_ck",
+				      "asrc1_out_ck",
+				      "asrc2_out_ck",
+				      "asrc3_out_ck",
+				      "audio_afe_pd",
+				      "audio_afe_conn_pd",
+				      "audio_a1sys_pd",
+				      "audio_a2sys_pd",
+				      "audio_mrgif_pd";
+
+			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
+					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
+			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
+						 <&topckgen CLK_TOP_AUD2PLL_90M>;
+			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
+		};
 	};
 
 	mmc0: mmc@11230000 {
-- 
1.9.1
