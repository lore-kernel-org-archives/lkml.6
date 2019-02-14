Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED554222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SGW1B5ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439829AbfBNTdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43023 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439821AbfBNTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so3659402plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6AGEDEznrcyIAQu7pFk0JzPvtPdj8NLMH+33kB6pi0=;
        b=SGW1B5akvXzvsxDyeejD9mmfcNx8ja4vu84TPtTlU19Xk9kLsVx4nL/ePLdO27zelG
         6h7fFzxs/YzTGWdvUJYojyW80NIZGRAFmi5o5GhNhlUyaJqJpACVXAC4noTN55OZuQBD
         DmlhgD/fLzNgau6GvLRzm2wq0EhPXaMSxBZKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6AGEDEznrcyIAQu7pFk0JzPvtPdj8NLMH+33kB6pi0=;
        b=c6pwAQ6IoOBBqN1U1SyYc8Dqq8VM8K7C+ng5bKKN0F5U0TM8/r4Y3dOb/5Red/d6N5
         lw/2haD54lYLgkDG7n8A8V1C7l1CfZR7FPZKSK8yzn0SCt6LdVgWnXnFFmT4LW0IDQ6F
         jw97WlP5bNJvXiiNa3v2OiGjHK0ZP9J+EWsWjtXCidep0gumxIqWZEgIpaZh9NWdkn3J
         Qf1jUEEBkRtNTwowwSozqr7AwoWBS74sJymdJXczS+U69Vcsd1OFOcSayBcjx46dwW0G
         SMe9KzaUpJqsXWvId+r1I9T1u2OQlVtSdrlodvmnkTk6PuQG36ZaRdORwRwx5QWHSusY
         4DWw==
X-Gm-Message-State: AHQUAuZqy86tisr82CUBnHPm0LpZp5Ek7+vsYVEKHNmMfSLHDqu/AhfT
        260OM7b1iTQM2SLv50KosMcmEQ==
X-Google-Smtp-Source: AHgI3IbudX+KX/Xlne9o+VRFvpKSm10YpgxqmC05vhloYEmTQVaMjo2QK/RRqs8kz1huw4dQFI88yQ==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10mr5589873pls.303.1550172795331;
        Thu, 14 Feb 2019 11:33:15 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:14 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 07/10] drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
Date:   Fri, 15 Feb 2019 01:02:34 +0530
Message-Id: <20190214193236.7504-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe tcon0 during dsi_bind, so-that the tcon attributes like
divider value, clock rate can get whenever it need.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index ab95e2a873b5..62b4c822bf18 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -25,6 +25,7 @@
 #include <drm/drm_probe_helper.h>
 
 #include "sun4i_drv.h"
+#include "sun4i_tcon.h"
 #include "sun6i_mipi_dsi.h"
 
 #include <video/mipi_display.h>
@@ -996,6 +997,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
 	int ret;
 
 	if (!dsi->panel)
@@ -1003,6 +1005,11 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->drv = drv;
 
+	if (!tcon0)
+		return -EINVAL;
+
+	dsi->tcon = tcon0;
+
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index a07090579f84..747c451a9a20 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -26,6 +26,7 @@ struct sun6i_dsi {
 
 	struct device		*dev;
 	struct sun4i_drv	*drv;
+	struct sun4i_tcon	*tcon;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
 };
-- 
2.18.0.321.gffc6fa0e3

