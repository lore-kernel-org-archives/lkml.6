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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAE2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587BB207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMKu9+qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfA3QGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:06:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35732 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbfA3QGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:06:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so81757qtc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hH3U0WFHZZpNJH6bCOhEbZsbYJbx6ZUSf+ECUNlMvDg=;
        b=SMKu9+qdc5uZQIyxvfsVyQRrY05OjXhY6bdqnnQj7jimS17eQdeLPAGXSQ7dQKHItq
         9FXeI5Y10+WYR9KObYouo0OM+KFlNfg2eJDYGQtWV/Uua1QHJ7JCmcshNjwP1SJmR5a2
         FnkyLFFEd1bYgmSEFiOCZaZ60kTXZ19DKdl6eQ+lll0GWBRLCa2U2eHyDPBKABYc6hPw
         Iqqwgc83k7XGITFeRB1QBGY/ew4ogGfnjo4SFmEKoJnuyckFUtJ5sA8CHEbCWdidoMYy
         2JPOEdbi6RnEv66Vwvv+gdDHRuNk5Cbwx9R9KiYIkHKo1KTr7w+DEqkvSxBJEsfac3/q
         r1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hH3U0WFHZZpNJH6bCOhEbZsbYJbx6ZUSf+ECUNlMvDg=;
        b=nVY5CBDSnaTjDYayvzPiZ/Zm7N6YehSdHyqoQpWM9SARKS7DleSdee4OyxlR6WVrLe
         UMN8Rlb0w+CpjSgu3SaPl3BYWhu9vlKL9C6Wrr6V8I3zI2aCR2h6gqt+6BnTJ06hAZx+
         1t8FzeHxZ8oAWKPU4QGoEZGC3wXHYL4lepG7QZeacbJ6l3hoS3dSogJ4mb4nvH5qbS75
         +wmGMFSiB5k+Ehe+Iv+QZE96/U/UYAtW/5LbxHUzYdHQaV8WitWYK9hseFmFZuHXY0cN
         Alcg1kt1HkDeMwV7Dc1E/TfMCX820JLVMB1kDN3z0jCRd5dCRSPCt2ZL0ySfDWSZ1duu
         uucA==
X-Gm-Message-State: AJcUukd8wFoNAxX2hKhAHg3dRHgnlnapWBOWaU1eoCI+hZy6r+p32V1Z
        +uDupQArK2pkzsVbnmpHoY8=
X-Google-Smtp-Source: ALg8bN62AN5MtRpb4sM9A0YfNwTP3LMSKoNQz7lz4SN59FCQAtpAVqbXaqJUwYbbm5SF7fgbbZPkzA==
X-Received: by 2002:ac8:543:: with SMTP id c3mr30900897qth.34.1548864400728;
        Wed, 30 Jan 2019 08:06:40 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u4sm1547948qkk.51.2019.01.30.08.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:06:40 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:06:36 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/vkms: Bugfix extra vblank frame
Message-ID: <171e6e1c239cbca0c3df7183ed8acdfeeace9cf4.1548856186.git.shayenneluzmoura@gmail.com>
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

kms_flip tests are breaking on vkms when simulate vblank because vblank
event sequence count returns one extra frame after arm vblank event to
make a page flip.

When vblank interrupt happens, userspace processes the vblank event and
issues the next page flip command. Kernel calls queue_work to call
commit_planes and arm the new page flip. The next vblank picks up the
newly armed vblank event and vblank interrupt happens again.

The arm and vblank event are asynchronous, then, on the next vblank, we
receive x+2 from `get_vblank_timestamp`, instead x+1, although timestamp
and vblank seqno matches.

Function `get_vblank_timestamp` is reached by 2 ways:

  - from `drm_mode_page_flip_ioctl`: driver is doing one atomic operation
    to synchronize planes in the same output. There is no vblank simulation,
    the `drm_crtc_arm_vblank_event` function adds 1 on vblank count, and the
    variable in_vblank_irq is false
  - from `vkms_vblank_simulate`: since the driver is doing a vblank simulation,
    the variable in_vblank_irq is true.

Fix this problem subtracting one vblank period from vblank_time when
`get_vblank_timestamp` is called from trace `drm_mode_page_flip_ioctl`,
i.e., is not a real vblank interrupt, and getting the timestamp and vblank
seqno when it is a real vblank interrupt.

The reason for all this is that get_vblank_timestamp always supplies the
timestamp for the next vblank event. The hrtimer is the vblank simulator,
and it needs the correct previous value to present the next vblank. Since
this is how hw timestamp registers work and what the vblank core expects.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

---
 drivers/gpu/drm/vkms/vkms_crtc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index d44bfc392491..23146ff2a25b 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -87,6 +87,9 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
 
 	*vblank_time = output->vblank_hrtimer.node.expires;
 
+	if (!in_vblank_irq)
+		*vblank_time -= output->period_ns;
+
 	return true;
 }
 
-- 
2.17.1

