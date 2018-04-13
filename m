Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDMC2j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 22:28:39 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:37052 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeDMC2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 22:28:37 -0400
X-Google-Smtp-Source: AIpwx49NvJNPRJOEfeBbQA34/a/iNxRynFRl3J4mGMDtD6CicvNZqlvA0TEOpJhhy5MMfaZfG8DlOnkebBNPdjXABag=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 13 Apr 2018 12:28:35 +1000
Message-ID: <CAPM=9tx8XR=fqHAgFug_jDZvCJHnJ6OY=8kNHOZerzJegjkYAw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Decloaking in the middle of holidays (still off all next week), just
to vacuum up any outstanding fixes for rc1.

One omap, and one alsa pm fix (we merged the breaking patch via drm tree).

Otherwise it's two bunches of amdgpu fixes, removing an unneeded file,
some DC fixes, HDMI audio
regression fix, and some vega12 fixes.

I didn't get any i915 fixes so I'm assuming they can wait until -rc2
if they have any, though I probably won't be
back until rc2 releases.

Thanks,
Dave.

The following changes since commit 694f54f680f7fd8e9561928fbfc537d9afbc3d79:

  Merge branch 'drm-misc-next-fixes' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2018-03-29
09:25:13 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc1

for you to fetch changes up to a10beabba213924d876f2d10ca9351aeab93f58a:

  Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2018-04-13
09:25:21 +1000)

----------------------------------------------------------------
amdgpu, omap and snd regression fix

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/sdma: fix mask in emit_pipeline_sync
      drm/amdgpu/si: implement get/set pcie_lanes asic callback
      drm/amdgpu: Fix PCIe lane width calculation

Andrey Grodzovsky (2):
      drm/amdgpu: Fix KIQ hang on bare metal for device unbind/bind back v2.
      drm/amdgpu: Add support for SRBM selection v3

Charlene Liu (1):
      drm/amd/display: HDMI has no sound after Panel power off/on

Chunming Zhou (2):
      drm/amdgpu: fix typo of domain fallback
      Revert "drm/amdgpu: Don't change preferred domian when fallback GTT v5"

Dan Carpenter (1):
      drm/amd/pp: silence a static checker warning

Dave Airlie (4):
      Merge tag 'drm-misc-next-fixes-2018-04-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2018-04-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Eric Huang (1):
      drm/amd/powerply: fix power reading on Fiji

Evan Quan (2):
      drm/amdgpu: drop compute ring timeout setting for non-sriov only (v2)
      drm/amdgpu: add MP1 and THM hw ip base reg offset

Harry Wentland (3):
      drm/amd/display: Only register backlight device if embedded
panel connected
      Revert "drm/amd/display: fix dereferencing possible ERR_PTR()"
      Revert "drm/amd/display: disable CRTCs with NULL FB on their
primary plane (V2)"

Huang Rui (1):
      drm/amdgpu: fix null pointer panic with direct fw loading on gpu reset

Kenneth Feng (1):
      drm/amd/powerplay: Enable ACG SS feature

Leo (Sunpeng) Li (1):
      drm/amd/display: Fix regamma not affecting full-intensity color values

Lukas Wunner (1):
      ALSA: hda - Silence PM ops build warning

Nico Sneck (1):
      drm/radeon: add PX quirk for Asus K73TK

Paul Parsons (1):
      drm/radeon: Fix PCIe lane width calculation

Rex Zhu (2):
      drm/amd/pp: Remove Dead functions on Vega12
      drm/amd/pp: Clean header file in vega12_smumgr.c

Roman Li (2):
      drm/amd/display: fix brightness level after resume from suspend
      drm/amd/display: Fix FBC text console corruption

Takashi Iwai (1):
      drm/amdgpu: Fix memory leaks at amdgpu_init() error path

Tomi Valkeinen (1):
      drm/omap: fix crash if there's no video PLL

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  117 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    3 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   61 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   67 +
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    4 +-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |    3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   89 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   13 +
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    2 +
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    2 +
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |   67 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   13 +-
 drivers/gpu/drm/amd/include/atomfirmware.h         |   12 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |   10 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |   10 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   23 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega12_powertune.c | 1364 --------------------
 .../gpu/drm/amd/powerplay/hwmgr/vega12_powertune.h |   53 -
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |   11 +-
 .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |   14 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |    6 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |   15 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    4 +
 drivers/gpu/drm/radeon/si_dpm.c                    |    4 +-
 sound/pci/hda/hda_intel.c                          |    4 +-
 40 files changed, 432 insertions(+), 1640 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_powertune.c
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_powertune.h
