Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA62C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBDC218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oQm704RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfBAMI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45903 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfBAMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:08:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so6763233wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U8D4EMqbdrTzMxFbP2TPfoDUUlIzjOUqwmRCaEDL1aI=;
        b=oQm704RCZtUrJJLIzY3UT6NQVrASndtwgpj7x5PHMZ8EhpthGJCgNF1/P1Dnk/Ix8I
         /US0g/nS7nx1l7s7fXo1C2TTnGl+wm3cUvSipzmeCCiN3qioHmKB3IPPhvbhIw5bMIpM
         Iyn20HuVgacnQ80b8gTZFnofKgtTbYrC//05JETctOmOAIxLpRGwwCrvA4abcMGRH0BB
         +YUXExv2aUjb+q54bQr5paQqKu7B2W001a6GmT/EMXM6Wa28ZBuvJhIH2Z4N7CKhX9FV
         FEapsZRaSGoWCM/YkEAJfOTdQai3hB3yHw/c6Pbvd7C1G5q35QjgJNvQYAWRNhsCK4VX
         CgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U8D4EMqbdrTzMxFbP2TPfoDUUlIzjOUqwmRCaEDL1aI=;
        b=Sei/piJQ3ChzrqKdr2/0P9/0l/eBD4Ofx0LOFnCmIU/JsuxgJGpLgczlHVvJNbz5ig
         FHqZUlkg4ZocWz0rv9e7MnKrkCy9DNEuOooa+LrfzMQ8g/WMzEr75SpdPb2qg8jUgds/
         EjDTVGEb7zJB5ji3bY2lIkJc2y0MRRwdP37xTs9IwIFQkZJLsqwu5u4yrBG6mF0lDT8n
         cE4N4N5/99xIhDd4lJI4mKkqQs9ErFJ8cCtQTHogQvnC5r4l6EcmnAYzuopQ2NokscmD
         tUPe5kKph8oeBfIRt/2x8V9KEUCV6w9aaLfMkHLfW5PtrkAOIsycNrwMe/ZTr1ukRJwj
         zZ4Q==
X-Gm-Message-State: AJcUukerJ2P32aRcjsDHJajxJCsXJdlTbhiNoMs+XzWTirr8utjn8L2u
        rtx90wYfzFw1PyFj52fD983ljg==
X-Google-Smtp-Source: ALg8bN7XUHxYZxVvm11k9DeDTcDHKBeThuvU2vXysmFx9rud3MJVL7Z5eDp/opAonYQ+hJaFVGW0OA==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr37384238wrt.63.1549022881479;
        Fri, 01 Feb 2019 04:08:01 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:08:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Zheng Yang <zhengyang@rock-chips.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] drm/bridge: dw-hdmi: support dynamically get input/out color info
Date:   Fri,  1 Feb 2019 12:07:50 +0000
Message-Id: <1549022873-40549-6-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

To get input/output bus_format/enc_format dynamically, this patch
introduce following functions in plat_data:
	- get_input_bus_format
	- get_output_bus_format
	- get_enc_in_encoding
	- get_enc_out_encoding

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++++++-------
 include/drm/bridge/dw_hdmi.h              |  5 +++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a63e5f0..3634bbd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1807,6 +1807,7 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 {
 	int ret;
+	void *data = hdmi->plat_data->phy_data;
 
 	hdmi_disable_overflow_interrupts(hdmi);
 
@@ -1818,10 +1819,13 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
@@ -1830,21 +1834,31 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
index 66e7077..d506df2 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -144,6 +144,11 @@ struct dw_hdmi_plat_data {
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
2.7.4

