Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDBC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763C22146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RlRJIZkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763C22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLAAwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:52:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeLAAwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:52:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so5337198wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pw9KpLOFwvXEx8nU61djtZpAOLbaAkCOuBAXZZE13tg=;
        b=RlRJIZkXO9otrNeJ991GYRQJAui59XknLZ7uLUp2nhPDx8WsVlnNyynrfqU5wKtfW3
         GLWxJCGPy5CbB51GFMCYe4/6AVoVdmD8q0U3Qr6gaG6MK1WRcJyAlopp6Ib9C9GdXH9a
         2fe6Jfh9r2DX2QvXpnxnCdhzPyOvE/J426rF6cxMri5BFP9uYBvYFa6XEQiSZFvW+gBR
         6fJF6x7OfTLzqfuOCD3QkeHG3PV19XyRNbVmn+BfZaL0bu5rNFEe2f0e9zSgOJlhamDY
         SGZ9z2YxttvxDdUhb5jGU33pbTSbBwl0hl6aIfC6AWu6pGC9fTRqGcQIT/BVMQXi3BZb
         rGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pw9KpLOFwvXEx8nU61djtZpAOLbaAkCOuBAXZZE13tg=;
        b=aPrrErkNp3sQ2mNJWIIbWe3WmFEsLVImBiy2OyChq51itN4FiJFKEast9/e2apSCl/
         4g6crf+fMFMX5hXKhcoCBPs0FCU6M3uiMy50u5D3V24CWacKquIvG9D+hAVqSp/AQ0+v
         MLsOy4Lb3YYMbJguulum/Q7QZuTq3O9WN+vSkuCzdPcpjltEr1H5N5MmpVCuu6HTXKGm
         iLJqeNgB+CT35pZBUf3dI/HPlnIUm+JZLMhROKxwKyCqo51MdCXrJGNkpebDHo5eEBnU
         bmcKR9IUIDBsl8UkviriCCVE66epSTgKss1USEKmUKu9e52fY4C9Lxeihny9ebZgyO74
         NBfw==
X-Gm-Message-State: AA+aEWYJwPB6IR+swqmnkAI1bqDhEcTqHp0+fFUNJVh2iydz9Q3AEdY8
        DtHinSVNv8U4emKpMpY3fzdyiQ==
X-Google-Smtp-Source: AFSGD/XlxMpllYPmBoDNicDFWnIzhCyyRZFkXymHYDx7sFTOicEjbXdTpVRTGABmv5HAK7Gb2ogLFw==
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr4689146wrn.73.1543585390173;
        Fri, 30 Nov 2018 05:43:10 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm6864898wml.35.2018.11.30.05.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:43:09 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RFC v2 5/8] drm/bridge: dw-hdmi: support dynamically get input/out color info
Date:   Fri, 30 Nov 2018 14:42:58 +0100
Message-Id: <20181130134301.17963-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130134301.17963-1-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com>
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
2.19.2

