Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933000AbeDXIih (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:38:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46134 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756580AbeDXIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:37:57 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/5] dt-bindings: devfreq: rk3399_dmc: remove interrupts as is not required.
Date: Tue, 24 Apr 2018 10:37:41 +0200
Message-Id: <20180424083742.14042-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424083742.14042-1-enric.balletbo@collabora.com>
References: <20180424083742.14042-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ATF we already wait for DDR dvfs finish, so don't need to do this in
kernel, so remove the interrupts properties as is not longer required.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---

Changes in v2:
- [4/6] Add Reviewed-by Chanwoo Choi.

 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 834637c7bae7..e7f0ef9548b7 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -5,10 +5,6 @@ Required properties:
 - devfreq-events:	 Node to get DDR loading, Refer to
 			 Documentation/devicetree/bindings/devfreq/event/
 			 rockchip-dfi.txt
-- interrupts:		 The CPU interrupt number. The interrupt specifier
-			 format depends on the interrupt controller.
-			 It should be a DCF interrupt. When DDR DVFS finishes
-			 a DCF interrupt is triggered.
 - clocks:		 Phandles for clock specified in "clock-names" property
 - clock-names :		 The name of clock used by the DFI, must be
 			 "pclk_ddr_mon";
@@ -172,7 +168,6 @@ Example:
 	dmc: dmc {
 		compatible = "rockchip,rk3399-dmc";
 		devfreq-events = <&dfi>;
-		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_DDRCLK>;
 		clock-names = "dmc_clk";
 		operating-points-v2 = <&dmc_opp_table>;
-- 
2.17.0
