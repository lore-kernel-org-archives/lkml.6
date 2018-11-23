Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0FA20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d5ZN6O4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0FA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504636AbeKXAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:46:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46357 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504597AbeKXAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:46:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12437263wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQVPhJGSfneBKnrTCT8O09cuMeK3FO9IL5Xd1gWmYUA=;
        b=d5ZN6O4uV69BR9+C+OxqmjGqoWdZwz4UKAx6gqplXhux8tbtCwjgRyGmPw2AzBPm1Z
         oLeVdLNFnlqR4lmzIC6U41nxFvUrWFKDvwmNYecyWMcdbdUYBwQOl8HN0iytE3/dmo0N
         jitskJ3BeEW0QpJ8344d3J11lfL8FAvLOoJ7TVk5COnlGxxgVlCOLTP/OfORfvPgaMF0
         hJjkUovOJiVxND+eJ9dDG43NI6LTNiBPU0AXvUmrgVYuEvw7Z42G1YQWn5xcVxWkWTYt
         JJ3NAvtXTBQnGCcvQ9jbIsjGpEuzZshBzix5fDAkPPenPTdbz9qajetV2OCIfDIHfDXK
         75Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQVPhJGSfneBKnrTCT8O09cuMeK3FO9IL5Xd1gWmYUA=;
        b=YnmwIPe/MEh3/kIZM0gs9cWxuQrrB2w9eZCwLkvFwfHuA6NNyjqweS0QflTkBCvu68
         6fqIa/UGS4eQ31J47f7S/gRDVUBwVQDheIpMS2YQ38Tj2U5+HMJi0n0+SBlZLiy9sgeP
         3ib3g2VlIeOhb4ocCof+ftBHAutValWUI0Alx8R1Vb/ZA6ISCPecyD2Y/ZCePuMXaAIk
         dP92UzamoUPu6Ir5gqwOwAm0Vfmu2fzFLkz/0tJ9Qf2qxJladCgzZzcM8lRbvvoOtJjR
         y5b/ocHHgKAMA4Dd/H2FpPyKA8bUqnKYB2lyrmj3NKlp269jq9iZGVslSkWLhM7x1FqR
         +fgg==
X-Gm-Message-State: AA+aEWbvdEYq8JPnAEDy2hMaRksZ5HvY6xL7sshtITpFhwd3ACgWhzTt
        ie+SElbI5LLcEbLcBwZJ9VZnyQ==
X-Google-Smtp-Source: AFSGD/U3PfTK74RJp5GB/Wyvb8KPwwJ46YvPAWsZIJ5GF+vtZ67G+pZrlNyqp19NaLzapdhKgq7xQg==
X-Received: by 2002:adf:f703:: with SMTP id r3mr13715504wrp.93.1542981755778;
        Fri, 23 Nov 2018 06:02:35 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:33 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zheng Yang <zhengyang@rock-chips.com>
Subject: [PATCH RFC 4/8] drm/bridge: dw-hdmi: add support for YUV420 output
Date:   Fri, 23 Nov 2018 15:02:17 +0100
Message-Id: <20181123140221.15700-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123140221.15700-1-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the HDMI2.0 YUV420 display modes, this patch
adds support for the YUV420 TMDS Clock divided by 2 and the controller
passthrough mode.

This patch is based on work from Zheng Yang <zhengyang@rock-chips.com> in
the Rockchip Linux 4.4 BSP at [1]

[1] https://github.com/rockchip-linux/kernel/tree/release-4.4

Cc: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 63 ++++++++++++++++++-----
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 523508af70b0..0b07bda73ffd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -94,6 +94,7 @@ struct hdmi_vmode {
 	unsigned int mpixelclock;
 	unsigned int mpixelrepetitioninput;
 	unsigned int mpixelrepetitionoutput;
+	unsigned int mtmdsclock;
 };
 
 struct hdmi_data_info {
@@ -538,7 +539,7 @@ static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
 static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 {
 	mutex_lock(&hdmi->audio_mutex);
-	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mtmdsclock,
 				 hdmi->sample_rate);
 	mutex_unlock(&hdmi->audio_mutex);
 }
@@ -547,7 +548,7 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
 {
 	mutex_lock(&hdmi->audio_mutex);
 	hdmi->sample_rate = rate;
-	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mtmdsclock,
 				 hdmi->sample_rate);
 	mutex_unlock(&hdmi->audio_mutex);
 }
@@ -648,6 +649,20 @@ static bool hdmi_bus_fmt_is_yuv422(unsigned int bus_format)
 	}
 }
 
+static bool hdmi_bus_fmt_is_yuv420(unsigned int bus_format)
+{
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
+	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 static int hdmi_bus_fmt_color_depth(unsigned int bus_format)
 {
 	switch (bus_format) {
@@ -877,7 +892,8 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
 	u8 val, vp_conf;
 
 	if (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) ||
-	    hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format)) {
+	    hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format) ||
+	    hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format)) {
 		switch (hdmi_bus_fmt_color_depth(
 					hdmi->hdmi_data.enc_out_bus_format)) {
 		case 8:
@@ -1018,7 +1034,7 @@ EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
 
 void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
 {
-	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mpixelclock;
+	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mtmdsclock;
 
 	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
 	if (hdmi->connector.display_info.hdmi.scdc.supported) {
@@ -1359,6 +1375,9 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	struct hdmi_avi_infoframe frame;
 	u8 val;
 
+	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
+		is_hdmi2_sink = true;
+
 	/* Initialise info frame from DRM mode */
 	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, is_hdmi2_sink);
 
@@ -1366,6 +1385,8 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 		frame.colorspace = HDMI_COLORSPACE_YUV444;
 	else if (hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format))
 		frame.colorspace = HDMI_COLORSPACE_YUV422;
+	else if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
+		frame.colorspace = HDMI_COLORSPACE_YUV420;
 	else
 		frame.colorspace = HDMI_COLORSPACE_RGB;
 
@@ -1523,15 +1544,18 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	struct drm_hdmi_info *hdmi_info = &hdmi->connector.display_info.hdmi;
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
-	unsigned int vdisplay;
+	unsigned int vdisplay, hdisplay;
 
-	vmode->mpixelclock = mode->clock * 1000;
+	vmode->mtmdsclock = vmode->mpixelclock = mode->clock * 1000;
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
+	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
+		vmode->mtmdsclock /= 2;
+
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
-		   vmode->mpixelclock > 340000000 ||
+		   vmode->mtmdsclock > 340000000 ||
 		   hdmi_info->scdc.scrambling.low_rates ?
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
@@ -1565,6 +1589,22 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	hdmi_writeb(hdmi, inv_val, HDMI_FC_INVIDCONF);
 
+	hdisplay = mode->hdisplay;
+	hblank = mode->htotal - mode->hdisplay;
+	h_de_hs = mode->hsync_start - mode->hdisplay;
+	hsync_len = mode->hsync_end - mode->hsync_start;
+
+	/*
+	 * When we're setting a YCbCr420 mode, we need
+	 * to adjust the horizontal timing to suit.
+	 */
+	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format)) {
+		hdisplay /= 2;
+		hblank /= 2;
+		h_de_hs /= 2;
+		hsync_len /= 2;
+	}
+
 	vdisplay = mode->vdisplay;
 	vblank = mode->vtotal - mode->vdisplay;
 	v_de_vs = mode->vsync_start - mode->vdisplay;
@@ -1583,7 +1623,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	/* Scrambling Control */
 	if (hdmi_info->scdc.supported) {
-		if (vmode->mpixelclock > 340000000 ||
+		if (vmode->mtmdsclock > 340000000 ||
 		    hdmi_info->scdc.scrambling.low_rates) {
 			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
 				       &bytes);
@@ -1602,15 +1642,14 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	}
 
 	/* Set up horizontal active pixel width */
-	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
-	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
+	hdmi_writeb(hdmi, hdisplay >> 8, HDMI_FC_INHACTV1);
+	hdmi_writeb(hdmi, hdisplay, HDMI_FC_INHACTV0);
 
 	/* Set up vertical active lines */
 	hdmi_writeb(hdmi, vdisplay >> 8, HDMI_FC_INVACTV1);
 	hdmi_writeb(hdmi, vdisplay, HDMI_FC_INVACTV0);
 
 	/* Set up horizontal blanking pixel region width */
-	hblank = mode->htotal - mode->hdisplay;
 	hdmi_writeb(hdmi, hblank >> 8, HDMI_FC_INHBLANK1);
 	hdmi_writeb(hdmi, hblank, HDMI_FC_INHBLANK0);
 
@@ -1618,7 +1657,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, vblank, HDMI_FC_INVBLANK);
 
 	/* Set up HSYNC active edge delay width (in pixel clks) */
-	h_de_hs = mode->hsync_start - mode->hdisplay;
 	hdmi_writeb(hdmi, h_de_hs >> 8, HDMI_FC_HSYNCINDELAY1);
 	hdmi_writeb(hdmi, h_de_hs, HDMI_FC_HSYNCINDELAY0);
 
@@ -1626,7 +1664,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, v_de_vs, HDMI_FC_VSYNCINDELAY);
 
 	/* Set up HSYNC active pulse width (in pixel clks) */
-	hsync_len = mode->hsync_end - mode->hsync_start;
 	hdmi_writeb(hdmi, hsync_len >> 8, HDMI_FC_HSYNCINWIDTH1);
 	hdmi_writeb(hdmi, hsync_len, HDMI_FC_HSYNCINWIDTH0);
 
-- 
2.19.1

