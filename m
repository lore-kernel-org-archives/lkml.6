Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeECOPd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:15:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50445 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeECOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:15:30 -0400
X-Google-Smtp-Source: AB8JxZpn7A1nqTM0sVXejVmKy8SGuyotWGOqxrS8DdAlOc2AQkZQQWcPzpmfpdwQva25JOxAVdsfoA==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH] backlight: remove obsolete comment for ->state
Date: Thu,  3 May 2018 16:15:17 +0200
Message-Id: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani spotted this when reviewing my earlier patch to remove the driver
internal usage of this field in

commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed Apr 25 19:42:52 2018 +0200

    backlight: Nuke BL_CORE_DRIVER1

Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 7fbf0539e14a..0b5897446dca 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -79,7 +79,6 @@ struct backlight_properties {
 	/* Backlight type */
 	enum backlight_type type;
 	/* Flags used to signal drivers of state changes */
-	/* Upper 4 bits are reserved for driver internal use */
 	unsigned int state;
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
-- 
2.17.0
