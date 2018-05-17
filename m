Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeEQRha (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:37:30 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59806 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751047AbeEQRh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:37:29 -0400
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
        Daniel Stone <daniels@collabora.com>
Subject: [PATCH v7 0/3] drm: Introduce writeback connectors
Date: Thu, 17 May 2018 17:43:25 +0100
Message-Id: <20180517164328.11814-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v7 of the writeback connector series. This is just a refresh
of the v6 series in order to get it ready for merging into the kernel,
now that the userspace implementation has been reviewed and ACKed
by Sean Paul here [1].

For anyone that wants a refresh on what changed in v6, the series
can be found here [2]. The only change in v7 is that the userspace
capabilities patch does not depend on the cleanup patch that got NACKed.

Best regards,
Liviu


[1] https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/merge_requests/3
[2] https://lists.freedesktop.org/archives/dri-devel/2018-February/167703.html


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
