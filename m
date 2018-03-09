Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeCIRtu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:49:50 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37031 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeCIRts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:49:48 -0500
X-Google-Smtp-Source: AG47ELvfmAMMhpgnFDdf6ZAiZaTR3LDz2sOPSuJX5BrHV49ZsRzQ2NnZ9pPkaFrIuSjdzmyeM7/BRg==
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: [PATCH v8 03/13] [media] omap3isp: group device capabilities
Date: Fri,  9 Mar 2018 14:49:10 -0300
Message-Id: <20180309174920.22373-4-gustavo@padovan.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180309174920.22373-1-gustavo@padovan.org>
References: <20180309174920.22373-1-gustavo@padovan.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

Instead of putting V4L2_CAP_STREAMING everywhere, set device_caps
earlier with this value.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
---
 drivers/media/platform/omap3isp/ispvideo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/omap3isp/ispvideo.c
index a751c89a3ea8..b4d4ef926749 100644
--- a/drivers/media/platform/omap3isp/ispvideo.c
+++ b/drivers/media/platform/omap3isp/ispvideo.c
@@ -658,13 +658,14 @@ isp_video_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
 	strlcpy(cap->card, video->video.name, sizeof(cap->card));
 	strlcpy(cap->bus_info, "media", sizeof(cap->bus_info));
 
-	cap->capabilities = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_VIDEO_OUTPUT
-		| V4L2_CAP_STREAMING | V4L2_CAP_DEVICE_CAPS;
+	cap->device_caps = V4L2_CAP_STREAMING;
+	cap->capabilities = cap->device_caps | V4L2_CAP_VIDEO_CAPTURE |
+		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_DEVICE_CAPS;
 
 	if (video->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
-		cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+		cap->device_caps |= V4L2_CAP_VIDEO_CAPTURE;
 	else
-		cap->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
+		cap->device_caps |= V4L2_CAP_VIDEO_OUTPUT;
 
 	return 0;
 }
-- 
2.14.3
