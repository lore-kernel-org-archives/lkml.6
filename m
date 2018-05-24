Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033827AbeEXQl1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:41:27 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59878 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030723AbeEXQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:41:22 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>, Rob Clark <robdclark@gmail.com>
Subject: [PATCH v9 0/3]  drm: Introduce writeback connectors
Date: Thu, 24 May 2018 17:41:00 +0100
Message-Id: <20180524164103.8378-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v9 of the writeback connector series. Compared to v8 I've
addressed the comments from Eric Anholt, as well as Maarten Lankhorst's
and Daniel Vetter's one on the client capabilities.

Most importantly, I've also realised that Dave Airlie has moved the drm-next
tree to fd.org and went and rebased the patches on top of the new tree,
which had conflicts with this series as the aspect ration capability was
introduced in the meanwhile.

I will ask Gustavo to pull this series into drm-misc if there are no further
comments.

Best regards,
Liviu



Brian Starkey (2):
  drm: Add writeback connector type
  drm: writeback: Add out-fences for writeback connectors

Liviu Dudau (1):
  drm: writeback: Add client capability for exposing writeback
    connectors

 Documentation/gpu/drm-kms.rst            |   9 +
 drivers/gpu/drm/Makefile                 |   2 +-
 drivers/gpu/drm/drm_atomic.c             | 227 +++++++++++++-
 drivers/gpu/drm/drm_atomic_helper.c      |  30 ++
 drivers/gpu/drm/drm_connector.c          |   4 +-
 drivers/gpu/drm/drm_ioctl.c              |   7 +
 drivers/gpu/drm/drm_mode_config.c        |   5 +
 drivers/gpu/drm/drm_writeback.c          | 360 +++++++++++++++++++++++
 include/drm/drm_atomic.h                 |  11 +
 include/drm/drm_connector.h              |  13 +
 include/drm/drm_file.h                   |   7 +
 include/drm/drm_mode_config.h            |  23 ++
 include/drm/drm_modeset_helper_vtables.h |  11 +
 include/drm/drm_writeback.h              | 129 ++++++++
 include/uapi/drm/drm.h                   |   9 +
 include/uapi/drm/drm_mode.h              |   1 +
 16 files changed, 837 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_writeback.c
 create mode 100644 include/drm/drm_writeback.h

-- 
2.17.0
