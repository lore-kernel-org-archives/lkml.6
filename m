Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeC0N7q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:59:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40100 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeC0N7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:59:44 -0400
X-Google-Smtp-Source: AG47ELu+I95+8PH2q8QbyWqz4/W9U3S14SHSsN0s0SGwO9zuIMTSpJMwxAZohiTsvAXk7D27Wd79dQ==
Date: Tue, 27 Mar 2018 06:59:43 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal SoC management updates for v4.17-rc1
Message-ID: <20180327135942.GA11104@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

Please find thermal-soc changes for v4.17-rc1 as follows.

- New i.MX7 thermal sensor
- Mediatek driver now supports MT7622 SoC
- Fixes on exynos driver
- Removal of min max cpu cooling dt property

Despite my local testing, this has been tested by kernelci bot:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.16-rc1-16-g9db4c0feaf87/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.16-rc1-16-g9db4c0feaf87/

BR,

Eduardo

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 2db48884bb51f2ad26b1b716297ceaab624a2e68:

  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties (2018-03-27 06:43:05 -0700)

----------------------------------------------------------------
Anson Huang (1):
      thermal: imx: add i.MX7 thermal sensor support

Bartlomiej Zolnierkiewicz (10):
      thermal: exynos: remove unused "type" field from struct exynos_tmu_platform_data
      thermal: exynos: remove parsing of samsung, tmu_default_temp_offset property
      thermal: exynos: remove parsing of samsung, tmu_[first, second]_point_trim properties
      thermal: exynos: remove parsing of samsung, tmu_noise_cancel_mode property
      thermal: exynos: remove parsing of samsung, tmu[_min, _max]_efuse_value properties
      thermal: exynos: remove parsing of samsung, tmu_reference_voltage property
      thermal: exynos: remove parsing of samsung,tmu_gain property
      thermal: exynos: remove parsing of samsung, tmu_cal_type property
      thermal: exynos: remove separate exynos_tmu.h header file
      dt-bindings: thermal: remove no longer needed samsung thermal properties

Maciej Purski (1):
      thermal: exynos: Read soc_type from match data

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is turned on
      thermal: exynos: Propagate error value from tmu_read()

Sean Wang (2):
      dt-bindings: thermal: add binding for MT7622 SoC
      thermal: mediatek: add support for MT7622 SoC

Viresh Kumar (1):
      dt-bindings: thermal: Remove "cooling-{min|max}-level" properties

 .../devicetree/bindings/thermal/exynos-thermal.txt |  23 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../devicetree/bindings/thermal/thermal.txt        |  16 +-
 drivers/thermal/imx_thermal.c                      | 295 ++++++++++++++++-----
 drivers/thermal/mtk_thermal.c                      |  35 +++
 drivers/thermal/samsung/exynos_tmu.c               | 268 ++++++++++---------
 drivers/thermal/samsung/exynos_tmu.h               |  75 ------
 8 files changed, 423 insertions(+), 299 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
