Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E32C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C593218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EWnUUTen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfBAMIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38820 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfBAMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:08:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so5976665wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=11s2QChWMxoAONOZIbjjpwNNRD7Oc4uhJh6j2T4FWQo=;
        b=EWnUUTenfoGOYERwFcGIXsp644ddQilEE3SgMGtpvYCymRbmzOObezvbbg+VBbls5u
         tMLzBRIgg6q91tVdQTh/MIrHC7nAp4KuFdk7DJWFeqN9koNgef3N9Dm5ld0ZYOHad5Uq
         ZlSq9bEfYPiLRl7p64xHyV5mzdeaCO1cntYJeSa1dD+1ZDdDgPOeT2DKqkaK+6z4gAV5
         LLCgDr6BXW8neF8LWHvY9vLeHxmNNnplAt0eGH3f9ROwaSZyRKeL0jN2VAT3MgJjq+RG
         7HqI+2ruudI5/eiOjwEpCVdFTe2Ac58Jy4wzzUgnlQTKSqEQjlWy9pNeZzs4NbXHinLg
         /dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=11s2QChWMxoAONOZIbjjpwNNRD7Oc4uhJh6j2T4FWQo=;
        b=CIW2djMnmqvFToRcrHFgCyA81ykIqHULN86/arjg5r7zQlk2RS9rpWJEmCWidCGPqn
         HBY8sK2RY+t8jAMpcYenSunUz6ZU2vb/vrpjTBisiSPtMxboxcCCdeh1AAJMcR7/WB5P
         bixn9WTGfLFFLQUps6Fp7bJlYtkpAmzM2YQ2/Hoik9m6xaqN8BDEFeCQVWiYuYpTQboZ
         a+XHkbFGqaWFgWqz1Z+xf8gxP4NUMLSlnOc4VewOnXoqQi1NGPZDL0LS+riE5aQ6nMUz
         ySHlmiyBX4LhH7SJSCiPFfQNv8u1HOat5gubY8kiOLX474iTxJ0D80y2LQyyjqGUUMyH
         MEaw==
X-Gm-Message-State: AHQUAuYI4hQTxxGFkYRT/G3NLzieyh42X+tOBf3da6cxHoJ367zfvmnq
        wJnbEn+2YCWnEbYL7yOMTRCX1w==
X-Google-Smtp-Source: AHgI3IYPr+Ng8Mft1ToKVAInWUY3yMqQYEUlQon+y3cVPcQ2jXX0jGEnNxMvRDZdPQlmWJp4Oyytsw==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr2227402wmd.36.1549022877239;
        Fri, 01 Feb 2019 04:07:57 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:07:56 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
Subject: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
Date:   Fri,  1 Feb 2019 12:07:46 +0000
Message-Id: <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
 include/drm/bridge/dw_hdmi.h              |  1 +
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7aae726..6d5a2e9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -27,6 +27,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
+#include <drm/drm_scdc_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/bridge/dw_hdmi.h>
 
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
 
@@ -1504,7 +1543,8 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
 static void hdmi_av_composer(struct dw_hdmi *hdmi,
 			     const struct drm_display_mode *mode)
 {
-	u8 inv_val;
+	u8 inv_val, bytes;
+	struct drm_hdmi_info *hdmi_info = &hdmi->connector.display_info.hdmi;
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
 	unsigned int vdisplay;
@@ -1514,7 +1554,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
 	/* Set up HDMI_FC_INVIDCONF */
-	inv_val = (hdmi->hdmi_data.hdcp_enable ?
+	inv_val = (hdmi->hdmi_data.hdcp_enable ||
+		   vmode->mpixelclock > HDMI14_MAX_TMDSCLK ||
+		   hdmi_info->scdc.scrambling.low_rates ?
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
 
@@ -1563,6 +1605,45 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
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
index 9d90eb9..3f3c616 100644
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
index 9f93895..66e7077 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -159,6 +159,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
+void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi);
 
 /* PHY configuration */
 void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);
-- 
2.7.4

