Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7225AC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4203D222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="coa3lgKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438344AbfBNT0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36885 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbfBNT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so3666411plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RPyU9KlTHdOgkAmLOMKP2ZsiLo1+0ZzZXt5rKrY9KQ=;
        b=coa3lgKd3W2zLu2VziGXiWdi2qk5QxDTrpA2V0L/4d0k8Na1MyZ7VcBMJzkpIOQmTY
         bwC+BKOOMMfY/oYkT8xYMgTmOvOa7K2+U0iljl8Ngny+htseLtdLPWUMjdqAVh78LcbF
         /8qvTLIReYhLio93eNCAvCIo8MzRuYbQ4wSts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RPyU9KlTHdOgkAmLOMKP2ZsiLo1+0ZzZXt5rKrY9KQ=;
        b=ABiFAmvForff+XBf7TxPkgCBacsEsMyPfQ6W0ByWhAoNNWcPDN7/dCV8+0UHgtRPEq
         4qVC14o5XPE2idB7STMsIA3KGmIYcGQkDRDMhLftbEQ38Jt6NdsbZfsNaOan9BUPUYXt
         7PB0ZzBmT7AeZ0VaV8FQnE0gfQN9i9IqS+ZKUKPB66ie/+CZNk8xDVYRRbJbvAJemC6z
         mHrAKCJM+zC9sH6YwGSfBo5Bz6eJ+mahU1CgczbxYLY/iZABoObZ+ACKRAPaz1NL3LZ5
         SWulY0SIEOIF8VOmA11SuiQkwO/lbq4/kVQPJxqn3oMTIPjnY25tQtGyVqjIUnvNZU4e
         2gJA==
X-Gm-Message-State: AHQUAuZVKk85Lkqx22yJCYRYtp5MYoWMKWMr5Fn3xljjjFZ4jpdWNqdG
        dfmpWuTeZ9WB3fjerEzC1SBoYQ==
X-Google-Smtp-Source: AHgI3IaiBOPW+CBlLrKkP81yfT4FIZkOlPh6b4UXVprpinR0lR+vBgoOU825d/GhH4kDRSvMHMelvA==
X-Received: by 2002:a17:902:b087:: with SMTP id p7mr3905888plr.56.1550172368856;
        Thu, 14 Feb 2019 11:26:08 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:08 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 1/8] drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
Date:   Fri, 15 Feb 2019 00:55:37 +0530
Message-Id: <20190214192544.7314-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The horizontal and vertical back porch calculation in BSP
code is simply following the Linux drm comment diagram, in
include/drm/drm_modes.h which is

[hv]back porch = [hv]total - [hv]sync_end

BSP code form BPI-M64-bsp is calculating vertical back porch as
(from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)

timmings->ver_sync_time= panel_info->lcd_vspw;
timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;

vbp = panel->lcd_vbp;
vspw = panel->lcd_vspw;
dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
=>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
=>  timmings->ver_back_porch
=>  mode->vtotal - mode->end

Which evatually same as mode->vtotal - mode->vsync_end so fix the VBP
value in SUN6I_DSI_BASIC_SIZE0_VBP

On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
value.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 318994cd1b85..d70a8c43a4b8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
 		     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
 					       mode->vsync_start) |
-		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
-					       mode->vdisplay));
+		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
+					       mode->vsync_end));
 
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE1_REG,
 		     SUN6I_DSI_BASIC_SIZE1_VACT(mode->vdisplay) |
-- 
2.18.0.321.gffc6fa0e3

