Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DB3222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K9+zw67u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439771AbfBNT0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33625 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439737AbfBNT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so3596389pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCL7zOvAf1NWF05m63CPXM37pS/d93C5nu4kd6BUq+I=;
        b=K9+zw67ufc8DaaJo+tTQydkpSrx5nlGraeqeSAo3n+X5ceMeAcFS+s+lCDqXhZbCAH
         KEudWGAC2KiR8BjB8qkOw9YxkdTUyNd0mkTg2gtgWQKt/1hifbYXJ10L1t6qBPOXFbE1
         W67Bp3DP6NAW4Nt8HFiWxkEnuqEFYqaGYV2bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCL7zOvAf1NWF05m63CPXM37pS/d93C5nu4kd6BUq+I=;
        b=Z36GPwChWyMS+EqhHb6lloGGRzaQlpzfTRM3Yhw71IdQJPbg4ud8axc6Q52jUyw6NJ
         YXIM9wRNUIn6O61qAi7asix1A276ubvYUQMdsmF75OrcmXutut+JKDgEBtANy4kY4NmR
         qzpRW/VR/a1IGjKmNV6OB3cZzp96Z4BtYCLY4yCcMFApYIzB25aw8+XOBsGEIQ0J750e
         8VkV1pAFTqgFkJYzLajpSSSt4lXfDDy3J6Pc12mVH+7DfUMenRAyuqZSP3MLXQY6e+vV
         /XMIEyB7+Dvo0TzhgaoWupfkuuk4uhkz0og2sLYwonTSCqaeBs+KBj1wz3LZuZj0afXL
         YUFA==
X-Gm-Message-State: AHQUAuZOXT0eI/r6voo8f/dhoS4KZbUWp0v2jpJonR3icteMcoAUUszo
        r9l5LMsjtJg7eZeX0oFqUQj//g==
X-Google-Smtp-Source: AHgI3IbMiL/gS1qmVCENxTGERlXMbdvyTc5nPHlKAL3EzoaLl3D4CI3+JAB3CJNEUS0DDrPFt54fxg==
X-Received: by 2002:a63:fa48:: with SMTP id g8mr1447618pgk.203.1550172393490;
        Thu, 14 Feb 2019 11:26:33 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:32 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 8/8] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param transfer
Date:   Fri, 15 Feb 2019 00:55:44 +0530
Message-Id: <20190214192544.7314-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short transfer write support for DCS and Generic transfer types
share similar way to process command sequence in DSI block so
add generic write 2 param transfer type macro so-that the panels
which are requesting similar transfer type may process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 31cf9c58e98d..3a28d70dbdc1 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -918,6 +918,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3

