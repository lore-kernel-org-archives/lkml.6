Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074EECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7891C2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEkwOTjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7891C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJ0DnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:43:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37183 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJ0DnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:43:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so2455212qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VvHu1C5zv0/vYjXlEVVxM7J02J9JLPYpPuqNHakxEEw=;
        b=rEkwOTjyXZBu9Q2isZSyKRPcOQ/Yzd5Xb1IHBoqC42mKcz3zOeT9lyDkGjG3GmwSiI
         +lkzLADQWhe7WONV7svoPj0mjVeX9B5Wo+0dbtVGKkvNZK/nP3j8PaXBFe5tiI6l1ac9
         Zv7bUFcpYemF4nEHLaHNPKn/HhRWg3u0tDEBBKQJFC4dgAgML8+9Ecuac8QFfcQs+dib
         icVTnq9naPA8+yVYQVIhE2LXVCqiNwTgYDRi8n+KF4OkuRMH5jAo+pgT42zGLs0ts6n3
         5kE1f82zkT17gf41YrqjtBT7gQJ5isHKqs+qcAyUSVofWAISscAgIgOD4UyL2p6IV6ym
         ckKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VvHu1C5zv0/vYjXlEVVxM7J02J9JLPYpPuqNHakxEEw=;
        b=HVd6+YysenHXNqd5201Qqs6JdP3l5FT34Hmlk1srdUZouz1bS55OmRqqxG+fCd7yej
         mDbHEAsRyBfP9fSafntN2IEpv4yqZgCPKjFtKHzpRnqOkMkd25tC8L1ob2KFIMhmHTso
         r9E64MrJfsr8rb7LURn1gSDReirulUkubtiiiNZ8NZGTzID78o9vfx2xO26oUZ7zexHf
         k/OoI0ka7H2bZTq5Lyf9npcAlwqQW5lNWnCuOULHAlmoCZWgfdrzMfHWQY2tAFl2IJMq
         MTxqLLcm3rvZphQDsENpG9EMxUU8I+G+uAfL3IULA98r7YiPyKmR0uftmsfNnyVWw/I5
         mgSg==
X-Gm-Message-State: AGRZ1gLTY+AkNqyLaE0EGwM/l3IUVvUJ6N67xmx+yz/a/jKZku7l8NW6
        rFYR0uEBXCDQXVw6n1hoxMo=
X-Google-Smtp-Source: AJdET5eCHki3BCBPTOLxpTvyHjx+V68NvxnHIYf2o627s1gDiU14zCND4BOKSkv63+swMJe65Fm1Kw==
X-Received: by 2002:ac8:1c43:: with SMTP id j3-v6mr4521728qtk.320.1540580689979;
        Fri, 26 Oct 2018 12:04:49 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y42-v6sm1950937qty.42.2018.10.26.12.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:04:49 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:04:45 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [RESEND PATCH 2/2] staging: vboxvideo: Use unsigned int instead bool
Message-ID: <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540580493.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change was suggested by checkpath.pl. Use unsigned int with bitfield
allocate only one bit to the boolean variable.

CHECK: Avoid using bool structure members because of possible alignment
issues

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
 drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_drv.h b/drivers/staging/vboxvideo/vbox_drv.h
index 594f84272957..7d3e329a6b1c 100644
--- a/drivers/staging/vboxvideo/vbox_drv.h
+++ b/drivers/staging/vboxvideo/vbox_drv.h
@@ -81,7 +81,7 @@ struct vbox_private {
 	u8 __iomem *vbva_buffers;
 	struct gen_pool *guest_pool;
 	struct vbva_buf_ctx *vbva_info;
-	bool any_pitch;
+	unsigned int any_pitch:1;
 	u32 num_crtcs;
 	/** Amount of available VRAM, including space used for buffers. */
 	u32 full_vram_size;
@@ -106,7 +106,7 @@ struct vbox_private {
 	 * depending on whether they react to a hot-plug event after the initial
 	 * mode query.
 	 */
-	bool initial_mode_queried;
+	unsigned int initial_mode_queried:1;
 	struct work_struct hotplug_work;
 	u32 input_mapping_width;
 	u32 input_mapping_height;
@@ -114,7 +114,7 @@ struct vbox_private {
 	 * Is user-space using an X.Org-style layout of one large frame-buffer
 	 * encompassing all screen ones or is the fbdev console active?
 	 */
-	bool single_framebuffer;
+	unsigned int single_framebuffer:1;
 	u32 cursor_width;
 	u32 cursor_height;
 	u32 cursor_hot_x;
@@ -139,17 +139,17 @@ struct vbox_connector {
 	struct {
 		u32 width;
 		u32 height;
-		bool disconnected;
+		unsigned int disconnected:1;
 	} mode_hint;
 };
 
 struct vbox_crtc {
 	struct drm_crtc base;
-	bool blanked;
-	bool disconnected;
+	unsigned int blanked:1;
+	unsigned int disconnected:1;
 	unsigned int crtc_id;
 	u32 fb_offset;
-	bool cursor_enabled;
+	unsigned int cursor_enabled:1;
 	u32 x_hint;
 	u32 y_hint;
 };
diff --git a/drivers/staging/vboxvideo/vboxvideo_guest.h b/drivers/staging/vboxvideo/vboxvideo_guest.h
index d09da841711a..7a98fb4fb108 100644
--- a/drivers/staging/vboxvideo/vboxvideo_guest.h
+++ b/drivers/staging/vboxvideo/vboxvideo_guest.h
@@ -36,7 +36,7 @@ struct vbva_buf_ctx {
 	/** Length of the buffer in bytes */
 	u32 buffer_length;
 	/** Set if we wrote to the buffer faster than the host could read it */
-	bool buffer_overflow;
+	unsigned int buffer_overflow:1;
 	/** VBVA record that we are currently preparing for the host, or NULL */
 	struct vbva_record *record;
 	/**
-- 
2.19.1

