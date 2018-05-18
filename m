Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeERFAl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:00:41 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33648 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:00:40 -0400
X-Google-Smtp-Source: AB8JxZooxMx0E4VZjrrUDtqc4kFkJ+UB/QeNgh1nqjf+tLONTcAc0uKnffX/xmAjiFBCVPgtzKgmtsZ/FRF5ZDgtLT0=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 18 May 2018 15:00:38 +1000
Message-ID: <CAPM=9tyARsi2BqffEQ7WU3+3ZjdMFb=s10MDuY=aVKnr04YAwQ@mail.gmail.com>
Subject: [git pull] drm fixes for v4.17-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Pretty quiet week again, one vmwgfx regression fix, one core buffer
overflow fix,one vc4 leak fix and three i915 fixes.

Dave.

The following changes since commit 76ef6b28ea4f81c3d511866a9b31392caa833126:

  drm: set FMODE_UNSIGNED_OFFSET for drm files (2018-05-15 14:46:04 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc6

for you to fetch changes up to 1827cad96d624ec127853a71cb931c74024e57d6:

  Merge tag 'drm-intel-fixes-2018-05-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-05-18
12:01:49 +1000)

----------------------------------------------------------------
i915, vc4, vmwgfx and core fixes

----------------------------------------------------------------
Chris Wilson (1):
      drm/i915/execlists: Use rmb() to order CSB reads

Dan Carpenter (1):
      drm/dumb-buffers: Integer overflow in drm_mode_create_ioctl()

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2018-05-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'vmwgfx-fixes-4.17' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-05-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Deepak Rawat (1):
      drm/vmwgfx: Set dmabuf_size when vmw_dmabuf_init is successful

Eric Anholt (1):
      drm/vc4: Fix leak of the file_priv that stored the perfmon.

Haneen Mohammed (1):
      drm: Match sysfs name in link removal to link creation

Matthew Auld (1):
      drm/i915/userptr: reject zero user_size

Michel Thierry (1):
      drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk

 drivers/gpu/drm/drm_drv.c               | 2 +-
 drivers/gpu/drm/drm_dumb_buffers.c      | 7 ++++---
 drivers/gpu/drm/i915/i915_gem_userptr.c | 3 +++
 drivers/gpu/drm/i915/i915_reg.h         | 3 +++
 drivers/gpu/drm/i915/intel_engine_cs.c  | 4 ++++
 drivers/gpu/drm/i915/intel_lrc.c        | 1 +
 drivers/gpu/drm/vc4/vc4_drv.c           | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c    | 2 ++
 8 files changed, 19 insertions(+), 4 deletions(-)
