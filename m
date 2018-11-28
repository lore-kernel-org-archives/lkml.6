Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A92081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e7n3oRUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781A92081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeK1VIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:08:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeK1VIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:08:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so1918931wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQVMuqWbkOH065zM1K32Q1gjaQprT4aEQt0Rzogauk4=;
        b=e7n3oRUB1ZyD44xI8MMESz8QwfVdrQ26WbOo38xr+JCBgBUHsX3RNe48bKJ42WuMHk
         QWCPMPskffkm2KIbExgbYOCd7MG2tllnqk5F+lJlFyE36t/DZTu82BKkEtxNhNqwxpiO
         BOc2sIk1ztDdT+m2Z2LFOOhqj8MSfqpUjsGr8l8+WLuZZXVHmytWTzUIri0uv5YSQpCs
         +4N/P2Qj4iQ79yPRlZjl4epbZZPAjcZBfPa/nO3x5uNl62Jd8eJIrcLXAtGi34GXylqE
         2QASYg34bx1ocyZFiWJSsUGss6mioPafbD9v4rtO1QKOqQqAr1ZQdyNJTQfdle6ktLYc
         XtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQVMuqWbkOH065zM1K32Q1gjaQprT4aEQt0Rzogauk4=;
        b=ef8KdOq42Iuu7V8Hyvq0uDZEgBW4J1a4sy0sRH3TR6+30/UL9rhDW1D+kWUgvI7ios
         V+vcWx6gtjLuFUT01JxyR2LY5oyQNnk8ajIOOjevo9FjD36zyX2G9b5X7K2yVofk40pp
         5dC2xdJgS2VcrphH8/dWqiWxsict8rshqciO36UulQd2J4NJAhWhZWM1P4iRTm+bJNV7
         hT6HKfgzmKjrJeeCTfHxckkVF7tW3ZNnS0H09fXa9zxA8d6a7rCz7pKa8SHvnKpbFJhR
         wZOMNM/MrEtjUr5c7sA53fQpVcrY6YxDEvkCT9Otg3lvFjFETTRISJG0a0jPIzYjnSBz
         cmkg==
X-Gm-Message-State: AA+aEWadE0uQ2bSgv62LvLmHLmze/GBXPm55ylF/mCmwiiv+i9smm4Pb
        3PbpQ3hFIlInhq/KduNdQASC/w==
X-Google-Smtp-Source: AFSGD/Vjhqiggcz3PrCJoGl45HoP1SV7K/tR+VX1RXHpxeYihi9TSG8DKatXtr5GZjsB95EOAO27AA==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr2063914wmg.122.1543399659575;
        Wed, 28 Nov 2018 02:07:39 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h16sm5509730wrs.60.2018.11.28.02.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 02:07:38 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/meson: Fix an Alpha Primary Plane bug on Meson GXL/GXM SoCs
Date:   Wed, 28 Nov 2018 11:07:34 +0100
Message-Id: <20181128100734.6536-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic GXL & GXM SoCs, a bug occurs on the primary plane when
alpha is used where the alpha is not aligned with the pixel content.

The woraround Amlogic implemented is to reset the OSD1 plane hardware
block each time the plane is (re)enabled, solving the issue.

In the reset, we still need to save the content of 2 registers which
depends on the status of the plane, in addition to reload the scaler
conversion matrix at the same time.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1 at [1]:
- Fix flickering and shaking by moving reset when plane is disabled

[1] https://patchwork.freedesktop.org/patch/263550/

 drivers/gpu/drm/meson/meson_plane.c | 12 ++++++++++++
 drivers/gpu/drm/meson/meson_viu.c   | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_viu.h   |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 12a47b4f65a5..8e27f275ece8 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -79,6 +79,7 @@
 struct meson_plane {
 	struct drm_plane base;
 	struct meson_drm *priv;
+	bool enabled;
 };
 #define to_meson_plane(x) container_of(x, struct meson_plane, base)
 
@@ -303,6 +304,15 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 	priv->viu.osd1_stride = fb->pitches[0];
 	priv->viu.osd1_height = fb->height;
 
+	if (!meson_plane->enabled) {
+		/* Reset OSD1 before enabling it on GXL+ SoCs */
+		if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
+		    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+			meson_viu_osd1_reset(priv);
+
+		meson_plane->enabled = true;
+	}
+
 	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
 }
 
@@ -316,6 +326,8 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
 	writel_bits_relaxed(VPP_OSD1_POSTBLEND, 0,
 			    priv->io_base + _REG(VPP_MISC));
 
+	meson_plane->enabled = false;
+
 }
 
 static const struct drm_plane_helper_funcs meson_plane_helper_funcs = {
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 2dffb987ec65..0ba87ff95530 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -296,6 +296,33 @@ static void meson_viu_load_matrix(struct meson_drm *priv)
 				 true);
 }
 
+/* VIU OSD1 Reset as workaround for GXL+ Alpha OSD Bug */
+void meson_viu_osd1_reset(struct meson_drm *priv)
+{
+	uint32_t osd1_fifo_ctrl_stat, osd1_ctrl_stat2;
+
+	/* Save these 2 registers state */
+	osd1_fifo_ctrl_stat = readl_relaxed(
+				priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
+	osd1_ctrl_stat2 = readl_relaxed(
+				priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+
+	/* Reset OSD1 */
+	writel_bits_relaxed(BIT(0), BIT(0),
+			    priv->io_base + _REG(VIU_SW_RESET));
+	writel_bits_relaxed(BIT(0), 0,
+			    priv->io_base + _REG(VIU_SW_RESET));
+
+	/* Rewrite these registers state lost in the reset */
+	writel_relaxed(osd1_fifo_ctrl_stat,
+		       priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
+	writel_relaxed(osd1_ctrl_stat2,
+		       priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+
+	/* Reload the conversion matrix */
+	meson_viu_load_matrix(priv);
+}
+
 void meson_viu_init(struct meson_drm *priv)
 {
 	uint32_t reg;
diff --git a/drivers/gpu/drm/meson/meson_viu.h b/drivers/gpu/drm/meson/meson_viu.h
index 073b1910bd1b..0f84bddd2ff0 100644
--- a/drivers/gpu/drm/meson/meson_viu.h
+++ b/drivers/gpu/drm/meson/meson_viu.h
@@ -59,6 +59,7 @@
 #define OSD_REPLACE_EN		BIT(14)
 #define OSD_REPLACE_SHIFT	6
 
+void meson_viu_osd1_reset(struct meson_drm *priv);
 void meson_viu_init(struct meson_drm *priv);
 
 #endif /* __MESON_VIU_H */
-- 
2.19.2

