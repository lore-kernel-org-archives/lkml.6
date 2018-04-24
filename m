Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933450AbeDXNPD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35415 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933411AbeDXNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:55 -0400
X-Google-Smtp-Source: AIpwx48TEHiGsO5p8A9uIbI94l9hI0p0eztRYPajAlnSV92GLOGHOizmaYXPPXp8SNScHG0HgUU2aA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: tc358767: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:52 +0200
Message-Id: <20180424131453.1961-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 08ab7d6ae..0fd9cf275 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1102,7 +1102,7 @@ static bool tc_bridge_mode_fixup(struct drm_bridge *bridge,
 	return true;
 }
 
-static int tc_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status tc_connector_mode_valid(struct drm_connector *connector,
 				   struct drm_display_mode *mode)
 {
 	/* DPI interface clock limitation: upto 154 MHz */
-- 
2.17.0
