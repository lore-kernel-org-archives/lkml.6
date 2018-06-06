Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0256C60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeFFTEj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:04:39 -0400
Received: from anholt.net ([50.246.234.109]:50118 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752994AbeFFTEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:04:36 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/3] drm/bridge: Move the struct drm_bridge member kerneldoc inline.
Date: Wed,  6 Jun 2018 12:04:29 -0700
Message-Id: <20180606190431.1833-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it more likely that the docs stay updated with the code.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/drm/drm_bridge.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 70131ab57e8f..bd850747ce54 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -270,27 +270,29 @@ struct drm_bridge_timings {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
- * @dev: DRM device this bridge belongs to
- * @encoder: encoder to which this bridge is connected
- * @next: the next bridge in the encoder chain
- * @of_node: device node pointer to the bridge
- * @list: to keep track of all added bridges
- * @timings: the timing specification for the bridge, if any (may
- * be NULL)
- * @funcs: control functions
- * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	/** @dev: DRM device this bridge belongs to */
 	struct drm_device *dev;
+	/** @encoder: encoder to which this bridge is connected */
 	struct drm_encoder *encoder;
+	/** @next: the next bridge in the encoder chain */
 	struct drm_bridge *next;
 #ifdef CONFIG_OF
+	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
 #endif
+	/** @list: to keep track of all added bridges */
 	struct list_head list;
+	/**
+	 * @timings:
+	 *
+	 * the timing specification for the bridge, if any (may be NULL)
+	 */
 	const struct drm_bridge_timings *timings;
-
+	/** @funcs: control functions */
 	const struct drm_bridge_funcs *funcs;
+	/** @driver_private: pointer to the bridge driver's internal context */
 	void *driver_private;
 };
 
-- 
2.17.0
