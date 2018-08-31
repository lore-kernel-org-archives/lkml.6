Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33B920658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33B920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeHaUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:29 -0400
Received: from mout.perfora.net ([74.208.4.197]:59465 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeHaUr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgoYS-1fbXus23JW-00oC9L; Fri, 31 Aug 2018 18:39:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 18/34] ARM: tegra: apalis_t30: add missing pinmux
Date:   Fri, 31 Aug 2018 18:38:00 +0200
Message-Id: <20180831163817.23970-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:hlkSQOPmXZPKaLt79zY+9ywwKXwJex+zqNDzbpVDgfaKwlezSCW
 iMsnWvC2x9maYOMwGwB7Feqo4iDqzPe9rnz5Ipfi1vhh5HAC1qz6bfVcnxBl4t7Jiscebaw
 Iv/Uf2Ncn/qXbIa/HGMg+QeAu6kF1EcCjNx+D2LJ3AEahACJSTusvG5ta7LIb1Dm8A21oVH
 6uj2R572MC+qzZG2HhDNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gm5g5cJQdHs=:+Px8AB+oyylTMC9OYIWYlP
 jmVEAm2Sgg34EK/DR95agAv+VDkqt1pKkUHPbM5ThCYXL3HBUb0FQLTe12vGEroP3Fai0PkQX
 7J3sOMW+Ow7SxbrmwpYhiwCMAbRNLJZA0PftmiYpCN3efeZztMX/+SHL62JG3RWkuaLvlZFl5
 QLMKfLuW1cNyu+iyhJIp3R4+HVJrTbxmEiyYiiasLyH9XTABv8gCnR3IvWPe5wJUkXSxLNPtY
 yOdJXDf+GWpNuVE193Wv/Fk1elwdDYnqGypgi2S36/pgdHyY6Q01TKh2fjt5xN5pnzJNdxAca
 IYcv2JX5xs4CE9JKV8IAH6HxTfdFeX8gvlihgdWipGppgeiMWAG66tlOJrkTehLfkrijwoNSr
 TjskZcrRmnu6ddPhY81F8dy/1I3Vd04DATsT+hF/NLa98fJWBM6rKLcilAYM35czy9UMacj6n
 A9IvE8PH+geYcZmOiwNRA6vuRf0F+A8XVfXW9HQhRJxCD3tmXE+Oco12eldpymcOCsDpKDD51
 FXEThuClvcM9Zf/Ws7fauq8oWx0rhcTJFGD/4NOV8sc7k1dpYDY4g+Gf6egy0PqHH2Cqoeu8a
 olwKCoK9kAb7keK6qziVTqLMU+sNAVJtqHDce1IBLJNFpjV627FVua57LC7hD2GjIDYDfv5He
 aeEVscRJMkyoKyUSfSQRydQdxMxKQlzKABV0shVMRxW6PiBh0dTH4bFpp4EvM+fAFD9o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Explicitly mux all T30 SoC balls now:
- Apalis GPIO
- Apalis HDMI1
- Apalis I2C1
- Apalis I2C2 (DDC)
- Apalis LCD1
- Apalis Parallel Camera
- Apalis SATA1_ACT#
- Apalis SPDIF1
- Apalis TS (Low-speed type specific)
- Apalis USBH_EN
- Apalis USBH_OC#
- Apalis VGA1
- on-module i210/i211 LAN control signals
- not connected and therefore disabled signals

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Replace underscores in node names with dashes.

 arch/arm/boot/dts/tegra30-apalis.dtsi | 370 ++++++++++++++++++++++++++++++++++
 1 file changed, 370 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index cb587670a5af..e37d22e2ceef 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -169,6 +169,68 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Apalis GPIO */
+			kb-col0-pq0 {
+				nvidia,pins = "kb_col0_pq0",
+					      "kb_col1_pq1",
+					      "kb_row10_ps2",
+					      "kb_row11_ps3",
+					      "kb_row12_ps4",
+					      "kb_row13_ps5",
+					      "kb_row14_ps6",
+					      "kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis HDMI1 */
+			hdmi-cec-pee3 {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi-int-pn7 {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C1 */
+			gen1-i2c-scl-pc4 {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+					      "gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C2 (DDC) */
+			ddc-scl-pv4 {
+				nvidia,pins = "ddc_scl_pv4",
+					      "ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis I2C3 (CAM) */
 			cam-i2c-scl-pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -180,6 +242,42 @@
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis LCD1 */
+			lcd-d0-pe0 {
+				nvidia,pins = "lcd_d0_pe0",
+					      "lcd_d1_pe1",
+					      "lcd_d2_pe2",
+					      "lcd_d3_pe3",
+					      "lcd_d4_pe4",
+					      "lcd_d5_pe5",
+					      "lcd_d6_pe6",
+					      "lcd_d7_pe7",
+					      "lcd_d8_pf0",
+					      "lcd_d9_pf1",
+					      "lcd_d10_pf2",
+					      "lcd_d11_pf3",
+					      "lcd_d12_pf4",
+					      "lcd_d13_pf5",
+					      "lcd_d14_pf6",
+					      "lcd_d15_pf7",
+					      "lcd_d16_pm0",
+					      "lcd_d17_pm1",
+					      "lcd_d18_pm2",
+					      "lcd_d19_pm3",
+					      "lcd_d20_pm4",
+					      "lcd_d21_pm5",
+					      "lcd_d22_pm6",
+					      "lcd_d23_pm7",
+					      "lcd_de_pj1",
+					      "lcd_hsync_pj3",
+					      "lcd_pclk_pb3",
+					      "lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis MMC1 */
 			sdmmc3-clk-pa6 {
 				nvidia,pins = "sdmmc3_clk_pa6";
@@ -210,6 +308,77 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis Parallel Camera */
+			cam-mclk-pcc0 {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi-vsync-pd6 {
+				nvidia,pins = "vi_d0_pt4",
+					      "vi_d1_pd5",
+					      "vi_d2_pl0",
+					      "vi_d3_pl1",
+					      "vi_d4_pl2",
+					      "vi_d5_pl3",
+					      "vi_d6_pl4",
+					      "vi_d7_pl5",
+					      "vi_d8_pl6",
+					      "vi_d9_pl7",
+					      "vi_d10_pt2",
+					      "vi_d11_pt3",
+					      "vi_hsync_pd7",
+					      "vi_pclk_pt0",
+					      "vi_vsync_pd6";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			kb-col2-pq2 {
+				nvidia,pins = "kb_col2_pq2",
+					      "kb_col3_pq3",
+					      "kb_col4_pq4",
+					      "kb_row4_pr4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row0-pr0 {
+				nvidia,pins = "kb_row0_pr0",
+					      "kb_row1_pr1",
+					      "kb_row2_pr2",
+					      "kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row5-pr5 {
+				nvidia,pins = "kb_row5_pr5",
+					      "kb_row6_pr6",
+					      "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/*
+			 * VI level-shifter direction
+			 * (pull-down => default direction input)
+			 */
+			vi-mclk-pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis PWM1 */
 			pu6 {
 				nvidia,pins = "pu6";
@@ -250,6 +419,15 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Apalis SATA1_ACT# */
+			pex-l0-prsnt-n-pdd0 {
+				nvidia,pins = "pex_l0_prsnt_n_pdd0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis SD1 */
 			sdmmc1-clk-pz0 {
 				nvidia,pins = "sdmmc1_clk_pz0";
@@ -276,6 +454,16 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis SPDIF1 */
+			spdif-out-pk5 {
+				nvidia,pins = "spdif_out_pk5",
+					      "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis SPI1 */
 			spi1-sck-px5 {
 				nvidia,pins = "spi1_sck_px5",
@@ -298,6 +486,28 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/*
+			 * Apalis TS (Low-speed type specific)
+			 * pins may be used as GPIOs
+			 */
+			kb-col5-pq5 {
+				nvidia,pins = "kb_col5_pq5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-col6-pq6 {
+				nvidia,pins = "kb_col6_pq6",
+					      "kb_col7_pq7",
+					      "kb_row8_ps0",
+					      "kb_row9_ps1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis UART1 */
 			ulpi-data0 {
 				nvidia,pins = "ulpi_data0_po1",
@@ -342,6 +552,24 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Apalis USBH_EN */
+			pex-l0-rst-n-pdd1 {
+				nvidia,pins = "pex_l0_rst_n_pdd1";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis USBH_OC# */
+			pex-l0-clkreq-n-pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis USBO1_EN */
 			gen2-i2c-scl-pt5 {
 				nvidia,pins = "gen2_i2c_scl_pt5";
@@ -361,6 +589,16 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis VGA1 not supported and therefore disabled */
+			crt-hsync-pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+					      "crt_vsync_pv7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis WAKE1_MICO */
 			pv1 {
 				nvidia,pins = "pv1";
@@ -395,6 +633,33 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* LAN i210/i211 DEV_OFF_N, PE_RST_N (On-module) */
+			pex-l2-prsnt-n-pdd7 {
+				nvidia,pins = "pex_l2_prsnt_n_pdd7",
+					      "pex_l2_rst_n_pcc6";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* LAN i210/i211 PE_WAKE_N, SDP3 (On-module) */
+			pex-wake-n-pdd3 {
+				nvidia,pins = "pex_wake_n_pdd3",
+					      "pex_l2_clkreq_n_pcc7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* LAN i210/i211 SMB_ALERT_N (On-module) */
+			sys-clk-req-pz5 {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* LVDS Transceiver Configuration */
 			pbb0 {
 				nvidia,pins = "pbb0",
@@ -417,6 +682,111 @@
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Not connected and therefore disabled */
+			clk-32k-out-pa0 {
+				nvidia,pins = "clk3_out_pee0",
+					      "clk3_req_pee1",
+					      "clk_32k_out_pa0",
+					      "dap4_din_pp5",
+					      "dap4_dout_pp6",
+					      "dap4_fs_pp4",
+					      "dap4_sclk_pp7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap2-fs-pa2 {
+				nvidia,pins = "dap2_fs_pa2",
+					      "dap2_sclk_pa3",
+					      "dap2_din_pa4",
+					      "dap2_dout_pa5",
+					      "lcd_dc0_pn6",
+					      "lcd_m1_pw1",
+					      "lcd_pwr1_pc1",
+					      "pex_l1_clkreq_n_pdd6",
+					      "pex_l1_prsnt_n_pdd4",
+					      "pex_l1_rst_n_pdd5";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad0-pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+					      "gmi_ad2_pg2",
+					      "gmi_ad3_pg3",
+					      "gmi_ad4_pg4",
+					      "gmi_ad5_pg5",
+					      "gmi_ad6_pg6",
+					      "gmi_ad7_pg7",
+					      "gmi_ad8_ph0",
+					      "gmi_ad9_ph1",
+					      "gmi_ad10_ph2",
+					      "gmi_ad11_ph3",
+					      "gmi_ad12_ph4",
+					      "gmi_ad13_ph5",
+					      "gmi_ad14_ph6",
+					      "gmi_ad15_ph7",
+					      "gmi_adv_n_pk0",
+					      "gmi_clk_pk1",
+					      "gmi_cs4_n_pk2",
+					      "gmi_cs2_n_pk3",
+					      "gmi_dqs_pi2",
+					      "gmi_iordy_pi5",
+					      "gmi_oe_n_pi1",
+					      "gmi_wait_pi7",
+					      "gmi_wr_n_pi0",
+					      "lcd_cs1_n_pw0",
+					      "pu0",
+					      "pu1",
+					      "pu2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs0-n-pj0 {
+				nvidia,pins = "gmi_cs0_n_pj0",
+					      "gmi_cs1_n_pj2",
+					      "gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs6-n-pi3 {
+				nvidia,pins = "gmi_cs6_n_pi3";
+				nvidia,function = "sata";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs7-n-pi6 {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-pwr0-pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+					      "lcd_pwr2_pc6",
+					      "lcd_wr_n_pz3";
+				nvidia,function = "hdcp";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uart2-cts-n-pj5 {
+				nvidia,pins = "uart2_cts_n_pj5",
+					      "uart2_rts_n_pj6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Power I2C (On-module) */
 			pwr-i2c-scl-pz6 {
 				nvidia,pins = "pwr_i2c_scl_pz6",
-- 
2.14.4

