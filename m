Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeBPFxt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 00:53:49 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35182 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeBPFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 00:53:46 -0500
X-Google-Smtp-Source: AH8x224LohRkO5TlljtO2/SuFFiQZx6/2qzuf5Wlw5XAQhKS3BqBiUxFGxuABOLBYv2BMfQqyfEYcrvBOzD387VerwA=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 16 Feb 2018 15:53:44 +1000
Message-ID: <CAPM=9tzE791n0+H3m4XLZ_UKXVWaHq_LmNQ+560ito+GaJyhxA@mail.gmail.com>
Subject: [git pull] drm fixes for 4.16-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One nouveau regression fix, one AMD quirk and a full set of i915 fixes.

The i915 fixes are mostly for things caught by their CI system, main
ones being DSI panel fixes and GEM fixes.

Pretty quiet overall.

Dave.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc2

for you to fetch changes up to bfad2d08e540b18cfd92694fbb388e7d202df31f:

  Merge branch 'linux-4.16' of git://github.com/skeggsb/linux into
drm-fixes (2018-02-16 14:26:01 +1000)

----------------------------------------------------------------
i915 fixes, and single amd and nouveau fix

----------------------------------------------------------------
Chris Wilson (7):
      drm/i915/perf: Fix compiler warning for string truncation
      drm/i915/perf: Fix compiler warning for string truncation
      drm/i915: Avoid truncation before clamping userspace's priority value
      drm/i915: Don't wake the device up to check if the engine is asleep
      drm/i915/breadcrumbs: Ignore unsubmitted signalers
      drm/i915: Lock out execlist tasklet while peeking inside for busy-stats
      drm/i915/pmu: Fix building without CONFIG_PM

Dave Airlie (3):
      Merge branch 'drm-next-4.16' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-02-14-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'linux-4.16' of git://github.com/skeggsb/linux into drm-fixes

Hans de Goede (4):
      drm/i915/vlv: Add cdclk workaround for DSI
      drm/i915: Add intel_bios_cleanup() function
      drm/i915: Free memdup-ed DSI VBT data structures on driver_unload
      drm/i915: Fix DSI panels with v1 MIPI sequences without a
DEASSERT sequence v3

Kai-Heng Feng (1):
      drm/amdgpu: add new device to use atpx quirk

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2018-02-14' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Thierry Reding (1):
      drm/nouveau: Make clock gate support conditional

Tina Zhang (1):
      drm/i915/gvt: Support BAR0 8-byte reads/writes

Tvrtko Ursulin (2):
      drm/i915/pmu: Fix PMU enable vs execlists tasklet race
      drm/i915/pmu: Fix sleep under atomic in RC6 readout

Weinan Li (2):
      drm/i915/gvt: add 0xe4f0 into gen9 render list
      drm/i915/gvt: fix one typo of render_mmio trace

 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   1 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                 |  51 ++++-
 drivers/gpu/drm/i915/gvt/mmio_context.c          |   1 +
 drivers/gpu/drm/i915/gvt/trace.h                 |   2 +-
 drivers/gpu/drm/i915/i915_drv.c                  |  14 +-
 drivers/gpu/drm/i915/i915_drv.h                  |   2 +
 drivers/gpu/drm/i915/i915_gem_context.c          |   2 +-
 drivers/gpu/drm/i915/i915_oa_cflgt3.c            |   4 +-
 drivers/gpu/drm/i915/i915_oa_cnl.c               |   4 +-
 drivers/gpu/drm/i915/i915_pmu.c                  | 231 ++++++++++++++---------
 drivers/gpu/drm/i915/i915_pmu.h                  |   6 +
 drivers/gpu/drm/i915/intel_bios.c                | 105 +++++++++++
 drivers/gpu/drm/i915/intel_breadcrumbs.c         |  29 +--
 drivers/gpu/drm/i915/intel_cdclk.c               |   8 +
 drivers/gpu/drm/i915/intel_engine_cs.c           |  24 ++-
 drivers/gpu/drm/i915/intel_ringbuffer.h          |  14 --
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c |   6 +-
 17 files changed, 350 insertions(+), 154 deletions(-)
