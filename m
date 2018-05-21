Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeEUMJB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:09:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38618 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752644AbeEUMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:08:59 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 00/33] use match_string() helper
Date: Mon, 21 May 2018 19:57:37 +0800
Message-ID: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy introduce helper function match_string() which can be used to return
the index of array for a matching string. so we can use it in many places
intead of open coded variant.

I just try to make this API be used more commonly, sorry if this makes
too much big patchset.

Yisheng Xie (33):
  usb: phy: use match_string() helper
  mfd: omap-usb-host: use match_string() helper
  Staging: gdm724x: use match_string() helper
  gpiolib-of: use match_string() helper
  cxgb4: use match_string() helper
  hp100: use match_string() helper
  iwlwifi: mvm: use match_string() helper
  vfio: use match_string() helper
  phy: tegra: use match_string() helper
  pata_hpt37x: use match_string() helper
  bus: fsl-mc: use match_string() helper
  clk: bcm2835: use match_string() helper
  clk: rockchip: use match_string() helper
  clk: use match_string() helper
  cpufreq: intel_pstate: use match_string() helper
  mmc: sdhci-xenon: use match_string() helper
  pinctrl: armada-37xx: use match_string() helper
  power: supply: use match_string() helper
  thermal: db8500: use match_string() helper
  video: fbdev: pxafb: use match_string() helper
  drm/nouveau: use match_string() helper
  drm/i915: use match_string() helper
  drm: i2c: ch7006: use match_string() helper
  drm: use match_string() helper
  ima: use match_string() helper
  apparmor: use match_string() helper
  sched/debug: use match_string() helper
  ALSA: dice use match_string() helper
  ALSA: oxfw: use match_string() helper
  ALSA: oxygen: use match_string() helper
  ASoC: max98088: use match_string() helper
  ASoC: max98095: use match_string() helper
  ASoC: dapm: use match_string() helper

 drivers/ata/pata_hpt37x.c                        | 13 +++++-------
 drivers/bus/fsl-mc/fsl-mc-allocator.c            | 24 +++++------------------
 drivers/clk/bcm/clk-bcm2835.c                    | 14 ++++++-------
 drivers/clk/clk.c                                |  8 ++------
 drivers/clk/rockchip/clk.c                       | 16 +++++----------
 drivers/cpufreq/intel_pstate.c                   | 15 ++++++--------
 drivers/gpio/gpiolib-of.c                        |  7 +------
 drivers/gpu/drm/drm_panel_orientation_quirks.c   |  7 ++-----
 drivers/gpu/drm/i2c/ch7006_drv.c                 | 13 +++++-------
 drivers/gpu/drm/i915/intel_pipe_crc.c            | 22 ++++++++++-----------
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c        | 13 +++++-------
 drivers/mfd/omap-usb-host.c                      | 24 ++---------------------
 drivers/mmc/host/sdhci-xenon-phy.c               | 11 +++--------
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c   | 14 ++++---------
 drivers/net/ethernet/hp/hp100.c                  |  9 +--------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 11 +++--------
 drivers/phy/tegra/xusb.c                         | 15 +-------------
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c      | 16 ++-------------
 drivers/power/supply/power_supply_core.c         | 16 ++++++---------
 drivers/staging/gdm724x/gdm_tty.c                | 16 ++++-----------
 drivers/thermal/db8500_thermal.c                 |  8 +++-----
 drivers/usb/phy/of.c                             | 12 +++++-------
 drivers/vfio/vfio.c                              | 11 +++--------
 drivers/video/fbdev/pxafb.c                      |  6 ++----
 kernel/sched/debug.c                             | 20 +++++++++----------
 security/apparmor/lsm.c                          | 25 +++++++++++-------------
 security/integrity/ima/ima_main.c                | 11 ++++-------
 sound/firewire/dice/dice.c                       |  8 +-------
 sound/firewire/oxfw/oxfw.c                       |  8 +-------
 sound/pci/oxygen/oxygen_mixer.c                  | 13 ++++++------
 sound/soc/codecs/max98088.c                      |  9 +++------
 sound/soc/codecs/max98095.c                      | 11 ++++-------
 sound/soc/soc-dapm.c                             | 18 +++++++----------
 33 files changed, 137 insertions(+), 307 deletions(-)

-- 
1.7.12.4
