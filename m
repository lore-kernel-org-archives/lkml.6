Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F52213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiBydDQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfBYO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:26:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38882 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfBYO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:26:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so5363596qkl.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oQx8Ikl37EpzxPFH8S4MVsrRB32APMK/9Vuc3hAlWNk=;
        b=hiBydDQ4THaSJwUFx4Szq8Sz8Pm6dZbCvZKbtNcsWZyTC2MgjWAl1YNpngoIfjRFx4
         eThU6zR0T/+pPj4OE5qed5w8JJDnXYirPcIiil8mjgMMypGUDLk/oempHAYoMAG+TPaZ
         DxGQCO7y9eWinyfh69NyqGoJtuzO922QrIK030ioD45fz/Joubh/TQWyJo26GK8Tx9ru
         KNqnwV46B/XauXqtwpnVaaq+lxHIn/xjIQUf/OdMFbq/CmziPIPAijmvj9hnH6ILwe4D
         y7pAAlDLJvu8srcGidL4+ZipnYT9G1alEjBIkSAjyWKR569OstDkdVgwonEt0YS351aU
         9VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oQx8Ikl37EpzxPFH8S4MVsrRB32APMK/9Vuc3hAlWNk=;
        b=j/8ptkSSjz2duhQtR1FvhievvwHbTlA/msIrE5IVv4mI5yoQuZHrjSmHIp7vXaL5Y9
         Jgv6W4hscwMvot0WZz4Pi6g05w/WhAhlXMOMnI619WBYsNcAgN0MURxIf2QJOImoOrjM
         PUiXNxFvSCati8EfY3HEWxPfet9/nBc3D7CxnKwMeDNPaUQyIGxBC+FpT1OCHRRN8HSp
         bBBKVNZvxRorluDo8hpVz0GstDEpwIzS/yjIE1NuFwohCKgWKzYqMCaw1HeOP112ZKJK
         h73oc2ZsE3cDA+92t7Z6W1C7U4FahQ2j0oaLT03Gfue5clsB6K9dL//oq64wUPWD5Uwj
         W3xA==
X-Gm-Message-State: AHQUAubD4K6QWZLocqgAw7DYVelZ7Y/IQyXqU7B7+p8IegSCU5DHsjGF
        c+kBGM3BrTWZhYwFAqmBuWE=
X-Google-Smtp-Source: AHgI3IYmOQjk4gBi8YFv551I1eJq3CPdBlLyqryfKSpj9E+deCDp1LL5Uj6opTKbh0WQkm4lW/VUig==
X-Received: by 2002:a37:4bd7:: with SMTP id y206mr13288781qka.167.1551104770568;
        Mon, 25 Feb 2019 06:26:10 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id h10sm10218600qta.3.2019.02.25.06.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:26:10 -0800 (PST)
Date:   Mon, 25 Feb 2019 11:26:06 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vkms_crc_work_handle needs the value of the actual frame to
schedule the workqueue that calls periodically the vblank
handler and the destroy state functions. However, the frame
value returned from vkms_vblank_simulate is updated and
diminished in vblank_get_timestamp because it is not in a
vblank interrupt, and return an inaccurate value.

Solve this getting the actual vblank frame directly from the
vblank->count inside the `struct drm_crtc`, instead of using
the `drm_accurate_vblank_count` function.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index d7b409a3c0f8..09a8b00ef1f1 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct *work)
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	struct vkms_device *vdev = container_of(out, struct vkms_device,
 						output);
+	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
 	struct vkms_crc_data *primary_crc = NULL;
 	struct vkms_crc_data *cursor_crc = NULL;
 	struct drm_plane *plane;
@@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct *work)
 	if (primary_crc)
 		crc32 = _vkms_get_crc(primary_crc, cursor_crc);
 
-	frame_end = drm_crtc_accurate_vblank_count(crtc);
+	frame_end = vblank->count;
 
 	/* queue_work can fail to schedule crc_work; add crc for
 	 * missing frames
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 8a9aeb0a9ea8..9bf3268e2e92 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 						  vblank_hrtimer);
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
+	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
 	u64 ret_overrun;
 	bool ret;
 
@@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 		DRM_ERROR("vkms failure on handling vblank");
 
 	if (state && output->crc_enabled) {
-		u64 frame = drm_crtc_accurate_vblank_count(crtc);
+		u64 frame = vblank->count;
 
 		/* update frame_start only if a queued vkms_crc_work_handle()
 		 * has read the data
-- 
2.17.1

