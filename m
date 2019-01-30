Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFE4207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tX5lc8qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfA3QHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:07:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33594 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfA3QHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:07:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so102418qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tEC/1d7HwlRgQF4JsIh02lHiS2ctUBvLOXuE7PW9NQU=;
        b=tX5lc8qQqbp5g+iqJQ4JUu2U0Lmtx89xg3dB9WyPxbZsrDUS3OG2NVS86u++i+nijC
         7+7XiF+PUXR8O9Jvqti9eyQHDhPkcyXMxPUVejvZ+dSTo6RQ26eWItDJfvkUTJ/TcwSk
         ycDj5VbTaCuSf77ZCqWqVnH4DHbOdbjd5FXQzCCO4a5KtvBfGNz6cdb9t7Yxp8Iu5+Xa
         nMFXUJPFLZ9XS28UhonNZwjFg74TwtQaMlPfcQcjw9dAFJgBgG5WD7nAe7CbBMG0pqmC
         bfhr0NsAnqe7f0Q/+EmuLY5ccLWKBS9sRi4aU9Y8E7vjbqwxWyKcNv2dI/1qc1snHgJN
         2Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tEC/1d7HwlRgQF4JsIh02lHiS2ctUBvLOXuE7PW9NQU=;
        b=aGgH/0dpJf5BlmtqYb8qfrLEbooRzithOT0MtN/Wm10cBraekXcO6aW7CaGEfI8+Ii
         zhMw8D6gMwZJ7zhjpngNgtId0PMFKNIDnni/spJaqWIB1i6ba1ZHHbk6GXAJTBT7UV8C
         rA8863bxHPUcFeUBzvWGu1E2lS4z43kIOiPXnwQM3QLxnPzngyApEzNifkNHX/Ww2OHi
         jwlh5MyoxnZrxVyX5dj1Y29s5/2NdayWAMQHgA2UUrc8VWID2pPuuKMcAbDZRG7ff9BI
         O1Ts8xDqqhTUc/w6oX2tJwH6ivHVAn31OaOjAXjOB+eRz+PT6mySLiH5kfZwds3eSQnj
         PD0w==
X-Gm-Message-State: AJcUukdanNf0yb3cZisBSPca0eOaPtgFubULe31fO5jkdFuzhOUBLPuN
        Thw8yDLC3+ZooXXwTewhmuc=
X-Google-Smtp-Source: ALg8bN5ZMOX1R8ucVKpM3hmvserhCd+POspecpXR13DEX2Dyq1hh/KUUwWW3wye6g80YGd9ti0Du3w==
X-Received: by 2002:a0c:81c4:: with SMTP id 4mr30036967qve.156.1548864436074;
        Wed, 30 Jan 2019 08:07:16 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d85sm1790571qkb.89.2019.01.30.08.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:07:15 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:07:11 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm: vkms: Bugfix racing hrtimer vblank handle
Message-ID: <e2e4b8f3a5cab7b2dba75bf1930f86b0a4ee08c9.1548856186.git.shayenneluzmoura@gmail.com>
References: <cover.1548856186.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548856186.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the vblank irq happens, kernel time subsystem executes
`vkms_vblank_simulate`. In parallel or not, it prepares all stuff
necessary to the next vblank with arm, and it must flush these
stuff before the next vblank irq. However, vblank counter is ahead
when arm is executed in parallel with handle vblank.

CPU 0:					CPU 1:
 |					 |
atomic_commit_tail is ongoing		 |
 |					 |
 |					hrtimer: vkms_vblank_simulate()
 |					 |
 |					drm_crtc_handle_vblank()
 |					 |
drm_crtc_arm_vblank()			 |
 |					 |
->get_vblank_timestamp()		 |
 |					 |
 |					hrtimer_forward_now()

Then, we should guarantee that the vblank interval time is correct
(not changed) before finish the vblank handle.

Fix the bug including the call to `hrtimer_forward_now()` in the same
lock of `drm_crtc_handle_vblank()` to ensure that the timestamp update
is correct when finish the vblank handle.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 23146ff2a25b..5a095610726b 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -10,13 +10,17 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
 
-static void _vblank_handle(struct vkms_output *output)
+static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 {
+	struct vkms_output *output = container_of(timer, struct vkms_output,
+						  vblank_hrtimer);
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
+	int ret_overrun;
 	bool ret;
 
 	spin_lock(&output->lock);
+
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
 		DRM_ERROR("vkms failure on handling vblank");
@@ -37,19 +41,9 @@ static void _vblank_handle(struct vkms_output *output)
 			DRM_WARN("failed to queue vkms_crc_work_handle");
 	}
 
-	spin_unlock(&output->lock);
-}
-
-static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
-{
-	struct vkms_output *output = container_of(timer, struct vkms_output,
-						  vblank_hrtimer);
-	int ret_overrun;
-
-	_vblank_handle(output);
-
 	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
 					  output->period_ns);
+	spin_unlock(&output->lock);
 
 	return HRTIMER_RESTART;
 }
-- 
2.17.1

