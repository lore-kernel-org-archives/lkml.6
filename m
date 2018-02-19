Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBSIUr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:20:47 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:44762 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752058AbeBSITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:19:02 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH v3 1/2] arm64: dts: rockchip: move i2s0 node from baseboard to SoM
Date: Mon, 19 Feb 2018 09:18:53 +0100
Message-Id: <20180219081855.34400-2-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
References: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S definition is part of the SoM and therefore should be in
rk3399-puma.dtsi. Also correct the number of channels available.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 8 --------
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 9a7486058455..8fd0d7ba1dc9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -117,14 +117,6 @@
 	clock-frequency = <400000>;
 };
 
-&i2s0 {
-	status = "okay";
-	rockchip,playback-channels = <8>;
-	rockchip,capture-channels = <8>;
-	#sound-dai-cells = <0>;
-	status = "okay";
-};
-
 &pcie_phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index ce15a57a5b85..fc913e2d962f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -435,6 +435,14 @@
 	};
 };
 
+&i2s0 {
+	pinctrl-0 = <&i2s0_2ch_bus>;
+	rockchip,playback-channels = <2>;
+	rockchip,capture-channels = <2>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcc_1v8>;
-- 
2.11.0
