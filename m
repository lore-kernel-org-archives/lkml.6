Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24821C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEFB2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEFB2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIAMYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:41 -0400
Received: from mout.perfora.net ([74.208.4.197]:55679 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbeIAMYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:41 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MDwNt-1g7szv4619-00HKMJ; Sat, 01 Sep 2018 10:13:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 11/34] ARM: tegra: colibri_t30: add missing pinmux
Date:   Sat,  1 Sep 2018 10:12:25 +0200
Message-Id: <20180901081248.22639-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:0nSwoeBSih+VKUtwc/8RIankO8uUlmi6oxnx+gI/yIvXLLNOYXB
 LP4rFIIbo7RdvJWbGpwc26YbH5Iy9a0TTvybFN5UOUso3pTZlWjQvtKpt+TbVYhZr7vYGA8
 HhHJ4tMhOXW4Oep+741vQhiQj7ODzYl69piZQ4o3M+KvtMUqxff3mUuyjr8O7LYQKWwu8R7
 yCHtwJLS5PfA5v8OmedjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TKBaQDQHU4Q=:Yi9pfNH5rdp/8GYT87P1Md
 sAmHtHi1qt3knXUQSS2Ga/Evk2Un8f44Jbw3McGHYMkuiyUku6hNANokNvYmPrxs/CWZWKVZb
 jhEk0QnM/QN6N5tHAmB6kaWP8b1rmh5A6AB8fqU0OAiyuRJVssIUnrBlH7Eq/5sWiK8IBEj7S
 XaK6LXP+M1Ej+tOBGP5ym+KFU0fckL9rLPGXel20Db/C+0iIfPwG8swSoAoDeofp/Svqnns9M
 JrAQacnVxE5lDCo+NHFaxIkah9WTFZoLmxCYxcgcloWt51viHVfnRj9p1Wrko9ID5wiKdNzGv
 kiE7NyhNuEG2aSXpV5yigSfTlYhAI2M/vcO8GPIR7lzZqtY7JseeX+uhoa/ppQdmZTnih/NkX
 v0xtyVELRQKStdQ1MAi/zRhjrV/6jKwzWBQUMPAqfq7Z/eI6+WgAzCIZrXDLNbP/zIj2FZWPc
 Bh06rBozJviV+rD6EkOhyARY6eJqgfPt11Ghditjv3BdS3+ImSY+34huW1aHflXZR+X+7U6JY
 H8GJygLQ3vzwxl+vG7/UhhAC6NKEslxLKUD0573yyj8/lROC+co+hdEsIK5aRUGDHlYfHXOBh
 k6sJj/JJTIgLjZPrYVOsLriwJbBNelRzXZHenBo5h6tFPEtpcmLBmWovnzqxKIzu2w1QPB7Op
 8XAQvF8G5PgMLt59xZWBGaue7nYjMSoRtQATdIRa91n7jjsAsZxknqlYn0AfaQOkS1JM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Explicitly mux all T30 SoC balls now:
- Colibri Address/Data Bus (GMI)
- Colibri DDC
- Colibri EXT_IO*
- Colibri GPIO
- Colibri HOTPLUG_DETECT (HDMI)
- Colibri I2C
- Colibri LCD (L_* resp. LDD<*>)
- Colibri MMC_CD
- Colibri nRESET_OUT
- Colibri Parallel Camera (Optional)
- Colibri PWM<B>, <C>, <D>
- Colibri VGA
- Colibri USBC_DET
- Colibri USBH_PEN
- Colibri USBH_OC
- on-module AX88772B LAN control signals
- Colibri nBATT_FAULT(SENSE) and nVDD_FAULT(SENSE
- not connected and therefore disabled signals

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Replace underscores in node names with dashes.

 arch/arm/boot/dts/tegra30-colibri.dtsi | 486 +++++++++++++++++++++++++++++++++
 1 file changed, 486 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 6bedb69be553..197605d99425 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -47,6 +47,156 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Colibri Address/Data Bus (GMI) */
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
+					      "gmi_iordy_pi5",
+					      "gmi_oe_n_pi1",
+					      "gmi_wait_pi7",
+					      "gmi_wr_n_pi0",
+					      "dap1_fs_pn0",
+					      "dap1_din_pn1",
+					      "dap1_dout_pn2",
+					      "dap1_sclk_pn3",
+					      "dap2_fs_pa2",
+					      "dap2_sclk_pa3",
+					      "dap2_din_pa4",
+					      "dap2_dout_pa5",
+					      "spi1_sck_px5",
+					      "spi1_mosi_px4",
+					      "spi1_cs0_n_px6",
+					      "spi2_cs0_n_px3",
+					      "spi2_miso_px1",
+					      "spi2_mosi_px0",
+					      "spi2_sck_px2",
+					      "uart2_cts_n_pj5",
+					      "uart2_rts_n_pj6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Further pins may be used as GPIOs */
+			dap4-din-pp5 {
+				nvidia,pins = "dap4_din_pp5",
+					      "dap4_dout_pp6",
+					      "dap4_fs_pp4",
+					      "dap4_sclk_pp7",
+					      "pbb7",
+					      "sdmmc1_clk_pz0",
+					      "sdmmc1_cmd_pz1",
+					      "sdmmc1_dat0_py7",
+					      "sdmmc1_dat1_py6",
+					      "sdmmc1_dat3_py4",
+					      "uart3_cts_n_pa1",
+					      "uart3_txd_pw6",
+					      "uart3_rxd_pw7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd-d18-pm2 {
+				nvidia,pins = "lcd_d18_pm2",
+					      "lcd_d19_pm3",
+					      "lcd_d20_pm4",
+					      "lcd_d21_pm5",
+					      "lcd_d22_pm6",
+					      "lcd_d23_pm7",
+					      "lcd_dc0_pn6",
+					      "pex_l2_clkreq_n_pcc7";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd-cs0-n-pn4 {
+				nvidia,pins = "lcd_cs0_n_pn4",
+					      "lcd_sdin_pz2",
+					      "pu0",
+					      "pu1",
+					      "pu2",
+					      "pu3",
+					      "pu4",
+					      "pu5",
+					      "pu6",
+					      "spi1_miso_px7",
+					      "uart3_rts_n_pc0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd-pwr0-pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+					      "lcd_sck_pz4",
+					      "lcd_sdout_pn5",
+					      "lcd_wr_n_pz3";
+				nvidia,function = "hdcp";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb4 {
+				nvidia,pins = "pbb4",
+					      "pbb5",
+					      "pbb6";
+				nvidia,function = "displayb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed RDnWR and therefore disabled */
+			lcd-cs1-n-pw0 {
+				nvidia,pins = "lcd_cs1_n_pw0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* Multiplexed GMI_CLK and therefore disabled */
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* Tri-stating GMI_WR_N on nPWE SODIMM pin 99 */
+			sdmmc3-dat4-pd1 {
+				nvidia,pins = "sdmmc3_dat4_pd1";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* Not tri-stating GMI_WR_N on RDnWR SODIMM pin 93 */
+			sdmmc3-dat5-pd0 {
+				nvidia,pins = "sdmmc3_dat5_pd0";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Colibri BL_ON */
 			pv2 {
 				nvidia,pins = "pv2";
@@ -72,6 +222,113 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Colibri DDC */
+			ddc-scl-pv4 {
+				nvidia,pins = "ddc_scl_pv4",
+					      "ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri EXT_IO* */
+			gen2-i2c-scl-pt5 {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+					      "gen2_i2c_sda_pt6";
+				nvidia,function = "rsvd4";
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spdif-in-pk6 {
+				nvidia,pins =	"spdif_in_pk6";
+				nvidia,function = "hda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri GPIO */
+			clk2-out-pw5 {
+				nvidia,pins = "clk2_out_pw5",
+					      "pcc2",
+					      "pv3",
+					      "sdmmc1_dat2_py5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd-pwr1-pc1 {
+				nvidia,pins = "lcd_pwr1_pc1",
+					      "pex_l1_clkreq_n_pdd6",
+					      "pex_l1_rst_n_pdd5";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pv1 {
+				nvidia,pins = "pv1",
+					      "sdmmc3_dat0_pb7",
+					      "sdmmc3_dat1_pb6";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri HOTPLUG_DETECT (HDMI) */
+			hdmi-int-pn7 {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri I2C */
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
+			/* Colibri LCD (L_* resp. LDD<*>) */
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
+					      "lcd_de_pj1",
+					      "lcd_hsync_pj3",
+					      "lcd_pclk_pb3",
+					      "lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
 			/*
 			 * Colibri L_BIAS, LCD_M1 is muxed with LCD_DE
 			 * today's display need DE, disable LCD_M1
@@ -101,6 +358,105 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
+			/* Colibri MMC_CD */
+			gmi-wp-n-pc7 {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			cam-mclk-pcc0 {
+				nvidia,pins =	"cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cam-i2c-scl-pbb1 {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+					      "cam_i2c_sda_pbb2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+			pbb0 {
+				nvidia,pins = "pbb0",
+					      "pcc1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "displayb";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Colibri nRESET_OUT */
+			gmi-rst-n-pi4 {
+				nvidia,pins = "gmi_rst_n_pi4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/*
+			 * Colibri Parallel Camera (Optional)
+			 * pins multiplexed with others and therefore disabled
+			 */
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
+					      "vi_mclk_pt1",
+					      "vi_pclk_pt0",
+					      "vi_vsync_pd6";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Colibri PWM<B> */
+			sdmmc3-dat2-pb5 {
+				nvidia,pins = "sdmmc3_dat2_pb5";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Colibri PWM<C> */
+			sdmmc3-clk-pa6 {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Colibri PWM<D> */
+			sdmmc3-cmd-pa7 {
+				nvidia,pins = "sdmmc3_cmd_pa7";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
 
 			/* Colibri SSP */
 			ulpi-clk-py0 {
@@ -157,6 +513,42 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Colibri USBC_DET */
+			spdif-out-pk5 {
+				nvidia,pins =	"spdif_out_pk5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri USBH_PEN */
+			spi2-cs1-n-pw2 {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Colibri USBH_OC */
+			spi2-cs2-n-pw3, {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi2_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri VGA not supported and therefore disabled */
+			crt-hsync-pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+					      "crt_vsync_pv7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* eMMC (On-module) */
 			sdmmc4-clk-pcc4 {
 				nvidia,pins = "sdmmc4_clk_pcc4",
@@ -182,6 +574,100 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* LAN_EXT_WAKEUP#, LAN_PME (On-module) */
+			pex-l0-rst-n-pdd1 {
+				nvidia,pins = "pex_l0_rst_n_pdd1",
+					      "pex_wake_n_pdd3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* LAN_V_BUS, LAN_RESET# (On-module) */
+			pex-l0-clkreq-n-pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2",
+					      "pex_l0_prsnt_n_pdd0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* nBATT_FAULT(SENSE), nVDD_FAULT(SENSE) */
+			pex-l2-rst-n-pcc6 {
+				nvidia,pins = "pex_l2_rst_n_pcc6",
+					      "pex_l2_prsnt_n_pdd7";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Not connected and therefore disabled */
+			clk1-req-pee2 {
+				nvidia,pins = "clk1_req_pee2",
+					      "pex_l1_prsnt_n_pdd4";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			clk2-req-pcc5 {
+				nvidia,pins = "clk2_req_pcc5",
+					      "clk3_out_pee0",
+					      "clk3_req_pee1",
+					      "clk_32k_out_pa0",
+					      "hdmi_cec_pee3",
+					      "sys_clk_req_pz5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-dqs-pi2 {
+				nvidia,pins = "gmi_dqs_pi2",
+					      "kb_col2_pq2",
+					      "kb_col3_pq3",
+					      "kb_col4_pq4",
+					      "kb_col5_pq5",
+					      "kb_row4_pr4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-col0-pq0 {
+				nvidia,pins = "kb_col0_pq0",
+					      "kb_col1_pq1",
+					      "kb_col6_pq6",
+					      "kb_col7_pq7",
+					      "kb_row5_pr5",
+					      "kb_row6_pr6",
+					      "kb_row7_pr7",
+					      "kb_row9_ps1";
+				nvidia,function = "kbc";
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
+			lcd-pwr2-pc6 {
+				nvidia,pins = "lcd_pwr2_pc6";
+				nvidia,function = "hdcp";
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

