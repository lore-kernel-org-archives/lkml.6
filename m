Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7ECC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC6C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zvcNuf5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfBAMIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45911 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfBAMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:08:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so6763454wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQOoUB0rgLtmYotjEraQRM2tqr+yR8VV5kceQJyYLDI=;
        b=zvcNuf5Prmwt7s9u71yqsqADM+sILJuGe6MILPhv/QoYcaFDNMa9bjFyNLI5L/XOv1
         2kMoTVUwSlRBUEsoN53Izcdt5U/EECacXaEURBWwv3kJnQQBvLl9QvYCUt0Je5F7xS/h
         9enbFDmqnFJxiouy7N9iPLK1Gtll4IZsNN4keuiG6Q5KHT95fXC3xHjO+Tl387hyFI+l
         44O2pBRhsLsKT9ZL9s+tm/8QyksRduRXkxPJGmtHOmGjFQNzVUpm8RZdKuqxItqseiYO
         6sZNB7okRaw5BAV8zz7217h+sjkQPQXYsmkBdw41J+xwPRpXuF8+kgP2mHlmrg3GHtbi
         xANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQOoUB0rgLtmYotjEraQRM2tqr+yR8VV5kceQJyYLDI=;
        b=e1kL/NOl7AjXBQUbGGIXa+KUKW6HO8gPQ8i612DrmfJnGW3HNTVf0wYEp58dqYAspM
         Rni3tDTfKCxavz1o5w9LcKJMazugzVp6cLjbvxeL9d1rff1k1lLe91jp4VNTLCUcBaTo
         M8D09Y7a90meKGCKygCM3+U1//nAM9kGLFKpyeotjrMWpDWk4mloqvglUq1ZKB2LpmKV
         /PIjxzKsLI607w/t1tgtiPbpZuaY4e/IDUeBY9yLZXbF6ODHxzYiQ3LE8W7On3u/YJs1
         eb/6auEMFZspPYCVBhuwGUYD2/M7bSh3ZuQwon7MRcWr3MpYPp5U1vaomJBxO5/NnoWo
         1Y0w==
X-Gm-Message-State: AJcUukeL+rG71XycqoMXPzzhB/LZ+LElGbcpsY3kLUACVc9c4YEYcFnE
        TQOCdOFQVqZIYLP5+AM8CHcAgw==
X-Google-Smtp-Source: ALg8bN6W6UUSJgBgN8zNCuHul8qB4MBOiy7g3LviRj/8/vg/TkfEZrq1xKdupKqZnIdk3MzmrTQ0jQ==
X-Received: by 2002:adf:b102:: with SMTP id l2mr37076933wra.296.1549022884854;
        Fri, 01 Feb 2019 04:08:04 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:08:03 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] drm/meson: Output in YUV444 if sink supports it
Date:   Fri,  1 Feb 2019 12:07:53 +0000
Message-Id: <1549022873-40549-9-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the YUV420 handling, we can dynamically setup the HDMI output
pixel format depending on the mode and connector info.
So now, we can output in YUV444, which is the native video pipeline
format, directly to the HDMI Sink if it's supported without
necessarily involving the HDMI Controller CSC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 540971a..69f9b2a 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -664,7 +664,10 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 		dw_hdmi->output_bus_format = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
 	} else {
 		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
-		dw_hdmi->output_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+			dw_hdmi->output_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
+		else
+			dw_hdmi->output_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 	}
 
 	return 0;
-- 
2.7.4

