Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEKEwt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:52:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39556 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKEws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:52:48 -0400
X-Google-Smtp-Source: AB8JxZoMPJFEltwEY60hVKnQxMKzccNKAydinTcmIlEV8gjoap1Hxl3kq3l7woWYJjRwtPF6D8XqxSMf5N/W5BvmAA8=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 11 May 2018 14:52:45 +1000
Message-ID: <CAPM=9ty4nBiqr08zvz8skf8MXc0he_ggq5VjhCEdguAaGoY4ZQ@mail.gmail.com>
Subject: [git pull] drm fixes for v4.17-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4B4qwrJ016143

Hi Linus,

As last week seemed a bit slow, we got a few more fixes this week.

The main stuff is 2 weeks of fixes for amdgpu, some missing bits of
vega12 atom firmware support were added, and some power management
fixes.

Nouveau got two regression fixes for an DP MST deadlock and a random oops fix.

i915 got an LVDS panel timeout fix 2 WARN fixes.

exynos fixed a pagefault issue in the mixer driver.

vc4 has an oops fix.

omap had a bunch of uninit var and error-checking fixes.
Two atomic modesetting state fixes.

One minor agp cleanup patch

Regards,
Dave.

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc5

for you to fetch changes up to 72777fe79768ec30ac2163d26de68a89edc9849f:

  Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-05-11
10:37:17 +1000)

----------------------------------------------------------------
nouveau, amdgpu, i915, vc4, omap, exynos and atomic fixes

----------------------------------------------------------------
Andrey Grodzovsky (1):
      drm/amdgpu: Switch to interruptable wait to recover from ring hang.

Andrzej Hajda (2):
      drm/exynos/mixer: fix synchronization check in interlaced mode
      drm/bridge/sii8620: add Kconfig dependency on extcon

Ben Skeggs (1):
      drm/nouveau/ttm: don't dereference nvbo::cli, it can outlive client

Boris Brezillon (1):
      drm/vc4: Fix scaling of uni-planar formats

Dan Carpenter (1):
      drm/omap: silence unititialized variable warning

Dave Airlie (6):
      Merge tag 'exynos-drm-fixes-for-v4.17-rc5' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'drm-intel-fixes-2018-05-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-05-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'linux-4.17' of git://github.com/skeggsb/linux into drm-fixes
      Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Eric Anholt (1):
      drm/vc4: Fix oops dereferencing DPI's connector since panel_bridge.

Florent Flament (1):
      drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Harry Wentland (3):
      drm/amd/display: Add VG12 ASIC IDs
      drm/amd/display: Add get_firmware_info_v3_2 for VG12
      drm/amd/display: Don't return ddc result and read_bytes in same
return value

Jerry (Fangzhi) Zuo (1):
      drm/amd: Add BIOS smu_info v3_3 required struct def.

Lyude Paul (1):
      drm/nouveau: Fix deadlock in nv50_mstm_register_connector()

Mathieu Malaterre (1):
      agp: uninorth: make two functions static

Michel Dänzer (2):
      drm/amd/display: Use kvzalloc for potentially large allocations
      drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages

Peter Rosin (1):
      drm/exynos: hdmi: avoid duplicating drm_bridge_attach

Rex Zhu (2):
      drm/amd/pp: Refine the output of pp_power_profile_mode on VI
      drm/amd/pp: Fix performance drop on Fiji

Rodrigo Vivi (1):
      drm/i915: Adjust eDP's logical vco in a reliable place.

Tobias Jakobi (1):
      drm/exynos: mixer: avoid Oops in vp_video_buffer()

Tomi Valkeinen (6):
      drm/omap: fix uninitialized ret variable
      drm/omap: fix possible NULL ref issue in tiler_reserve_2d
      drm/omap: check return value from soc_device_match
      drm/omap: handle error if scale coefs are not found
      drm/omap: add missing linefeeds to prints
      drm/omap: handle alloc failures in omap_connector

Ville Syrjälä (3):
      drm/atomic: Clean old_state/new_state in drm_atomic_state_default_clear()
      drm/atomic: Clean private obj old_state/new_state in
drm_atomic_state_default_clear()
      drm/i915: Correctly populate user mode h/vdisplay with pipe src
size during readout

 drivers/char/agp/uninorth-agp.c                    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  20 ++-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  86 ++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |  14 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |   5 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   9 +-
 .../drm/amd/display/modules/color/color_gamma.c    |  72 ++++-----
 drivers/gpu/drm/amd/include/atomfirmware.h         | 170 ++++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  52 +++----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h   |   1 -
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |   4 +-
 drivers/gpu/drm/bridge/Kconfig                     |   1 +
 drivers/gpu/drm/drm_atomic.c                       |   8 +
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   2 -
 drivers/gpu/drm/exynos/exynos_mixer.c              |  22 ++-
 drivers/gpu/drm/exynos/regs-mixer.h                |   1 +
 drivers/gpu/drm/i915/intel_cdclk.c                 |  41 ++++-
 drivers/gpu/drm/i915/intel_display.c               |   2 +
 drivers/gpu/drm/i915/intel_dp.c                    |  20 ---
 drivers/gpu/drm/i915/intel_lvds.c                  |   3 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   1 -
 drivers/gpu/drm/nouveau/nouveau_bo.h               |   2 -
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |   6 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |   7 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |  20 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |   7 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   2 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |  10 ++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |   6 +-
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |   2 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |  11 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |   3 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |  25 ++-
 drivers/gpu/drm/vc4/vc4_plane.c                    |   2 +-
 37 files changed, 501 insertions(+), 158 deletions(-)
