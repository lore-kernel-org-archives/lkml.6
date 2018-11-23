Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D49C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA5D20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UIIfmXrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA5D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504675AbeKXArF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:47:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52562 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504597AbeKXArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:47:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so11979718wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SIJT5QqO0Ood+YfrWWDW0Calk9kUt/xKiJMwTKVygRA=;
        b=UIIfmXrjtCP/n7VMS3ZKBcqWVMlafkJEkceR28ylOAbK2qj3rWGRHEXZQBfZfgLqEC
         rBZTMC2nQYudehjF9RFWDthl9dKCcwwXDCgrcwB7lUtGR3s7LcdgyaQMicfyxuWpl/yu
         6UN7An0c6DUT+Fk3a45UF9XixrSOaNS3IS7yqw+wW3hvUflEvVVjmNe02J0yEiD62L+x
         cYhO3BECw6yBwhd9O+SBk5NHPfMEMLe2UkcLRpcUXUtZt1ffcozsdnP83yxP8EGMZIbO
         WvqO5KhaiFVek/4zuoVibyliiv9jTq9DSNaoYXgqKBEWcinSOJYwUO155EAd/y3SNJWb
         FhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SIJT5QqO0Ood+YfrWWDW0Calk9kUt/xKiJMwTKVygRA=;
        b=C16mjUY/skhamyNeu6QRDpm1olU3u4B8J0mvfvHHZypOUy+ouEV6xtHDJQNWMjzTA3
         NfPcwU7NfL5PuFyq+C7kWvG06dwpk1ZwuwhOiEX3F1iQ4tryvxUdFxhwkny/Oxd4JK+y
         63ZT7zVq+dMmCRLi67WSD5kUDWCIHKQNoVTvpa5JvGW+ADDxvpY+9N3kLlpGMt+IMYF+
         ALqcIOIZFlbfd+qT9bRiCzzEL00HPsZxW7ivlEVL/uiAEZ5g1MeFNQ8k+BYFlPAt70rX
         Wg41tCVsmAeeJDd1+jkgIW53Tj0cI1jLMSZtdlik+JNn3p5Ukf8NKVqMSVy96KS8T6Uf
         iO1w==
X-Gm-Message-State: AA+aEWZTbeflsqXyOBSVuAkxcUQCJ3Lx+sU6UWOMxozzzXYtxchG7B06
        MlfGeDpjgiEH0Zq37zDFIuWp1w==
X-Google-Smtp-Source: AJdET5eAPcZ9Ku85dss+v39pgv/YUeCxdqKg889SvevlBC2Oz9OZmjHMC3m35bcLm08KmM/MyVK0oQ==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr13929589wmf.33.1542981763977;
        Fri, 23 Nov 2018 06:02:43 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:42 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 8/8] drm/meson: Output in YUV444 if sink supports it
Date:   Fri, 23 Nov 2018 15:02:21 +0100
Message-Id: <20181123140221.15700-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123140221.15700-1-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
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
index 0b9ecbfe65b4..6df124c1bba5 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -670,7 +670,10 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
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
2.19.1

