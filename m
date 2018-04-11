Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeDKIlX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:41:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:56707 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbeDKIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:41:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="190595680"
Message-ID: <1523436077.16235.5.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.17-rc1
From: Zhang Rui <rui.zhang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 11 Apr 2018 16:41:17 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.17-rc1 with
top-most commit f8837aac36cdc7430422cd65f4466071b42654bb:

  Merge branches 'thermal-core' and 'thermal-soc' into next (2018-04-02 
21:49:31 +0800)

on top of commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

Specifics:

- Fix race condition in imx_thermal_probe(). (Mikhail Lappo)

- Add cooling device's statistics in sysfs. (Viresh Kumar)

- add support for i.MX7 thermal sensor in imx_thermal driver. (Anson
Huang)

- add support for MT7622 SoC in mtk_thermal driver. (Sean Wang)

- Remove unused min/max cpu cooling DT property. (Viresh Kumar).

- A series of fixes on exynos driver. (Bartlomiej Zolnierkiewicz,
Maciej Purski, Marek Szyprowski)

thanks,
rui



----------------------------------------------------------------
Anson Huang (1):
      thermal: imx: add i.MX7 thermal sensor support

Bartlomiej Zolnierkiewicz (10):
      thermal: exynos: remove unused "type" field from struct
exynos_tmu_platform_data
      thermal: exynos: remove parsing of samsung,
tmu_default_temp_offset property
      thermal: exynos: remove parsing of samsung, tmu_[first,
second]_point_trim properties
      thermal: exynos: remove parsing of samsung, tmu_noise_cancel_mode
property
      thermal: exynos: remove parsing of samsung, tmu[_min,
_max]_efuse_value properties
      thermal: exynos: remove parsing of samsung, tmu_reference_voltage
property
      thermal: exynos: remove parsing of samsung,tmu_gain property
      thermal: exynos: remove parsing of samsung, tmu_cal_type property
      thermal: exynos: remove separate exynos_tmu.h header file
      dt-bindings: thermal: remove no longer needed samsung thermal
properties

Maciej Purski (1):
      thermal: exynos: Read soc_type from match data

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is
turned on
      thermal: exynos: Propagate error value from tmu_read()

Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()

Sean Wang (2):
      dt-bindings: thermal: add binding for MT7622 SoC
      thermal: mediatek: add support for MT7622 SoC

Viresh Kumar (2):
      dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
      thermal: Add cooling device's statistics in sysfs

Zhang Rui (2):
      Merge branch 'linus' of git://git.kernel.org/.../evalenti/linux-
soc-thermal into thermal-soc
      Merge branches 'thermal-core' and 'thermal-soc' into next

 .../devicetree/bindings/thermal/exynos-thermal.txt |  23 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../devicetree/bindings/thermal/thermal.txt        |  16 +-
 Documentation/thermal/sysfs-api.txt                |  31 +++
 drivers/thermal/Kconfig                            |   7 +
 drivers/thermal/imx_thermal.c                      | 301
++++++++++++++++-----
 drivers/thermal/mtk_thermal.c                      |  35 +++
 drivers/thermal/samsung/exynos_tmu.c               | 268 +++++++++--
-------
 drivers/thermal/samsung/exynos_tmu.h               |  75 -----
 drivers/thermal/thermal_core.c                     |   3 +-
 drivers/thermal/thermal_core.h                     |  10 +
 drivers/thermal/thermal_helpers.c                  |   5 +-
 drivers/thermal/thermal_sysfs.c                    | 225
+++++++++++++++
 include/linux/thermal.h                            |   1 +
 15 files changed, 706 insertions(+), 304 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
