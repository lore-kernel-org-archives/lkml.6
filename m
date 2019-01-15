Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB51C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HBom914s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfAOMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:33:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55269 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfAOMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so3094601wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUfwTqoMPR8UzZypqTJDh+Fm2T1kEFvs4nZ2QeLkUPU=;
        b=HBom914sYtVT9MM8OI9PQvgsUTpfwAJCnkLKf+GefDBt8AtPBp2tzzJLJtrUm+mPSl
         +0gBwOJZsER9Gqm38ZLbuoH6RmEWkgbiJ7erf8bYqJdcmUxEvJk0qN1+f6jN5rSRCqVK
         FcN84FVaLaj+La8RqHisoqYhMwk6THvwL0MbBm2xNDAAGQfgm+x2mc1vc3L6a7UpSsMn
         OUhUELnnOflCgH+oL6UooWbw3YRkOcqjarKCCghcXn9amxY//Dhwv3UQhdO0ma9IOtwV
         m19XnKAoW/UxBC059wTfRje/gaFyiN1QFa04qVfM0jlhF3p1mvzqJXaesDfNJzwqubgA
         FlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUfwTqoMPR8UzZypqTJDh+Fm2T1kEFvs4nZ2QeLkUPU=;
        b=hD16H9inBHeqLDNrBQajm7S2asgQMQXl+TcbFadqUPcDe1dOEINP+dKrN/76Dto9Xd
         sLIMYDJTLAF9EqPHpjGM6lybu35Hshwc39D1mQzaFgsQkWbJs10YgtGllHe0N+uh7zJF
         lb6o8PrsHnz8wS7AuDLcJutEhA2L/oDfA8YTVcn/uZyQo5pp3GrzsC8UtaDRRIQfJ+xx
         sX2erk1bSAFqJnCPKh8R8AjBUOoipbBFce4ZIbCJpSB6ylTRWsPQIrsmEV3JkLf7osHV
         jh+uULUbHg7BUlhmLUsN9YSpqOygxLvSn/oPG/UR/YXkXAHRm9MP0LbsqiPGqt46GkDb
         KflQ==
X-Gm-Message-State: AJcUuke7fSBr7fCQLpuTIvZxHzxXj/Cufhc6Eaw3OVUK8hR5HXnRQZ9D
        T2HZHp6wnD9GxI/E8NbO3GYgqA==
X-Google-Smtp-Source: ALg8bN6BxR3WgrQy7Tb5sH0N7HiyYqaHgXyfiWbKrC9IbeBRedCzujVGXEcsa2J5be40krADBnmm7w==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr3488704wmf.144.1547555606337;
        Tue, 15 Jan 2019 04:33:26 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x15sm75658842wrs.27.2019.01.15.04.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 04:33:25 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/8] drm/bridge: dw-hdmi: support dynamically get input/out color info
Date:   Tue, 15 Jan 2019 13:33:12 +0100
Message-Id: <20190115123315.11069-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115123315.11069-1-narmstrong@baylibre.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++------
 include/drm/bridge/dw_hdmi.h              |  5 ++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 4a9a24e854db..bd564ffdf18b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1810,6 +1810,7 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 {
 	int ret;
+	void *data = hdmi->plat_data->phy_data;
 
 	hdmi_disable_overflow_interrupts(hdmi);
 
@@ -1821,10 +1822,13 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
@@ -1833,21 +1837,31 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
index 7a02744ce0bc..2e797f782c51 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -142,6 +142,11 @@ struct dw_hdmi_plat_data {
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
2.20.1

