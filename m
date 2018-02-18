Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeBRWBw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:01:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751598AbeBRWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:51 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] ASoC: Intel: sst: Remove 2 unused members from stream_info struct
Date: Sun, 18 Feb 2018 23:01:39 +0100
Message-Id: <20180218220146.22485-3-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused ops and str_id members from the stream_info struct.

While at it also remove some kernel-doc comments for members which have
already been removed in the past.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/atom/sst/sst.h     | 7 -------
 sound/soc/intel/atom/sst/sst_pvt.c | 1 -
 2 files changed, 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index e02e2b4cc08f..1f3107909044 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -181,21 +181,15 @@ struct sst_block {
  *
  * @status : stream current state
  * @prev : stream prev state
- * @ops : stream operation pb/cp/drm...
- * @bufs: stream buffer list
  * @lock : stream mutex for protecting state
  * @pcm_substream : PCM substream
  * @period_elapsed : PCM period elapsed callback
  * @sfreq : stream sampling freq
- * @str_type : stream type
  * @cumm_bytes : cummulative bytes decoded
- * @str_type : stream type
- * @src : stream source
  */
 struct stream_info {
 	unsigned int		status;
 	unsigned int		prev;
-	unsigned int		ops;
 	struct mutex		lock;
 
 	void			*pcm_substream;
@@ -212,7 +206,6 @@ struct stream_info {
 
 	unsigned int		num_ch;
 	unsigned int		pipe_id;
-	unsigned int		str_id;
 	unsigned int		task_id;
 };
 
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index b1e6b8f34a6a..d7d38b0f68db 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -365,7 +365,6 @@ void sst_init_stream(struct stream_info *stream,
 {
 	stream->status = STREAM_INIT;
 	stream->prev = STREAM_UN_INIT;
-	stream->ops = ops;
 }
 
 int sst_validate_strid(
-- 
2.14.3
