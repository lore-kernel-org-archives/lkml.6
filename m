Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0399C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D8720685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EdLNJqxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D8720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504649AbeKXArA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:47:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41155 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504623AbeKXAq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:46:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so12457530wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPc6aKsyCR0rc8B9wZzKkKLvBDF8NLCBhUpLs1nYqDg=;
        b=EdLNJqxQn+UHQvkoE2Z2vHzP8UE0eEyVegRHgBaj4qfgKFP7nQMVtge56C0cXXIPEx
         dZyey0gPKicEVvJ2twwkAHJECJB0l6VCDNuO+0UL/tiqUJ0uFGrXEb9biKKZ9tEx8Bp5
         hGLyYR6iaKsq5eWUO5f2D1uJ68s2fctCQSohhm4dRjeH/WMoH9+7Gb79YnxfqmfM4Vdt
         1qY/k8h4rJGnVuvx3alITg7P1MXxoGZ7lk3nt/n3dWSCXvFpM/cm9Bx1Dsz3tKl3Gr+W
         ihSJgoq0nv6YO/II0xSzMwzcDwNMweGqiW/VUHDLQGdZ39UiibBkIaVvlqmoQH45Zm/V
         Ws9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPc6aKsyCR0rc8B9wZzKkKLvBDF8NLCBhUpLs1nYqDg=;
        b=i5eYbuAtQmY02ujUVS3SiNHhCa5RmunuX37OBRUqyQ4wiWFKmqX1qXYUxRfKVSQY88
         xwagbBOcEkvGdFQzPn2rA3dayP2turovq+aFk3x3lFL0boYpolVycAjS1yDDsKApSEIE
         SbOzCV5XAYS4VMete3pgNHYCOQug8eKzYpSjkflutn8PvGGc1faYK/CeS10EM8/urYW9
         0fRVSOoNeWJ1NDk0c+kFtr8esCVEJfIxcl+h90/zt9OSXJFKGgtlTSzHPDVZ1mytXER9
         Ie1IBksCKAkZwtsmBp8JqwUDREagNuNR81V2/I5qKS3Lz+XAAHSFQgrL8PlhEJRZgsMz
         w3BA==
X-Gm-Message-State: AA+aEWa6GuDoiYJwfGgHojs8ymaLib4lJchfAl3z4rD3d074dmzbUEMj
        sCewc+/YyeqFka2Ai/uCHVbWQA==
X-Google-Smtp-Source: AFSGD/XD/kWmctMwWudcg/z8r8sppGMWUEEGLUHWWvfRsI0xXVIORdak4C5esaKEHXfYSx0SpW23yw==
X-Received: by 2002:adf:8342:: with SMTP id 60mr13449251wrd.212.1542981757541;
        Fri, 23 Nov 2018 06:02:37 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:36 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RFC 5/8] drm/bridge: dw-hdmi: support dynamically get input/out color info
Date:   Fri, 23 Nov 2018 15:02:18 +0100
Message-Id: <20181123140221.15700-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123140221.15700-1-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

To get input/output bus_format/enc_format dynamically, this patch
introduce following funstion in plat_data:
	- get_input_bus_format
	- get_output_bus_format
	- get_enc_in_encoding
	- get_enc_out_encoding

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++------
 include/drm/bridge/dw_hdmi.h              |  5 ++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0b07bda73ffd..b38ec1d775aa 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1763,6 +1763,7 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 {
 	int ret;
+	void *data = hdmi->plat_data->phy_data;
 
 	hdmi_disable_overflow_interrupts(hdmi);
 
@@ -1774,10 +1775,13 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 		dev_dbg(hdmi->dev, "CEA mode used vic=%d\n", hdmi->vic);
 	}
 
-	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
-	    (hdmi->vic == 21) || (hdmi->vic == 22) ||
-	    (hdmi->vic == 2) || (hdmi->vic == 3) ||
-	    (hdmi->vic == 17) || (hdmi->vic == 18))
+	if (hdmi->plat_data->get_enc_out_encoding)
+		hdmi->hdmi_data.enc_out_encoding =
+			hdmi->plat_data->get_enc_out_encoding(data);
+	else if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
+		 (hdmi->vic == 21) || (hdmi->vic == 22) ||
+		 (hdmi->vic == 2) || (hdmi->vic == 3) ||
+		 (hdmi->vic == 17) || (hdmi->vic == 18))
 		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_601;
 	else
 		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_709;
@@ -1786,21 +1790,31 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
 
 	/* TOFIX: Get input format from plat data or fallback to RGB888 */
-	if (hdmi->plat_data->input_bus_format)
+	if (hdmi->plat_data->get_input_bus_format)
+		hdmi->hdmi_data.enc_in_bus_format =
+			hdmi->plat_data->get_input_bus_format(data);
+	else if (hdmi->plat_data->input_bus_format)
 		hdmi->hdmi_data.enc_in_bus_format =
 			hdmi->plat_data->input_bus_format;
 	else
 		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
 	/* TOFIX: Get input encoding from plat data or fallback to none */
-	if (hdmi->plat_data->input_bus_encoding)
+	if (hdmi->plat_data->get_enc_in_encoding)
+		hdmi->hdmi_data.enc_in_encoding =
+			hdmi->plat_data->get_enc_in_encoding(data);
+	else if (hdmi->plat_data->input_bus_encoding)
 		hdmi->hdmi_data.enc_in_encoding =
 			hdmi->plat_data->input_bus_encoding;
 	else
 		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
 
 	/* TOFIX: Default to RGB888 output format */
-	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	if (hdmi->plat_data->get_output_bus_format)
+		hdmi->hdmi_data.enc_out_bus_format =
+			hdmi->plat_data->get_output_bus_format(data);
+	else
+		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
 	hdmi->hdmi_data.pix_repet_factor = 0;
 	hdmi->hdmi_data.hdcp_enable = 0;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index d7cc5d094270..27f9cce66b6a 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -141,6 +141,11 @@ struct dw_hdmi_plat_data {
 	int (*configure_phy)(struct dw_hdmi *hdmi,
 			     const struct dw_hdmi_plat_data *pdata,
 			     unsigned long mpixelclock);
+
+	unsigned long (*get_input_bus_format)(void *data);
+	unsigned long (*get_output_bus_format)(void *data);
+	unsigned long (*get_enc_in_encoding)(void *data);
+	unsigned long (*get_enc_out_encoding)(void *data);
 };
 
 struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
-- 
2.19.1

