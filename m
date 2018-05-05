Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeEEJgK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:36:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57092 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeEEJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:35:02 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Nick Milner <nick.milner@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/5] dt-bindings: devfreq: rk3399_dmc: improve binding documentation.
Date: Sat,  5 May 2018 11:34:46 +0200
Message-Id: <20180505093450.17327-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180505093450.17327-1-enric.balletbo@collabora.com>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Milner <nick.milner@collabora.com>

There are several typos, references to non existent files, grammar and
punctuation mistakes in the rk3399_dmc.txt binding. This patch tries
to improve the binding documentation and fix these mistakes.

Signed-off-by: Nick Milner <nick.milner@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---

Changes in v3: None
Changes in v2:
- [1/6] Add Acked-by MyungJoo Ham.
- [6/6] Removed this patch from this series.

 .../bindings/devfreq/rk3399_dmc.txt           | 207 +++++++++---------
 1 file changed, 105 insertions(+), 102 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index d6d2833482c9..d83ef821d282 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -1,155 +1,158 @@
-* Rockchip rk3399 DMC(Dynamic Memory Controller) device
+* Rockchip rk3399 DMC (Dynamic Memory Controller) device
 
 Required properties:
 - compatible:		 Must be "rockchip,rk3399-dmc".
 - devfreq-events:	 Node to get DDR loading, Refer to
-			 Documentation/devicetree/bindings/devfreq/
+			 Documentation/devicetree/bindings/devfreq/event/
 			 rockchip-dfi.txt
-- interrupts:		 The interrupt number to the CPU. The interrupt
-			 specifier format depends on the interrupt controller.
-			 It should be DCF interrupts, when DDR dvfs finish,
-			 it will happen.
+- interrupts:		 The CPU interrupt number. The interrupt specifier
+			 format depends on the interrupt controller.
+			 It should be a DCF interrupt. When DDR DVFS finishes
+			 a DCF interrupt is triggered.
 - clocks:		 Phandles for clock specified in "clock-names" property
 - clock-names :		 The name of clock used by the DFI, must be
 			 "pclk_ddr_mon";
-- operating-points-v2:	 Refer to Documentation/devicetree/bindings/power/opp.txt
+- operating-points-v2:	 Refer to Documentation/devicetree/bindings/opp/opp.txt
 			 for details.
 - center-supply:	 DMC supply node.
 - status:		 Marks the node enabled/disabled.
 
-Following properties are ddr timing:
+Following properties relate to DDR timing:
 
 - rockchip,dram_speed_bin :	  Value reference include/dt-bindings/clock/ddr.h,
-				  it select ddr3 cl-trp-trcd type, default value
-				  "DDR3_DEFAULT".it must selected according to
-				  "Speed Bin" in ddr3 datasheet, DO NOT use
-				  smaller "Speed Bin" than ddr3 exactly is.
-
-- rockchip,pd_idle :		  Config the PD_IDLE value, defined the power-down
-				  idle period, memories are places into power-down
-				  mode if bus is idle for PD_IDLE DFI clocks.
-
-- rockchip,sr_idle :		  Configure the SR_IDLE value, defined the
-				  selfrefresh idle period, memories are places
-				  into self-refresh mode if bus is idle for
-				  SR_IDLE*1024 DFI clocks (DFI clocks freq is
-				  half of dram's clocks), defaule value is "0".
-
-- rockchip,sr_mc_gate_idle :	  Defined the self-refresh with memory and
-				  controller clock gating idle period, memories
-				  are places into self-refresh mode and memory
-				  controller clock arg gating if bus is idle for
-				  sr_mc_gate_idle*1024 DFI clocks.
-
-- rockchip,srpd_lite_idle :	  Defined the self-refresh power down idle
-				  period, memories are places into self-refresh
-				  power down mode if bus is idle for
-				  srpd_lite_idle*1024 DFI clocks. This parameter
-				  is for LPDDR4 only.
-
-- rockchip,standby_idle :	  Defined the standby idle period, memories are
-				  places into self-refresh than controller, pi,
-				  phy and dram clock will gating if bus is idle
-				  for standby_idle * DFI clocks.
-
-- rockchip,dram_dll_disb_freq :  It's defined the DDR3 dll bypass frequency in
-				  MHz, when ddr freq less than DRAM_DLL_DISB_FREQ,
-				  ddr3 dll will bypssed note: if dll was bypassed,
-				  the odt also stop working.
-
-- rockchip,phy_dll_disb_freq :	  Defined the PHY dll bypass frequency in
-				  MHz (Mega Hz), when ddr freq less than
-				  DRAM_DLL_DISB_FREQ, phy dll will bypssed.
-				  note: phy dll and phy odt are independent.
-
-- rockchip,ddr3_odt_disb_freq :  When dram type is DDR3, this parameter defined
-				  the odt disable frequency in MHz (Mega Hz),
-				  when ddr frequency less then ddr3_odt_disb_freq,
-				  the odt on dram side and controller side are
+				  it selects the DDR3 cl-trp-trcd type. It must be
+				  set according to "Speed Bin" in DDR3 datasheet,
+				  DO NOT use a smaller "Speed Bin" than specified
+				  for the DDR3 being used.
+
+- rockchip,pd_idle :		  Configure the PD_IDLE value. Defines the
+				  power-down idle period in which memories are
+				  placed into power-down mode if bus is idle
+				  for PD_IDLE DFI clock cycles.
+
+- rockchip,sr_idle :		  Configure the SR_IDLE value. Defines the
+				  self-refresh idle period in which memories are
+				  placed into self-refresh mode if bus is idle
+				  for SR_IDLE * 1024 DFI clock cycles (DFI
+				  clocks freq is half of DRAM clock), default
+				  value is "0".
+
+- rockchip,sr_mc_gate_idle :	  Defines the memory self-refresh and controller
+				  clock gating idle period. Memories are placed
+				  into self-refresh mode and memory controller
+				  clock arg gating started if bus is idle for
+				  sr_mc_gate_idle*1024 DFI clock cycles.
+
+- rockchip,srpd_lite_idle :	  Defines the self-refresh power down idle
+				  period in which memories are placed into
+				  self-refresh power down mode if bus is idle
+				  for srpd_lite_idle * 1024 DFI clock cycles.
+				  This parameter is for LPDDR4 only.
+
+- rockchip,standby_idle :	  Defines the standby idle period in which
+				  memories are placed into self-refresh mode.
+				  The controller, pi, PHY and DRAM clock will
+				  be gated if bus is idle for standby_idle * DFI
+				  clock cycles.
+
+- rockchip,dram_dll_disb_freq :	  Defines the DDR3 DLL bypass frequency in MHz.
+				  When DDR frequency is less than DRAM_DLL_DISB_FREQ,
+				  DDR3 DLL will be bypassed. Note: if DLL was bypassed,
+				  the odt will also stop working.
+
+- rockchip,phy_dll_disb_freq :	  Defines the PHY dll bypass frequency in
+				  MHz (Mega Hz). When DDR frequency is less than
+				  DRAM_DLL_DISB_FREQ, PHY DLL will be bypassed.
+				  Note: PHY DLL and PHY ODT are independent.
+
+- rockchip,ddr3_odt_disb_freq :	  When the DRAM type is DDR3, this parameter defines
+				  the ODT disable frequency in MHz (Mega Hz).
+				  when the DDR frequency is  less then ddr3_odt_disb_freq,
+				  the ODT on the DRAM side and controller side are
 				  both disabled.
 
-- rockchip,ddr3_drv :		  When dram type is DDR3, this parameter define
-				  the dram side driver stength in ohm, default
+- rockchip,ddr3_drv :		  When the DRAM type is DDR3, this parameter defines
+				  the DRAM side driver strength in ohms. Default
 				  value is DDR3_DS_40ohm.
 
-- rockchip,ddr3_odt :		  When dram type is DDR3, this parameter define
-				  the dram side ODT stength in ohm, default value
+- rockchip,ddr3_odt :		  When the DRAM type is DDR3, this parameter defines
+				  the DRAM side ODT strength in ohms. Default value
 				  is DDR3_ODT_120ohm.
 
-- rockchip,phy_ddr3_ca_drv :	  When dram type is DDR3, this parameter define
-				  the phy side CA line(incluing command line,
+- rockchip,phy_ddr3_ca_drv :	  When the DRAM type is DDR3, this parameter defines
+				  the phy side CA line (incluing command line,
 				  address line and clock line) driver strength.
 				  Default value is PHY_DRV_ODT_40.
 
-- rockchip,phy_ddr3_dq_drv :	  When dram type is DDR3, this parameter define
-				  the phy side DQ line(incluing DQS/DQ/DM line)
-				  driver strength. default value is PHY_DRV_ODT_40.
+- rockchip,phy_ddr3_dq_drv :	  When the DRAM type is DDR3, this parameter defines
+				  the PHY side DQ line (including DQS/DQ/DM line)
+				  driver strength. Default value is PHY_DRV_ODT_40.
 
-- rockchip,phy_ddr3_odt : 	  When dram type is DDR3, this parameter define the
-				  phy side odt strength, default value is
+- rockchip,phy_ddr3_odt : 	  When the DRAM type is DDR3, this parameter defines
+				  the PHY side ODT strength. Default value is
 				  PHY_DRV_ODT_240.
 
-- rockchip,lpddr3_odt_disb_freq : When dram type is LPDDR3, this parameter defined
-				  then odt disable frequency in MHz (Mega Hz),
-				  when ddr frequency less then ddr3_odt_disb_freq,
-				  the odt on dram side and controller side are
+- rockchip,lpddr3_odt_disb_freq : When the DRAM type is LPDDR3, this parameter defines
+				  then ODT disable frequency in MHz (Mega Hz).
+				  When DDR frequency is less then ddr3_odt_disb_freq,
+				  the ODT on the DRAM side and controller side are
 				  both disabled.
 
-- rockchip,lpddr3_drv :	  When dram type is LPDDR3, this parameter define
-				  the dram side driver stength in ohm, default
+- rockchip,lpddr3_drv :		  When the DRAM type is LPDDR3, this parameter defines
+				  the DRAM side driver strength in ohms. Default
 				  value is LP3_DS_34ohm.
 
-- rockchip,lpddr3_odt :	  When dram type is LPDDR3, this parameter define
-				  the dram side ODT stength in ohm, default value
+- rockchip,lpddr3_odt :		  When the DRAM type is LPDDR3, this parameter defines
+				  the DRAM side ODT strength in ohms. Default value
 				  is LP3_ODT_240ohm.
 
-- rockchip,phy_lpddr3_ca_drv :	  When dram type is LPDDR3, this parameter define
-				  the phy side CA line(incluing command line,
+- rockchip,phy_lpddr3_ca_drv :	  When the DRAM type is LPDDR3, this parameter defines
+				  the PHY side CA line (including command line,
 				  address line and clock line) driver strength.
-				  default value is PHY_DRV_ODT_40.
+				  Default value is PHY_DRV_ODT_40.
 
-- rockchip,phy_lpddr3_dq_drv :	  When dram type is LPDDR3, this parameter define
-				  the phy side DQ line(incluing DQS/DQ/DM line)
-				  driver strength. default value is
+- rockchip,phy_lpddr3_dq_drv :	  When the DRAM type is LPDDR3, this parameter defines
+				  the PHY side DQ line (including DQS/DQ/DM line)
+				  driver strength. Default value is
 				  PHY_DRV_ODT_40.
 
 - rockchip,phy_lpddr3_odt : 	  When dram type is LPDDR3, this parameter define
 				  the phy side odt strength, default value is
 				  PHY_DRV_ODT_240.
 
-- rockchip,lpddr4_odt_disb_freq : When dram type is LPDDR4, this parameter
-				  defined the odt disable frequency in
-				  MHz (Mega Hz), when ddr frequency less then
-				  ddr3_odt_disb_freq, the odt on dram side and
+- rockchip,lpddr4_odt_disb_freq : When the DRAM type is LPDDR4, this parameter
+				  defines the ODT disable frequency in
+				  MHz (Mega Hz). When the DDR frequency is less then
+				  ddr3_odt_disb_freq, the ODT on the DRAM side and
 				  controller side are both disabled.
 
-- rockchip,lpddr4_drv :	  When dram type is LPDDR4, this parameter define
-				  the dram side driver stength in ohm, default
+- rockchip,lpddr4_drv :		  When the DRAM type is LPDDR4, this parameter defines
+				  the DRAM side driver strength in ohms. Default
 				  value is LP4_PDDS_60ohm.
 
-- rockchip,lpddr4_dq_odt : 	  When dram type is LPDDR4, this parameter define
-				  the dram side ODT on dqs/dq line stength in ohm,
-				  default value is LP4_DQ_ODT_40ohm.
+- rockchip,lpddr4_dq_odt : 	  When the DRAM type is LPDDR4, this parameter defines
+				  the DRAM side ODT on DQS/DQ line strength in ohms.
+				  Default value is LP4_DQ_ODT_40ohm.
 
-- rockchip,lpddr4_ca_odt :	  When dram type is LPDDR4, this parameter define
-				  the dram side ODT on ca line stength in ohm,
-				  default value is LP4_CA_ODT_40ohm.
+- rockchip,lpddr4_ca_odt :	  When the DRAM type is LPDDR4, this parameter defines
+				  the DRAM side ODT on CA line strength in ohms.
+				  Default value is LP4_CA_ODT_40ohm.
 
-- rockchip,phy_lpddr4_ca_drv :	  When dram type is LPDDR4, this parameter define
-				  the phy side  CA line(incluing command address
-				  line) driver strength. default value is
+- rockchip,phy_lpddr4_ca_drv :	  When the DRAM type is LPDDR4, this parameter defines
+				  the PHY side CA line (including command address
+				  line) driver strength. Default value is
 				  PHY_DRV_ODT_40.
 
-- rockchip,phy_lpddr4_ck_cs_drv : When dram type is LPDDR4, this parameter define
-				  the phy side clock line and cs line driver
-				  strength. default value is PHY_DRV_ODT_80.
+- rockchip,phy_lpddr4_ck_cs_drv : When the DRAM type is LPDDR4, this parameter defines
+				  the PHY side clock line and CS line driver
+				  strength. Default value is PHY_DRV_ODT_80.
 
-- rockchip,phy_lpddr4_dq_drv :	  When dram type is LPDDR4, this parameter define
-				  the phy side DQ line(incluing DQS/DQ/DM line)
-				  driver strength. default value is PHY_DRV_ODT_80.
+- rockchip,phy_lpddr4_dq_drv :	  When the DRAM type is LPDDR4, this parameter defines
+				  the PHY side DQ line (including DQS/DQ/DM line)
+				  driver strength. Default value is PHY_DRV_ODT_80.
 
-- rockchip,phy_lpddr4_odt :	  When dram type is LPDDR4, this parameter define
-				  the phy side odt strength, default value is
+- rockchip,phy_lpddr4_odt :	  When the DRAM type is LPDDR4, this parameter defines
+				  the PHY side ODT strength. Default value is
 				  PHY_DRV_ODT_60.
 
 Example:
-- 
2.17.0
