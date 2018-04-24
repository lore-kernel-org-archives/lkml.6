Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeDXNPT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36468 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeDXNPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:13 -0400
X-Google-Smtp-Source: AIpwx4+5rF+II+sPXAUb1R/SL1AaRsUImsZdys5DdtgCM4z5BVNQ7Zk+0mODQrclJHlc7fMCMxoSLQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:10 +0200
Message-Id: <20180424131511.2261-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 6ed9cb053..52b425cdf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1005,7 +1005,7 @@ get_tmds_link_bandwidth(struct drm_connector *connector, bool hdmi)
 		return 112000;
 }
 
-static int
+static enum drm_mode_status
 nouveau_connector_mode_valid(struct drm_connector *connector,
 			     struct drm_display_mode *mode)
 {
-- 
2.17.0
