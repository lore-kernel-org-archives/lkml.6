Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeBHScu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:32:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeBHSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:30:48 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/8] drm/omap: add manual update detection helper
Date: Thu,  8 Feb 2018 19:30:29 +0100
Message-Id: <20180208183035.8461-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for manually updated display support, such as DSI
command mode panels, this adds a simple helper to see if a connector
is manually updated.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 8 ++++++++
 drivers/gpu/drm/omapdrm/omap_connector.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index a0d7b1d905e8..a33b51484b2d 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -57,6 +57,14 @@ bool omap_connector_get_hdmi_mode(struct drm_connector *connector)
 	return omap_connector->hdmi_mode;
 }
 
+bool omap_connector_get_manually_updated(struct drm_connector *connector)
+{
+	struct omap_connector *omap_connector = to_omap_connector(connector);
+
+	return !!(omap_connector->dssdev->caps &
+		  OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE);
+}
+
 static enum drm_connector_status omap_connector_detect(
 		struct drm_connector *connector, bool force)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.h b/drivers/gpu/drm/omapdrm/omap_connector.h
index 98bbc779b302..652136d167f5 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.h
+++ b/drivers/gpu/drm/omapdrm/omap_connector.h
@@ -33,5 +33,6 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
+bool omap_connector_get_manually_updated(struct drm_connector *connector);
 
 #endif /* __OMAPDRM_CONNECTOR_H__ */
-- 
2.15.1
