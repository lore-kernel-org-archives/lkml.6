Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D483C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C8218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548361978;
	bh=ArcGIucQXiy8vIZ0oY6G2rrKIztzKnNxJNPq6tvzvKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rq+Q6HgIercqxb4JPMvvu2nH0q0LGgstg5MTu38UsRuAw8vbf+vo7M21UKSlKEYkv
	 vtZsEMdVZms86JPuFrfXyT9BsmFLBAAWrG12ooew+ThVZ+JevxHZT8GYprESeq+pKz
	 TDG211g1HK0AdDsthvKYjhgq6GaQLK5UItzgeGJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfAXUc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfAXUcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:32:54 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6622F218A6;
        Thu, 24 Jan 2019 20:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548361972;
        bh=ArcGIucQXiy8vIZ0oY6G2rrKIztzKnNxJNPq6tvzvKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOqLXqdql+1koBv0aXc9iy5y4wHw/xzXnEIG4yL/jbZRJ1gnAysoz7r3rqaJfkeVY
         E/AhM3Jw8qhUQ44IBLO53mGyGL50DXgP6zHg/uWZl87KVsMdcPZ+Rl0OWrNWbkvmyN
         mmgFrBYcGvuhC7OUaKD8QCcfalvVCD49WxhtaELg=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v10 3/4] media: media.h: Enable ALSA MEDIA_INTF_T* interface types
Date:   Thu, 24 Jan 2019 13:32:40 -0700
Message-Id: <ac131eaf92081e3016c3da6ff0f59c747b87baf8.1548360791.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1548360791.git.shuah@kernel.org>
References: <cover.1548360791.git.shuah@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PCM_CAPTURE, PCM_PLAYBACK, and CONTROL ALSA MEDIA_INTF_T* interface
types back into __KERNEL__ scope to get ready for adding ALSA support for
these to the media controller.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 include/uapi/linux/media.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index e5d0c5c611b5..9aedb187bc48 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -262,6 +262,11 @@ struct media_links_enum {
 #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
 #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
 
+#define MEDIA_INTF_T_ALSA_BASE			0x00000300
+#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
+#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
+#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
+
 #if defined(__KERNEL__)
 
 /*
@@ -413,19 +418,19 @@ struct media_v2_topology {
 #define MEDIA_ENT_F_DTV_DECODER			MEDIA_ENT_F_DV_DECODER
 
 /*
- * There is still no ALSA support in the media controller. These
+ * There is still no full ALSA support in the media controller. These
  * defines should not have been added and we leave them here only
  * in case some application tries to use these defines.
+ *
+ * The ALSA defines that are in use have been moved into __KERNEL__
+ * scope. As support gets added to these interface types, they should
+ * be moved into __KERNEL__ scope with the code that uses them.
  */
-#define MEDIA_INTF_T_ALSA_BASE			0x00000300
-#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
-#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
-#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
-#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
-#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
-#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
-#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
-#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
+#define MEDIA_INTF_T_ALSA_COMPRESS             (MEDIA_INTF_T_ALSA_BASE + 3)
+#define MEDIA_INTF_T_ALSA_RAWMIDI              (MEDIA_INTF_T_ALSA_BASE + 4)
+#define MEDIA_INTF_T_ALSA_HWDEP                (MEDIA_INTF_T_ALSA_BASE + 5)
+#define MEDIA_INTF_T_ALSA_SEQUENCER            (MEDIA_INTF_T_ALSA_BASE + 6)
+#define MEDIA_INTF_T_ALSA_TIMER                (MEDIA_INTF_T_ALSA_BASE + 7)
 
 /* Obsolete symbol for media_version, no longer used in the kernel */
 #define MEDIA_API_VERSION			((0 << 16) | (1 << 8) | 0)
-- 
2.17.1

