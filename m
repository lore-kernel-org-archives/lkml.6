Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeA3Udb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:33:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56506 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbeA3U34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:56 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31
Date: Tue, 30 Jan 2018 21:29:03 +0100
Message-Id: <20180130202913.28724-34-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Change the mode for Sharp lq123p1jx31 panel to something more
rockchip-friendly such that we can use the fixed PLLs to
generate the pixel clock

Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5591984a392b..a4a6ea3ca0e6 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1742,17 +1742,18 @@ static const struct panel_desc sharp_lq101k1ly04 = {
 };
 
 static const struct drm_display_mode sharp_lq123p1jx31_mode = {
-	.clock = 252750,
+	.clock = 266667,
 	.hdisplay = 2400,
 	.hsync_start = 2400 + 48,
 	.hsync_end = 2400 + 48 + 32,
-	.htotal = 2400 + 48 + 32 + 80,
+	.htotal = 2400 + 48 + 32 + 139,
 	.vdisplay = 1600,
 	.vsync_start = 1600 + 3,
 	.vsync_end = 1600 + 3 + 10,
-	.vtotal = 1600 + 3 + 10 + 33,
+	.vtotal = 1600 + 3 + 10 + 84,
 	.vrefresh = 60,
 	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	.type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER,
 };
 
 static const struct panel_desc sharp_lq123p1jx31 = {
-- 
2.14.1
