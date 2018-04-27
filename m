Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757338AbeD0FmR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:42:17 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34519 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeD0FmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:42:15 -0400
X-Google-Smtp-Source: AB8JxZrg3wcCAgV4rWud7brNoMVyDXr5PF/yNS0b4EWSPXQnsAmvdw68X86bfx05hKfeJceqqjQfSZetcXFFw34I9O4=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 27 Apr 2018 15:42:13 +1000
Message-ID: <CAPM=9twVzYRZ=G++LKV8gd+1DOAPf+zKJaL7aYj-OhevHCDfLA@mail.gmail.com>
Subject: [git pull] drm fixes for v4.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3R5gNr8014930

Hi Linus,

Pretty run of the mill for this stage in the cycle.

i915:
- Black screen fixes
- Display w/a fix
- HDA codec interop fix
sun4i:
- tbsa711 tablet regression fix
qxl:
- Regression fixes due to changes in TTM
virtio:
- Fix wait event condition
msm:
- DSI display fixes
amdgpu:
- fix hang on Carrizo
- DP MST hang fixes
- irq handling deadlock in DC.
amdkfd:
- Fix Kconfig issue
- Clock retrieval fix
- Sparse fixes

Regards,
Dave.


The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc3

for you to fetch changes up to 24d9092c8b7de0a0f630adbe3504bef8d3a618af:

  Merge tag 'drm-intel-fixes-2018-04-26' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-04-27
14:08:47 +1000)

----------------------------------------------------------------
msm, i915, amdgpu, qxl, virtio-gpu, sun4i fixes

----------------------------------------------------------------
Abhay Kumar (1):
      drm/i915/audio: set minimum CD clock to twice the BCLK

Abhinav Kumar (3):
      drm/msm/dsi: check return value for video done waits
      drm/msm/dsi: check video mode engine status before waiting
      drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY

Andres Rodriguez (1):
      drm/amdkfd: fix clock counter retrieval for node without GPU

Ben Hutchings (1):
      drm/msm: Fix possible null dereference on failure of get_pages()

Dave Airlie (5):
      Merge tag 'drm-amdkfd-fixes-2018-04-24' of
git://people.freedesktop.org/~gabbayo/linux into drm-fixes
      Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2018-04-25' of
git://people.freedesktop.org/~robclark/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2018-04-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2018-04-26' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Emil Velikov (1):
      drm/msm: don't deref error pointer in the msm_fbdev_create error path

Gerd Hoffmann (3):
      qxl: fix qxl_release_{map,unmap}
      qxl: keep separate release_bo pointer
      drm/virtio: fix vq wait_event condition

Harry Wentland (2):
      drm/amd/display: Disallow enabling CRTC without primary plane with FB
      drm/amd/display: Don't read EDID in atomic_check

Imre Deak (1):
      drm/i915: Enable display WA#1183 from its correct spot

Jerry (Fangzhi) Zuo (2):
      drm/amd/display: Update MST edid property every time
      drm/amd/display: Check dc_sink every time in MST hotplug

Jeykumar Sankaran (1):
      drm/msm: Add modifier to mdp_get_format arguments

José Roberto de Souza (1):
      drm/i915/fbdev: Enable late fbdev initial configuration

Mika Kuoppala (1):
      drm/i915: Use ktime on wait_for

Mikita Lipski (1):
      drm/amd/display: Fix deadlock when flushing irq

Nicolai Hähnle (1):
      drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Ondrej Jirman (1):
      Revert "drm/sun4i: add lvds mode_valid function"

Randy Dunlap (1):
      drm/amdkfd: fix build, select MMU_NOTIFIER

Sean Paul (1):
      drm/msm: Mark the crtc->state->event consumed

Stefan Agner (1):
      drm/msm/dsi: use correct enum in dsi_get_cmd_fmt

Ville Syrjälä (1):
      drm/edid: Reset more of the display info

Wei Yongjun (1):
      drm/amdkfd: Fix the error return code in kfd_ioctl_unmap_memory_from_gpu()

kbuild test robot (1):
      drm/amdkfd: kfd_dev_is_large_bar() can be static

 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   7 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  17 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  54 +++++-----
 drivers/gpu/drm/drm_edid.c                         |  11 +--
 drivers/gpu/drm/i915/intel_cdclk.c                 |  16 ++-
 drivers/gpu/drm/i915/intel_drv.h                   |   4 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |   2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  11 +--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   1 +
 drivers/gpu/drm/msm/disp/mdp_format.c              |   3 +-
 drivers/gpu/drm/msm/disp/mdp_kms.h                 |   2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  16 ++-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              | 109 +++++++++++++++++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |  28 ------
 drivers/gpu/drm/msm/msm_fb.c                       |   3 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |  11 +--
 drivers/gpu/drm/msm/msm_gem.c                      |  20 ++--
 drivers/gpu/drm/msm/msm_kms.h                      |   5 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   6 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |   1 +
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |   4 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |  18 ++--
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |  55 -----------
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   4 +-
 29 files changed, 237 insertions(+), 190 deletions(-)
