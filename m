Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeCIGaD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:30:03 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:41228 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeCIGaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:30:01 -0500
X-Google-Smtp-Source: AG47ELuOiV0IuqEq4G1IfB5ABvQfInp9x0yCOPAhpvKGdk1kV6SaD62I8nsASVMC7FRhM42Uqi5RdSCuBLXacTGpmHI=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 9 Mar 2018 16:29:58 +1000
Message-ID: <CAPM=9tw15hgcRgUTsQaOMSCJqQP4xO0sLMFswrp_Bg-L=6PY6g@mail.gmail.com>
Subject: [git pull] drm fixes for 4.16-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w296UD4d021458

Hi Linus,

There are a small set of sun4i  and i915  fixes:

sun4i: divide by zero, clock and LVDS fixes
i915: 1 fix for perf and a 1 race fix

However amdgpu is a bit more than we are normally comfortable with at
this point, however it does fix a lot of display issues with the new
DC code which result in black screens in various configurations along
with some run of the mill gpu configuration fixes. I'm happy enough
that the fixes are limited to the DC code and should fix a bunch of
issues on the new raven ridge APUs that we are seeing shipped now.

Thanks,
Dave.

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc5

for you to fetch changes up to b0655d668fc4faf0c1985e828820f9b9ca13abe6:

  Merge branch 'drm-fixes-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-03-09
09:23:02 +1000)

----------------------------------------------------------------
amdgfx, i915, sun4i fixes

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: used cached pcie gen info for SI (v2)
      drm/radeon: fix KV harvesting
      drm/amdgpu: fix KV harvesting

Bhawanpreet Lakha (1):
      drm/amd/display: Fix takover from VGA mode

Chris Wilson (1):
      drm/i915: Suspend submission tasklets around wedging

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2018-03-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-03-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Eric Yang (3):
      drm/amd/display: fix cursor related Pstate hang
      drm/amd/display: update infoframe after dig fe is turned on
      drm/amd/display: early return if not in vga mode in disable_vga

Giulio Benetti (1):
      drm/sun4i: Fix dclk_set_phase

Harry Wentland (11):
      drm/amd/display: Don't blow up if TG is NULL in dce110_vblank_set
      drm/amd/display: Default HDMI6G support to true. Log VBIOS table error.
      drm/amd/display: Move MAX_TMDS_CLOCK define to header
      drm/amd/display: Remove unnecessary fail labels in create_stream_for_sink
      drm/amd/display: Pass signal directly to enable_tmds_output
      drm/amd/display: Don't allow dual-link DVI on all ASICs.
      drm/amd/display: Don't block dual-link DVI modes
      drm/amd/display: Make create_stream_for_sink more consistent
      drm/amd/display: Call update_stream_signal directly from amdgpu_dm
      drm/amd/display: Use crtc enable/disable_vblank hooks
      drm/amd/display: Return success when enabling interrupt

James Zhu (2):
      drm/amdgpu:Correct max uvd handles
      drm/amdgpu:Always save uvd vcpu_bo in VM Mode

Jernej Skrabec (1):
      drm/sun4i: Release exclusive clock lock when disabling TCON

Jerry (Fangzhi) Zuo (2):
      drm/amd/display: Fix topology change issue in MST rehook
      drm/amd/display: Fixed non-native modes not lighting up

Leo (Sunpeng) Li (1):
      drm/amd/display: Fix memleaks when atomic check fails.

Lionel Landwerlin (1):
      drm/i915/perf: fix perf stream opening lock

Maxime Ripard (3):
      drm/sun4i: tcon: Reduce the scope of the LVDS error a bit
      drm/sun4i: rgb: Fix potential division by zero
      drm/sun4i: crtc: Call drm_crtc_vblank_on / drm_crtc_vblank_off

Michel Dänzer (1):
      drm/amdgpu/dce6: Use DRM_DEBUG instead of DRM_INFO for HPD IRQ info

Mikita Lipski (1):
      drm/amd/display: Set irq state only on existing crtcs

Rex Zhu (1):
      drm/amdgpu: Notify sbios device ready before send request

Roman Li (3):
      drm/amd/display: Fix active dongle hotplug
      drm/amd/display: Fix FBC topology change
      drm/amd/display: fix boot-up on vega10

Shirish S (5):
      drm/amd/display: defer modeset check in dm_update_planes_state
      drm/amd/display: validate plane in dce110 for scaling
      drm/amd/display: update plane params before validation
      drm/amd/display: disable CRTCs with NULL FB on their primary plane (V2)
      drm/amd/display: validate plane format on primary plane

Tom St Denis (1):
      drm/amd/amdgpu: Mask rptr as well in ring debugfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  13 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |  30 +---
 drivers/gpu/drm/amd/amdgpu/si.c                    |  22 ++-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  50 ++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 165 +++++++++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   6 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   3 -
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  76 +---------
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |  10 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  38 +++--
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.h  |   3 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   1 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  91 ++++++++++--
 .../drm/amd/display/dc/dce110/dce110_resource.c    |  18 +++
 .../drm/amd/display/dc/dce112/dce112_resource.c    |   2 +
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   2 +
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  65 +++++++-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |   3 +
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |   2 +-
 .../amd/display/dc/virtual/virtual_link_encoder.c  |   3 +-
 .../amd/display/include/grph_object_ctrl_defs.h    |   5 -
 drivers/gpu/drm/amd/display/include/signal_types.h |   5 +
 drivers/gpu/drm/i915/i915_gem.c                    |   6 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  40 ++---
 drivers/gpu/drm/i915/intel_lrc.c                   |   5 +
 drivers/gpu/drm/radeon/cik.c                       |  31 +---
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |   4 +
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             |   5 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   2 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  92 ++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
 41 files changed, 464 insertions(+), 366 deletions(-)
