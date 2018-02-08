Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeBHGHO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:07:14 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34682 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:07:11 -0500
X-Google-Smtp-Source: AH8x227zWrA06LZ+fqxvAwpVEI26+ZvSSFDoq4cEW9o4BSkVTyLFjzyXsR1wXfbHjgtkF8SXkPOjsV38pK19T7ACt/U=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 8 Feb 2018 16:07:08 +1000
Message-ID: <CAPM=9txbNT8Gd46GVPMoRo9Xu_oRftKirhgVgS2iV1OMSrJdog@mail.gmail.com>
Subject: [git pull] drm for v4.16-rc1 (part 2 - fixes)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1867Igt020844

Hi Linus,

Ben missed sending his tree, but he really didn't have much stuff in
it, GP108 acceleration support is enabled by "secure boot" support,
some clockgating work on Kepler, and bunch of fixes. The main bulk is
regenerated firmware files, the change to them really isn't that
large.

Otherwise this contains regular Intel and AMDGPU fixes

Regards,
Dave.

The following changes since commit 24b8ef699e8221d2b7f813adaab13eec053e1507:

  drm/ast: Load lut in crtc_commit (2018-02-01 11:35:46 +1000)

are available in the git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-for-v4.16-part2-fixes

for you to fetch changes up to 94fc27ac487a80daf42f97b1a0503d029f3c1325:

  Merge tag 'drm-intel-next-fixes-2018-02-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-02-08
08:21:37 +1000)

----------------------------------------------------------------
nouveau features, i915 + amdgpu fixes

----------------------------------------------------------------
Anusha Srivatsa (1):
      drm/i915/glk: Disable Guc and HuC on GLK

Arnd Bergmann (2):
      drm/nouveau: nouveau: use correct string length
      drm/nouveau/clk: fix gcc-7 -Wint-in-bool-context warning

Ben Skeggs (8):
      drm/nouveau/secboot/r370: move a bunch of r375 stuff to a new
implementation
      drm/nouveau/secboot/r370: implement support for booting LS SEC2 ucode
      drm/nouveau/secboot/gp108: implement on top of acr_r370
      drm/nouveau/fbcon: add module parameter to select bits-per-pixel
      drm/nouveau/bo: add helper functions for handling pinned+mapped buffers
      drm/nouveau/kms/nv50: prepare for double-buffered LUTs
      drm/nouveau/kms/nv50: use INTERPOLATE_257_UNITY_RANGE LUT on
newer chipsets
      drm/nouveau/kms/nv50: fix handling of gamma since atomic conversion

Changbin Du (1):
      drm/i915/gvt: Fix aperture read/write emulation when enable x-no-mmap=on

Chris Wilson (5):
      drm/i915/pmu: Reconstruct active state on starting busy-stats
      drm/i915: Only attempt to scan the requested number of shrinker slabs
      drm/i915: Protect WC stash allocation against direct reclaim
      drm/i915: Always run hangcheck while the GPU is busy
      drm/i915/ppgtt: Pin page directories before allocation

Christian König (3):
      drm/amdgpu: fix another potential cause of VM faults
      drm/amdgpu: fix locking in vega10_ih_prescreen_iv
      drm/amdgpu: remove WARN_ON when VM isn't found v2

Christoph Böhmwalder (1):
      drm/nouveau/drm/nouveau/mmu: fix odd_ptr_err.cocci warnings

Dave Airlie (4):
      Merge tag 'drm-intel-next-fixes-2018-02-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'linux-4.16' of git://github.com/skeggsb/linux into drm-next
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2018-02-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Hang Yuan (1):
      drm/i915/gvt: validate gfn before set shadow page entry

Huang Rui (1):
      drm/amdgpu: use queue 0 for kiq ring

Ilia Mirkin (1):
      drm/nouveau/kms/nv50: use "low res" lut for indexed mode

Imre Deak (2):
      drm/i915: Fix using BIT_ULL() vs. BIT() for power domain masks
      drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing

Jani Nikula (1):
      drm/i915/bios: add DP max link rate to VBT child device struct

Julia Lawall (1):
      drm/radeon: adjust tested variable

Karol Herbst (1):
      drm/nouveau/pmu/fuc: don't use movw directly anymore

Lionel Landwerlin (1):
      Revert "drm/i915: mark all device info struct with __initconst"

Luis de Bethencourt (1):
      drm/nouveau/mmu: Fix trailing semicolon

Lyude Paul (5):
      drm/nouveau: Add support for basic clockgating on Kepler1
      drm/nouveau: Add support for BLCG on Kepler1
      drm/nouveau: Add support for BLCG on Kepler2
      drm/nouveau: Add support for SLCG for Kepler2
      drm/nouveau: Introduce NvPmEnableGating option

Maarten Lankhorst (1):
      drm/i915: Always call to intel_display_set_init_power() in resume_early.

Manasi Navare (1):
      drm/i915/edp: Do not do link training fallback or prune modes on EDP

Michal Srb (2):
      drm/i915/cmdparser: Check reg_table_count before derefencing.
      drm/i915/cmdparser: Do not check past the cmd length.

Michel Thierry (1):
      drm/i915/gvt: Do not use I915_NUM_ENGINES to iterate over the
mocs regs array

Mika Kahola (1):
      drm/i915: Check for fused or unused pipes

Oscar Mateo (1):
      drm/i915: Stop getting the fault address from RING_FAULT_REG

Pei Zhang (1):
      drm/i915/gvt: add PLANE_KEYMAX regs to mmio track list

Rodrigo Vivi (2):
      drm/i915/cnp: Ignore VBT request for know invalid DDC pin.
      drm/i915/cnp: Properly handle VBT ddc pin out of bounds.

Roger He (1):
      drm/ttm: fix missing parameter change for ttm_bo_cleanup_refs

Sagar Arun Kamble (1):
      drm/i915/guc: Add uc_fini_wq in gem_init unwind path

Shirish S (2):
      drm/amdgpu: disable coarse grain clockgating for ST
      drm/amdgpu: re-enable CGCG on CZ and disable on ST

Stefan Brüns (1):
      drm/i915: Try EDID bitbanging on HDMI after failed read

Tina Zhang (2):
      drm/i915/gvt: Keep obj->dma_buf link NULL during exporting
      drm/i915/gvt: Use KVM r/w to access guest opregion

Tom St Denis (1):
      drm/ttm: Fix 'buf' pointer update in ttm_bo_vm_access_kmap() (v2)

Weinan Li (2):
      drm/i915/gvt: refine intel_vgpu_submission_ops as per engine ops
      drm/i915/gvt: only reset execlist state of one engine during VM
engine reset

Xiong Zhang (1):
      drm/i915/gvt: Fix gen8/9_render_mmio_list[0] don't take effect

Zhenyu Wang (2):
      drm/i915/gvt: cancel virtual vblank timer when no vGPU exists
      drm/i915/gvt: cancel scheduler timer when no vGPU exists

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   32 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    6 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    1 -
 drivers/gpu/drm/i915/gvt/cfg_space.c               |   15 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |    1 -
 drivers/gpu/drm/i915/gvt/execlist.c                |   22 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   24 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |    6 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   10 +-
 drivers/gpu/drm/i915/gvt/hypercall.h               |    1 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   52 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |   42 -
 drivers/gpu/drm/i915/gvt/mmio_context.c            |   10 +-
 drivers/gpu/drm/i915/gvt/mpt.h                     |   17 +
 drivers/gpu/drm/i915/gvt/opregion.c                |   98 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c            |   21 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   19 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    1 +
 drivers/gpu/drm/i915/gvt/vgpu.c                    |    5 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   10 +-
 drivers/gpu/drm/i915/i915_drv.c                    |    2 +
 drivers/gpu/drm/i915/i915_drv.h                    |    6 +-
 drivers/gpu/drm/i915/i915_gem.c                    |    9 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   61 +-
 drivers/gpu/drm/i915/i915_gem_request.c            |    2 +
 drivers/gpu/drm/i915/i915_gem_shrinker.c           |    4 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   94 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    2 +
 drivers/gpu/drm/i915/intel_audio.c                 |    2 +-
 drivers/gpu/drm/i915/intel_bios.c                  |   20 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   11 -
 drivers/gpu/drm/i915/intel_cdclk.c                 |   22 +-
 drivers/gpu/drm/i915/intel_display.c               |    6 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |   26 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |   16 +-
 drivers/gpu/drm/i915/intel_guc_fw.c                |    9 -
 drivers/gpu/drm/i915/intel_hangcheck.c             |    7 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |   14 +-
 drivers/gpu/drm/i915/intel_huc.c                   |   11 -
 drivers/gpu/drm/i915/intel_pm.c                    |    6 +-
 drivers/gpu/drm/i915/intel_uc.c                    |    2 -
 drivers/gpu/drm/i915/intel_vbt_defs.h              |    2 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |    1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/secboot.h  |    1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/therm.h    |   17 +
 drivers/gpu/drm/nouveau/nouveau_bo.h               |   28 +
 drivers/gpu/drm/nouveau/nouveau_crtc.h             |    1 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |   22 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |  189 ++--
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   30 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c     |  207 ++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h     |   55 ++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c     |  155 +++
 drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c      |    6 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild      |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c     |    6 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c     |   47 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h     |   35 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c     |   71 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c     |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |    2 +-
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gf100.fuc3.h   |  746 +++++++--------
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gk208.fuc5.h   |  802 ++++++++--------
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gt215.fuc3.h   | 1006 ++++++++++----------
 .../gpu/drm/nouveau/nvkm/subdev/pmu/fuc/memx.fuc   |   30 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/Kbuild |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr.h  |    1 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.c |  144 +++
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.h |   49 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r375.c |   93 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp108.c    |   67 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/priv.h |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild   |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |   70 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c  |   58 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h  |   35 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c  |    8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c  |  136 +++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h  |   48 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h   |   21 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |    2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    3 +-
 90 files changed, 3168 insertions(+), 1788 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp108.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h
