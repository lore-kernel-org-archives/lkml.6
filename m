Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88432C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2E020879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omzImKyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfAJRSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:18:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42191 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfAJRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:18:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so14062655qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qN2LbJR3NsKZsQgqr5h9W8jkonbeONwWnW8fLuoI2NA=;
        b=omzImKyW2y+LeGqABiO41oQ3xhIbt5MMNc2pbDPJ4dU358Tx8Vg8PF0n9RrR4WIMZd
         nAqBPQtaH29SutwfxretVn3F8wN6p6rqzgjRqlMQfpBMSFCH1mPWJ6yewrL41vuPh83N
         3o406prskBgMp3Mgpn53lXR+yIMdeW2hhxX9T3IuR9JUAKst4yHn/lG7fUkm1gq5Xlt4
         o2Ce7YuIyKf2RpxnNPYQA0Cw8OOucgkdxABA+78foWqkkT0Cipnwby9nkIAqHcG5k7Be
         VgXuuZNaElPj6RWPUW4Hqf0/LwV8tFi5FdvtSfkOdYgPKL+jNjJ1+tY5igLPGXfLpwVB
         W4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qN2LbJR3NsKZsQgqr5h9W8jkonbeONwWnW8fLuoI2NA=;
        b=gMonYaM0S66vfA6qqO5iBG7TyATMQDBaTAZczDLqil0MsHyyQVxdlCrcLWcREhmGfC
         skUZsIbkE2YCaVEmA7QfZ4fuO7tpkcmJ4NRhdNBXlE+nzL2G2zOIl58xJXgZYFs5Ltur
         5FNhp6xRxhRaHzUtNKkFXQFS03O30rHUclpLiHTyKCAOxXpi0kHpBgSDdgsXmbMs2S28
         4g0s7vY9snZT3qkuH+sJaDrps9Xn1ApeGbXyz42pxBvEAzlEfL04L2R2ZKlNIWR2Nheg
         nA2mdLZAE/kT+ceYYtAAP7wFgB+kb81H84Yw735E/JRkXeGlA4PVrsFZnORDMMhtvDma
         mdtw==
X-Gm-Message-State: AJcUukcM9xfBA3RWHsDb9oaz7GoPAS5YlUNs4YZehtiPsog86nAnIawJ
        iqGLWZJk0As7BTT7lQhh6tI=
X-Google-Smtp-Source: ALg8bN468vI5CuqdpExXWlx75nQNu8lzN80AirHQxYEKCv64N+4OgnKv+e85aAdWs5X87DqXVe3u5g==
X-Received: by 2002:a0c:ad9a:: with SMTP id w26mr10553472qvc.39.1547140720800;
        Thu, 10 Jan 2019 09:18:40 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d85sm7000154qkb.89.2019.01.10.09.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:18:40 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:18:34 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] drm: i915: Cleanup drm_display_mode print str
Message-ID: <35ff563d8a3a7cc59b99b08c2d2f57364bd52f82.1547137815.git.shayenneluzmoura@gmail.com>
References: <cover.1547137815.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547137815.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in i915 files.
It modifies the print style to standardize the use of DRM_MODE_FMT.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

Changes in v3:
  - No changes

 drivers/gpu/drm/i915/i915_debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 7f455bca528e..a63d084c8e96 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -2948,14 +2948,7 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
 	for (i = 0; i < tabs; i++)
 		seq_putc(m, '\t');
 
-	seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
-		   mode->base.id, mode->name,
-		   mode->vrefresh, mode->clock,
-		   mode->hdisplay, mode->hsync_start,
-		   mode->hsync_end, mode->htotal,
-		   mode->vdisplay, mode->vsync_start,
-		   mode->vsync_end, mode->vtotal,
-		   mode->type, mode->flags);
+	seq_printf(m, DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 }
 
 static void intel_encoder_info(struct seq_file *m,
-- 
2.17.1

