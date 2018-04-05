Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeDEVWy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:22:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34312 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeDEVWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:22:52 -0400
X-Google-Smtp-Source: AIpwx4/CBf1No65H2LnpK4alEZI4lMCrhi8aKIO6b+kpM6MloR3djwEuEK+y+1pw5Mo+whtBDILLYuRIztSHL+YnWL8=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 23:22:50 +0200
X-Google-Sender-Auth: bB2i7yMhhDN2m_m-X4V6R7E4RbY
Message-ID: <CAK8P3a3Cr34cOcUbxbznHHvUdz1qd0=YLBF8-cc6NF5cgFmK1g@mail.gmail.com>
Subject: [GIT PULL 2/3] ARM: SoC platform updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to cd903711fd9dce808b5cc07e509135886d962b0c:

  arm: npcm: modify configuration for the NPCM7xx BMC. (2018-04-05
14:49:08 +0200)

----------------------------------------------------------------
ARM: SoC platform updates for 4.17

This release brings up a new platform based on the old ARM9 core: the
Nuvoton NPCM is used as a baseboard management controller, competing
with the better known ASpeed AST2xx series.

Another important change is the addition of ARMv7-A based chips
in mach-stm32. The older parts in this platform are ARMv7-M based
microcontrollers, now they are expanding to general-purpose workloads.

The other changes are the usual defconfig updates to enable additional
drivers, lesser bugfixes. The largest updates as often are the ongoing
OMAP cleanups, but we also have a number of changes for the older
PXA and davinci platforms this time.

For the Renesas shmobile/r-car platform, some new infrastructure
is needed to make the watchdog work correctly.

Supporting Multiprocessing on Allwinner A80 required a significant
amount of new code, but is not doing anything unexpected.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: reorder mach-*/Kconfig inclusions

Alexandre Torgue (2):
      ARM: stm32: Kconfig: introduce MACH_STM32F769 flag
      ARM: stm32: add new STM32F769 MCU

Amit Kucheria (3):
      arm64: defconfig: Enable the APCS IPC driver on Qualcomm platforms
      arm64: defconfig: enable thermal sensor on QCOM platforms
      arm64: defconfig: enable more cpufreq governors

Andy Shevchenko (1):
      ARM: pxa/raumfeld: use PROPERTY_ENTRY_U32() directly

Anson Huang (1):
      ARM: imx_v6_v7_defconfig: select the CONFIG_CPUFREQ_DT

Ard Biesheuvel (2):
      arm64: defconfig: add newly added accelerated crypto modules
      arm64: defconfig: add support for Socionext SynQuacer based platforms

Arnd Bergmann (33):
      Merge tag 'davinci-for-v4.17/soc' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'davinci-for-v4.17/defconfig' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'stm32-soc-for-v4.17-1' of
ssh://gitolite.kernel.org/.../atorgue/stm32 into next/soc
      Merge tag 'stm32-defconfig-for-v4.17-1' of
ssh://gitolite.kernel.org/.../atorgue/stm32 into next/soc
      Merge tag 'omap-for-v4.17/soc-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.17/timer-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.17/am-pm-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.17/ti-sysc-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'samsung-soc-4.17' of
ssh://gitolite.kernel.org/.../krzk/linux into next/soc
      Merge tag 'hisi-defconfig-for-4.17' of
git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'at91-ab-4.17-soc' of
ssh://gitolite.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'pxa-for-4.17' of https://github.com/rjarzmik/linux
into next/soc
      Merge tag 'arm-soc/for-4.17/defconfig' of
https://github.com/Broadcom/stblinux into next/soc
      Merge tag 'imx-soc-4.17' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/soc
      ARM: imx: select ARM_CPU_SUSPEND for CPU_IDLE as well
      ARM: imx: fix imx6sll-only build
      Merge tag 'imx-defconfig-4.17' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'tegra-for-4.17-arm64-defconfig' of
ssh://gitolite.kernel.org/.../tegra/linux into next/soc
      Merge tag 'renesas-arm64-defconfig-for-v4.17' of
ssh://gitolite.kernel.org/.../horms/renesas into next/soc
      Merge tag 'renesas-defconfig-for-v4.17' of
ssh://gitolite.kernel.org/.../horms/renesas into next/soc
      Merge tag 'omap-for-v4.17/defconfig-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'amlogic-defconfig' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/soc
      Merge tag 'armsoc-versatile-drm-defconfig' of
ssh://gitolite.kernel.org/.../linusw/linux-integrator into next/soc
      Merge tag 'qcom-arm64-defconfig-for-4.17' of
ssh://gitolite.kernel.org/.../agross/linux into next/soc
      Merge tag 'omap-for-v4.17/defconfig-pt2-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'stratix10_defconfig_for_v4.17' of
ssh://gitolite.kernel.org/.../dinguyen/linux into next/soc
      Merge tag 'sunxi-core-for-4.17' of
ssh://gitolite.kernel.org/.../sunxi/linux into next/soc
      Merge tag 'renesas-soc-for-v4.17' of
ssh://gitolite.kernel.org/.../horms/renesas into next/soc
      Merge tag 'samsung-soc-4.17-2' of
ssh://gitolite.kernel.org/.../krzk/linux into next/soc
      Merge tag 'omap-for-v4.17/soc-pt2-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'v4.17-rockchip-soc32-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/soc
      ARM: omap2: fix am43xx build without L2X0
      Merge tag 'davinci-for-v4.17/soc-2' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into next/soc

Bai Ping (2):
      ARM: imx: Improve the soc revision calculation flow
      ARM: imx: Add basic msl support for imx6sll

Benjamin Gaignard (2):
      ARM: stm32: Fix copyright
      ARM: stm32: restore reboot capabilities

Brendan Higgins (2):
      MAINTAINERS: Add entry for the Nuvoton NPCM architecture
      arm: npcm: add basic support for Nuvoton BMCs

Chen-Yu Tsai (7):
      ARM: sun9i: Support SMP bring-up on A80
      ARM: sun9i: smp: Support CPU/cluster power down and hotplugging for cpu1~7
      dt-bindings: ARM: sunxi: Document A80 SoC secure SRAM usage by SMP hotplug
      ARM: sun9i: smp: Support cpu0 hotplug
      ARM: sunxi: mc-smp: Fix "lookback" typo
      ARM: sunxi: mc-smp: Use DT enable-method for sun9i A80 SMP
      ARM: sunxi: mc-smp: Split out SoC-specific device node lookup sequence

Chunyan Zhang (1):
      MAINTAINERS: Add Spreadtrum SoC entry

Dave Gerlach (4):
      ARM: OMAP2+: Introduce low-level suspend code for AM33XX
      ARM: OMAP2+: Introduce low-level suspend code for AM43XX
      ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
      soc: ti: Add pm33xx driver for basic suspend support

David Lechner (8):
      phy: da8xx-usb: rename clock con_ids
      ARM: da8xx: use platform data for CFGCHIP syscon regmap
      ARM: davinci: remove watchdog reset
      ARM: davinci: move davinci_clk_init() to init_time
      ARM: davinci_all_defconfig: enable SYSCON_REBOOT_MODE
      ARM: davinci_all_defconfig: set CONFIG_DAVINCI_WATCHDOG=y
      ARM: davinci: da8xx: fix oops in USB PHY driver due to stack
allocated platform_data
      ARM: davinci: da8xx: simplify CFGCHIP regmap_config

Dinh Nguyen (1):
      arm64: defconfig: enable stmmac ethernet to defconfig

Fabio Estevam (8):
      ARM: imx_v6_v7_defconfig: Enable AC97 codec support
      ARM: imx: Remove epit support
      ARM: imx_v6_v7_defconfig: Re-sync defconfig
      ARM: imx: pm-imx6: Return the error directly
      ARM: imx_v6_v7_defconfig: Select CONFIG_SND_SOC_WM8962 explicitly
      ARM: imx_v4_v5_defconfig: Re-sync defconfig
      ARM: imx_v4_v5_defconfig: Use the generic fsl-asoc-card driver
      ARM: mxs_defconfig: Re-sync defconfig

Fabrizio Castro (3):
      soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
      ARM: shmobile: Add watchdog support
      ARM: shmobile: rcar-gen2: Add watchdog support

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2018-02-28' into defconfig/next

Geert Uytterhoeven (6):
      soc: renesas: rcar-sysc: Mark rcar_sysc_matches[] __initconst
      ARM: shmobile: rcar-gen2: Fix error check in regulator quirk
      ARM: shmobile: defconfig: Refresh
      ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
      ARM: nspire: Remove unneeded nspire_map_io()
      ARM: socfpga: PM: Drop useless check for PM_SUSPEND_STANDBY

Igor Grinberg (3):
      ARM: pxa: fix static checker warning in pxa3xx-ulpi
      ARM: pxa: cm-x300: remove inline directive
      ARM: pxa: ulpi: fix ulpi timeout and slowpath warn

Jacopo Mondi (4):
      ARM: shmobile: Enable RZA1 pin controller
      soc: renesas: Identify R-Car M3-N
      soc: renesas: rcar-sysc: Add R-Car M3-N support
      soc: renesas: rcar-rst: Add support for R-Car M3-N

Jeffy Chen (1):
      ARM: rockchip: Set name of pmu regmap_config in smp code

Jerome Brunet (1):
      arm64: defconfig: enable MESON EFUSE

Jisheng Zhang (1):
      MAINTAINERS: update entry for ARM/berlin

John Garry (1):
      arm64: defconfig: enable IOSCHED_DEADLINE

Keerthy (9):
      ARM: OMAP: dmtimer: Remove all the exports
      ARM: OMAP: timer: Wrap the inline functions under OMAP2PLUS define
      ARM: OMAP: Move dmtimer.h out of plat-omap
      clocksource: timer-ti-dm: Replace architecture
      ARM: OMAP: Move dmtimer driver out of plat-omap to drivers under
clocksource
      clocksource: timer-ti-dm: Add timer ops to the platform data structure
      clocksource: timer-ti-dm: Populate the timer ops to the pdata
      pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
      ARM: OMAP: pdata-quirks: Remove unused timer pdata

Kishon Vijay Abraham I (2):
      ARM: multi_v7_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
      ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Add SPDX license identifiers

Kunihiko Hayashi (1):
      arm64: defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

Ladislav Michl (4):
      clocksource: timer-ti-dm: Hook device platform data if not
already assigned
      clocksource: timer-ti-dm: Make unexported functions static
      clocksource: timer-ti-dm: Consolidate set source
      clocksource: timer-ti-dm: Check prescaler value

Linus Walleij (4):
      ARM: defconfig: Update RealView defconfig
      ARM: defconfig: Switch RealView boards to use P111 DRM
      ARM: defconfig: Update Versatile defconfig
      ARM: defconfig: Configure Versatile boards to use PL111 DRM

Ludovic Barre (4):
      ARM: configs: multi_v7: add stm32 support
      Documentation: arm: stm32: move to rst format
      ARM: stm32: prepare stm32 family to welcome armv7 architecture
      ARM: stm32: add initial support for STM32MP157

Marco Franchi (1):
      ARM: imx: Update imx_v6_v7_defconfig for mag3110 support

Marek Szyprowski (2):
      ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
      ARM: EXYNOS: Simplify code in coupled CPU idle hot path

Marek Vasut (1):
      ARM: shmobile: stout: enable R-Car Gen2 regulator quirk

Martin Kaiser (1):
      ARM: imx: avic: set low-power interrupt mask for imx25

Mikko Perttunen (3):
      arm64: defconfig: Enable NVIDIA Tegra194 support
      arm64: defconfig: Enable CONFIG_ARM_TEGRA186_CPUFREQ
      arm64: defconfig: Enable CONFIG_TEGRA_BPMP_THERMAL

Miquel Raynal (6):
      mtd: nand: use Marvell reworked NAND controller driver with all platforms
      mtd: nand: remove deprecated pxa3xx_nand driver
      mtd: nand: remove useless fields from pxa3xx NAND platform data
      dt-bindings: mtd: remove pxa3xx NAND controller documentation
      arm: dts: pxa: use reworked NAND controller driver
      MAINTAINERS: remove entry for deleted pxa3xx_nand driver

Neil Armstrong (1):
      ARM: configs: add OXNAS v6 defconfig

Nicolas Ferre (3):
      MAINTAINERS: ARM: at91: update entry for ARM/Microchip
      Documentation: at91: Update Microchip SoC documentation
      ARM: at91: Kconfig: Update company to Microchip

Patrice Chotard (2):
      ARM: configs: stm32: Enable MMC_ARMMMCI and EXT3_FS support
      ARM: stm32: Add AMBA support for STM32F4 and STM32F7 SoCs

Peng Fan (1):
      ARM: imx_v6_v7_defconfig: enable OP-TEE

Robert Jarzmik (1):
      Merge tag 'nand/pxa3xx-removal' of
git://git.infradead.org/linux-mtd into pxa/for-next

Sekhar Nori (1):
      ARM: davinci: board-da830-evm: fix unused const variable warning

Sergei Shtylyov (5):
      soc: renesas: identify R-Car V3H
      soc: renesas: rcar-rst: add R8A77980 support
      soc: renesas: r8a77970-sysc: fix power area parents
      dt-bindings: power: add R8A77980 SYSC power domain definitions
      soc: renesas: rcar-sysc: add R8A77980 support

Simon Horman (2):
      arm64: defconfig: enable R8A77980 SoC
      arm64: defconfig: enable R8A77965 SoC

Simon Shields (1):
      ARM: EXYNOS: Extend cpuidle support to Midas boards

Stefan Agner (8):
      ARM: imx: add timer stop flag to ARM power off state
      ARM: multi_v7_defconfig: configure I2C driver built-in
      ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
      ARM: multi_v7_defconfig: add GPMI NAND controller support
      ARM: multi_v7_defconfig: add NXP graphics drivers
      ARM: multi_v7_defconfig: add RN5T618 PMIC family support
      ARM: multi_v7_defconfig: enable thermal driver for i.MX devices
      ARM: multi_v7_defconfig: add NXP FlexCAN IP support

Stefan Riedmueller (1):
      ARM: imx_v6_v7_defconfig: Enable Dialog Semiconductor DA9062 driver

Stefan Wahren (2):
      ARM: bcm2385_defconfig: Enable BT support for BCM43438
      ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3

Suman Anna (7):
      ARM: OMAP2+: Cleanup omap_gpio_dev_attr usage
      ARM: OMAP2+: Cleanup omap_i2c_dev_attr usage
      ARM: OMAP2+: Cleanup omap_timer_capability_dev_attr usage
      ARM: OMAP2+: Cleanup omap2_spi_dev_attr and other legacy data
      ARM: OMAP2+: Cleanup omap_mcbsp_dev_attr and other legacy data
      ARM: OMAP: Move plat/i2c.h into mach-omap1 folder
      ARM: OMAP2+: Remove unused gpio header file references

Tero Kristo (2):
      ARM: omap2+: control: add support for auxiliary control module instances
      ARM: OMAP5: control: add support for control module wkup pad config

Thierry Reding (1):
      arm64: defconfig: Enable the Tegra SMMU by default

Tomer Maimon (1):
      arm: npcm: modify configuration for the NPCM7xx BMC.

Tony Lindgren (35):
      ARM: OMAP2+: Include types.h directly for hwmod data
      Merge branch 'omap-for-v.16/dmtimer-fix' into omap-for-v4.17/timer
      ARM: OMAP2+: Prepare to pass auxdata for smartreflex
      bus: ti-sysc: Add fck clock alias for children with notifier_block
      bus: ti-sysc: Add suspend and resume handling
      bus: ti-sysc: Handle stdout-path for debug console
      bus: ti-sysc: Improve handling for no-reset-on-init and no-idle-on-init
      bus: ti-sysc: Remove unnecessary debugging statements
      bus: ti-sysc: Add support for platform data callbacks
      bus: ti-sysc: Handle some devices in omap_device compatible way
      ARM: OMAP2+: Use v7_invalidate_l1 in omap4_finish_suspend
      ARM: OMAP2+: Fix typo for wakeup_ns_pa_addr
      ARM: OMAP2+: Add functions to allocate module data from device tree
      ARM: OMAP2+: Add checks for device tree based sysconfig data
      ARM: OMAP2+: Try to parse earlycon from parent too
      PM / AVS: SmartReflex: Prepare to use device tree based probing
      ARM: OMAP2+: Enable ti-sysc to use device tree data for smartreflex
      ARM: omap2plus_defconfig: Update for moved options
      ARM: omap2plus_defconfig: Add SERIAL_DEV for bluetooth
      ARM: omap2plus_defconfig: Select MFD_TI_LMU
      ARM: omap2plus_defconfig: Update LIRC options
      ARM: omap2plus_defconfig: Add SND_OSSEMUL
      ARM: omap2plus_defconfig: Drop unneeded options
      ARM: omap2plus_defconfig: Enable am335x and am437x PM options
      ARM: omap2plus_defconfig: Enable CEC
      ARM: omap2plus_defconfig: Switch to use omapdrm by default
      ARM: omap2plus_defconfig: Enable 8250_OMAP
      ARM: multi_v7_defconfig: Enable OTG and MUSB as loadable modules
      ARM: multi_v7_defconfig: Enable various USB PHYs found on omap variants
      ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module
      ARM: omap2plus_defconfig: Enable PWM_VIBRA
      ARM: omap2plus_defconfig: Add AUDIO_GRAPH_CARD
      ARM: omap2plus_defconfig: Enable MDM6600 USB PHY
      ARM: omap2plus_defconfig: Add UINPUT
      ARM: multi_v7_defconfig: Enable CPCAP related options mostly as
loadable modules

Tuomas Tynkkynen (1):
      ARM: multi_v7_defconfig: Enable serial console on RPi 3

Yoshihiro Shimoda (1):
      arm64: defconfig: Enable PWM and USB for R-Car

 Documentation/arm/{Atmel => Microchip}/README      |   52 +-
 Documentation/arm/stm32/overview.rst               |   34 +
 Documentation/arm/stm32/overview.txt               |   33 -
 Documentation/arm/stm32/stm32f429-overview.rst     |   26 +
 Documentation/arm/stm32/stm32f429-overview.txt     |   22 -
 Documentation/arm/stm32/stm32f746-overview.rst     |   33 +
 Documentation/arm/stm32/stm32f746-overview.txt     |   34 -
 Documentation/arm/stm32/stm32f769-overview.rst     |   35 +
 Documentation/arm/stm32/stm32h743-overview.rst     |   34 +
 Documentation/arm/stm32/stm32h743-overview.txt     |   30 -
 Documentation/arm/stm32/stm32mp157-overview.rst    |   19 +
 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 Documentation/devicetree/bindings/arm/omap/mpu.txt |   16 +
 .../devicetree/bindings/arm/sunxi/smp-sram.txt     |   44 +
 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   50 -
 .../bindings/power/renesas,rcar-sysc.txt           |    2 +
 .../devicetree/bindings/reset/renesas,rst.txt      |    2 +
 MAINTAINERS                                        |   88 +-
 arch/arm/Kconfig                                   |   54 +-
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/pxa3xx.dtsi                      |    6 +-
 arch/arm/configs/bcm2835_defconfig                 |    4 +
 arch/arm/configs/cm_x300_defconfig                 |    2 +-
 arch/arm/configs/davinci_all_defconfig             |    3 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    9 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   28 +-
 arch/arm/configs/multi_v7_defconfig                |   65 +-
 arch/arm/configs/mxs_defconfig                     |   14 +-
 arch/arm/configs/omap2plus_defconfig               |   99 +-
 arch/arm/configs/oxnas_v6_defconfig                |   93 +
 arch/arm/configs/pxa3xx_defconfig                  |    3 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 arch/arm/configs/raumfeld_defconfig                |    2 +-
 arch/arm/configs/realview_defconfig                |   21 +-
 arch/arm/configs/shmobile_defconfig                |    9 +-
 arch/arm/configs/stm32_defconfig                   |    3 +
 arch/arm/configs/versatile_defconfig               |   18 +-
 arch/arm/include/debug/exynos.S                    |    7 +-
 arch/arm/include/debug/samsung.S                   |   10 +-
 arch/arm/mach-at91/Kconfig                         |   14 +-
 arch/arm/mach-davinci/board-da830-evm.c            |   35 +-
 arch/arm/mach-davinci/board-da850-evm.c            |    7 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |    3 +-
 arch/arm/mach-davinci/board-dm355-leopard.c        |    3 +-
 arch/arm/mach-davinci/board-dm365-evm.c            |    3 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |    3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           |   21 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |    7 +-
 arch/arm/mach-davinci/board-neuros-osd2.c          |    3 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |    7 +-
 arch/arm/mach-davinci/board-sffsdr.c               |    3 +-
 arch/arm/mach-davinci/clock.h                      |    3 -
 arch/arm/mach-davinci/da830.c                      |    7 +-
 arch/arm/mach-davinci/da850.c                      |    7 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |    3 +-
 arch/arm/mach-davinci/davinci.h                    |    4 +
 arch/arm/mach-davinci/devices-da8xx.c              |   57 +-
 arch/arm/mach-davinci/devices.c                    |    7 +-
 arch/arm/mach-davinci/dm355.c                      |    8 +-
 arch/arm/mach-davinci/dm365.c                      |    8 +-
 arch/arm/mach-davinci/dm644x.c                     |    8 +-
 arch/arm/mach-davinci/dm646x.c                     |   22 +-
 arch/arm/mach-davinci/include/mach/common.h        |    2 -
 arch/arm/mach-davinci/include/mach/da8xx.h         |    7 +-
 arch/arm/mach-davinci/time.c                       |   57 -
 arch/arm/mach-davinci/usb-da8xx.c                  |   18 +-
 arch/arm/mach-exynos/exynos.c                      |    3 +-
 arch/arm/mach-exynos/pm.c                          |    8 +-
 arch/arm/mach-imx/Kconfig                          |   22 +-
 arch/arm/mach-imx/Makefile                         |    3 +-
 arch/arm/mach-imx/anatop.c                         |   56 +-
 arch/arm/mach-imx/avic.c                           |   37 +
 arch/arm/mach-imx/cpu.c                            |    3 +
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |    7 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |    1 +
 arch/arm/mach-imx/epit.c                           |  228 ---
 arch/arm/mach-imx/mach-imx6sl.c                    |   10 +-
 arch/arm/mach-imx/mxc.h                            |    6 +
 arch/arm/mach-imx/pm-imx6.c                        |    7 +-
 arch/arm/mach-mmp/aspenite.c                       |    6 +-
 arch/arm/mach-mmp/ttc_dkb.c                        |    9 +-
 arch/arm/mach-npcm/Kconfig                         |   30 +
 arch/arm/mach-npcm/Makefile                        |    4 +
 arch/arm/mach-npcm/headsmp.S                       |   17 +
 arch/arm/mach-npcm/npcm7xx.c                       |   20 +
 arch/arm/mach-npcm/platsmp.c                       |   81 +
 arch/arm/mach-nspire/nspire.c                      |    6 -
 arch/arm/mach-omap1/Kconfig                        |    1 +
 arch/arm/mach-omap1/common.h                       |    3 +-
 arch/arm/mach-omap1/i2c.c                          |    2 -
 .../{plat-omap/include/plat => mach-omap1}/i2c.h   |    9 +-
 arch/arm/mach-omap1/pm.c                           |    2 +-
 arch/arm/mach-omap1/timer.c                        |    2 +-
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile                       |   16 +
 arch/arm/mach-omap2/board-n8x0.c                   |    4 +-
 arch/arm/mach-omap2/common.h                       |    7 +
 arch/arm/mach-omap2/control.c                      |   20 +-
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/hsmmc.c                        |    2 -
 arch/arm/mach-omap2/i2c.h                          |   15 +-
 arch/arm/mach-omap2/io.c                           |    2 +
 arch/arm/mach-omap2/msdi.c                         |    1 -
 arch/arm/mach-omap2/omap4-sar-layout.h             |    2 +-
 arch/arm/mach-omap2/omap_device.c                  |    5 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  418 +++-
 arch/arm/mach-omap2/omap_hwmod.h                   |    7 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   11 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   61 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |    3 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   25 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    4 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  116 --
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    8 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   75 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   54 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   53 -
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   31 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 -
 arch/arm/mach-omap2/pdata-quirks.c                 |   86 +-
 arch/arm/mach-omap2/pm-asm-offsets.c               |   31 +
 arch/arm/mach-omap2/pm.h                           |    3 +
 arch/arm/mach-omap2/pm33xx-core.c                  |  189 ++
 arch/arm/mach-omap2/sleep33xx.S                    |  214 ++
 arch/arm/mach-omap2/sleep43xx.S                    |  391 ++++
 arch/arm/mach-omap2/sleep44xx.S                    |    7 +-
 arch/arm/mach-omap2/sr_device.c                    |   27 +-
 arch/arm/mach-omap2/timer.c                        |    2 +-
 arch/arm/mach-pxa/cm-x300.c                        |   14 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |    8 +-
 arch/arm/mach-pxa/colibri.h                        |    2 +-
 arch/arm/mach-pxa/littleton.c                      |   10 +-
 arch/arm/mach-pxa/mxm8x10.c                        |   10 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c                    |    6 +-
 arch/arm/mach-pxa/raumfeld.c                       |   12 +-
 arch/arm/mach-pxa/zylonite.c                       |   10 +-
 arch/arm/mach-rockchip/platsmp.c                   |    1 +
 arch/arm/mach-shmobile/common.h                    |    4 +
 arch/arm/mach-shmobile/headsmp.S                   |   55 +
 arch/arm/mach-shmobile/platsmp-apmu.c              |    1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |   15 +-
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |   25 +-
 arch/arm/mach-socfpga/pm.c                         |    1 -
 arch/arm/mach-stm32/Kconfig                        |   46 +-
 arch/arm/mach-stm32/board-dt.c                     |   11 +-
 arch/arm/mach-sunxi/Kconfig                        |    7 +
 arch/arm/mach-sunxi/Makefile                       |    3 +
 arch/arm/mach-sunxi/mc_smp.c                       |  856 ++++++++
 arch/arm/plat-omap/Kconfig                         |    6 -
 arch/arm/plat-omap/Makefile                        |    1 -
 arch/arm64/configs/defconfig                       |   39 +-
 drivers/bus/ti-sysc.c                              |  526 ++++-
 drivers/clocksource/Kconfig                        |    3 +
 drivers/clocksource/Makefile                       |    1 +
 .../dmtimer.c => drivers/clocksource/timer-ti-dm.c |  293 ++-
 drivers/mtd/nand/Kconfig                           |   11 -
 drivers/mtd/nand/Makefile                          |    1 -
 drivers/mtd/nand/marvell_nand.c                    |    3 +-
 drivers/mtd/nand/pxa3xx_nand.c                     | 2105 --------------------
 drivers/phy/ti/phy-da8xx-usb.c                     |   16 +-
 drivers/power/avs/smartreflex.c                    |   41 +-
 drivers/pwm/pwm-omap-dmtimer.c                     |   68 +-
 drivers/soc/renesas/Kconfig                        |   14 +-
 drivers/soc/renesas/Makefile                       |    2 +
 drivers/soc/renesas/r8a77965-sysc.c                |   37 +
 drivers/soc/renesas/r8a77970-sysc.c                |   12 +-
 drivers/soc/renesas/r8a77980-sysc.c                |   52 +
 drivers/soc/renesas/rcar-rst.c                     |   37 +-
 drivers/soc/renesas/rcar-sysc.c                    |    8 +-
 drivers/soc/renesas/rcar-sysc.h                    |    2 +
 drivers/soc/renesas/renesas-soc.c                  |   16 +
 drivers/soc/ti/Kconfig                             |    9 +
 drivers/soc/ti/Makefile                            |    1 +
 drivers/soc/ti/pm33xx.c                            |  349 ++++
 .../dmtimer.h => include/clocksource/timer-ti-dm.h |   44 +-
 include/dt-bindings/power/r8a77965-sysc.h          |   30 +
 include/dt-bindings/power/r8a77980-sysc.h          |   43 +
 include/linux/clk/ti.h                             |    1 +
 include/linux/platform_data/asoc-ti-mcbsp.h        |   12 -
 include/linux/platform_data/dmtimer-omap.h         |   38 +
 include/linux/platform_data/gpio-omap.h            |    5 -
 include/linux/platform_data/mtd-nand-pxa3xx.h      |   43 +-
 include/linux/platform_data/phy-da8xx-usb.h        |   21 +
 include/linux/platform_data/pm33xx.h               |   42 +
 include/linux/platform_data/spi-omap2-mcspi.h      |    8 -
 include/linux/platform_data/ti-sysc.h              |   50 +
 include/linux/power/smartreflex.h                  |   10 +-
 include/linux/serial_s3c.h                         |   17 +-
 189 files changed, 4979 insertions(+), 3965 deletions(-)
 rename Documentation/arm/{Atmel => Microchip}/README (64%)
 create mode 100644 Documentation/arm/stm32/overview.rst
 delete mode 100644 Documentation/arm/stm32/overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f429-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f746-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f769-overview.rst
 create mode 100644 Documentation/arm/stm32/stm32h743-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32h743-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32mp157-overview.rst
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
 create mode 100644 arch/arm/configs/oxnas_v6_defconfig
 delete mode 100644 arch/arm/mach-imx/epit.c
 create mode 100644 arch/arm/mach-npcm/Kconfig
 create mode 100644 arch/arm/mach-npcm/Makefile
 create mode 100644 arch/arm/mach-npcm/headsmp.S
 create mode 100644 arch/arm/mach-npcm/npcm7xx.c
 create mode 100644 arch/arm/mach-npcm/platsmp.c
 rename arch/arm/{plat-omap/include/plat => mach-omap1}/i2c.h (90%)
 create mode 100644 arch/arm/mach-omap2/pm-asm-offsets.c
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 arch/arm/mach-sunxi/mc_smp.c
 rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-ti-dm.c (87%)
 delete mode 100644 drivers/mtd/nand/pxa3xx_nand.c
 create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
 create mode 100644 drivers/soc/renesas/r8a77980-sysc.c
 create mode 100644 drivers/soc/ti/pm33xx.c
 rename arch/arm/plat-omap/include/plat/dmtimer.h =>
include/clocksource/timer-ti-dm.h (87%)
 create mode 100644 include/dt-bindings/power/r8a77965-sysc.h
 create mode 100644 include/dt-bindings/power/r8a77980-sysc.h
 create mode 100644 include/linux/platform_data/phy-da8xx-usb.h
 create mode 100644 include/linux/platform_data/pm33xx.h
