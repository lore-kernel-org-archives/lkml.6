Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F161BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA634222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OeoCqo+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437247AbfBNTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:32:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37492 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405962AbfBNTc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:32:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3675233plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9m6ReoBLBZFOeMQ09Fo4ZfosvrNH9XVGYhAEmEbH5dY=;
        b=OeoCqo+1i6jzEn5S5XDmRKxrzslqlqYs/BvduK85Glf5ZV1W2o23Sx7cdG38olCj7e
         hdkC78PBImdtCLjMwJS+HAmt0f9+vy/Xu9y6Hx44az+uv6BqY4ycKa2Y6P2KOMJPlB+0
         /TwNNnv5NyIJsMfZCaKrAJGzu0pZ2Bx3MEdiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9m6ReoBLBZFOeMQ09Fo4ZfosvrNH9XVGYhAEmEbH5dY=;
        b=trxCmjmZ/ZfboAF6Voa8X6U0J+upfVmY4jNTN18x0KIHqi8IVyUMpZW9lnTfyxEn48
         71C+uZ4ROXMZdx4JAuUsww2MRUG0gP6OE6GPrNJrlgcpqTK2vCcZqj4RW7i84uMNfNHy
         MnsZvIcTzKrS+zj86ASCmxDNUnSYwZroCZGKPhUOpNe/YpQ7ZyKKd8wz96AvSs8G7C61
         L2EUCkRVVDQutC7umvOnqtIJU5RQcnI6ricFpzutBliJXkc6+pFA6ztmsbTtnTRy+0Zp
         NS43cLUboyDhVwLrWr9f3SQnwjudVD39JrA76K0oEEI+FOy1tOoLqwnGxSR13x3LuVF/
         YPJg==
X-Gm-Message-State: AHQUAuaWiyuEdZQeK+QtOiO2yUav9z3TWFmVg/xK1VfQ08vAvl09GOax
        +mLaiO0IWXAaZvKXJDGFr4jRmw==
X-Google-Smtp-Source: AHgI3IapVc576RPyNQeLXBiOhwHc8LrJB3pQYJLbmAl68gLhk5RNwUKAtczEDY1JZy+5na4RFvDE4w==
X-Received: by 2002:a17:902:2ba8:: with SMTP id l37mr5888652plb.243.1550172778007;
        Thu, 14 Feb 2019 11:32:58 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:32:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 02/10] drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
Date:   Fri, 15 Feb 2019 01:02:29 +0530
Message-Id: <20190214193236.7504-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction loop selection would require before writing
loop number registers, so enable idle, LP11 bits on
loop selection register.

Reference code available in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

(dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
	3<<(4*DSI_INST_ID_DLY);

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8184fbcfd9fd..1a0707468121 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -421,6 +421,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 {
 	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+		     DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
+		     DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
 		     SUN6I_DSI_INST_LOOP_NUM_N1(delay));
-- 
2.18.0.321.gffc6fa0e3

