Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeCPDHW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:07:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40444 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeCPDHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 23:07:20 -0400
X-Google-Smtp-Source: AG47ELvO9IdduK1KjvxZ+PQGSEY3aJFF2YsCW3+nwa3gh8bGH4WxofGLV5XgPIFn1GY90v2Th/psVZGaIppJiuLA5vg=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 16 Mar 2018 13:07:18 +1000
Message-ID: <CAPM=9txk25eOeOX4TeBBjUFh6RmGknV4Nt=-cr7OYtOLb4G1_Q@mail.gmail.com>
Subject: [git pull] drm fixes for 4.16-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2G37SoL014556

Hi Linus,

i915 has a backlight fix for some panels, a pm and a fencing fix,
along with some GVT fixes.
amdgpu has a backlight fix across suspend/resume, an object
destruction ordering issue fix, and a displayport fix
nouveau has two backlight fixes, and a fix for some lockups.

Pretty quiet week, seems like everyone was fixing backlights.

Dave.

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc6

for you to fetch changes up to 3a1b5de36fdf403d1b004e537dc13997633d65df:

  Merge tag 'drm-intel-fixes-2018-03-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-03-16
12:51:35 +1000)

----------------------------------------------------------------
i915, amd and nouveau fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: save/restore backlight level in legacy dce code

Chris Wilson (2):
      drm/i915: Only prune fences after wait-for-all
      drm/i915: Kick the rps worker when changing the boost frequency

Christian König (2):
      drm/amdgpu: fix prime teardown order
      drm/radeon: fix prime teardown order

Dave Airlie (4):
      Merge branch 'drm-fixes-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-03-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'linux-4.16' of git://github.com/skeggsb/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-03-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Karol Herbst (1):
      drm/nouveau/bl: fix backlight regression

Lukas Wunner (1):
      drm/nouveau/bl: Fix oops on driver unbind

Michel Dänzer (1):
      drm/amdgpu/dce: Don't turn off DP sink when disconnected

Min He (1):
      drm/i915/gvt: keep oa config in shadow ctx

Mustamin B Mustaffa (1):
      drm/i915: Enable VBT based BL control for DP

Māris Nartišs (1):
      drm/nouveau/mmu: ALIGN_DOWN correct variable

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2018-03-15' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Xiong Zhang (1):
      drm/i915/gvt: Add runtime_pm_get/put into gvt_switch_mmio

Zhenyu Wang (1):
      drm/i915/gvt: fix user copy warning by whitelist workload rb_tail field

fred gao (1):
      drm/i915/gvt: Correct the privilege shadow batch buffer address

 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 31 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c        |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     |  2 +
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.h |  5 ++
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  8 +++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  8 +++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  8 +++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  8 +++
 drivers/gpu/drm/i915/gvt/cmd_parser.c          |  8 +++
 drivers/gpu/drm/i915/gvt/mmio_context.c        |  2 +
 drivers/gpu/drm/i915/gvt/scheduler.c           | 71 ++++++++++++++++++++++++--
 drivers/gpu/drm/i915/gvt/scheduler.h           |  5 ++
 drivers/gpu/drm/i915/i915_gem.c                | 16 ++++--
 drivers/gpu/drm/i915/i915_sysfs.c              | 10 +++-
 drivers/gpu/drm/i915/intel_dp.c                | 10 ++--
 drivers/gpu/drm/nouveau/nouveau_backlight.c    | 14 ++---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c  |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c            |  2 -
 drivers/gpu/drm/radeon/radeon_object.c         |  2 +
 21 files changed, 169 insertions(+), 50 deletions(-)
