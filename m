Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MA+FRrD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAOMdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:33:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32957 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbfAOMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so937387wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyRstzIV/tkAOjKYQyUc2I3/RSm50wt24so0Y7Xd4I0=;
        b=MA+FRrD2pAe1tJDkbCSL7E5xbgFJTsqLnnkt0FCKFfj401eznf0TvJ33FnJ4mVwffc
         GTXwuftlxCEEurP2YL6g0gX2fnwSI0gIhSE4arQ8UUU/4/1sJw7aYmnHxrRvmDRIS3ap
         x/LM0RR7e2D/7D6h+ZghwnnTJtmFnDPc4ycOdAbIMFOhWwCtQTH9bzHZF98ti6++BW7U
         7F7xVkqoLMlm2ENUvWZFDYD7uq4gGtWKXPhwPTn6CiUDM1dNwUHkk2AHnWxkG6PWw8HO
         6eyVC16tO9PFW1LCVSghtyf+20hvF4zxH+nGruvePdYCEhNm2zpoSfwHhUg02iNC2vHU
         vZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyRstzIV/tkAOjKYQyUc2I3/RSm50wt24so0Y7Xd4I0=;
        b=Jbwdi+T60mUAZX5cjYgQtdJQwpSbgcq/xSP7nAqGk9Q4Ej4EJgOPRgeF1fan62m8kQ
         zOKgrbGcqpllGgAAHP/aASCb2ZM1Sa6DgjUYz7iQnfG0oTAPoc2BResw+bHuntoR7nF1
         ZeBkq4wRleVA27L8S1Ka/xU/xNU9qP/6EQkcge+X9x2LAwu+FLoGuZYHwlI0TK9D+gci
         mQ7Jv7IKnS+ScxIbth1HNI9uZ6v5SVQvH0IK8hpGkkZqMHwZKPi6JZuj8fdyJ4nkXMRz
         9pCUby6VPM/xTRu/MEiU+q/JfPoDeIk72HR2Xyfgi09uma7TzZVaRDgHFctdCnz/6MCX
         rlrQ==
X-Gm-Message-State: AJcUukexeIerEcWJvqaUG9iTePPKl5ufplelbQAg4ScCucYvJgZjnIZY
        gPPE09kCec++fOUadH3kDyhsUw==
X-Google-Smtp-Source: ALg8bN4KHxpUruVaC3yEK2Zo21G5jB7Xjk3AuRbqMXTguxiTn86PlJC+fphEuc+YHMEgsDLJrU3lhg==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr3032470wmk.59.1547555609820;
        Tue, 15 Jan 2019 04:33:29 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x15sm75658842wrs.27.2019.01.15.04.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 04:33:29 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/meson: Output in YUV444 if sink supports it
Date:   Tue, 15 Jan 2019 13:33:15 +0100
Message-Id: <20190115123315.11069-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115123315.11069-1-narmstrong@baylibre.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 068b56a991b5..413575b5c3a0 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -669,7 +669,10 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
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
2.20.1

