Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E3C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FA220868
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZcIGl3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FA220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeKBJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbeKBJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:36:59 -0400
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48D720840;
        Fri,  2 Nov 2018 00:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541118707;
        bh=J52tuGlXP99up45X1moW9a/M3v90My264/sTTr+JuCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HZcIGl3FsVoY+yKjUfuwIHJNv+NtxzUtGhvkpVbNosV5dHNk+bPypKLYZqmsyZy02
         9ltIcjxLDyoAGkmWl+S4a7T7O67er+8YNnPXnWhz+gMusbjOQ8msuQUGkHdxhsEFyr
         SokI/2TN8CbXH1DwAAIfiHZvSdvFrf/JmhKUxyKY=
From:   shuah@kernel.org
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH v8 3/4] media: media.h: Enable ALSA MEDIA_INTF_T* interface types
Date:   Thu,  1 Nov 2018 18:31:32 -0600
Message-Id: <0f47952fd84fd275646e3c9a18e208ced08dd6bb.1541109584.git.shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1541118238.git.shuah@kernel.org>
References: <cover.1541118238.git.shuah@kernel.org>
In-Reply-To: <cover.1541109584.git.shuah@kernel.org>
References: <cover.1541109584.git.shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

Move ALSA MEDIA_INTF_T* interface types back into __KERNEL__ scope
to get ready for adding ALSA support to the media controller.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 include/uapi/linux/media.h | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 36f76e777ef9..07be07263597 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -262,6 +262,16 @@ struct media_links_enum {
 #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
 #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
 
+#define MEDIA_INTF_T_ALSA_BASE			0x00000300
+#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
+#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
+#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
+#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
+#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
+#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
+#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
+#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
+
 #if defined(__KERNEL__)
 
 /*
@@ -404,21 +414,6 @@ struct media_v2_topology {
 
 #define MEDIA_ENT_F_DTV_DECODER			MEDIA_ENT_F_DV_DECODER
 
-/*
- * There is still no ALSA support in the media controller. These
- * defines should not have been added and we leave them here only
- * in case some application tries to use these defines.
- */
-#define MEDIA_INTF_T_ALSA_BASE			0x00000300
-#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
-#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
-#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
-#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
-#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
-#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
-#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
-#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
-
 /* Obsolete symbol for media_version, no longer used in the kernel */
 #define MEDIA_API_VERSION			((0 << 16) | (1 << 8) | 0)
 
-- 
2.17.0

