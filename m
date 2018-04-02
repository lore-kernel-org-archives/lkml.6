Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeDBWsP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:48:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754516AbeDBWsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:48:14 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: "David Airlie" <airlied@linux.ie>, "Sean Paul" <seanpaul@chromium.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Gustavo Padovan" <gustavo@padovan.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Andrey Grodzovsky" <andrey.grodzovsky@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        nouveau@lists.freedesktop.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Roman Li" <roman.li@amd.com>, "Ben Skeggs" <bskeggs@redhat.com>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>,
        "Shirish S" <shirish.s@amd.com>, "Tony Cheng" <tony.cheng@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 00/10] Implement proper MST fallback retraining in i915
Date: Mon,  2 Apr 2018 18:47:36 -0400
Message-Id: <20180402224800.16080-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest version of https://patchwork.freedesktop.org/series/39642/ ,
hopefully patchwork understands this and doesn't break anything!

Lots of changes.

Lyude Paul (10):
  drm/atomic: Print debug message on atomic check failure
  drm/i915: Move DP modeset retry work into intel_dp
  drm/dp_mst: Fix naming on drm_atomic_get_mst_topology_state()
  drm/dp_mst: Remove all evil duplicate state pointers
  drm/dp_mst: Make drm_dp_mst_topology_state subclassable
  drm/dp_mst: Add reset_state callback to topology mgr
  drm/i915: Only use one link bw config for MST topologies
  drm/i915: Make intel_dp_mst_atomic_check() idempotent
  drm/dp_mst: Add MST fallback retraining helpers
  drm/i915: Implement proper fallback training for MST

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  35 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   4 +-
 drivers/gpu/drm/drm_atomic.c                       |   5 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              | 548 ++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_ddi.c                   |  10 +-
 drivers/gpu/drm/i915/intel_display.c               |  14 +-
 drivers/gpu/drm/i915/intel_dp.c                    | 361 ++++++++++----
 drivers/gpu/drm/i915/intel_dp_link_training.c      |   6 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                | 180 +++++--
 drivers/gpu/drm/i915/intel_drv.h                   |  20 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |  15 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |  13 +-
 include/drm/drm_dp_mst_helper.h                    |  42 +-
 14 files changed, 1088 insertions(+), 179 deletions(-)

-- 
2.14.3
