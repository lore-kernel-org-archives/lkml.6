Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758281AbeDXN6U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:58:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37688 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933395AbeDXNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:00 -0400
X-Google-Smtp-Source: AIpwx4+E99OdvVjYcTD9tCP6l4UUehN2q2/ULShcnloPJ91e7qUeFxBsNsrPmD6KVas6bsjOZN3DKQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/gma500: fix psb_intel_lvds_mode_valid()'s return type
Date: Tue, 24 Apr 2018 15:14:57 +0200
Message-Id: <20180424131458.2060-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method, psb_intel_lvds_mode_valid(), uses an 'int' for it.

Fix this by using 'enum drm_mode_status' for psb_intel_lvds_mode_valid().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/gma500/psb_intel_drv.h  | 2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
index e8e4ea14b..e05e5399a 100644
--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -255,7 +255,7 @@ extern int intelfb_remove(struct drm_device *dev,
 extern bool psb_intel_lvds_mode_fixup(struct drm_encoder *encoder,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode);
-extern int psb_intel_lvds_mode_valid(struct drm_connector *connector,
+extern enum drm_mode_status psb_intel_lvds_mode_valid(struct drm_connector *connector,
 				     struct drm_display_mode *mode);
 extern int psb_intel_lvds_set_property(struct drm_connector *connector,
 					struct drm_property *property,
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index be3eefec5..8baf6325c 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -343,7 +343,7 @@ static void psb_intel_lvds_restore(struct drm_connector *connector)
 	}
 }
 
-int psb_intel_lvds_mode_valid(struct drm_connector *connector,
+enum drm_mode_status psb_intel_lvds_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
 	struct drm_psb_private *dev_priv = connector->dev->dev_private;
-- 
2.17.0
