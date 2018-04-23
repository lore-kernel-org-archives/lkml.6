Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeDWKuW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:50:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38416 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbeDWKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:18 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, wzz@rock-chips.com,
        hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 00/27] DRM Rockchip rk3399 (Kevin)
Date: Mon, 23 Apr 2018 12:49:36 +0200
Message-Id: <20180423105003.9004-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

This is the rebased version of v6 series. This patchset includes cleanups,
improvements, and bug fixes for Rockchip DRM driver and PSR support.

This version is a RESEND of v6 with few changes. The following two
patches are not included and will be send in a separate patchset for
further discussion.

- [PATCH v6 24/30] drm/rockchip: Disable PSR on input events
- [PATCH v6 25/30] drm/rockchip: Cancel PSR enable work before changing
                   the state

The following patch was remove as is not needed.

- [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier

I think that the other patches have the required tags and are ready to
be merged.

Regards,
  Enric

Changes in v6:
- Removed the following patches as are already applied.
  [PATCH v5 01/36] drm/bridge: analogix_dp: detect Sink PSR state after
  configuring the PSR
  [PATCH v5 02/36] drm/rockchip: Remove analogix psr worker
  [PATCH v5 03/36] drm/bridge: analogix_dp: Don't change psr while
  bridge is disabled
- Explain in the commit message why we need to increase
  the delay in the timeout loop in
  [PATCH v5 07/36] drm/bridge: analogix_dp: Move enable video into
  config_video()
- Add Reviewed-by: Archit Taneja <architt@codeaurora.org> for the
  drm/bridge parts
- Add Reviewed-by: Heiko Stuebner <heiko@sntech.de> for
  [PATCH v5 19/36] drm/rockchip: Restore psr->state when enable/disable
  psr failed

Changes in v5:
- Removed the following patches as are already applied.
  [PATCH v4 01/38] drm/bridge: analogix_dp: set psr activate/deactivate
  when enable/disable bridge
  [PATCH v4 02/38] drm/rockchip: Don't use atomic constructs for psr
- Add Mareks tested-tag and including the missing people.
- [PATCH v4 15/38] move analogix_dp_set_analog_power_down() before
  phy_power_off() to fix Exynos issue.

Changes in v4:
- Rebased all on top of drm-misc-next
- Removed the following patches as are already applied.
  [PATCH v3 01/43] drm/rockchip: Get rid of unnecessary struct fields
  [PATCH v3 02/43] drm/rockchip: support prime import sg table
  [PATCH v3 03/43] drm/rockchip: Respect page offset for PRIME mmap
  calls
- Removed the following patches as now are part of another patchset
  [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in
  analogix_dp_bind
  [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31

Changes in v3:
- Addressed some of the comments from Sean on the v2

Changes in v2:
- A few patches have been replaced by newer and cleaner versions from
  the ChromeOS kernel gerrit, especially about disallowing PSR for the
  whole atomic commit.


Douglas Anderson (4):
  drm/bridge: analogix_dp: Reorder plat_data->power_off to happen sooner
  drm/bridge: analogix_dp: Properly log AUX CH errors
  drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
  drm/bridge: analogix_dp: Split the platform-specific poweron in two
    parts

Lin Huang (6):
  drm/bridge: analogix_dp: Move enable video into config_video()
  drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
  drm/bridge: analogix_dp: Ensure edp is disabled when shutting down the
    panel
  drm/bridge: analogix_dp: Extend hpd check time to 100ms
  drm/bridge: analogix_dp: Check dpcd write/read status
  drm/bridge: analogix_dp: Reset aux channel if an error occurred

Mark Yao (1):
  drm/rockchip: pre dither down when output bpc is 8bit

Tomasz Figa (5):
  drm/rockchip: analogix_dp: Do not call Analogix code before bind
  drm/rockchip: psr: Avoid redundant calls to .set() callback
  drm/rockchip: psr: Sanitize semantics of allow/inhibit API
  drm/rockchip: Disallow PSR for the whole atomic commit
  drm/rockchip: psr: Remove flush by CRTC

zain wang (11):
  drm/bridge: analogix_dp: Don't use fast link training when panel just
    powered up
  drm/bridge: analogix_dp: Retry bridge enable when it failed
  drm/bridge: analogix_dp: Wait for HPD signal before configuring link
  drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
  drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
  drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
  drm/rockchip: Restore psr->state when enable/disable psr failed
  drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
  drm/bridge: analogix_dp: Fix timeout of video streamclk config
  drm/bridge: analogix_dp: Fix incorrect operations with register
    ANALOGIX_DP_FUNC_EN_1
  drm/bridge: analogix_dp: Move fast link training detect to set_bridge

 .../drm/bridge/analogix/analogix_dp_core.c    | 331 +++++++++++++-----
 .../drm/bridge/analogix/analogix_dp_core.h    |   5 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 236 +++++++------
 .../gpu/drm/bridge/analogix/analogix_dp_reg.h |   7 +
 drivers/gpu/drm/exynos/exynos_dp.c            |   2 +-
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  37 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  61 +++-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c   | 158 ++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h   |   7 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   1 +
 include/drm/bridge/analogix_dp.h              |   3 +-
 14 files changed, 559 insertions(+), 304 deletions(-)

-- 
2.17.0
