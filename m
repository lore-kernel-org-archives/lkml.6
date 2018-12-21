Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A936EC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C921920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545428055;
	bh=NUXSUsv6jtFWAKmGjhtcBlKIO3N+rN38khQIODioerg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=X+iA9h/v6QIK7laicZ8eUal1/iJt3tiwnAfndeJOJTeCgzWibvuuW5XGdSO+80d3h
	 ZniNPsJn5oNnX4AKzXoPB0+jAYA1DPRM6Y7evgYk1fT2Y3Uu4bid2P5VrCQWkVxVMF
	 rtky2kF2+JklfzIiIP1rvJEeIRIeRrSm7Zp6eX0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeLUVeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLUVeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:34:13 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BE621920;
        Fri, 21 Dec 2018 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545428049;
        bh=NUXSUsv6jtFWAKmGjhtcBlKIO3N+rN38khQIODioerg=;
        h=From:To:Cc:Subject:Date:From;
        b=2irJxaMjEoo02oXWj4sOvcZkebdZyhZ1ZhKWO+zejXbVoK9JWeBkHLiH0GWmRmvEi
         2RYfPgdXaA+6KvXXy+C1XmgL9Bu0N7hc4nAhvgFLPuqUdE1N/vLLFdmC0YUnTGevWv
         r+y46eBwTA9/RR4zqjmgt+5OfBulLLkY8aPt4eSk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri, 21 Dec 2018 13:34:08 -0800
Message-Id: <20181221213408.248831-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a034aad4892baf82f8c9082f969c5ebc1143a05:

  clk: qcom: qcs404: Fix gpll0_out_main parent (2018-12-10 11:31:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to b677574bdf292e31c8f9810ff0fc0b35839d4636:

  Merge branch 'clk-imx7ulp' into clk-next (2018-12-14 14:03:38 -0800)

----------------------------------------------------------------
This round is dominated by NXP's i.MX clk drivers. We gained support for two or
three i.MX SoCs in here and that mostly means a lot of driver code and data.
Beyond that platform, there are some new Mediatek, Amlogic, and Qualcomm clk
drivers added in here, and then we get to the long tail of driver updates and
non-critical fixes all around, including code for vendors such as Renesas,
Rockchip, Nvidia, and Allwinner. Overall, the driver updates look normal.

Beyond the usual driver updates we have an update to make registering OF based
clk providers a little simpler when they're devices created as a child of a
device backed by a node in DT. Drivers don't have to jump through hoops to
unregister the provider upon driver removal anymore because the API does the
right thing and uses the parent device DT node.

Core:
 - Make devm_of_clk_add_hw_provider() use parent dt node if necessary
 - Various SPDX taggings
 - Mark clk_ops const when possible

New Drivers:
 - NXP i.MX7ULP SoC clock support
 - NXP i.MX8QXP SoC clock support
 - NXP i.MX8MQ SoC clock support
 - NXP QorIQ T1023 SoC support
 - Qualcomm SDM845 audio subsystem clks
 - Qualcomm SDM845 GPU clck controllers
 - Qualcomm QCS404 RPM clk support
 - Mediatek MT7629 SoC clk controllers
 - Allwinner F1c100s SoC clocks
 - Allwinner H6 display engine clocks
 - Amlogic GX video clocks
 - Support for Amlogic meson8b CPU frequency scaling
 - Amlogic Meson8b CPU post-divider clocks

Updates:
 - Proper suspend/resume on VersaClock5
 - Shrink code some with DEFINE_SHOW_ATTRIBUTE()
 - Register fixes for Rockchip rk3188 and rk3328
 - One new critical clock for Rockchip rk3188 and a fixed clock id (double used number)
 - New clock id for Rockchip rk3328
 - Amlogic Meson8/Meson8b video clock support
 - Amlogic got a clk-input helper and used it for the axg-audio clock driver
 - Sigma Delta modulation for the Allwinner A33 audio clocks
 - Support for CPEX (timer) clocks on various Renesas R-Car Gen3 and RZ/G2 SoCs
 - Support for SDHI HS400 clocks on early revisions of Renesas R-Car H3 and M3-W
 - Support for SDHI and USB clocks on Renesas RZ/A2
 - Support for RPC (SPI Multi I/O Bus Controller) clocks on Renesas R-Car V3M
 - Qualcomm MSM8998 GCC driver improvements (resets, drop unused clks, etc.)

----------------------------------------------------------------
A.s. Dong (13):
      dt-bindings: imx: add scu resource id headfile
      firmware: imx: remove resource id enums
      dt-bindings: fsl: scu: update power domain binding
      firmware: imx: add pm svc headfile
      clk: imx: add gatable clock divider support
      clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
      clk: imx: add pllv4 support
      clk: imx: add pfdv2 support
      clk: imx: add imx7ulp composite clk support
      dt-bindings: clock: add imx7ulp clock binding doc
      clk: imx: make mux parent strings const
      clk: imx: implement new clk_hw based APIs
      clk: imx: add imx7ulp clk driver

Abel Vesa (3):
      clk: imx: Add imx composite clock
      clk: imx: Add clock driver for i.MX8MQ CCM
      clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ dependant

Aisheng Dong (7):
      dt-bindings: clock: imx8qxp: add SCU clock IDs
      dt-bindings: clock: add imx8qxp lpcg clock binding
      clk: imx: add configuration option for mmio clks
      clk: imx: add scu clock common part
      clk: imx: add imx8qxp clk driver
      clk: imx: add lpcg clock support
      clk: imx: add imx8qxp lpcg driver

Amit Nischal (2):
      dt-bindings: clock: Introduce QCOM Graphics clock bindings
      clk: qcom: Add graphics clock controller driver for SDM845

Anson Huang (5):
      clk: imx7d: remove UART1 clock setting
      clk: imx6sl: ensure MMDC CH0 handshake is bypassed
      clk: imx6q: add DCICx clocks gate
      dt-bindings: clock: imx7ulp: add HSRUN mode related clocks
      clk: imx: imx7ulp: add arm hsrun mode clocks support

Bjorn Andersson (3):
      clk: qcom: gcc-msm8998: Drop hmss_dvm and lpass_at
      clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
      clk: qcom: gcc-msm8998: Add clkref clocks

Chen-Yu Tsai (5):
      clk: sunxi-ng: sun50i: a64: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
      clk: sunxi-ng: h3/h5: Fix CSI_MCLK parent
      clk: sunxi-ng: a33: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks

Chris Brandt (2):
      clk: renesas: r7s9210: Add SDHI clocks
      clk: renesas: r7s9210: Add USB clocks

Colin Ian King (1):
      clk: imx: remove redundant initialization of ret to zero

Dmitry Osipenko (2):
      clk: tegra20: Turn EMC clock gate into divider
      clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC

Douglas Anderson (3):
      clk: qcom: gpu_cc_gmu_clk_src has 5 parents, not 6
      dt-bindings: clock: qcom: Fix the xo parent in gpucc example
      dt-bindings: clock: Require #reset-cells in sdm845-videocc

Finley Xiao (1):
      clk: rockchip: fix rk3188 sclk_smc gate data

Geert Uytterhoeven (12):
      dt-bindings: clock: r8a7795: Remove CSIREF clock
      dt-bindings: clock: r8a7796: Remove CSIREF clock
      clk: renesas: r8a774a1: Add CPEX clock
      clk: renesas: r8a7795: Add CPEX clock
      clk: renesas: r8a7796: Add CPEX clock
      clk: renesas: r8a77965: Add CPEX clock
      clk: renesas: r8a77970: Add CPEX clock
      clk: renesas: r8a77995: Correct parent clock of DU
      clk: renesas: r8a77995: Remove non-existent VIN5-7 module clocks
      clk: renesas: r8a77995: Remove non-existent SSP clocks
      clk: renesas: r8a77995: Add missing CPEX clock
      clk: renesas: r8a77995: Simplify PLL3 multiplier/divider

Heiko Stuebner (2):
      clk: rockchip: fix rk3188 sclk_mac_lbtest parameter ordering
      Merge branch 'v4.21-shared/clkids' into v4.21-clk/next

Icenowy Zheng (1):
      clk: sunxi-ng: enable so-said LDOs for A64 SoC's pll-mipi clock

Jagan Teki (3):
      clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
      clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
      clk: sunxi-ng: a64: Fix gate bit of DSI DPHY

Jeffrey Hugo (5):
      clk: qcom: Fix MSM8998 resets
      clk: qcom: Enumerate remaining msm8998 resets
      clk: qcom: Add missing msm8998 resets
      clk: qcom: Leave mmss noc on for 8998
      clk: qcom: Drop unused 8998 clock

Jernej Skrabec (7):
      clk: sunxi-ng: Adjust MP clock parent rate when allowed
      clk: sunxi-ng: Use u64 for calculation of NM rate
      clk: sunxi-ng: h6: Set video PLLs limits
      dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
      clk: sunxi-ng: Add support for H6 DE3 clocks
      clk: sunxi-ng: h3: Allow parent change for ve clock
      clk: sunxi-ng: a64: Allow parent change for VE clock

Jerome Brunet (2):
      clk: meson: add clk-input helper function
      clk: meson: axg-audio: use the clk input helper function

Johan Jonker (1):
      clk: rockchip: fix typo in rk3188 spdif_frac parent

Jon Hunter (3):
      clk: tegra: Fix maximum audio sync clock for Tegra124/210
      soc/tegra: pmc: Drop SMP dependency from CPU APIs
      clk: tegra30: Use Tegra CPU powergate helper function

Jordan Crouse (2):
      clk: qcom: gdsc: Don't override existing gdsc pd functions
      clk: qcom: Add a dummy enable function for GX gdsc

Julia Lawall (5):
      clk: max77686: constify clk_ops structure
      clk: palmas: constify clk_ops structure
      clk: pistachio: constify clk_ops structures
      clk: pxa: constify clk_ops structures
      clk: s2mps11: constify clk_ops structure

Katsuhiro Suzuki (4):
      clk: rockchip: fix I2S1 clock gate register for rk3328
      clk: rockchip: fix ID of 8ch clock of I2S1 for rk3328
      clk: rockchip: add clock ID of ACODEC for rk3328
      clk: rockchip: add clock-id to gate of ACODEC for rk3328

Loic Poulain (1):
      clk: qcom: msm8916: Additional clock rates for spi

Lucas Stach (6):
      dt-bindings: Add binding for i.MX8MQ CCM
      clk: imx: Add fractional PLL output clock
      clk: imx: Add SCCG PLL type
      clk: imx6q: reset exclusive gates on init
      clk: imx6q: optionally get CCM inputs via standard clock handles
      clk: imx6q: handle ENET PLL bypass

Marcel Ziswiler (1):
      clk: tegra: get rid of duplicate defines

Marek Vasut (1):
      clk: vc5: Add suspend/resume support

Mark Yao (1):
      clk: rockchip: make rk3188 hclk_vio_bus critical

Martin Blumenstingl (17):
      dt-bindings: clock: meson8b: export the CPU post dividers
      dt-bindings: clock: meson8b: use the registers from the HHI syscon
      clk: meson: meson8b: use the HHI syscon if available
      clk: meson: meson8b: fix incorrect divider mapping in cpu_scale_table
      clk: meson: meson8b: fix the width of the cpu_scale_div clock
      clk: meson: clk-pll: check if the clock is already enabled
      clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
      clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
      clk: meson: meson8b: add support for more M/N values in sys_pll
      clk: meson: meson8b: run from the XTAL when changing the CPU frequency
      clk: meson: meson8b: allow changing the CPU clock tree
      clk: meson: clk-regmap: add read-only gate ops
      clk: meson: meson8b: rename cpu_div2/cpu_div3 to cpu_in_div2/cpu_in_div3
      clk: meson: meson8b: add the CPU clock post divider clocks
      clk: meson: meson8b: fix the offset of vid_pll_dco's N value
      clk: meson: meson8b: add the fractional divider for vid_pll_dco
      clk: meson: meson8b: add the read-only video clock trees

Matti Vaittinen (7):
      clk: Add kerneldoc to managed of-provider interfaces
      clk: of-provider: look at parent if registered device has no provider info
      clk: clk-hi655x: Free of_provider at remove
      clk: rk808: use managed version of of_provider registration
      clk: clk-twl6040: Free of_provider at remove
      clk: apcs-msm8916: simplify probe cleanup by using devm
      clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

Mesih Kilinc (2):
      dt-bindings: clock: Add Allwinner suniv F1C100s CCU
      clk: sunxi-ng: add support for suniv F1C100s SoC

Neil Armstrong (5):
      clk: meson: Add vid_pll divider driver
      clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
      dt-bindings: clk: meson-gxbb: Add Video clock bindings
      clk: meson-gxbb: Add video clocks
      clk: meson: Fix GXL HDMI PLL fractional bits width

Niklas Söderlund (3):
      clk: renesas: rcar-gen3: Set state when registering SD clocks
      clk: renesas: rcar-gen3: Add documentation for SD clocks
      clk: renesas: rcar-gen3: Add HS400 quirk for SD clock

Rob Herring (1):
      clk: Use of_node_name_eq for node name comparisons

Robert Yang (1):
      clk: tegra: Return the exact clock rate from clk_round_rate

Ryder Lee (3):
      clk: mediatek: add clock support for MT7629 SoC
      dt-bindings: arm: mediatek: document clk bindings for MT7629
      clk: mediatek: fix the PCIe MAC clock parent

Sergei Shtylyov (1):
      clk: renesas: r8a77970: Add RPC clocks

Stefan Wahren (2):
      clk: bcm2835: make license text and module license match
      clk: bcm2835: Switch to SPDX identifier

Stephen Boyd (34):
      Merge tag 'clk-renesas-for-v4.21-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      clk: renesas: Mark rza2_cpg_clk_register static
      clk: mediatek: Drop __init from mtk_clk_register_cpumuxes()
      clk: mediatek: Drop more __init markings for driver probe
      Merge tag 'meson-clk-4.21-1' of https://github.com/BayLibre/clk-meson into clk-meson
      clk: meson: Mark some things static
      clk: qcom: Add xo dummy clk on msm8998
      Merge tag 'clk-renesas-for-v4.21-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-4.21' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      clk: qcom: Move to menuconfig and reduce lines
      clk: renesas: Remove usage of CLK_IS_BASIC
      clk: st: Remove usage of CLK_IS_BASIC
      clk: axm5516: Remove usage of CLK_IS_BASIC
      clk: h8300: Remove usage of CLK_IS_BASIC
      clk: hisilicon: Remove usage of CLK_IS_BASIC
      clk: versatile: sp810: Remove usage of CLK_IS_BASIC
      clk: samsung: s3c2410: Remove usage of CLK_IS_BASIC
      clk: Loongson1: Remove usage of CLK_IS_BASIC
      clk: Tag clk core files with SPDX
      clk: Tag basic clk types with SPDX
      Merge tag 'meson-clk-4.21-2' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'v4.21-rockchip-clk-1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge branches 'clk-bcm-module-license', 'clk-boston-leak' and 'clk-mtk-mt7629' into clk-next
      Merge branches 'clk-qoriq-t1023', 'clk-protected-binding', 'clk-define-show-macro' and 'clk-static' into clk-next
      Merge branches 'clk-qcom-kconfig', 'clk-qcom-gpucc', 'clk-qcom-qcs404-rpm', 'clk-qcom-spi' and 'clk-qcom-videocc-binding' into clk-next
      Merge branch 'clk-qcom-sdm845-lpass' into clk-next
      Merge branches 'clk-managed-registration', 'clk-spdx', 'clk-remove-basic' and 'clk-ops-const' into clk-next
      Merge branches 'clk-renesas', 'clk-allwinner', 'clk-tegra', 'clk-meson' and 'clk-rockchip' into clk-next
      Merge branches 'clk-imx7ulp', 'clk-imx6-fixes', 'clk-imx-fixes', 'clk-imx8qxp' and 'clk-imx8mq' into clk-next
      Merge branch 'clk-qcom-8998-resets' into clk-next
      Merge branch 'clk-fixes' into clk-next
      Merge branch 'clk-vc5-suspend' into clk-next
      Merge branch 'clk-of' into clk-next
      Merge branch 'clk-imx7ulp' into clk-next

Takeshi Kihara (1):
      clk: renesas: r8a77990: Correct parent clock of DU

Taniya Das (4):
      clk: qcom: smd: Add support for QCS404 rpm clocks
      dt-bindings: clock: Update GCC bindings for protected-clocks
      dt-bindings: clock: Introduce QCOM LPASS clock bindings
      clk: qcom: Add lpass clock controller driver for SDM845

Yangtao Li (2):
      clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
      clk: tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro

Yi Wang (2):
      clk: boston: fix possible memory leak in clk_boston_setup()
      clk: boston: unregister clks on failure in clk_boston_setup()

Yuantian Tang (1):
      clk: qoriq: add more chips support

YueHaibing (1):
      clk: stm32mp1: drop pointless static qualifier in stm32_register_hw_clk()

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   37 +-
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,sgmiisys.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/clock/amlogic,meson8b-clkc.txt        |   13 +-
 .../devicetree/bindings/clock/imx6q-clock.txt      |    3 +
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  104 ++
 .../devicetree/bindings/clock/imx8mq-clock.txt     |   20 +
 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |   51 +
 .../devicetree/bindings/clock/qcom,gcc.txt         |   16 +
 .../devicetree/bindings/clock/qcom,gpucc.txt       |   22 +
 .../devicetree/bindings/clock/qcom,lpasscc.txt     |   26 +
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    1 +
 .../devicetree/bindings/clock/qcom,videocc.txt     |    3 +-
 .../devicetree/bindings/clock/sun8i-de2.txt        |    5 +-
 .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +
 drivers/clk/Kconfig                                |    9 +
 drivers/clk/Makefile                               |    3 +-
 drivers/clk/bcm/clk-bcm2835-aux.c                  |   13 +-
 drivers/clk/bcm/clk-bcm2835.c                      |   14 +-
 drivers/clk/clk-axm5516.c                          |    2 -
 drivers/clk/clk-bd718x7.c                          |  123 ++
 drivers/clk/clk-bulk.c                             |   13 +-
 drivers/clk/clk-composite.c                        |   13 +-
 drivers/clk/clk-conf.c                             |    5 +-
 drivers/clk/clk-devres.c                           |    7 +-
 drivers/clk/clk-divider.c                          |    5 +-
 drivers/clk/clk-fixed-factor.c                     |    7 +-
 drivers/clk/clk-fixed-rate.c                       |    5 +-
 drivers/clk/clk-fractional-divider.c               |   15 +-
 drivers/clk/clk-gate.c                             |    5 +-
 drivers/clk/clk-gpio.c                             |    5 +-
 drivers/clk/clk-hi655x.c                           |    4 +-
 drivers/clk/clk-max77686.c                         |    2 +-
 drivers/clk/clk-multiplier.c                       |    5 +-
 drivers/clk/clk-mux.c                              |    5 +-
 drivers/clk/clk-nomadik.c                          |   16 +-
 drivers/clk/clk-palmas.c                           |    2 +-
 drivers/clk/clk-qoriq.c                            |   11 +
 drivers/clk/clk-rk808.c                            |   15 +-
 drivers/clk/clk-s2mps11.c                          |    2 +-
 drivers/clk/clk-stm32mp1.c                         |    2 +-
 drivers/clk/clk-twl6040.c                          |    5 +-
 drivers/clk/clk-versaclock5.c                      |   25 +
 drivers/clk/clk.c                                  |   47 +-
 drivers/clk/clk.h                                  |    7 +-
 drivers/clk/h8300/clk-h8s2678.c                    |    2 +-
 drivers/clk/hisilicon/clk-hi3620.c                 |    2 +-
 drivers/clk/hisilicon/clk-hisi-phase.c             |    2 +-
 drivers/clk/hisilicon/clk-hix5hd2.c                |    2 +-
 drivers/clk/hisilicon/clkgate-separated.c          |    2 +-
 drivers/clk/imgtec/clk-boston.c                    |   21 +-
 drivers/clk/imx/Kconfig                            |   22 +
 drivers/clk/imx/Makefile                           |   19 +-
 drivers/clk/imx/clk-busy.c                         |    2 +-
 drivers/clk/imx/clk-composite-7ulp.c               |   87 ++
 drivers/clk/imx/clk-composite-8m.c                 |  178 +++
 drivers/clk/imx/clk-divider-gate.c                 |  221 +++
 drivers/clk/imx/clk-fixup-mux.c                    |    2 +-
 drivers/clk/imx/clk-frac-pll.c                     |  232 ++++
 drivers/clk/imx/clk-imx6q.c                        |   93 +-
 drivers/clk/imx/clk-imx6sl.c                       |    6 +
 drivers/clk/imx/clk-imx7d.c                        |    3 -
 drivers/clk/imx/clk-imx7ulp.c                      |  249 ++++
 drivers/clk/imx/clk-imx8mq.c                       |  589 ++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |  216 +++
 drivers/clk/imx/clk-imx8qxp-lpcg.h                 |  102 ++
 drivers/clk/imx/clk-imx8qxp.c                      |  153 ++
 drivers/clk/imx/clk-lpcg-scu.c                     |  116 ++
 drivers/clk/imx/clk-pfdv2.c                        |  203 +++
 drivers/clk/imx/clk-pllv4.c                        |  184 +++
 drivers/clk/imx/clk-sccg-pll.c                     |  256 ++++
 drivers/clk/imx/clk-scu.c                          |  270 ++++
 drivers/clk/imx/clk-scu.h                          |   18 +
 drivers/clk/imx/clk.c                              |   22 +
 drivers/clk/imx/clk.h                              |  160 ++-
 drivers/clk/loongson1/clk.c                        |    8 +-
 drivers/clk/mediatek/Kconfig                       |   23 +
 drivers/clk/mediatek/Makefile                      |    3 +
 drivers/clk/mediatek/clk-cpumux.c                  |    8 +-
 drivers/clk/mediatek/clk-mt7622.c                  |    4 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |  159 +++
 drivers/clk/mediatek/clk-mt7629-hif.c              |  156 +++
 drivers/clk/mediatek/clk-mt7629.c                  |  723 ++++++++++
 drivers/clk/meson/Makefile                         |    3 +-
 drivers/clk/meson/axg-audio.c                      |   83 +-
 drivers/clk/meson/clk-input.c                      |   44 +
 drivers/clk/meson/clk-pll.c                        |   19 +
 drivers/clk/meson/clk-regmap.c                     |    5 +
 drivers/clk/meson/clk-regmap.h                     |    1 +
 drivers/clk/meson/clkc.h                           |   11 +
 drivers/clk/meson/gxbb.c                           |  779 ++++++++++-
 drivers/clk/meson/gxbb.h                           |   26 +-
 drivers/clk/meson/meson8b.c                        | 1463 +++++++++++++++++---
 drivers/clk/meson/meson8b.h                        |   69 +-
 drivers/clk/meson/vid-pll-div.c                    |   91 ++
 drivers/clk/pistachio/clk-pll.c                    |    8 +-
 drivers/clk/pxa/clk-pxa.c                          |    4 +-
 drivers/clk/qcom/Kconfig                           |   61 +-
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/apcs-msm8916.c                    |    6 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |   45 +
 drivers/clk/qcom/gcc-msm8916.c                     |    4 +
 drivers/clk/qcom/gcc-msm8998.c                     |  271 +++-
 drivers/clk/qcom/gcc-sdm845.c                      |   35 +
 drivers/clk/qcom/gdsc.c                            |    6 +-
 drivers/clk/qcom/gpucc-sdm845.c                    |  252 ++++
 drivers/clk/qcom/lpasscc-sdm845.c                  |  179 +++
 drivers/clk/renesas/clk-div6.c                     |    2 +-
 drivers/clk/renesas/clk-mstp.c                     |    4 +-
 drivers/clk/renesas/r7s9210-cpg-mssr.c             |    9 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    1 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |    5 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    4 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |   15 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    8 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |   57 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    2 +-
 drivers/clk/rockchip/clk-rk3188.c                  |   13 +-
 drivers/clk/rockchip/clk-rk3328.c                  |    4 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c             |    2 +-
 drivers/clk/st/clk-flexgen.c                       |    2 +-
 drivers/clk/st/clkgen-fsyn.c                       |    4 +-
 drivers/clk/st/clkgen-pll.c                        |    2 +-
 drivers/clk/sunxi-ng/Kconfig                       |    6 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   48 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   10 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   43 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |   71 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h               |    4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |   11 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |  541 ++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |   34 +
 drivers/clk/sunxi-ng/ccu_mp.c                      |   64 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |   18 +-
 drivers/clk/tegra/clk-audio-sync.c                 |    3 +-
 drivers/clk/tegra/clk-dfll.c                       |   12 +-
 drivers/clk/tegra/clk-pll.c                        |    7 +-
 drivers/clk/tegra/clk-tegra-audio.c                |    7 +-
 drivers/clk/tegra/clk-tegra-periph.c               |    3 -
 drivers/clk/tegra/clk-tegra114.c                   |    9 +-
 drivers/clk/tegra/clk-tegra124.c                   |    9 +-
 drivers/clk/tegra/clk-tegra20.c                    |   46 +-
 drivers/clk/tegra/clk-tegra210.c                   |    9 +-
 drivers/clk/tegra/clk-tegra30.c                    |   15 +-
 drivers/clk/tegra/clk.h                            |    4 +-
 drivers/clk/ti/clkctrl.c                           |    2 +-
 drivers/clk/ti/dpll.c                              |    2 +-
 drivers/clk/ux500/u8500_of_clk.c                   |   10 +-
 drivers/clk/versatile/clk-sp810.c                  |    2 +-
 drivers/soc/tegra/pmc.c                            |    2 -
 include/dt-bindings/clock/bcm2835-aux.h            |   10 +-
 include/dt-bindings/clock/bcm2835.h                |   10 +-
 include/dt-bindings/clock/gxbb-clkc.h              |   18 +
 include/dt-bindings/clock/imx6qdl-clock.h          |    4 +-
 include/dt-bindings/clock/imx7ulp-clock.h          |  116 ++
 include/dt-bindings/clock/imx8mq-clock.h           |  395 ++++++
 include/dt-bindings/clock/imx8qxp-clock.h          |  289 ++++
 include/dt-bindings/clock/meson8b-clkc.h           |    4 +
 include/dt-bindings/clock/mt7629-clk.h             |  203 +++
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |   94 ++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |    2 +
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
 include/dt-bindings/clock/qcom,rpmcc.h             |    4 +
 include/dt-bindings/clock/r8a7795-cpg-mssr.h       |    2 +-
 include/dt-bindings/clock/r8a7796-cpg-mssr.h       |    2 +-
 include/dt-bindings/clock/r8a77995-cpg-mssr.h      |    5 +-
 include/dt-bindings/clock/rk3328-cru.h             |    3 +-
 include/dt-bindings/clock/sun8i-de2.h              |    3 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |   70 +
 include/dt-bindings/firmware/imx/rsrc.h            |  559 ++++++++
 include/dt-bindings/reset/sun8i-de2.h              |    1 +
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |   38 +
 include/linux/clk-provider.h                       |   15 +-
 include/linux/clk/clk-conf.h                       |    5 +-
 include/linux/firmware/imx/sci.h                   |    1 +
 include/linux/firmware/imx/svc/pm.h                |   85 ++
 include/linux/firmware/imx/types.h                 |  552 --------
 include/soc/tegra/pmc.h                            |    2 -
 190 files changed, 11000 insertions(+), 1352 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 drivers/clk/clk-bd718x7.c
 create mode 100644 drivers/clk/imx/Kconfig
 create mode 100644 drivers/clk/imx/clk-composite-7ulp.c
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-divider-gate.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.h
 create mode 100644 drivers/clk/imx/clk-imx8qxp.c
 create mode 100644 drivers/clk/imx/clk-lpcg-scu.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 drivers/clk/imx/clk-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.h
 create mode 100644 drivers/clk/mediatek/clk-mt7629-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7629-hif.c
 create mode 100644 drivers/clk/mediatek/clk-mt7629.c
 create mode 100644 drivers/clk/meson/clk-input.c
 create mode 100644 drivers/clk/meson/vid-pll-div.c
 create mode 100644 drivers/clk/qcom/gpucc-sdm845.c
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h
 create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
 create mode 100644 include/dt-bindings/clock/mt7629-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/firmware/imx/rsrc.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
 create mode 100644 include/linux/firmware/imx/svc/pm.h

-- 
Sent by a computer through tubes
