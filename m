Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885CFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAB3214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAB3214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeHBNz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:55:27 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:26175 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbeHBNz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:55:26 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Aug 2018 09:55:22 EDT
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b62f21f0000>; Thu, 02 Aug 2018 19:59:28 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Aug 2018 04:59:27 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 02 Aug 2018 04:59:27 -0700
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 11:59:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 11:59:25 +0000
Received: from vreddytalla-dt.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 2 Aug 2018 11:59:19 +0000
From:   Venkat Reddy Talla <vreddytalla@nvidia.com>
To:     <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <jonathanh@nvidia.com>, <pdeschrijver@nvidia.com>,
        <vivek.gautam@codeaurora.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <mperttunen@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <avienamo@nvidia.com>, <talho@nvidia.com>, <ldewangan@nvidia.com>,
        <vreddytalla@nvidia.com>
Subject: [PATCH 2/3] dt-bindings: tegra: update PMC DT binding with io pads control
Date:   Thu, 2 Aug 2018 17:29:02 +0530
Message-ID: <1533211143-17517-2-git-send-email-vreddytalla@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
References: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra124 and later SoCs support the multi-voltage level
and low power state of some of its IO pads. The IO pads can work
in the voltage of the 1.8V and 3.3V of IO voltage from IO power
rail sources. When IO interfaces are not used then IO pads
can be configure in low power state to reduce the power
consumption from that IO pads.

On Tegra124, the voltage level of IO power rail source is auto
detected by hardware(SoC) and hence it is only require to
configure in low power mode if IO pads are not used.

On T210 onwards, the auto-detection of voltage level from
IO power rail is removed from SoC and hence SW need to configure
the PMC register explicitly to set proper voltage in IO pads
based on IO rail power source voltage.

Updating PMC DT binding document for detailing the DT properties
for configuring IO pads voltage levels and its power state.

Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 125 ++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index a74b37b..1166373 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -6,6 +6,35 @@ The PMC block interacts with an external Power Management Unit. The PMC
 mostly controls the entry and exit of the system from different sleep
 modes. It provides power-gating controllers for SoC and CPU power-islands.
 
+NVIDIA Tegra124 and later SoCs support the multi-voltage level and low power
+state of some of its IO pads. When IO interface are not used then IO pads can
+be configure in low power state to reduce the power from that IO pads. The IO
+pads can operate at the nominal IO voltage of eother 1.8V or 3.3V.
+
+On Tegra124, the voltage of IO power rail source is auto detected by SoC and
+hence it is only require to configure in low power mode if IO pads are not
+used.
+
+On T210 onwards, the HW based auto-detection for IO voltage is removed and
+hence SW need to configure the PMC register explicitly, to set proper voltage
+in IO pads, based on IO rail power source voltage.
+
+The voltage configurations and low power state of IO pads should be done in
+boot if it is not going to change otherwise dynamically based on IO rail
+voltage on that IO pads and usage of IO pads.
+
+The DT property of the IO pads must be under the node of pmc i.e.
+pmc@7000e400 for Tegra124 onwards.
+
+Please refer to <pinctrl-bindings.txt> in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+Tegra's pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for an
+IO pads, or a list of IO pads. This configuration can include the voltage and
+power enable/disable control.
+
 Required properties:
 - name : Should be pmc
 - compatible : Should contain one of the following:
@@ -13,7 +42,7 @@ Required properties:
 	For Tegra30 must contain "nvidia,tegra30-pmc".
 	For Tegra114 must contain "nvidia,tegra114-pmc"
 	For Tegra124 must contain "nvidia,tegra124-pmc"
-	For Tegra132 must contain "nvidia,tegra124-pmc"
+	For Tegra132 must contain "nvidia,tegra132-pmc"
 	For Tegra210 must contain "nvidia,tegra210-pmc"
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
@@ -77,6 +106,56 @@ Optional nodes:
 	       should match the powergates on the Tegra SoC. See "Powergate
 	       Nodes" below.
 
+Required subnode-properties:
+==========================
+- pins : An array of strings. Each string contains the name of an IO pad. Valid
+	 values for these names are listed below.
+
+Optional subnode-properties:
+==========================
+Following properties are supported from generic pin configuration explained
+in <dt-bindings/pinctrl/pinctrl-binding.txt>.
+low-power-enable: enable low power mode
+low-power-disable: disable low power mode
+nvidia,restrict-voltage-switch: restrict io pad voltage switch for all pads
+nvidia,enable-voltage-switching: enable voltage switch for io pad
+
+Valid values for pin for T124 SOC are:
+	audio, bb, cam, comp, csia, csib, csie, dsi, dsib, dsic, dsid, hdmi,
+	hsic, hv, lvds, mipi-bias, nand, pex-bias, pex-clk1, pex-clk2,
+	pex-ctrl, sdmmc1, sdmmc3, sdmmc4, sys-ddc, uart, usb0, usb1, usb2,
+	usb-bias
+
+Valid values for pin for T210 SOC are:
+	audio, audio-hv, cam, csia, csib, csic, csid, csie, csif,
+	dbg, debug-nonao, dmic, dp, dsi, dsib, dsic, dsid, emmc, emmc2,
+	gpio, hdmi, hsic, lvds, mipi-bias, pex-bias, pex-clk1, pex-clk2,
+	pex-ctrl, sdmmc1, sdmmc3, spi, spi-hv, uart, usb-bias, usb0,
+	usb1, usb2, usb3.
+
+To find out the IO rail voltage for setting the voltage of IO pad by SW,
+the regulator supply handle must be provided from the DT and it is explained
+in the regulator DT binding document
+	<devicetree/bindings/regulator/regulator.txt>.
+For example, for GPIO rail the supply name is vddio-gpio and regulator
+handle is supplied from DT as
+	vddio-gpio-supply = <&regulator_xyz>;
+
+For T210, following IO pads support the 1.8V/3.3V and the corresponding
+IO voltage pin names are as follows:
+	audio -> vddio_audio
+	audio-hv -> vddio_audio_hv
+	cam ->vddio_cam
+	dbg -> vddio_dbg
+	dmic -> vddio_dmic
+	gpio -> vddio_gpio
+	pex-ctrl -> vddio_pex_ctrl
+	sdmmc1 -> vddio_sdmmc1
+	sdmmc3 -> vddio_sdmmc3
+	spi -> vddio_spi
+	spi-hv -> vddio_spi_hv
+	uart -> vddio_uart
+
 Example:
 
 / SoC dts including file
@@ -123,6 +202,50 @@ pmc@7000f400 {
 	...
 };
 
+== PMC Nodes for IO pad power state/voltage configuration ==
+	i2c@7000d000 {
+		pmic@3c {
+			regulators {
+				vddio_sdmmc1: ldo2 {
+					/* Regulator entries for LDO2 */
+				};
+
+				vdd_cam: ldo3 {
+					/* Regulator entries for LDO3 */
+				};
+			};
+		};
+	};
+
+	pmc@7000e400 {
+		vddio-cam-supply = <&vdd_cam>;
+		vddio-sdmmc1-supply = <&vddio_sdmmc1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tegra_io_pad_volt_default>;
+		nvidia,restrict-voltage-switch;
+		tegra_io_pad_volt_default: common {
+			audio-hv {
+				pins = "audio-hv";
+				low-power-disable;
+			};
+
+			gpio {
+				pins = "gpio";
+				low-power-disable;
+			};
+
+			audio {
+				pins = "audio", "dmic", "sdmmc3";
+				low-power-enable;
+			};
+
+			sdmmc-io-pads {
+				pins = "sdmmc1-hv", "sdmmc3-hv";
+				nvidia,enable-voltage-switching;
+			};
+		};
+	};
 
 == Powergate Nodes ==
 
-- 
2.1.4

