Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeCVX7z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:59:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34682 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeCVX7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:59:54 -0400
X-Google-Smtp-Source: AG47ELswUhGoStdkaTT3+6PAZ9T8IkBV+yC061tfe4G2fkexn77Ws61z2TfDi9FudiliUd91gNbwvFrxOktEenZ5TgU=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 23 Mar 2018 09:59:51 +1000
Message-ID: <CAPM=9tw0_sFjkdudWBQP1Xqzg9=_=rdn-gCkZ5+9Yu_X7tsqtw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.16-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N002ug007833

Hi Linus,

A bunch of fixes all over the place, nothing too serious or worrying
at this stage.

One uapi fix to stop multi-planar images with getfb,
Sun4i error path and clock fixes
udl driver mmap offset fix
i915 DP MST and GPU reset fixes
vmwgfx mutex and black screen fixes
imx array underflow fix and vblank fix
amdgpu: display fixes
exynos devicetree fix
ast mode fix.

Thanks,
Dave.

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc7

for you to fetch changes up to 5a9f698feb11b198f17b2acebbfe0e2716a3beed:

  drm/ast: Fixed 1280x800 Display Issue (2018-03-23 09:50:54 +1000)

----------------------------------------------------------------
core, i915, amdgpu, imx, sun4i, ast, tegra, vmwgfx fixes.

----------------------------------------------------------------
Arnd Bergmann (1):
      gpu: ipu-v3: prg: avoid possible array underflow

Chris Wilson (1):
      drm/i915: Specify which engines to reset following semaphore/event lockups

Christophe JAILLET (3):
      drm/sun4i: Fix an error handling path in 'sun4i_drv_bind()'
      drm/sun4i: hdmi: Fix an error handling path in 'sun4i_hdmi_bind()'
      drm/sun4i: hdmi: Fix another error handling path in 'sun4i_hdmi_bind()'

Clark Zheng (1):
      drm/amd/display: Refine disable VGA

Daniel Stone (1):
      drm: Reject getfb for multi-plane framebuffers

Dave Airlie (7):
      Merge tag 'drm/tegra/for-4.16-rc7-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v4.16-rc6' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge branch 'drm-fixes-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'imx-drm-fixes-2018-03-22' of
git://git.pengutronix.de/git/pza/linux into drm-fixes
      Merge branch 'vmwgfx-fixes-4.16' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-03-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-03-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Dhinakaran Pandiyan (1):
      drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.

Dmitry Osipenko (1):
      drm/tegra: plane: Correct legacy blending

Fabio Estevam (2):
      drm/imx: ipuv3-plane: Make functions static when possible
      drm/imx: ipuv3-plane: Include "imx-drm.h" header file

Greg Kroah-Hartman (1):
      drm: udl: Properly check framebuffer mmap offsets

Harry Wentland (2):
      drm/amd/display: We shouldn't set format_default on plane as atomic driver
      drm/amd/display: Add one to EDID's audio channel count when passing to DC

Lucas Stach (1):
      drm/imx: move arming of the vblank event to atomic_flush

Michel Dänzer (1):
      drm/radeon: Don't turn off DP sink when disconnected

Mikita Lipski (3):
      drm/amdgpu: Use atomic function to disable crtcs with dc enabled
      drm/amd/display: Allow truncation to 10 bits
      drm/amd/display: Fix FMT truncation programming

Ondrej Jirman (1):
      drm/sun4i: Fix exclusivity of the TCON clocks

Shirish S (1):
      drm/amd/display: fix dereferencing possible ERR_PTR()

Sylwester Nawrocki (1):
      dt-bindings: exynos: Document #sound-dai-cells property of the HDMI node

Thierry Reding (4):
      drm/tegra: plane: Fix RGB565 format on older Tegra
      drm/tegra: dc: Detach IOMMU group from domain only once
      drm/tegra: dsi: Don't disable regulator on ->exit()
      drm/tegra: Shutdown on driver unbind

Thomas Hellstrom (2):
      drm/vmwgfx: Fix black screen and device errors when running without fbdev
      drm/vmwgfx: Fix a destoy-while-held mutex problem.

Y.C. Chen (1):
      drm/ast: Fixed 1280x800 Display Issue

 .../bindings/display/exynos/exynos_hdmi.txt        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  9 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  5 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |  8 ++++-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |  9 +++--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 20 ++++++++---
 drivers/gpu/drm/ast/ast_tables.h                   |  4 +--
 drivers/gpu/drm/drm_framebuffer.c                  |  7 ++++
 drivers/gpu/drm/i915/intel_ddi.c                   |  7 ++--
 drivers/gpu/drm/i915/intel_hangcheck.c             |  4 +--
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |  5 +++
 drivers/gpu/drm/imx/ipuv3-plane.c                  | 10 +++---
 drivers/gpu/drm/radeon/radeon_connectors.c         | 31 +++++++----------
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  3 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  6 ++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  5 +--
 drivers/gpu/drm/tegra/dc.c                         | 16 +++++++--
 drivers/gpu/drm/tegra/drm.c                        |  1 +
 drivers/gpu/drm/tegra/dsi.c                        |  1 -
 drivers/gpu/drm/tegra/plane.c                      |  9 +++--
 drivers/gpu/drm/udl/udl_fb.c                       |  9 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                | 13 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 39 +++++++++++++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                | 13 +++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  5 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  5 +--
 drivers/gpu/ipu-v3/ipu-prg.c                       | 12 +++++--
 29 files changed, 176 insertions(+), 84 deletions(-)
