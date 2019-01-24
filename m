Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83ECC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BB21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jeWZ5DF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfAXT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:59:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41479 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfAXT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:59:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so3377253plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lUl8gOFhrx4lYOm2vF/JCpXkf8drgoe2NMxhC71Dtbc=;
        b=jeWZ5DF/Sq8J4qQFqwK9SuQ1fhIqjn/TB18xw+ErxMSSqUzs8Y3r+0dB8MgQhwvsX3
         REJe4AZyHAZRrDnOdJHNNP/DWhsjbhyP4KfIRizxp+8dTz2lQnuEr+rn+6DLBbFCY1ul
         BwsO3bb7BcuEbfryNfa3yYWkfc5Bay5zpgTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUl8gOFhrx4lYOm2vF/JCpXkf8drgoe2NMxhC71Dtbc=;
        b=HSq13n/L+SsMMoYEMOWAh78et8eCiu/HaPQ2TJCMGMGlAvQHZi8UzqbCSnF1ZNGBkp
         MztFdNXiuMc9oj1sCUv0RgmR05/T23yzD0Us8OHGXTBCRV1ZOvVRVcpXLAKHHOV6U87+
         zt4Pj6IE97Ct0C/hboKZjTiyzm5N/L6G2b2TP2Xq9XHixoExxQeF6y5nVL7fGPi4bftA
         mFqRc4hzdkzYTlK6BuUIT0awReQg20Ouo42mcWp5BopaP0j5miMWmfICBnpZGLR6bSMS
         G6BK5GsOKjuRNOITQdLSuC681/qSJxyWBwn/A2kXSHDCNhWHB9C9Ohe2W/VliN/tAqUR
         OCXA==
X-Gm-Message-State: AJcUukf0OlKju7y9EB/vHQ/2800yUF7VBjY4lGB4S4Bhcuuz75eboBot
        1xfXMIFhC2HcXf95j/zao8AVoA==
X-Google-Smtp-Source: ALg8bN7NESCraba3ImvDdbMW3YOUxJbvyN6X4qxs9MVe4v22yd3Dc0+wGfyMcok3MAgjFBhFhIabxQ==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr8016256plk.282.1548359991632;
        Thu, 24 Jan 2019 11:59:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:59:50 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 06/22] drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
Date:   Fri, 25 Jan 2019 01:28:44 +0530
Message-Id: <20190124195900.22620-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe tcon0 during dsi_bind, so-that the tcon attributes like
divider value, clock rate can get whenever it need.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 16a86d35dc5a..2aeaa19a8d1e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -24,6 +24,7 @@
 #include <drm/drm_panel.h>
 
 #include "sun4i_drv.h"
+#include "sun4i_tcon.h"
 #include "sun6i_mipi_dsi.h"
 
 #include <video/mipi_display.h>
@@ -947,6 +948,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
 	int ret;
 
 	if (!dsi->panel)
@@ -954,6 +956,11 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
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
index dbbc5b3ecbda..257cca660da0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -33,6 +33,7 @@ struct sun6i_dsi {
 
 	struct device		*dev;
 	struct sun4i_drv	*drv;
+	struct sun4i_tcon	*tcon;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
 };
-- 
2.18.0.321.gffc6fa0e3

