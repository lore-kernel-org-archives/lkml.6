Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935411AbeB1WZG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:25:06 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:44751 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935281AbeB1WZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:25:02 -0500
From: Luca Ceresoli <luca@lucaceresoli.net>
To: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/3] media: vb2-core: vb2_buffer_done: consolidate docs
Date: Wed, 28 Feb 2018 23:24:45 +0100
Message-Id: <1519856687-5568-1-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation about what start_streaming() should do on failure are
scattered in two places and mostly duplicated, so consolidate them in
one of the two places.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Pawel Osciak <pawel@osciak.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/media/videobuf2-core.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 5b6c541e4e1b..f1a479060f9e 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -602,9 +602,7 @@ void *vb2_plane_cookie(struct vb2_buffer *vb, unsigned int plane_no);
  *		Either %VB2_BUF_STATE_DONE if the operation finished
  *		successfully, %VB2_BUF_STATE_ERROR if the operation finished
  *		with an error or %VB2_BUF_STATE_QUEUED if the driver wants to
- *		requeue buffers. If start_streaming fails then it should return
- *		buffers with state %VB2_BUF_STATE_QUEUED to put them back into
- *		the queue.
+ *		requeue buffers.
  *
  * This function should be called by the driver after a hardware operation on
  * a buffer is finished and the buffer may be returned to userspace. The driver
@@ -613,9 +611,9 @@ void *vb2_plane_cookie(struct vb2_buffer *vb, unsigned int plane_no);
  * to the driver by &vb2_ops->buf_queue can be passed to this function.
  *
  * While streaming a buffer can only be returned in state DONE or ERROR.
- * The start_streaming op can also return them in case the DMA engine cannot
- * be started for some reason. In that case the buffers should be returned with
- * state QUEUED.
+ * The &vb2_ops->start_streaming op can also return them in case the DMA engine
+ * cannot be started for some reason. In that case the buffers should be
+ * returned with state QUEUED to put them back into the queue.
  */
 void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state);
 
-- 
2.7.4
