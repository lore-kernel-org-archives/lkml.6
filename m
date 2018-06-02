Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeFBUU2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 16:20:28 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:43843 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFBUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 16:20:27 -0400
X-Google-Smtp-Source: ADUXVKJ7C/igzznqZrOb2J6c7ngSwtrdXLt2rHpdYkF4xnXERhPtwxWDCmMIgJ1OLCSOdBwbDTcyp3EYYIJ01cOf3/0=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sun, 3 Jun 2018 06:20:24 +1000
Message-ID: <CAPM=9tzfkqhc+OnvTM=mgREsaZAM98NrG9L1b1gPZzftDNLZUw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.17-rc8/final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few final fixes:

i915:
  - Fix for potential Spectre vector in the new query uAPI
  - Fix NULL pointer deref (FDO #106559)
  - DMI fix to hide LVDS for Radiant P845 (FDO #105468)
amdgpu:
  - suspend/resume DC regression fix
  - underscan flicker fix on fiji
  - gamma setting fix after dpms
omap:
  - fix oops regression
core:
  - fix PSR timing
dw-hdmi:
  - fix oops regression.

Thanks,
Dave.

The following changes since commit b04e217704b7f879c6b91222b066983a44a7a09f:

  Linux 4.17-rc7 (2018-05-27 13:01:47 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.17-rc8

for you to fetch changes up to 012cfaced00b7a9498227504c4d37a1c4619403d:

  Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-06-03
06:13:57 +1000)

----------------------------------------------------------------
amdgpu, i915, omap, dw-hdmi fixes

----------------------------------------------------------------
Chris Wilson (3):
      drm/i915/lvds: Move acpi lid notification registration to
registration phase
      drm/i915/query: Protect tainted function pointer lookup
      drm/i915/query: nospec expects no more than an unsigned long

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2018-05-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-05-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2018-05-30' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

David Francis (1):
      drm/amd/display: Make atomic-check validate underscan changes

Dhinakaran Pandiyan (1):
      drm/psr: Fix missed entry in PSR setup time table.

Leo (Sunpeng) Li (2):
      drm/amd/display: Fix BUG_ON during CRTC atomic check update
      drm/amd/display: Update color props when modeset is required

Neil Armstrong (1):
      drm/bridge/synopsys: dw-hdmi: fix dw_hdmi_setup_rx_sense

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Tomi Valkeinen (1):
      drm/omap: fix NULL deref crash with SDI displays

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 44 ++++++++++++-------
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c         | 15 ++-----
 drivers/gpu/drm/drm_dp_helper.c                   |  1 +
 drivers/gpu/drm/i915/i915_query.c                 | 15 +++++--
 drivers/gpu/drm/i915/intel_lvds.c                 | 51 ++++++++++++++++++-----
 drivers/gpu/drm/meson/meson_dw_hdmi.c             |  2 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                 |  5 ++-
 include/drm/bridge/dw_hdmi.h                      |  2 +-
 8 files changed, 91 insertions(+), 44 deletions(-)
