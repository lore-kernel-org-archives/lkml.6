Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947030AbeCBR6W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:58:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48644 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946969AbeCBR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:58:16 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Archit Taneja <architt@codeaurora.org>, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, kernel@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v9 0/5] rockchip: kevin: Enable edp display
Date: Fri,  2 Mar 2018 18:57:52 +0100
Message-Id: <20180302175757.28192-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually the name of this patch series is not really true as the edp
display is working, but to not confuse I decided to maintain it. Now this
patchset is more a group of cleanups, the patchset has been originally
posted by Jeffy Chen and the 2 first commits from a previous version (v6)
are already merged in mainline. In v8, four patches more landed. And
this version are the remaining patches.

Regards,
 Enric

Changes in v9:
- The following patches from v8 has been applied:
  - [PATCH v8 1/8] drm/bridge: analogix: Do not use device's drvdata
  - [PATCH v8 2/8] drm/bridge: analogix_dp: Fix connector and encoder
    cleanup
  - [PATCH v8 3/8] drm/rockchip: analogix_dp: Add a sanity check for
    rockchip_drm_psr_register()
- The following patches from v8 has been superseeded.
  - [PATCH v8 7/8] drm/bridge/synopsys: dw-hdmi: Do not use device's
    drvdata
    - Superseeded by https://cgit.freedesktop.org/drm/drm-misc/commit/?id=eea034af90c64802fd747a9dc534c26a7ebe7754
- Moved clk_disable_unprepare reordering in unbin to separate patch.
- Added new patch to reorder clk_disable_unprepare call in inno_hdmi
  unbind()
- dw_hdmi: Rewrite the commit message to reflect the change.

Jeffy Chen (5):
  drm/rockchip: dw-mipi-dsi: Fix connector and encoder cleanup.
  drm/rockchip: inno_hdmi: Fix error handling path.
  drm/rockchip: inno_hdmi: reorder clk_disable_unprepare call in unbind
  drm/rockchip: dw_hdmi: Move HDMI vpll clock enable to bind()
  drm/bridge/synopsys: dw-hdmi: Add missing bridge detach

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   |  8 ++++++++
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c      |  8 ++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 17 +++++++++--------
 drivers/gpu/drm/rockchip/inno_hdmi.c        | 22 +++++++++++++++++-----
 4 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.16.1
