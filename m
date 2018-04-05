Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeDEVXw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:23:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36181 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeDEVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:23:51 -0400
X-Google-Smtp-Source: AIpwx4/nmy0nBqzckQbiGkOyMvEdeQEKmAv3aPdsEjWsnZlNspMU3Pg9cJ0qWkZzX7HmYWtDPX1UbCbzRgc48JYIr2k=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 23:23:49 +0200
X-Google-Sender-Auth: NH1HvFlz96gROkkp7N3DxJZ_y3Q
Message-ID: <CAK8P3a1rJc+3MMMwcYSZ0n14=5e_1v_UdnHexysuqy4RfQPxmA@mail.gmail.com>
Subject: [GIT PULL 3/3] ARM: SoC driver updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35LNxXP020785

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-drivers

for you to fetch changes up to 7df3f0bb5f90e3470de2798452000e221420059c:

  Merge tag 'v4.17-rockchip-drivers-1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip
into next/drivers (2018-03-28 17:08:34 +0200)

----------------------------------------------------------------
ARM: SoC driver updates for 4.17

The main addition this time around is the new ARM "SCMI" framework,
which is the latest in a series of standards coming from ARM to do power
management in a platform independent way. This has been through many
review cycles, and it relies on a rather interesting way of using the
mailbox subsystem, but in the end I agreed that Sudeep's version was
the best we could do after all.

Other changes include:

- the ARM CCN driver is moved out of drivers/bus into drivers/perf,
  which makes more sense. Similarly, the performance monitoring
  portion of the CCI driver are moved the same way and cleaned up
  a little more.

- a series of updates to the SCPI framework

- support for the Mediatek mt7623a SoC in drivers/soc

- support for additional NVIDIA Tegra hardware in drivers/soc

- a new reset driver for Socionext Uniphier

- lesser bug fixes in drivers/soc, drivers/tee, drivers/memory, and
  drivers/firmware and drivers/reset across platforms

----------------------------------------------------------------
Anders Roxell (1):
      firmware: arm_scmi: prevent accessing rate_discrete uninitialized

Anson Huang (1):
      soc: imx: gpc: ARM power domain should be always-on

Arnd Bergmann (16):
      Merge tag 'reset-for-4.17' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'scpi-updates-4.17' of
ssh://gitolite.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'scmi-updates-4.17' of
ssh://gitolite.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'soc_drivers_for_4.17' of
ssh://gitolite.kernel.org/.../ssantosh/linux-keystone into
next/drivers
      Merge tag 'tee-drv-misc-for-v4.17' of
https://git.linaro.org:/people/jens.wiklander/linux-tee into
next/drivers
      Merge tag 'samsung-drivers-4.17' of
ssh://gitolite.kernel.org/.../krzk/linux into next/drivers
      cpufreq: scmi: add thermal dependency
      Merge tag 'imx-drivers-4.17' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'tegra-for-4.17-firmware' of
ssh://gitolite.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.17-soc-2' of
ssh://gitolite.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'v4.16-next-soc' of
ssh://gitolite.kernel.org/.../matthias.bgg/linux into next/drivers
      Merge tag 'amlogic-drivers' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'qcom-drivers-for-4.17' of
ssh://gitolite.kernel.org/.../agross/linux into next/drivers
      Merge tag 'scmi-fixes-4.17' of
ssh://gitolite.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'reset-for-4.17-2' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'v4.17-rockchip-drivers-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/drivers

Bartosz Golaszewski (2):
      reset: add support for non-DT systems
      reset: modify the way reset lookup works for board files

Bjorn Andersson (2):
      soc: qcom: rmtfs-mem: Add support for assigning memory to remote
      soc: qcom: wcnss_ctrl: Fix increment in NV upload

Gabriel Fernandez (2):
      dt-bindings: reset: add STM32MP1 resets
      reset: stm32mp1: Enable stm32mp1 reset driver

Heiner Kallweit (12):
      soc: amlogic: meson-gx-pwrc-vpu: don't print error message on
probe deferral
      soc: amlogic: meson-gx-pwrc-vpu: fix error on shutdown when
domain is powered off
      firmware: arm_scpi: remove two unneeded devm_kfree's in scpi_remove
      firmware: arm_scpi: make freeing mbox channels device-managed
      firmware: arm_scpi: make scpi_probe completely device-managed
      firmware: arm_scpi: improve struct dvfs_info to make code better readable
      firmware: arm_scpi: improve handling of protocol and firmware
version subfields
      firmware: arm_scpi: improve struct sensor_value
      firmware: arm_scpi: fix incorrect __iomem accesses using correct accessors
      firmware: arm_scpi: remove struct sensor_capabilities
      firmware: arm_scpi: use FIELD_GET/_PREP to simplify macro definitions
      firmware: arm_scpi: improve info message for pre-1.0 firmware

Jeffy Chen (2):
      soc: rockchip: power-domain: use clk_bulk APIs
      soc: rockchip: power-domain: Add a sanity check on pd->num_clks

Joel Stanley (2):
      dt-bindings: aspeed-lpc: Add reset controller
      reset: simple: Enable for ASPEED systems

Julia Lawall (1):
      firmware: tegra: adjust tested variable

Jérôme Forissier (2):
      tee: optee: GET_OS_REVISION: document a2 as a build identifier
      tee: optee: report OP-TEE revision information

Katsuhiro Suzuki (1):
      reset: uniphier: add Pro4/Pro5/PXs2 audio systems reset control

Krzysztof Kozlowski (3):
      memory: samsung: Add SPDX license identifiers
      soc: samsung: Add SPDX license identifiers to headers
      soc: samsung: pmu: Populate children syscon nodes

Kunihiko Hayashi (1):
      reset: uniphier: add ethernet reset control support for PXs3

Martin Blumenstingl (1):
      reset: meson: enable level reset support on Meson8b

Masahiro Yamada (1):
      reset: imx7: add 'depends on HAS_IOMEM' to fix unmet dependency

Mikko Perttunen (3):
      firmware: tegra: Simplify channel management
      soc/tegra: Add Tegra194 SoC configuration option
      soc/tegra: pmc: Add Tegra194 compatibility string

Neil Armstrong (1):
      amlogic: meson-gx-socinfo: Update soc ids

Peng Fan (1):
      tee: correct max value for id allocation

Peter De Schrijver (1):
      soc/tegra: pmc: MBIST work around for Tegra210

Philipp Zabel (1):
      Merge branch 'reset/lookup' into reset/next

Robin Murphy (6):
      drivers/bus: Move Arm CCN PMU driver
      drivers/bus: Split Arm CCI driver
      perf/arm-cci: Simplify CPU hotplug
      bus/arm-cci: Streamline devicetree handling a bit
      perf/arm-cci: Clean up model discovery
      perf/arm-cci: Untangle global cci_ctrl_base

SF Markus Elfring (1):
      memory-EMIF: Use seq_putc() in emif_regdump_show()

Sean Wang (5):
      dt-bindings: soc: add SCPSYS binding for MT7623 and MT7623A SoC
      dt-bindings: soc: add header files required for MT7623A SCPSYS dt-binding
      soc: mediatek: avoid hardcoded value with bus_prot_mask
      soc: mediatek: add SCPSYS power domain driver for MediaTek MT7623A SoC
      soc: mediatek: fix the mistaken pointer accessed when subdomains are added

Shawn Lin (1):
      soc: rockchip: disable jtag switching for RK3228/RK3229 SoCs

Sudeep Holla (25):
      firmware: arm_scpi: drop unnecessary type cast to scpi_shared_mem
      firmware: arm_scpi: remove all single element structures
      dt-bindings: mailbox: add support for mailbox client shared memory
      dt-bindings: arm: add support for ARM System Control and
Management Interface(SCMI) protocol
      firmware: arm_scmi: add basic driver infrastructure for SCMI
      firmware: arm_scmi: add common infrastructure and support for
base protocol
      firmware: arm_scmi: add scmi protocol bus to enumerate protocol devices
      firmware: arm_scmi: add initial support for performance protocol
      firmware: arm_scmi: add initial support for clock protocol
      firmware: arm_scmi: add initial support for power protocol
      firmware: arm_scmi: add initial support for sensor protocol
      firmware: arm_scmi: probe and initialise all the supported protocols
      firmware: arm_scmi: add support for polling based SCMI transfers
      firmware: arm_scmi: add option for polling based performance
domain operations
      firmware: arm_scmi: refactor in preparation to support
per-protocol channels
      firmware: arm_scmi: add per-protocol channels support using idr objects
      firmware: arm_scmi: add device power domain support using genpd
      clk: add support for clocks provided by SCMI
      hwmon: (core) Add hwmon_max to hwmon_sensor_types enumeration
      hwmon: add support for sensors exported via ARM SCMI
      cpufreq: add support for CPU DVFS based on SCMI message protocol
      cpufreq: scmi: add support for fast frequency switching
      firmware: meson-sm: rework meson_sm_init to use
module_platform_driver_probe
      hwmon: (scmi) return -EINVAL when sensor information is unavailable
      clk: scmi: use devm_of_clk_add_hw_provider() API and drop
scmi_clocks_remove

Thierry Reding (1):
      soc/tegra: pmc: Pass PMC to tegra_powergate_power_up()

Vivek Gautam (1):
      soc/tegra: pmc: Use the new reset APIs to manage reset controllers

Wei Yongjun (1):
      memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe()

Xiao Yao (1):
      soc: rockchip: disable jtag switching for RK3128 SoCs

weiyi.lu@mediatek.com (2):
      dt-bindings: soc: update MT2712 power dt-bindings
      soc: mediatek: update power domain data of MT2712

weiyongjun (A) (2):
      meson-mx-socinfo: Make local function meson_mx_socinfo_init() static
      meson-gx-socinfo: make local function meson_gx_socinfo_init static

 Documentation/devicetree/bindings/arm/arm,scmi.txt |  179 ++
 .../devicetree/bindings/arm/samsung/pmu.txt        |    6 +
 .../devicetree/bindings/mailbox/mailbox.txt        |   28 +
 .../devicetree/bindings/mfd/aspeed-lpc.txt         |   21 +
 .../bindings/{arm/ccn.txt => perf/arm-ccn.txt}     |    0
 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |    6 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |    5 +-
 Documentation/{arm/CCN.txt => perf/arm-ccn.txt}    |    0
 MAINTAINERS                                        |   11 +-
 drivers/bus/Kconfig                                |   36 -
 drivers/bus/Makefile                               |    2 -
 drivers/bus/arm-cci.c                              | 1763 +-------------------
 drivers/clk/Kconfig                                |   10 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-scmi.c                             |  194 +++
 drivers/cpufreq/Kconfig.arm                        |   12 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/scmi-cpufreq.c                     |  264 +++
 drivers/firmware/Kconfig                           |   34 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/arm_scmi/Makefile                 |    5 +
 drivers/firmware/arm_scmi/base.c                   |  253 +++
 drivers/firmware/arm_scmi/bus.c                    |  221 +++
 drivers/firmware/arm_scmi/clock.c                  |  343 ++++
 drivers/firmware/arm_scmi/common.h                 |  105 ++
 drivers/firmware/arm_scmi/driver.c                 |  871 ++++++++++
 drivers/firmware/arm_scmi/perf.c                   |  481 ++++++
 drivers/firmware/arm_scmi/power.c                  |  221 +++
 drivers/firmware/arm_scmi/scmi_pm_domain.c         |  129 ++
 drivers/firmware/arm_scmi/sensors.c                |  291 ++++
 drivers/firmware/arm_scpi.c                        |  211 +--
 drivers/firmware/meson/meson_sm.c                  |   25 +-
 drivers/firmware/tegra/bpmp.c                      |  144 +-
 drivers/hwmon/Kconfig                              |   12 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/scmi-hwmon.c                         |  225 +++
 drivers/memory/emif.c                              |    2 +-
 drivers/memory/samsung/Kconfig                     |    1 +
 drivers/memory/samsung/Makefile                    |    1 +
 drivers/memory/samsung/exynos-srom.c               |   18 +-
 drivers/memory/samsung/exynos-srom.h               |    7 +-
 drivers/memory/ti-emif-pm.c                        |    1 -
 drivers/perf/Kconfig                               |   33 +
 drivers/perf/Makefile                              |    2 +
 drivers/perf/arm-cci.c                             | 1722 +++++++++++++++++++
 drivers/{bus => perf}/arm-ccn.c                    |    0
 drivers/reset/Kconfig                              |   17 +-
 drivers/reset/Makefile                             |    1 +
 drivers/reset/core.c                               |   96 +-
 drivers/reset/reset-meson.c                        |   22 +-
 drivers/reset/reset-simple.c                       |    2 +
 drivers/reset/reset-stm32mp1.c                     |  115 ++
 drivers/reset/reset-uniphier.c                     |    5 +
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            |    9 +-
 drivers/soc/amlogic/meson-gx-socinfo.c             |   12 +-
 drivers/soc/amlogic/meson-mx-socinfo.c             |    2 +-
 drivers/soc/imx/gpc.c                              |    1 +
 drivers/soc/mediatek/mtk-scpsys.c                  |  104 +-
 drivers/soc/qcom/Kconfig                           |    1 +
 drivers/soc/qcom/rmtfs_mem.c                       |   34 +
 drivers/soc/qcom/wcnss_ctrl.c                      |    2 +-
 drivers/soc/rockchip/grf.c                         |   28 +
 drivers/soc/rockchip/pm_domains.c                  |   95 +-
 drivers/soc/samsung/exynos-pmu.c                   |    7 +
 drivers/soc/tegra/Kconfig                          |   10 +
 drivers/soc/tegra/pmc.c                            |   98 +-
 drivers/tee/optee/core.c                           |   23 +
 drivers/tee/optee/optee_smc.h                      |   10 +-
 drivers/tee/tee_core.c                             |   14 +-
 include/dt-bindings/power/mt2712-power.h           |    3 +
 include/dt-bindings/power/mt7623a-power.h          |   10 +
 include/dt-bindings/reset/stm32mp1-resets.h        |  108 ++
 include/linux/hwmon.h                              |    1 +
 include/linux/reset-controller.h                   |   30 +
 include/linux/scmi_protocol.h                      |  277 +++
 include/linux/soc/mediatek/infracfg.h              |    4 +
 include/linux/soc/samsung/exynos-pmu.h             |    5 +-
 include/linux/soc/samsung/exynos-regs-pmu.h        |    6 +-
 include/soc/tegra/bpmp.h                           |    4 +-
 79 files changed, 6864 insertions(+), 2191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt
 rename Documentation/devicetree/bindings/{arm/ccn.txt =>
perf/arm-ccn.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
 rename Documentation/{arm/CCN.txt => perf/arm-ccn.txt} (100%)
 create mode 100644 drivers/clk/clk-scmi.c
 create mode 100644 drivers/cpufreq/scmi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scmi/Makefile
 create mode 100644 drivers/firmware/arm_scmi/base.c
 create mode 100644 drivers/firmware/arm_scmi/bus.c
 create mode 100644 drivers/firmware/arm_scmi/clock.c
 create mode 100644 drivers/firmware/arm_scmi/common.h
 create mode 100644 drivers/firmware/arm_scmi/driver.c
 create mode 100644 drivers/firmware/arm_scmi/perf.c
 create mode 100644 drivers/firmware/arm_scmi/power.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_pm_domain.c
 create mode 100644 drivers/firmware/arm_scmi/sensors.c
 create mode 100644 drivers/hwmon/scmi-hwmon.c
 create mode 100644 drivers/perf/arm-cci.c
 rename drivers/{bus => perf}/arm-ccn.c (100%)
 create mode 100644 drivers/reset/reset-stm32mp1.c
 create mode 100644 include/dt-bindings/power/mt7623a-power.h
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h
 create mode 100644 include/linux/scmi_protocol.h
