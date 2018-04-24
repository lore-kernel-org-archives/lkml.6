Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756294AbeDXNP2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40477 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933495AbeDXNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:22 -0400
X-Google-Smtp-Source: AIpwx49blMSD93HBa4tJlwMVE8+jJQYrio18/0LVlHBfNNbub/4QFXPlwemwBzyZsswbYQLGUDV81w==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Robert Tarasov <tutankhamen@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/udl: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:17 +0200
Message-Id: <20180424131520.2409-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/udl/udl_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
index c3dc1fd20..09dc585aa 100644
--- a/drivers/gpu/drm/udl/udl_connector.c
+++ b/drivers/gpu/drm/udl/udl_connector.c
@@ -105,7 +105,7 @@ static int udl_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int udl_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status udl_mode_valid(struct drm_connector *connector,
 			  struct drm_display_mode *mode)
 {
 	struct udl_device *udl = connector->dev->dev_private;
-- 
2.17.0
