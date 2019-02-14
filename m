Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC194C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFAC222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fi8MqaPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439819AbfBNTdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33182 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbfBNTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so3604819pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IvGrusmnL/Aou1wugSnS6px5st/Z0p64m7B6OiPnzc=;
        b=Fi8MqaPcIxGKR7Yzp0F8zn6F1VZ/N22K3AfaYUJXqdIeKAlYZPwmHaiFjwjRCcB0Kt
         2fEzYBYvqfk3C6DASFb+0QLNeEIxsuP4g0pJxBPetZpJnilhPokZgiBKz/DHMFJAiB8X
         dMEUBFpENR3eyuV/myAH9aCFmqWwERt8EXQ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IvGrusmnL/Aou1wugSnS6px5st/Z0p64m7B6OiPnzc=;
        b=qPMNr1Od/q1WP1fbwF3QQKt8gAA1yyTLsplyfTY5R+R8Z/mnvXs0sVdfYF2jMI/ZGT
         +MknsHH8Nx8JPY4w+dcXhlzXGYXnms9+LY1bCMSWOPJPExm+TRPhR0ckQJozr4/3N2Nv
         YPMyg8FUIqtyrvhQT9yne/kMw7VRmdAfOfBLnLO0QHTKeQyYleIfVfTgsDlJtqGIHm+1
         LrkyasRRWWKaGRd3Qk76uyBO4lADjiXXxFYrTZhnxNXTOSfQmg0ghaonyJ0Mkdbali8d
         jH19OPZAcMX82M/Wzw1zPICFzUyA6hYp0Wsi/VplwTpRnxuByvhBoGBFf8t9tF8S/HgK
         er1w==
X-Gm-Message-State: AHQUAubijNQ30zJIiaUnmi5uO1Uv7pON4pswlK/Mwls4fQ8YfNTWWm6g
        1GNp0qIUU0dbLkXBxnElAodVVw==
X-Google-Smtp-Source: AHgI3Ib+1+e8H9z4Pwke0tlc8r+YEYJdjpJ38IlWiXWurtSImc7BJmn9yEj1Vf3/xNFL5r+kAJ2fuQ==
X-Received: by 2002:a63:e410:: with SMTP id a16mr1483811pgi.28.1550172791847;
        Thu, 14 Feb 2019 11:33:11 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:11 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 06/10] drm/sun4i: tcon: Export get tcon0 routine
Date:   Fri, 15 Feb 2019 01:02:33 +0530
Message-Id: <20190214193236.7504-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes tcon attributes like tcon divider, clock rate etc are needed
in interface drivers like DSI. So for such cases interface driver must
probe the respective tcon and get the attributes.

Since tcon0 probe is already available, via sun4i_get_tcon0 function,
export the same instead of probing tcon explicitly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 7136fc91c603..4bb36ceb786b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -221,7 +221,7 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
  * are located in TCON0. This helper returns a pointer to TCON0's
  * sun4i_tcon structure, or NULL if not found.
  */
-static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 {
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
@@ -235,6 +235,7 @@ static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 
 	return NULL;
 }
+EXPORT_SYMBOL(sun4i_get_tcon0);
 
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			const struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b5214d71610f..a52696db14a5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -274,6 +274,7 @@ struct sun4i_tcon {
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm);
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
-- 
2.18.0.321.gffc6fa0e3

