Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF78C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60333218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f62HCysO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfAaT1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43022 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfAaT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so3658524lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDEz27tLmLKZREidfmHzJVIXlEr2ANQp/rtHlOQ/MMk=;
        b=f62HCysOuNBE2rtprEjceH+goSD7jiTEVLVfah7KIjc4zCNPsDRWTtBmJsq2CnOy4y
         jENInaSQz6BPI51mrBKqeM35o7pRlBbj4gEdz91nLWiNpT34/YKS5zzYeoinOYZpI8aL
         vg+Xk8F6ZhqsX4Yf5lPhX4KgMGSZmFRTZLLt9duYKkZkXProRr6rNEDH8qnDjcUa5xQ4
         vIBmUgY3THmWG2hYyr7vK4zhqCKRS99NGbJFUz+bXdvjAVODhw4nPGNJX7koSqg7lQ90
         XPGGVM+YSBEY473nTqnA8t4H1OvbbQ4GXLAS9c7nq4SarSsF+LlinRYUvavBVzPU42Q+
         xNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bDEz27tLmLKZREidfmHzJVIXlEr2ANQp/rtHlOQ/MMk=;
        b=RTWkGzAOc1pBsfTvdocuGP9Wil6ceTNtW3rVqdK13Eilf3lSQ6yiqRHtjeP987sRvu
         khA7CLbM08A/lr+7dx81N3smMOQ0594ge7MDGkdSyNiaIE/tQHJooPCwGH2KWrMrqbkH
         iIsdUNMCORdg97Yo5W35sTgC7Ft+Y78CkeqX/2gFJ0rRdl/bswyRUq2P3Hzcsk4ZFAGy
         9qFmVJbS5yNT2TVXTnHiciIQgZFbcalUmsd9XnTQGDgqH06fFXV7HIAsA4NLFVlyLg3c
         yxXUKACTffZJxyd7/UbGS1T/MhlrTmmTNvd1Sd7VPVRIjYQm5rsU2sPK3kv1ztY7hclr
         YITA==
X-Gm-Message-State: AHQUAub5lFwlogR3HQRP97re0WMxOp2ylB+ODo6YRdfU0eelBJy4LGhs
        qo4SXigae7S4Q5JPlixcE/M=
X-Google-Smtp-Source: AHgI3IYPhWNkedaZEyuB3JODOojYJdRbbNi/DqNpN9ep580hLnUkXEgri91U96iZM50OADxDvaWr9A==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr12454193lju.8.1548962802266;
        Thu, 31 Jan 2019 11:26:42 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:41 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 08/19] drm/panel: innolux: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:08 +0100
Message-Id: <20190131192619.9763-9-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index c8d0da3116dd..cf18594d1954 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -154,8 +154,9 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 			err = mipi_dsi_generic_write(innolux->link, cmd->data,
 						     cmd->len);
 			if (err < 0) {
-				dev_err(panel->dev,
-					"failed to write command %u\n", i);
+				DRM_DEV_ERROR(panel->dev,
+					      "failed to write command %u\n",
+					      i);
 				goto poweroff;
 			}
 
@@ -166,8 +167,9 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 			 */
 			err = mipi_dsi_dcs_nop(innolux->link);
 			if (err < 0) {
-				dev_err(panel->dev,
-					"failed to send DCS nop: %d\n", err);
+				DRM_DEV_ERROR(panel->dev,
+					      "failed to send DCS nop: %d\n",
+					      err);
 				goto poweroff;
 			}
 		}
@@ -482,7 +484,7 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
 						       GPIOD_OUT_HIGH);
 	if (IS_ERR(innolux->enable_gpio)) {
 		err = PTR_ERR(innolux->enable_gpio);
-		dev_dbg(dev, "failed to get enable gpio: %d\n", err);
+		DRM_DEV_DEBUG(dev, "failed to get enable gpio: %d\n", err);
 		innolux->enable_gpio = NULL;
 	}
 
-- 
2.12.0

