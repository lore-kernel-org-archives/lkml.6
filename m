Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeDYRnd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:43:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35673 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756085AbeDYRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:10 -0400
X-Google-Smtp-Source: AIpwx49Qw4oRaFjqKLXJOsukX7Zu5VZkH4P0k7rvGZrIkVZ1z0eHKVRggVE6nfHola3QnhOOwawkXg==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 5/6] backlight: Also nuke BL_CORE_DRIVER1
Date: Wed, 25 Apr 2018 19:42:52 +0200
Message-Id: <20180425174253.4616-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the 3 drivers using this are cleaned up we can also remove
this final bit of confusion of leaking driver internals into the
backlight power interface.

The backlight power interface itself is still a massive mess.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/backlight.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 1db67662bfcb..7fbf0539e14a 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -84,7 +84,6 @@ struct backlight_properties {
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
-#define BL_CORE_DRIVER1		(1 << 31)	/* reserved for driver specific use */
 
 };
 
-- 
2.17.0
