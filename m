Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E028C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25D42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TijsTHjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfAOMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:33:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37097 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbfAOMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so2775133wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtfWWbhzQdB5CMqLuImYQiLtl0QoEacaFXssU5u10C0=;
        b=TijsTHjIgG0NUrFHCOBe2ieIIoUpQI7bi2EUZQPA04Vrm/rT75a22MdxJJoHkYiXhw
         EgosoAtFeU7IWp97W7ZCBPZsAm0giiLyZFzwTls61lZstKj1ngPJj3NVgI0lc7AC/HJw
         shvHUd2Zj1YF/jSXaRtE2forRlP+Ttsida3VLsPg8Vdd9lrEx5omU3EeuWyfVzWIy8ua
         RMJP2Yh4KPU9vM9NfEnPCPhs+9tsewNhm3kQp6gQ58lHyot3dDT6pRr1r9R3zM8rrqMy
         zNNFdoyRPVv8EEXlbdHQA7jWNpSSQLPBVzMjKKcFf9c0e8CQ9fgQf913tvya7rzR0QuL
         2Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtfWWbhzQdB5CMqLuImYQiLtl0QoEacaFXssU5u10C0=;
        b=cfW8A/WMKVObHj5OibZIbUw5ESCfH51PJ0AwMb6LOxJZ9y3Ex9/vFr/UjxRKje3QYo
         yfgXpoLkTTe2XAnilqKnrcF3GttTrF4J1EO82TptLP0eBjI+7PenoIK36H+h/oWtuIcF
         bvlDFpjf5X98F1pm5v+bIhRVTcy7UDstRYvh9UbI91Pzm1gRR1QIkktlgrwbQX927z+8
         QXjgBquKtBb6VM2GmWh+c+Wg69WWUgy7A6a/qONmtgDBENdsl4WQyTtU/2EAfcXTwDzu
         B/9pKKdIv3D8nHodNNWqLZQ7vRl+2lMce+mUyNIEFim/9YGVeXxnw5oe+B2wzcaGW2RF
         rSnQ==
X-Gm-Message-State: AJcUukf16OjP7hSWU2MWqZxAGYQE/4emQhLtq53JgkxxzhTpqfoiaYcy
        kypPgggQZweR41Ei1bNdEgghMw==
X-Google-Smtp-Source: ALg8bN4q3DNyp+h59cGRqHgB2XJtZ5vEFBNtQCHrjhdGgN99F6Qdm6UD+fIy5hZgQSjeBrGSGSf/9Q==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr2992541wru.300.1547555601143;
        Tue, 15 Jan 2019 04:33:21 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x15sm75658842wrs.27.2019.01.15.04.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 04:33:20 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
Subject: [PATCH 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
Date:   Tue, 15 Jan 2019 13:33:08 +0100
Message-Id: <20190115123315.11069-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115123315.11069-1-narmstrong@baylibre.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
Scrambling when supported or mandatory.

This patch also adds an helper to setup the control bit to support
the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.

These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
on the Rockchip 4.4 BSP kernel at [1]

[1] https://github.com/rockchip-linux/kernel/tree/release-4.4

Cc: Nickey Yang <nickey.yang@rock-chips.com>
Cc: Huicong Xu <xhc@rock-chips.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 88 ++++++++++++++++++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
 include/drm/bridge/dw_hdmi.h              |  1 +
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 64c3cf027518..fcd941d52753 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -28,6 +28,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
+#include <drm/drm_scdc_helper.h>
 #include <drm/bridge/dw_hdmi.h>
 
 #include <uapi/linux/media-bus-format.h>
@@ -43,6 +44,11 @@
 
 #define HDMI_EDID_LEN		512
 
+/* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
+#define SCDC_MIN_SOURCE_VERSION	0x1
+
+#define HDMI14_MAX_TMDSCLK	340000000
+
 enum hdmi_datamap {
 	RGB444_8B = 0x01,
 	RGB444_10B = 0x03,
@@ -1015,6 +1021,33 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
 
+/*
+ * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
+ * - The Source shall suspend transmission of the TMDS clock and data
+ * - The Source shall write to the TMDS_Bit_Clock_Ratio bit to change it
+ * from a 0 to a 1 or from a 1 to a 0
+ * - The Source shall allow a minimum of 1 ms and a maximum of 100 ms from
+ * the time the TMDS_Bit_Clock_Ratio bit is written until resuming
+ * transmission of TMDS clock and data
+ *
+ * To respect the 100ms maximum delay, the dw_hdmi_set_high_tmds_clock_ratio()
+ * helper should called right before enabling the TMDS Clock and Data in
+ * the PHY configuration callback.
+ */
+void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
+{
+	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mpixelclock;
+
+	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
+	if (hdmi->connector.display_info.hdmi.scdc.supported) {
+		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
+			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
+		else
+			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_high_tmds_clock_ratio);
+
 static void dw_hdmi_phy_enable_powerdown(struct dw_hdmi *hdmi, bool enable)
 {
 	hdmi_mask_writeb(hdmi, !enable, HDMI_PHY_CONF0,
@@ -1216,6 +1249,8 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
 
 	dw_hdmi_phy_power_off(hdmi);
 
+	dw_hdmi_set_high_tmds_clock_ratio(hdmi);
+
 	/* Leave low power consumption mode by asserting SVSRET. */
 	if (phy->has_svsret)
 		dw_hdmi_phy_enable_svsret(hdmi, 1);
@@ -1237,6 +1272,10 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
 		return ret;
 	}
 
+	/* Wait for resuming transmission of TMDS clock and data */
+	if (mpixelclock > HDMI14_MAX_TMDSCLK)
+		msleep(100);
+
 	return dw_hdmi_phy_power_on(hdmi);
 }
 
@@ -1340,11 +1379,12 @@ static void hdmi_tx_hdcp_config(struct dw_hdmi *hdmi)
 
 static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 {
+	bool is_hdmi2_sink = hdmi->connector.display_info.hdmi.scdc.supported;
 	struct hdmi_avi_infoframe frame;
 	u8 val;
 
 	/* Initialise info frame from DRM mode */
-	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, false);
+	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, is_hdmi2_sink);
 
 	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
 		frame.colorspace = HDMI_COLORSPACE_YUV444;
@@ -1503,7 +1543,8 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
 static void hdmi_av_composer(struct dw_hdmi *hdmi,
 			     const struct drm_display_mode *mode)
 {
-	u8 inv_val;
+	u8 inv_val, bytes;
+	struct drm_hdmi_info *hdmi_info = &hdmi->connector.display_info.hdmi;
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
 	unsigned int vdisplay;
@@ -1513,7 +1554,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
 	/* Set up HDMI_FC_INVIDCONF */
-	inv_val = (hdmi->hdmi_data.hdcp_enable ?
+	inv_val = (hdmi->hdmi_data.hdcp_enable ||
+		   vmode->mpixelclock > HDMI14_MAX_TMDSCLK ||
+		   hdmi_info->scdc.scrambling.low_rates ?
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
 
@@ -1562,6 +1605,45 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 		vsync_len /= 2;
 	}
 
+	/* Scrambling Control */
+	if (hdmi_info->scdc.supported) {
+		if (vmode->mpixelclock > HDMI14_MAX_TMDSCLK ||
+		    hdmi_info->scdc.scrambling.low_rates) {
+			/*
+			 * HDMI2.0 Specifies the following procedure:
+			 * After the Source Device has determined that
+			 * SCDC_Present is set (=1), the Source Device should
+			 * write the accurate Version of the Source Device
+			 * to the Source Version field in the SCDCS.
+			 * Source Devices compliant shall set the
+			 * Source Version = 1.
+			 */
+			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
+				       &bytes);
+			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
+				min_t(u8, bytes, SCDC_MIN_SOURCE_VERSION));
+
+			/* Enabled Scrambling in the Sink */
+			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
+
+			/*
+			 * To activate the scrambler feature, you must ensure
+			 * that the quasi-static configuration bit
+			 * fc_invidconf.HDCP_keepout is set at configuration
+			 * time, before the required mc_swrstzreq.tmdsswrst_req
+			 * reset request is issued.
+			 */
+			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
+				    HDMI_MC_SWRSTZ);
+			hdmi_writeb(hdmi, 1, HDMI_FC_SCRAMBLER_CTRL);
+		} else {
+			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
+			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
+				    HDMI_MC_SWRSTZ);
+			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
+		}
+	}
+
 	/* Set up horizontal active pixel width */
 	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
 	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index 9d90eb9c46e5..3f3c616eba97 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -255,6 +255,7 @@
 #define HDMI_FC_MASK2                           0x10DA
 #define HDMI_FC_POL2                            0x10DB
 #define HDMI_FC_PRCONF                          0x10E0
+#define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
 
 #define HDMI_FC_GMD_STAT                        0x1100
 #define HDMI_FC_GMD_EN                          0x1101
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 9c56412bb2cf..7a02744ce0bc 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -157,6 +157,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
+void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi);
 
 /* PHY configuration */
 void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);
-- 
2.20.1

