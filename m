Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeFBVdR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 17:33:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38168 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFBVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 17:33:15 -0400
X-Google-Smtp-Source: ADUXVKLUvEkFDgFrXHRmuJO23trcPT9F8mqfg9z3pf/cC6/qiLnI3PhzKXH88C/H1+yu9fXn1EPESA==
Date: Sat, 2 Jun 2018 14:33:12 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal SoC management updates for v4.18-rc1 #1
Message-ID: <20180602213310.GA30328@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

Please pull the changes for thermal-soc for coming v4.18-rc1.
Changelog:
- imx thermal driver now supports i.MX7 thermal sensor
- exynos thermal driver dropped support for exynos 5440
- rcar_thermal now supports r8a77995
- rcar_gen3_thermal now supports r8a77965
- qcom-spmi-temp-alarm now supports GEN2 PMIC peripherals
- uniphier thermal now supports UniPhier PXs3
- mediatek thermal now supports MT7622 SoC
- considerable refactoring of exynos driver
- Fixes all over the place on different drivers.

Additional KernelCI Testing:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.17-rc3-359-g6d7c70d1cd65/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.17-rc3-359-g6d7c70d1cd65/

BR,

Eduardo

The following changes since commit 701e39d05119229b92ecca4add7b7ed2193622c3:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2018-05-06 05:46:29 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 6d7c70d1cd6526dc79e3d3b3faae1c40c1681168:

  thermal: qcom: tsens: Allow number of sensors to come from DT (2018-06-01 15:09:15 -0700)

----------------------------------------------------------------
Anson Huang (1):
      thermal: imx: add i.MX7 thermal sensor support

Bartlomiej Zolnierkiewicz (28):
      thermal: exynos: remove unused "type" field from struct exynos_tmu_platform_data
      thermal: exynos: remove parsing of samsung, tmu_default_temp_offset property
      thermal: exynos: remove parsing of samsung, tmu_[first, second]_point_trim properties
      thermal: exynos: remove parsing of samsung, tmu_noise_cancel_mode property
      thermal: exynos: remove parsing of samsung, tmu[_min, _max]_efuse_value properties
      thermal: exynos: remove parsing of samsung, tmu_reference_voltage property
      thermal: exynos: remove parsing of samsung,tmu_gain property
      thermal: exynos: remove parsing of samsung, tmu_cal_type property
      thermal: exynos: remove separate exynos_tmu.h header file
      thermal: exynos: fix setting rising_threshold for Exynos5433
      thermal: exynos: always check for trips points existence
      thermal: exynos: always check for critical trip points existence
      thermal: exynos: check STATUS register in exynos_tmu_initialize()
      thermal: exynos: use sanitize_temp_error() in exynos7_tmu_initialize()
      thermal: exynos: fix trips limit checking in get_th_reg()
      thermal: exynos: remove threshold_code checking from exynos4210_tmu_initialize()
      thermal: exynos: make ->tmu_initialize method void
      thermal: exynos: clear IRQs later in exynos4412_tmu_initialize()
      thermal: exynos: move IRQs clearing to exynos_tmu_initialize()
      thermal: exynos: add exynos*_tmu_set_[trip,hyst]() helpers
      thermal: exynos: do not use trips structure directly in ->tmu_initialize
      thermal: exynos: set trips in ascending order in exynos7_tmu_initialize()
      thermal: exynos: move trips setting to exynos_tmu_initialize()
      thermal: exynos: check return values of ->get_trip_[temp, hyst] methods
      thermal: exynos: cleanup code for enabling threshold interrupts
      thermal: exynos: remove unused defines for Exynos5433
      thermal: exynos: remove trip reporting to user-space
      thermal: ti-soc-thermal: fix incorrect entry in omap5430_adc_to_temp[]

Bjorn Andersson (1):
      thermal: qcom: tsens: Allow number of sensors to come from DT

David Collins (1):
      thermal: qcom-spmi-temp-alarm: add support for GEN2 PMIC peripherals

Ezequiel Garcia (1):
      thermal: tegra: Nuke clk_{readl,writel} helpers

Fabio Estevam (1):
      thermal: imx: Switch to SPDX identifier

Hien Dang (1):
      thermal: rcar_gen3_thermal: Update calculation formula due to HW evaluation

Krzysztof Kozlowski (2):
      thermal: samsung: Remove support for Exynos5440
      thermal: exynos: Reduce severity of too early temperature read

Kunihiko Hayashi (2):
      dt-bindings: thermal: uniphier: add a compatible string for PXs3
      thermal: uniphier: add UniPhier PXs3 support

Maciej Purski (1):
      thermal: exynos: Read soc_type from match data

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is turned on
      thermal: exynos: Propagate error value from tmu_read()

Niklas Söderlund (3):
      thermal: rcar_gen3_thermal: update max temperature clamp
      dt-bindings: thermal: rcar-gen3-thermal: add r8a77965
      thermal: rcar_gen3_thermal: add r8a77965 support

Ryder Lee (1):
      thermal: mediatek: use of_device_get_match_data()

Sean Wang (2):
      dt-bindings: thermal: add binding for MT7622 SoC
      thermal: mediatek: add support for MT7622 SoC

Yoshihiro Kaneko (2):
      dt-bindings: thermal: rcar-thermal: add R8A77995 support
      thermal: rcar_thermal: add r8a77995 support

srplinux2008 (1):
      thermal: tegra: soctherm: add const to struct thermal_cooling_device_ops

 .../devicetree/bindings/thermal/exynos-thermal.txt |  14 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../devicetree/bindings/thermal/qcom-tsens.txt     |   1 +
 .../bindings/thermal/rcar-gen3-thermal.txt         |   3 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   7 +-
 .../bindings/thermal/uniphier-thermal.txt          |   1 +
 drivers/thermal/imx_thermal.c                      | 306 +++++--
 drivers/thermal/mtk_thermal.c                      |  40 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |  92 +-
 drivers/thermal/qcom/tsens.c                       |  12 +-
 drivers/thermal/rcar_gen3_thermal.c                |  17 +-
 drivers/thermal/rcar_thermal.c                     | 158 +++-
 drivers/thermal/samsung/exynos_tmu.c               | 971 ++++++++-------------
 drivers/thermal/samsung/exynos_tmu.h               |  75 --
 drivers/thermal/tegra/soctherm.c                   |  31 +-
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   2 +-
 drivers/thermal/uniphier_thermal.c                 |   4 +
 18 files changed, 861 insertions(+), 883 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
