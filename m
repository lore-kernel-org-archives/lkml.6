Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC8DC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D636A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjPJOxPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfAaT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41546 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfAaT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so3689815ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9yYDkUUjcOaXiVEFqOCjqIzrXZJPeDn8vwPuVaGcd18=;
        b=tjPJOxPDu4b1zjB9mwdn+yT5Wgnqap4Y+P/9yAF85x0tbvSlZKG3czhUl7zVx6f2nF
         XU4Pf7frmcLeVZlbEbowT94pRklbetNyXVG3D51Eo52IF2wlJVpZP5kZQip9JduWeE/x
         nuy/9Cqth6Hg8CnrgqW+P/XoU7xX+oNaqEe3nqY/wQvw+fW/aV0VHCgm5ZmrlBKrMdwX
         eYICeHgN9g5h3Q6aUtypNpRu+h7bs2oNzTygXuXGBahJgU+vtM9KvnA8YpF6ToGaA8Rw
         11IJjf/flc2zksh1ERVbB1wo1Nw+wDdZYsnYTgl3f0Bm5FHjI0uo4zkRbaCrwu3KCuX4
         UkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9yYDkUUjcOaXiVEFqOCjqIzrXZJPeDn8vwPuVaGcd18=;
        b=R4luPFjPtiYsrLsopxr+f/fS7uN7rVc130fTRGEqdUZnGFY/kNoKi9BhU2BDMqhi89
         F3yQKIfLDmXkainkKd8f+W6V8wUrSBbqleWKhnYcV6zJAd8ByzgWFy110E6xD1jhRWZ4
         UWVqHtvZd1z+Ffn+zM+NvDnL0TAF4Fj7F/9Uw9Cc8Q8J32qgpfKlYBxhwk+k9Nnt9e/K
         b1V3g+cCpTI5U6846PBCT7col8txRCpZRGZh5Z3T6CoA8oqjZKCL8a4CLA+kJ0YQIHoj
         nQyLmeBdAD45grxqqDj3c8xvy6YUcIb5SVz6vhpq4b8mxhr8rX/YCqf2RbBvlugvs8Ow
         S1ZQ==
X-Gm-Message-State: AJcUukegrX1iP9xBJv/1Fpbtlvmo9zKz3oanY+mtkgPu1B8bZPIlVpMq
        JAn6SuEhHcRLXOrS6JplYPc=
X-Google-Smtp-Source: ALg8bN5dKf5uCFW5v8le+B51om37SZ8YgNmSb3012VWoZR2IZsqvmbWg1XSv+nR/nBtUQFKBa3c80A==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr28858377lje.28.1548962800433;
        Thu, 31 Jan 2019 11:26:40 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:39 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 06/19] drm/panel: sitronix: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:06 +0100
Message-Id: <20190131192619.9763-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 76bd6e7a1a60..f649fe5cc364 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -16,6 +16,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
@@ -180,9 +181,10 @@ static int st7789v_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &default_mode);
 	if (!mode) {
-		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			default_mode.vrefresh);
+		DRM_DEV_ERROR(panel->drm->dev,
+			      "failed to add mode %ux%ux@%u\n",
+			      default_mode.hdisplay, default_mode.vdisplay,
+			      default_mode.vrefresh);
 		return -ENOMEM;
 	}
 
@@ -393,7 +395,7 @@ static int st7789v_probe(struct spi_device *spi)
 
 	ctx->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset)) {
-		dev_err(&spi->dev, "Couldn't get our reset line\n");
+		DRM_DEV_ERROR(&spi->dev, "Couldn't get our reset line\n");
 		return PTR_ERR(ctx->reset);
 	}
 
-- 
2.12.0

