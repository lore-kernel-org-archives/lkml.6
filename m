Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeBFO6K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:58:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:39231 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeBFO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:58:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,469,1511856000";
   d="scan'208";a="27735542"
Message-ID: <1517929070.3034.16.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.16-rc1
From: Zhang Rui <rui.zhang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date: Tue, 06 Feb 2018 22:57:50 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.16-rc1 with
top-most commit 134f4010799a30acd969e603985c27b9f3e6f58d:

  Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc' into
next (2018-01-15 13:57:18 +0800)

on top of commit 464e1d5f23cca236b930ef068c328a64cab78fb1:

  Linux 4.15-rc5 (2017-12-23 20:47:16 -0800)

Specifics:
 - Fix a race condition issue in power allocator governor (Yi Zeng).
 - Add support for AP806 and CP110 in armada thermal driver, together
with several improvements (Baruch Siach, Miquel Raynal).
 - Add support for r8z7743 in rcar thermal driver (Biju Das).
 - convert thermal core to use new hwmon API to avoid warning (Fabio
Estevam).
 - Small fixes and cleanups in thermal core and x86_pkg_thermal,
int3400_thermal, hisi_thermal, mtk_thermal and imx_thermal drivers
(Pravin Shedge, Geert Uytterhoeven, Alexey Khoroshilov, Brian Bian,
Matthias Brugger, Nicolin Chen, Uwe Kleine-König).

thanks,
rui
----------------------------------------------------------------
Alexey Khoroshilov (1):
      thermal: int3400_thermal: fix error handling in
int3400_thermal_probe()

Baruch Siach (4):
      dt-bindings: thermal: Describe Armada AP806 and CP110
      thermal: armada: Use msleep for long delays
      thermal: armada: Add support for Armada AP806
      thermal: armada: Add support for Armada CP110

Biju Das (1):
      dt-bindings: thermal: rcar: Add device tree support for r8a7743

Brian Bian (1):
      thermal: int3400_thermal: Ignore Unknown Notification Codes

Fabio Estevam (1):
      thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()

Geert Uytterhoeven (2):
      thermal/drivers/hisi: Remove bogus const from function return
type
      thermal/x86 pkg temp: Remove debugfs_create_u32() casts

Matthias Brugger (1):
      thermal: mtk: Cleanup unused defines

Miquel Raynal (7):
      thermal: armada: Simplify the check of the validity bit
      thermal: armada: Clarify control registers accesses
      thermal: armada: Use real status register name
      thermal: armada: Update Kconfig and module description
      thermal: armada: Change sensors trim default value
      thermal: armada: Wait sensors validity before exiting the init
callback
      thermal: armada: Give meaningful names to the thermal zones

Nicolin Chen (1):
      thermal: tegra: remove forward declarations

Pravin Shedge (1):
      drivers: thermal: remove duplicate includes

Uwe Kleine-König (4):
      thermal: imx: Use better parameter names than "val"
      thermal: imx: improve comments describing algorithm for temp
calculation
      thermal: imx: use consistent style to write temperatures
      thermal: imx: update to new formula according to NXP AN5215

Yi Zeng (1):
      thermal: power_allocator: fix one race condition issue for
thermal_instances list

Zhang Rui (2):
      Merge branch 'linus' of git://git.kernel.org/.../evalenti/linux-
soc-thermal into thermal-soc
      Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc'
into next

 .../devicetree/bindings/thermal/armada-thermal.txt |  37 ++-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   1 +
 drivers/thermal/Kconfig                            |   4 +-
 drivers/thermal/armada_thermal.c                   | 253
+++++++++++++++------
 drivers/thermal/hisi_thermal.c                     |   2 +-
 drivers/thermal/imx_thermal.c                      |  74 +++---
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  12 +-
 drivers/thermal/mtk_thermal.c                      |   9 +-
 drivers/thermal/of-thermal.c                       |   1 -
 drivers/thermal/power_allocator.c                  |   2 +
 drivers/thermal/tegra/soctherm.c                   | 103 ++++-----
 drivers/thermal/thermal_hwmon.c                    |  20 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   4 +-
 13 files changed, 312 insertions(+), 210 deletions(-)
