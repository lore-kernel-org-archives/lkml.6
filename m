Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932219AbeE2G7Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:59:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45780 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932182AbeE2G7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:59:14 -0400
X-Google-Smtp-Source: AB8JxZomDkbOjkAKG77WCfUSIoKllWlEaSIWGriZlkb+fAQGJ6UQbw77t7XOdKJNtnZJUq2ZxpAj8A==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: b.zolnierkie@samsung.com
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video/hdmi: prefer strlcpy to strncpy
Date: Mon, 28 May 2018 23:59:05 -0700
Message-Id: <1527577145-7750-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 drivers/video/hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 111a0ab..46c184c 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -168,8 +168,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
-	strncpy(frame->product, product, sizeof(frame->product));
+	strlcpy(frame->vendor, vendor, sizeof(frame->vendor));
+	strlcpy(frame->product, product, sizeof(frame->product));
 
 	return 0;
 }
-- 
2.7.4
