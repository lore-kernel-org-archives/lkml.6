Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933425AbeDXNO6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:14:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53657 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933395AbeDXNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:53 -0400
X-Google-Smtp-Source: AIpwx49OiWyDl2vX/MAJadOTU7Ky+7pFyBbeGlgEYoG2oaJMQb7q1duzyviqEWGw0by4692qPNKM9A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Lars-Peter Clausen <lars@metafoo.de>,
        Bhumika Goyal <bhumirks@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, Inki Dae <inki.dae@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: adv7511: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:47 +0200
Message-Id: <20180424131450.1910-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index efa29db5f..1b74ee00b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -654,7 +654,7 @@ adv7511_detect(struct adv7511 *adv7511, struct drm_connector *connector)
 	return status;
 }
 
-static int adv7511_mode_valid(struct adv7511 *adv7511,
+static enum drm_mode_status adv7511_mode_valid(struct adv7511 *adv7511,
 			      struct drm_display_mode *mode)
 {
 	if (mode->clock > 165000)
-- 
2.17.0
