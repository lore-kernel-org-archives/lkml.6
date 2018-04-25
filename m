Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeDYRnL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:43:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38849 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755853AbeDYRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:05 -0400
X-Google-Smtp-Source: AIpwx48ytjVa3BSdc79KZdURk2OS0sUkzImTqkPp1F6NwevopOQ9MzCdiGpppFhIBJjBDHnavdsZDQ==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 2/6] backlight/generic-bl: remove DRIVER1 state
Date: Wed, 25 Apr 2018 19:42:49 +0200
Message-Id: <20180425174253.4616-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in the entire tree ever sets this, which means this is dead
code. Remove it.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/video/backlight/generic_bl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlight/generic_bl.c
index 67dfb939a514..4dea91acea13 100644
--- a/drivers/video/backlight/generic_bl.c
+++ b/drivers/video/backlight/generic_bl.c
@@ -21,9 +21,6 @@ static int genericbl_intensity;
 static struct backlight_device *generic_backlight_device;
 static struct generic_bl_info *bl_machinfo;
 
-/* Flag to signal when the battery is low */
-#define GENERICBL_BATTLOW       BL_CORE_DRIVER1
-
 static int genericbl_send_intensity(struct backlight_device *bd)
 {
 	int intensity = bd->props.brightness;
@@ -34,8 +31,6 @@ static int genericbl_send_intensity(struct backlight_device *bd)
 		intensity = 0;
 	if (bd->props.state & BL_CORE_SUSPENDED)
 		intensity = 0;
-	if (bd->props.state & GENERICBL_BATTLOW)
-		intensity &= bl_machinfo->limit_mask;
 
 	bl_machinfo->set_bl_intensity(intensity);
 
-- 
2.17.0
