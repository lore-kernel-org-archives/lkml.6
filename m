Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBTEpT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 23:45:19 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33666 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeBTEpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 23:45:13 -0500
X-Google-Smtp-Source: AH8x226393kFLiATAFHwwO+UjJyv0MoVsuLSwLVPSCI/fH/spb0TyNjoUpiMKwEEwdD+TH446U/plw==
From: Alexandre Courbot <acourbot@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv4 11/21] media: v4l2_fh: add request entity field
Date: Tue, 20 Feb 2018 13:44:15 +0900
Message-Id: <20180220044425.169493-12-acourbot@chromium.org>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180220044425.169493-1-acourbot@chromium.org>
References: <20180220044425.169493-1-acourbot@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow drivers to assign a request entity to v4l2_fh. This will be useful
for request-aware ioctls to find out which request entity to use.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 include/media/v4l2-fh.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
index ea73fef8bdc0..f54cb319dd64 100644
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -28,6 +28,7 @@
 
 struct video_device;
 struct v4l2_ctrl_handler;
+struct media_request_entity;
 
 /**
  * struct v4l2_fh - Describes a V4L2 file handler
@@ -43,6 +44,7 @@ struct v4l2_ctrl_handler;
  * @navailable: number of available events at @available list
  * @sequence: event sequence number
  * @m2m_ctx: pointer to &struct v4l2_m2m_ctx
+ * @entity: the request entity this fh operates on behalf of
  */
 struct v4l2_fh {
 	struct list_head	list;
@@ -60,6 +62,7 @@ struct v4l2_fh {
 #if IS_ENABLED(CONFIG_V4L2_MEM2MEM_DEV)
 	struct v4l2_m2m_ctx	*m2m_ctx;
 #endif
+	struct media_request_entity *entity;
 };
 
 /**
-- 
2.16.1.291.g4437f3f132-goog
