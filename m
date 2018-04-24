Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933476AbeDXNPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55836 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeDXNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:07 -0400
X-Google-Smtp-Source: AIpwx4//IHU9uI/eDucmOHOcxzpovBFH+zX+mqx+ofHnk22sLyFpWGSeXo9faiFnl1wTgWSWUp+VXA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>, David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/hisilicon: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:02 +0200
Message-Id: <20180424131504.2159-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method uses an 'int' for it.

Fix this by using 'enum drm_mode_status' in the driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index f4eba87c9..d2f4749eb 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -27,7 +27,7 @@ static int hibmc_connector_get_modes(struct drm_connector *connector)
 	return drm_add_modes_noedid(connector, 800, 600);
 }
 
-static int hibmc_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status hibmc_connector_mode_valid(struct drm_connector *connector,
 				      struct drm_display_mode *mode)
 {
 	return MODE_OK;
-- 
2.17.0
