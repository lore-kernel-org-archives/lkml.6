Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBDB20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF1r+X5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfAaT1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44466 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfAaT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so3652999lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AwLXrEd7M2yFDSfUFl2drBoNF7xy3205BXhalIm0O4=;
        b=JF1r+X5Hcp3O5NJSqKVztcKULmcyNJYJ16TAEZrZv8TDJ6mTt+5i7ovjzRONPtwRL7
         XMtgZKHkE2QyG/bbiOY0ynra4EmQ0w72Y6Mim44SVMTZtez7tY6U7VT83Q2b5wqZSnah
         6x4w3yUhWqZfjuXbJahkQjQGBXjWl7E3kNADostTG2n3J2rB7uGPQmcXZyiiukhyMq2p
         aiL0tXWc3dWuJEz3+7qs53Jt2DOVeNxbkfc+TCw1/AvtjW3DAYyhMz652RGHiUiS7S8l
         W4whoiU6Ty+m6PRlfg9tSdZwfnch9NDtdfURod7Fi82rAmCZnzwuQmB1NyLpMbVgjMjf
         51mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0AwLXrEd7M2yFDSfUFl2drBoNF7xy3205BXhalIm0O4=;
        b=fPHBWdXsyTXKYCzuPV4kzcz3I81HHTASIWrlu4o1QRS1gPKF0LUtsi/hSKV/V1JUhF
         VFp/L1twak6s7HN7IgtG352vC9COXg1nY+1K7eFAnmPZgchoUPo8JDmwEfPJSJ3nigNg
         qjZgSrgtpdol6Qphs8yXF4qseo0VJawXy3DwiQYW606x9r6hU/49kbSUh8JUB1XvviQn
         YXh8wnWiJgHC9ETAERrliIZsVJl6mbcziF/QwcBF3Q/Cjh6BDhfXja1D/zX6U7K30ggI
         5V3FcZ3ZtJrgmCeU5bbwQ5AiP6cQ44zdVKkq4GJLZKlygOTco2hRllXDZHkuTHseHN7E
         r6XA==
X-Gm-Message-State: AHQUAuYfSzE4jhsXeasLOzE5pDaOmvAoB1KZJele/e6nUyy6bWNRfX6n
        Z5ssTTLRyIE2BngEVrSaJyM=
X-Google-Smtp-Source: AHgI3IaAeoQyPNOlSXzLNvO3njgYOc8sjvpVB4vkLpmkuOngioFD/oVhu3FNnMm+L8JWxUZHMpbhzQ==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr6140083ljd.140.1548962811108;
        Thu, 31 Jan 2019 11:26:51 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:50 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 17/19] drm/panel: seiko: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:17 +0100
Message-Id: <20190131192619.9763-18-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index c1348a687447..26da26d38241 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -16,6 +16,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/display_timing.h>
 #include <video/videomode.h>
@@ -73,8 +74,8 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel)
 		videomode_from_timing(dt, &vm);
 		mode = drm_mode_create(drm);
 		if (!mode) {
-			dev_err(drm->dev, "failed to add mode %ux%u\n",
-				dt->hactive.typ, dt->vactive.typ);
+			DRM_DEV_ERROR(drm->dev, "failed to add mode %ux%u\n",
+				      dt->hactive.typ, dt->vactive.typ);
 			continue;
 		}
 
@@ -94,8 +95,9 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel)
 
 		mode = drm_mode_duplicate(drm, m);
 		if (!mode) {
-			dev_err(drm->dev, "failed to add mode %ux%u@%u\n",
-				m->hdisplay, m->vdisplay, m->vrefresh);
+			DRM_DEV_ERROR(drm->dev,
+				      "failed to add mode %ux%u@%u\n",
+				      m->hdisplay, m->vdisplay, m->vrefresh);
 			continue;
 		}
 
@@ -168,7 +170,7 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 
 	err = regulator_enable(p->dvdd);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to enable dvdd: %d\n", err);
+		DRM_DEV_ERROR(panel->dev, "failed to enable dvdd: %d\n", err);
 		return err;
 	}
 
@@ -177,7 +179,7 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 
 	err = regulator_enable(p->avdd);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to enable avdd: %d\n", err);
+		DRM_DEV_ERROR(panel->dev, "failed to enable avdd: %d\n", err);
 		goto disable_dvdd;
 	}
 
-- 
2.12.0

