Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeERIYn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:24:43 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59391 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753638AbeERIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:24:38 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Mali DP Maintainers <malidp@foss.arm.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>
Subject: [PATCH v7 0/5] drm/mali-dp: Add support for memory writeback engine
Date: Fri, 18 May 2018 09:24:18 +0100
Message-Id: <20180518082423.15500-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updating the Mali DP memory writeback engine support series to match
the latest generic writeback connector support posted here [1]. As the
generic patches look ready to be merged into drm-misc-next, I'm sending
the updated Mali DP driver as well.

Changelog:
 - v7: Added support for DP500 writeback. It behaves differently from
   the rest of the IP portfolio, but because customers are asking for
   it to be supported in mainline, we're adding it here.
 - v6: skipped, in order to align with latest generic series numbers.
 - v5: https://lists.freedesktop.org/archives/dri-devel/2017-May/141799.html

Best regards,
Liviu

[1] https://lists.freedesktop.org/archives/dri-devel/2018-May/177125.html



Brian Starkey (2):
  drm: mali-dp: Add RGB writeback formats for DP550/DP650
  drm: mali-dp: Add writeback connector

Liviu Dudau (3):
  drm: mali-dp: Add support for writeback on DP550/DP650
  drm/mali-dp: Add writeback support for DP500.
  drm/mali-dp: Add RGB writeback formats for DP500.

 drivers/gpu/drm/arm/Makefile      |   1 +
 drivers/gpu/drm/arm/malidp_crtc.c |   9 ++
 drivers/gpu/drm/arm/malidp_drv.c  |  19 ++-
 drivers/gpu/drm/arm/malidp_drv.h  |   3 +
 drivers/gpu/drm/arm/malidp_hw.c   | 165 ++++++++++++++++---
 drivers/gpu/drm/arm/malidp_hw.h   |  21 +++
 drivers/gpu/drm/arm/malidp_mw.c   | 253 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/arm/malidp_mw.h   |  18 +++
 drivers/gpu/drm/arm/malidp_regs.h |  18 ++-
 drivers/gpu/drm/drm_atomic.c      |   4 +
 10 files changed, 484 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.c
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.h

-- 
2.17.0
