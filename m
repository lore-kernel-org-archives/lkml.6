Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B4920880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B4920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbeGWNkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:40:52 -0400
Received: from mout.perfora.net ([74.208.4.196]:38325 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388507AbeGWNif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:35 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MDOgd-1fmqUt2UaT-00GojY; Mon, 23 Jul 2018 14:37:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 11/26] ARM: tegra: colibri_t30: pinmux clean-up
Date:   Mon, 23 Jul 2018 14:36:42 +0200
Message-Id: <20180723123658.980-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Scj/dzfn+wl1H16b30IL9oJMbSNE2JYvNzClbBdrHaO3klUcYcL
 YYRkdEAEUNU5encUAqh3/ovlQhTQh/2eJxxaadKocoDyQQzKOMDVU7rFfopC2THa991Nn8f
 qr8g4Ph+X0ukevXsj04GSPLqQkb1bU0hJlxOZIomJl1BBhRmkRQ9I8UfF4HxSdzSNZ9jSEM
 ib/L/WsaN9tmAUpgrYRwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EK5TH5QAetM=:qj5/4HFS//Bmi1Yhk30s/C
 FakVYPeiIcU+wZP3q30NCffac3x2nt66RUuAETRXOr2peegJ1KKez332g2mlnIp5iZDTjz0EE
 N6Rv1h6dD9uc/uIycsuUelShzjWK/24wGIF2fKrIJMqx7fcU+z8kj5uUQI5h/SNrRifOIM96l
 MG5HIQKi6/q4Am+n0xjgjIcBdvojIoTKwmpamAVUAeE5NDVLMOx9KigSmjdXbG0Vo+759M8L3
 iwT6GSnKbs0S4kX584H2/DljJjotZPZIouKzCFtLy1TqfOTRn8r7RPyIU2h+ym9xxBlyOuX44
 Y9qJw4feDTy1+eFHJNs7qRPOqVfL6ziKh2JgdfnbEKW4Vr94GWGDPfDLm8HDVWeBqez5e40dT
 BxP2/2sU+vv6L8S+VNzswIpInMo3aFpRvzMjE8ui+MNUFvQKnIclOhyAKPFE78EWQEEUMTMs+
 inbcNVm8FZa2J8vx/KmzegzM5v5OR+z5JpXlLXzXcDQbMpDq51mc6J9M+/dPpfHcWoPy/Bixd
 GeWVcKl0yLeGPQmyF8EVpdWPT49gYNTivAuOC4NrGzcoEuIV5gCgoIOtez597/7hA277nCASS
 6Th62x4tfR3OVkh6at+ag1Udm2XCBtDrikTwBFHAGHOrCatgreq/4vmd++mzph03nrp1VlHhh
 CLaAfFeev2uxhOu02ya8tweJ4tGAQixMq77iGRcMxVta/nybbUJvjVwxPOmRQoSD4CYc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Clean-up pinmuxing:
- white-space clean-up
- explicitly disable LCD_M1 in favour of LCD_DE on L_BIAS
- explicitly disable multiplexed SSPFRM and SSPTXD
- get rid of nvidia,lock property
- add missing eMMC sdmmc4_cmd_pt7 and explicitly enable input
- explicitly disable lcd_dc1_pd2 (e.g. LM95245 I2C address pin)
- annotate TOUCH_PEN_INT# being on-module

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index fedcd2f7912b..55dcd9d0dcce 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -38,10 +38,10 @@
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap3_fs_pp0 {
-				nvidia,pins =	"dap3_fs_pp0",
-						"dap3_sclk_pp3",
-						"dap3_din_pp1",
-						"dap3_dout_pp2";
+				nvidia,pins = "dap3_fs_pp0",
+					      "dap3_sclk_pp3",
+					      "dap3_din_pp1",
+					      "dap3_dout_pp2";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -79,9 +79,9 @@
 			lcd_m1_pw1 {
 				nvidia,pins = "lcd_m1_pw1";
 				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Colibri MMC */
@@ -112,12 +112,14 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
+			/* Multiplexed SSPFRM, SSPTXD and therefore disabled */
 			sdmmc3_dat6_pd3 {
 				nvidia,pins = "sdmmc3_dat6_pd3",
 					      "sdmmc3_dat7_pd4";
 				nvidia,function = "spdif";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Colibri UART_A */
@@ -155,13 +157,15 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			/* eMMC */
+			/* eMMC (On-module) */
 			sdmmc4_clk_pcc4 {
 				nvidia,pins = "sdmmc4_clk_pcc4",
+					      "sdmmc4_cmd_pt7",
 					      "sdmmc4_rst_n_pcc3";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc4_dat0_paa0 {
 				nvidia,pins = "sdmmc4_dat0_paa0",
@@ -175,6 +179,7 @@
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
 			/* Power I2C (On-module) */
@@ -185,7 +190,6 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <TEGRA_PIN_DISABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 
@@ -197,12 +201,12 @@
 			lcd_dc1_pd2 {
 				nvidia,pins = "lcd_dc1_pd2";
 				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
-			/* TOUCH_PEN_INT# */
+			/* TOUCH_PEN_INT# (On-module) */
 			pv0 {
 				nvidia,pins = "pv0";
 				nvidia,function = "rsvd1";
-- 
2.14.4

