Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758253AbeDXN5p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:57:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38329 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933436AbeDXNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:02 -0400
X-Google-Smtp-Source: AIpwx49RVHtMBYIUTFH2Fu09Jw1WlGBArWziRNgU4VZRidET296FJlAevJpbq2jc0XzIILvgvehlGQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: fix intel_dvo_dev_ops::mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:59 +0200
Message-Id: <20180424131500.2110-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All implementations of the method intel_dvo_dev_ops::mode_valid(), as
well as the underlying struct drm_connector_helper_funcs::mode_valid()
use 'enum drm_mode_status' for the method's return type but the
declaration of intel_dvo_dev_ops::mode_valid() uses an 'int' for it.

Fix this by using 'enum drm_mode_status' for the declaration too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/i915/dvo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/dvo.h b/drivers/gpu/drm/i915/dvo.h
index 5e6a3013d..b6e143ebc 100644
--- a/drivers/gpu/drm/i915/dvo.h
+++ b/drivers/gpu/drm/i915/dvo.h
@@ -74,7 +74,7 @@ struct intel_dvo_dev_ops {
 	 *
 	 * \return MODE_OK if the mode is valid, or another MODE_* otherwise.
 	 */
-	int (*mode_valid)(struct intel_dvo_device *dvo,
+	enum drm_mode_status (*mode_valid)(struct intel_dvo_device *dvo,
 			  struct drm_display_mode *mode);
 
 	/*
-- 
2.17.0
