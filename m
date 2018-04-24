Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeDXArC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:47:02 -0400
Received: from anholt.net ([50.246.234.109]:34452 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932661AbeDXAqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:46:15 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 0/3] V3D DRM driver
Date: Mon, 23 Apr 2018 17:46:07 -0700
Message-Id: <20180424004610.4637-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's v2 of the driver.  This is mostly handling danvet's feedback,
but there are a couple of other changes:

- new core patch for prime vmap/vunmap
- kbuild test robot fixes
- overflow mem simplification (figured it out over breakfast with keithp)
- drm_gem_object_unreference_unlocked() to _put_unlocked().

Eric Anholt (3):
  drm: Make the prime vmap/vunmap hooks optional.
  dt-bindings: Add a new binding for Broadcom V3D 3.x and newer GPUs.
  drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+

 .../bindings/display/brcm,bcm-v3d.txt         |  28 +
 Documentation/gpu/drivers.rst                 |   1 +
 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/drm_prime.c                   |   8 +-
 drivers/gpu/drm/v3d/Kconfig                   |   9 +
 drivers/gpu/drm/v3d/Makefile                  |  18 +
 drivers/gpu/drm/v3d/v3d_bo.c                  | 379 ++++++++++
 drivers/gpu/drm/v3d/v3d_debugfs.c             | 191 +++++
 drivers/gpu/drm/v3d/v3d_drv.c                 | 371 ++++++++++
 drivers/gpu/drm/v3d/v3d_drv.h                 | 294 ++++++++
 drivers/gpu/drm/v3d/v3d_fence.c               |  58 ++
 drivers/gpu/drm/v3d/v3d_gem.c                 | 663 ++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_irq.c                 | 206 ++++++
 drivers/gpu/drm/v3d/v3d_mmu.c                 | 122 ++++
 drivers/gpu/drm/v3d/v3d_regs.h                | 295 ++++++++
 drivers/gpu/drm/v3d/v3d_sched.c               | 228 ++++++
 drivers/gpu/drm/v3d/v3d_trace.h               |  82 +++
 drivers/gpu/drm/v3d/v3d_trace_points.c        |   9 +
 include/uapi/drm/v3d_drm.h                    | 191 +++++
 21 files changed, 3162 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
 create mode 100644 drivers/gpu/drm/v3d/Kconfig
 create mode 100644 drivers/gpu/drm/v3d/Makefile
 create mode 100644 drivers/gpu/drm/v3d/v3d_bo.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_debugfs.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_drv.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_drv.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_fence.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_gem.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_irq.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_mmu.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_regs.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_sched.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_trace.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_trace_points.c
 create mode 100644 include/uapi/drm/v3d_drm.h

-- 
2.17.0
