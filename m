Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0204AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF920857
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo1TENXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbeGTSHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:07:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40441 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbeGTSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:07:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so10336176edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ntO2/xlatDe+AJ970d8qzxQ9sQdiWauCDTfQ9G3zCH0=;
        b=fo1TENXOBgY7z7jzl9ECsTpaZlFWNhSF8WRVJ7PpXisTOSeK73WHyIARrtGUvMeiSj
         uydP03Pi7NTWGaYbHThv1dD1zmD7/l2pXiY92s5pahY8TP7Wv7MSriHFYVeGOmA6/zSW
         KCFv71NMF+79bitDIvf3NCZXKiPWUpDuCw0aYFhbRUIY6mfW0nt2CD1wzRECP5m3t2bN
         5jcaf7WDRLWxPvZRTrELW7FLM4cZQzj3QMfJfj6AioAuh/LAM+aDCJapmz1HZ7+RC6nc
         SXiteKGwUfVJxR1O5Q1ye0Z7AYgBbo0DhME+0xLXNtNdUNDbw4o1ckhT+5CvtoAueEDw
         IzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ntO2/xlatDe+AJ970d8qzxQ9sQdiWauCDTfQ9G3zCH0=;
        b=Af6qYgNd0oQoGid9Vm6IfEzRCSnSyKObu9/ZRDkvIhUkIi+vvFr9D1ZsrrvJaD7AkX
         4CYcGTemB+oTzFHahorBfW4Ieu1mGmVhoHdajcgRdm6RRnZ79Uhd0aSFKEwU61Tj/FXR
         ZNNaP4vCXX5U96+E1lHPZHYUqiqlhP8dFc36W5p+l7MIoyePOYcAGGUs34XBJ+VywcoA
         soLrwk17uAXHLqXwnKE9I2U9KCMBPezdmiLMS3ItTX9nVMJnbm526/LYIzPDNUVqCzt0
         UNGFxMnr/CioMGLUY5+vXkgrJuAqOFsIWIkL2QLO1m4gW38U5+kWCbmi9D+z+nu5mtzV
         C2dw==
X-Gm-Message-State: AOUpUlF89wzPnNTqCBbGLcNgA8pMdXkhaYiSzXxCSIO4zTyy9Grnkff9
        KSUpc1Cpy/OUmYHM7G2nyfg=
X-Google-Smtp-Source: AAOMgpcAmRrluqyo+oUwZ/KLhPPOD9JCJUMZRHfeCAmvo5juVXVIZeFr42PC1i9Agq5SqrQNMgyTzQ==
X-Received: by 2002:a50:d65e:: with SMTP id c30-v6mr3637531edj.178.1532107070801;
        Fri, 20 Jul 2018 10:17:50 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id i10-v6sm1498475edk.56.2018.07.20.10.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 10:17:50 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Cihangir Akturk <cakturk@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] staging: vboxvideo: Add page-flip support
Date:   Fri, 20 Jul 2018 10:17:31 -0700
Message-Id: <1532107051-31102-3-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532107051-31102-1-git-send-email-steve_longerbeam@mentor.com>
References: <1532107051-31102-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds crtc page-flip support by passing the new requested framebuffer
to vbox_crtc_do_set_base().

Note there is no attempt to support vblank interrupts, it's not
not known how to do this in VBOX or if it is even possible. Since
this page-flip implementation does not try to sync the page-flip
to vertical blanking, tearing effects are possible.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/vboxvideo/vbox_mode.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index 688e80d..285d8ad 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -308,6 +308,31 @@ static int vbox_crtc_mode_set(struct drm_crtc *crtc,
 	return ret;
 }
 
+static int vbox_crtc_page_flip(struct drm_crtc *crtc,
+			       struct drm_framebuffer *fb,
+			       struct drm_pending_vblank_event *event,
+			       uint32_t page_flip_flags,
+			       struct drm_modeset_acquire_ctx *ctx)
+{
+	struct vbox_private *vbox = crtc->dev->dev_private;
+	struct drm_device *drm = vbox->dev;
+	unsigned long flags;
+	int rc;
+
+	rc = vbox_crtc_do_set_base(crtc, CRTC_FB(crtc), fb, 0, 0);
+	if (rc)
+		return rc;
+
+	spin_lock_irqsave(&drm->event_lock, flags);
+
+	if (event)
+		drm_crtc_send_vblank_event(crtc, event);
+
+	spin_unlock_irqrestore(&drm->event_lock, flags);
+
+	return 0;
+}
+
 static void vbox_crtc_disable(struct drm_crtc *crtc)
 {
 }
@@ -346,6 +371,7 @@ static const struct drm_crtc_funcs vbox_crtc_funcs = {
 	.reset = vbox_crtc_reset,
 	.set_config = drm_crtc_helper_set_config,
 	/* .gamma_set = vbox_crtc_gamma_set, */
+	.page_flip = vbox_crtc_page_flip,
 	.destroy = vbox_crtc_destroy,
 };
 
-- 
2.7.4

