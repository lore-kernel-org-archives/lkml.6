Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeDXNOu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:14:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55755 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933395AbeDXNOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:45 -0400
X-Google-Smtp-Source: AIpwx48ffJ9owz4GkYXwTBMvM3iZ3bRE7es+DkrFc9dPmYyHPb+YBOYiSvHMQ9WukwJ46q9Y+XjQcg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Cihangir Akturk <cakturk@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Egbert Eich <eich@suse.de>, Peter Rosin <peda@axentia.se>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ast: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:40 +0200
Message-Id: <20180424131443.1810-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/ast/ast_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 831b73392..036dff8a1 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -799,7 +799,7 @@ static int ast_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int ast_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status ast_mode_valid(struct drm_connector *connector,
 			  struct drm_display_mode *mode)
 {
 	struct ast_private *ast = connector->dev->dev_private;
-- 
2.17.0
