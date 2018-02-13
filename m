Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbeBMJox (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:44:53 -0500
Received: from mail.tricorecenter.de ([217.6.246.34]:44468 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934267AbeBMJoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:44:37 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: rockchip: phycore: Support UHS mode for SD card on phyCORE-RK3288 RDK
Date: Tue, 13 Feb 2018 10:44:34 +0100
Message-Id: <1518515074-22526-3-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:44:35,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:44:35,
        Serialize complete at 13.02.2018 10:44:35
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wadim Egorov <w.egorov@phytec.de>

The phyCORE-RK3288 RDK could enable SD3.0 card but need vdd_io_sd to
support the voltage range from 1.8V to 3.3V.
And we have also to add relevant UHS modes to the sdmmc node.
Let's also turn off the vdd_io_sd regulator in suspend state.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/boot/dts/rk3288-phycore-rdk.dts  | 4 ++++
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
index ecb26f0..985743f 100644
--- a/arch/arm/boot/dts/rk3288-phycore-rdk.dts
+++ b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
@@ -265,6 +265,10 @@
 	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vdd_sd>;
 	vqmmc-supply = <&vdd_io_sd>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 5eae477..f13bcb1 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -336,11 +336,10 @@
 				regulator-name = "vdd_io_sd";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
+					regulator-off-in-suspend;
 				};
 			};
 		};
-- 
2.7.4
