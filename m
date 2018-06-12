Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B670CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D9208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7D9208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934567AbeFLQXW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:23:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:41852 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934151AbeFLQXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:23:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 09:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="63953655"
Received: from weideng-mobl2.ccr.corp.intel.com ([10.255.30.49])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2018 09:23:18 -0700
Message-ID: <1528820596.2661.34.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.18-rc1 #2
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Date:   Wed, 13 Jun 2018 00:23:16 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
thermal.git linus

to receive the latest Thermal SoC management updates for v4.18-rc1 with
top-most commit 6d7c70d1cd6526dc79e3d3b3faae1c40c1681168:

  thermal: qcom: tsens: Allow number of sensors to come from DT (2018-
06-01 15:09:15 -0700)

on top of commit 701e39d05119229b92ecca4add7b7ed2193622c3:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
(2018-05-06 05:46:29 -1000)

Specifics:

- imx thermal driver now supports i.MX7 thermal sensor (Anson Huang).

- exynos thermal driver dropped support for exynos 5440 (Krzysztof
Kozlowski).

- rcar_thermal now supports r8a77995 (Yoshihiro Kaneko).

- rcar_gen3_thermal now supports r8a77965 (Niklas Söderlund).

- qcom-spmi-temp-alarm now supports GEN2 PMIC peripherals (David
Collins).

- uniphier thermal now supports UniPhier PXs3 (Kunihiko Hayashi).

- mediatek thermal now supports MT7622 SoC (Sean Wang).

- considerable refactoring of exynos driver (Bartlomiej
Zolnierkiewicz).

- Small fixes all over the place on different drivers.

thanks,
rui

----------------------------------------------------------------
Anson Huang (1):
      thermal: imx: add i.MX7 thermal sensor support

Bartlomiej Zolnierkiewicz (28):
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
      thermal: exynos: fix setting rising_threshold for Exynos5433
      thermal: exynos: always check for trips points existence
      thermal: exynos: always check for critical trip points existence
      thermal: exynos: check STATUS register in exynos_tmu_initialize()
      thermal: exynos: use sanitize_temp_error() in
exynos7_tmu_initialize()
      thermal: exynos: fix trips limit checking in get_th_reg()
      thermal: exynos: remove threshold_code checking from
exynos4210_tmu_initialize()
      thermal: exynos: make ->tmu_initialize method void
      thermal: exynos: clear IRQs later in exynos4412_tmu_initialize()
      thermal: exynos: move IRQs clearing to exynos_tmu_initialize()
      thermal: exynos: add exynos*_tmu_set_[trip,hyst]() helpers
      thermal: exynos: do not use trips structure directly in
->tmu_initialize
      thermal: exynos: set trips in ascending order in
exynos7_tmu_initialize()
      thermal: exynos: move trips setting to exynos_tmu_initialize()
      thermal: exynos: check return values of ->get_trip_[temp, hyst]
methods
      thermal: exynos: cleanup code for enabling threshold interrupts
      thermal: exynos: remove unused defines for Exynos5433
      thermal: exynos: remove trip reporting to user-space
      thermal: ti-soc-thermal: fix incorrect entry in
omap5430_adc_to_temp[]

Bjorn Andersson (1):
      thermal: qcom: tsens: Allow number of sensors to come from DT

David Collins (1):
      thermal: qcom-spmi-temp-alarm: add support for GEN2 PMIC
peripherals

Ezequiel Garcia (1):
      thermal: tegra: Nuke clk_{readl,writel} helpers

Fabio Estevam (1):
      thermal: imx: Switch to SPDX identifier

Hien Dang (1):
      thermal: rcar_gen3_thermal: Update calculation formula due to HW
evaluation

Krzysztof Kozlowski (2):
      thermal: samsung: Remove support for Exynos5440
      thermal: exynos: Reduce severity of too early temperature read

Kunihiko Hayashi (2):
      dt-bindings: thermal: uniphier: add a compatible string for PXs3
      thermal: uniphier: add UniPhier PXs3 support

Maciej Purski (1):
      thermal: exynos: Read soc_type from match data

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is
turned on
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
      thermal: tegra: soctherm: add const to struct
thermal_cooling_device_ops

 .../devicetree/bindings/thermal/exynos-thermal.txt |  14 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../devicetree/bindings/thermal/qcom-tsens.txt     |   1 +
 .../bindings/thermal/rcar-gen3-thermal.txt         |   3 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   7 +-
 .../bindings/thermal/uniphier-thermal.txt          |   1 +
 drivers/thermal/imx_thermal.c                      | 306 +++++--
 drivers/thermal/mtk_thermal.c                      |  40 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |  92 +-
 drivers/thermal/qcom/tsens.c                       |  12 +-
 drivers/thermal/rcar_gen3_thermal.c                |  17 +-
 drivers/thermal/rcar_thermal.c                     | 158 +++-
 drivers/thermal/samsung/exynos_tmu.c               | 971 ++++++++-----
--------
 drivers/thermal/samsung/exynos_tmu.h               |  75 --
 drivers/thermal/tegra/soctherm.c                   |  31 +-
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   2 +-
 drivers/thermal/uniphier_thermal.c                 |   4 +
 18 files changed, 861 insertions(+), 883 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
