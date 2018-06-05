Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeFENyX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:54:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39460 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFENyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:21 -0400
X-Google-Smtp-Source: ADUXVKIuXKQ4rgcfmzGETOySKHZoqnqDq1vS2k2FJXaUy8x+gkvK7zoFQr3mZpWZIu0g9+o1/exfCg==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 0/7]  Remove debugfs from sti display driver
Date: Tue,  5 Jun 2018 15:54:00 +0200
Message-Id: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the various atomic_print_state hooks in drm structure all
custom debugfs code could be remove from sti driver (~ -330 lines).

This patchset does two addtion in drm core:
- printing normalized zpos of each plane
- add "atomic_print" hook in encoder structure to be able to dump encoders
  at the same time than the others elements

All other patches are implemeting the various hooks in sti driver.

Benjamin Gaignard (7):
  drm: print plane state normalized zpos value
  drm: add hook to print encoder status
  drm: sti: make planes use atomic_print_state instead of debugfs
  drm: sti: make connectors use atomic_print_state instead of debugfs
  drm: sti: make crtc use atomic_print_state instead of debugfs
  drm: sti: make encoders use atomic_print_state instead of debugfs
  drm: sti: remove the last call to debugfs

 drivers/gpu/drm/drm_atomic.c         |  16 +++
 drivers/gpu/drm/sti/sti_compositor.c |  16 ---
 drivers/gpu/drm/sti/sti_compositor.h |   3 -
 drivers/gpu/drm/sti/sti_crtc.c       |  17 +--
 drivers/gpu/drm/sti/sti_cursor.c     |  65 ++++--------
 drivers/gpu/drm/sti/sti_drv.c        |  50 ---------
 drivers/gpu/drm/sti/sti_dvo.c        |  60 +++--------
 drivers/gpu/drm/sti/sti_gdp.c        | 196 +++++++++++------------------------
 drivers/gpu/drm/sti/sti_hda.c        |  75 ++++----------
 drivers/gpu/drm/sti/sti_hdmi.c       | 132 ++++++++++-------------
 drivers/gpu/drm/sti/sti_hqvdp.c      | 149 +++++++++++---------------
 drivers/gpu/drm/sti/sti_mixer.c      |  89 +++++-----------
 drivers/gpu/drm/sti/sti_mixer.h      |   3 +-
 drivers/gpu/drm/sti/sti_tvout.c      | 162 +++++++++++------------------
 drivers/gpu/drm/sti/sti_vid.c        |  60 ++++-------
 drivers/gpu/drm/sti/sti_vid.h        |   2 +-
 include/drm/drm_encoder.h            |  12 +++
 17 files changed, 386 insertions(+), 721 deletions(-)

-- 
2.15.0
