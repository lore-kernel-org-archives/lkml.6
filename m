Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeDVXIm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 19:08:42 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:38086 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753678AbeDVXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 19:08:41 -0400
X-Google-Smtp-Source: AB8JxZp+s9n8BZhrjcnJm4flNvJqf+xVG55GbgpbVv9vs7sG//arHuqk5pJ3l8TsN3llKSEdVzRONEKCiaaJwm5UgGw=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 23 Apr 2018 09:08:38 +1000
Message-ID: <CAPM=9tw_rAFUd=sdS09QZO2urDU+SRu7PV_oTP4nX-GoXCQ5OA@mail.gmail.com>
Subject: [git pull] drm fixes for rc2 (or rc3)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just back at work today, I've pulled all the rc2 fixes pulls that were
outstanding, and pushed them out. If I missed rc2, no worries they
should all be fine for rc3.

i915 has an oops fix, and two race fixes, along with some gvt fixes
amdgpu has a dark screen fix, clk/voltage fix and vega12 smu fix
exynos just drops some code.

There is also a backmerge in here due to some unfortunate drm-misc
timing, but should be all fine.

Thanks,
Dave.

The following changes since commit a10beabba213924d876f2d10ca9351aeab93f58a:

  Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2018-04-13
09:25:21 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc2

for you to fetch changes up to 221bda4b5f1abfd74159d7bf3703affa62468030:

  Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2018-04-23
08:54:06 +1000)

----------------------------------------------------------------
exynos, i915, vc4, amdgpu fixes

----------------------------------------------------------------
Changbin Du (2):
      drm/i915/gvt: Missed to cancel dma map for ggtt entries
      drm/i915/gvt: Cancel dma map when resetting ggtt entries

Chris Wilson (2):
      drm/i915/execlists: Clear user-active flag on preemption completion
      drm/i915: Call i915_perf_fini() on init_hw error unwind

Daniel J Blueman (1):
      drm/vc4: Fix memory leak during BO teardown

Daniel Stone (3):
      drm/exynos: Move GEM BOs to drm_framebuffer
      drm/exynos: Move dma_addr out of exynos_drm_fb
      drm/exynos: exynos_drm_fb -> drm_framebuffer

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2018-04-18-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2018-04-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'exynos-drm-fixes-for-v4.17-rc2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge branch 'drm-next-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Gaurav K Singh (1):
      drm/i915/audio: Fix audio detection issue on GLK

Gerd Hoffmann (1):
      drm/i915/gvt: throw error on unhandled vfio ioctls

Gustavo A. R. Silva (1):
      drm/i915/gvt: Mark expected switch fall-through in handle_g2v_notification

Harry Wentland (1):
      drm/amd/display: Don't program bypass on linear regamma LUT

Imre Deak (1):
      drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state

Jani Nikula (1):
      drm/i915/bios: filter out invalid DDC pins from VBT child devices

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2018-04-03' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Kenneth Feng (1):
      drm/amd/powerplay: header file interface to SMU update

Ramalingam C (1):
      drm: Fix HDCP downstream dev count read

Rex Zhu (1):
      drm/amd/pp: Fix bug voltage can't be OD separately on VI

Sean Paul (1):
      Merge airlied/drm-next into drm-misc-fixes

Tina Zhang (1):
      drm/i915/gvt: Add drm_format_mod update

Tvrtko Ursulin (1):
      drm/i915/pmu: Inspect runtime PM state more carefully while estimating RC6

Xidong Wang (1):
      drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value

Xiong Zhang (2):
      drm/i915/gvt: Delete redundant error message in fb_decode.c
      drm/i915/gvt: Disable primary/sprite/cursor plane at virtual
display initialization

Zhipeng Gong (1):
      drm/i915/gvt: Make MI_USER_INTERRUPT nop in cmd parser

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 20 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |  7 ---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 16 +++--
 .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |  4 +-
 drivers/gpu/drm/drm_dp_dual_mode_helper.c          | 39 +++++++++---
 drivers/gpu/drm/exynos/exynos_drm_fb.c             | 73 +++++-----------------
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  1 +
 drivers/gpu/drm/i915/gvt/display.c                 | 10 +++
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |  1 +
 drivers/gpu/drm/i915/gvt/fb_decoder.c              | 27 +++-----
 drivers/gpu/drm/i915/gvt/gtt.c                     | 52 ++++++++++++---
 drivers/gpu/drm/i915/gvt/gtt.h                     |  2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  1 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  2 +-
 drivers/gpu/drm/i915/i915_drv.c                    | 27 ++++----
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |  2 +-
 drivers/gpu/drm/i915/i915_pmu.c                    | 37 ++++++++---
 drivers/gpu/drm/i915/intel_audio.c                 |  2 +-
 drivers/gpu/drm/i915/intel_bios.c                  | 13 ++--
 drivers/gpu/drm/i915/intel_lrc.c                   |  9 +++
 drivers/gpu/drm/vc4/vc4_bo.c                       |  2 +
 drivers/gpu/drm/vc4/vc4_validate_shaders.c         |  1 +
 include/drm/drm_hdcp.h                             |  2 +-
 24 files changed, 209 insertions(+), 144 deletions(-)
