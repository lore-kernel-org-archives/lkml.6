Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7824EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0292075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YGb1FjjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfAINgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:36:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43231 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfAINgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:36:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so7301508eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnLgVrJVpbIyePwV3TfK2FR4As9YTA7Q8/JEe8171WQ=;
        b=YGb1FjjIxdsQJiHQLY5+Najak26OJm8/l0CGSofVvUEOpFgiUn7GK9yb0vUejON7uX
         Mnq5UrVvPmczHxtzIy1OBym9P4j8G9HeR7F+6bG2vHYY4iiqdhzPYgAdiRlupNPP7uQY
         KpGvFtJ7IRnchYC5b6CyfbEMn6gR/i3qoFsc/okhcZBb20Gozn2TnEBslfQFKB69e8FR
         ScsP3TccmT92L5CoEhqRzwhTUWJmT/at1H/nyYJsOC4UFYo8t9sTqgpUq/30dWm91htb
         vyKWmWbHTD6q1lAF3ARdMEXZMfhZ9NKCWBtntJY7UKrCZUve03anHQOFkg4nK+2N5b/7
         UYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnLgVrJVpbIyePwV3TfK2FR4As9YTA7Q8/JEe8171WQ=;
        b=ePOP2xgwwTxRAdaR3gVyYx6Ot/2RjACzDKoR9uZsJyJOgtE3v22OWfqMDQpJP81LMf
         SzPYhh2XOtl+vlEq25o46D0grBUMmIm8udzZyecPgaQmPfZRp0mZWFPTafMiY4mBhzyL
         szCeJDW+YuhRgameUVTe/Jo+fRM+9HX3xY4PVaaHNGCVSsDtyAs3i0uKVuvOGg6YSAn2
         XCPRzyhfUGkEc7uHUVMiRv9o6M6GCpJ3R1Pead1d9alSFS/3ck+aadGZ2eh/4PeKoSNF
         QotuhXP58GXOyS+wuTaMb1IijZzYpxZpPO8adA4qbp9kfcAjdeUfnHniasOjdjk6JDlu
         mUAQ==
X-Gm-Message-State: AJcUukdqu0hIk0pM75SvFszIlk0vKW+yCTQPBVbOALclJ02nNQxyim9x
        VV6vNaT7+7jj0P3Baj4601opOOPqUz0=
X-Google-Smtp-Source: ALg8bN4HYlDh4yDZ4sQMTutowgKGpGI1HJ4YYFkzY7WW/4Utj1ZzHPxVqlbE7kF+37CiCt+QxANg8A==
X-Received: by 2002:a50:90c6:: with SMTP id d6mr6213815eda.15.1547041007775;
        Wed, 09 Jan 2019 05:36:47 -0800 (PST)
Received: from localhost.localdomain (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id c53sm1623999ede.26.2019.01.09.05.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 05:36:46 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Fix atomic mode switching regression
Date:   Wed,  9 Jan 2019 14:36:43 +0100
Message-Id: <20190109133644.27459-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2bcd3ecab773 when switching mode from X11 (ubuntu mate for
example) the display gets blurry, looking like an invalid framebuffer width.

This commit fixed atomic crtc modesetting but didn't update the display
parameters when changing mode, but only when starting a mode setting after
a crtc disable.

This commit setups the crctc parameter in _begin() and _enable() to
take in account the current ctrc parameters.

Reported-by: Tony McKahan <tonymckahan@gmail.com>
Fixes: 2bcd3ecab773 ("drm/meson: Fixes for drm_crtc_vblank_on/off support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 75d97f1b2e8f..5bb432021caf 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -82,14 +82,12 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
 
 };
 
-static void meson_crtc_enable(struct drm_crtc *crtc)
+static void meson_crtc_setup(struct drm_crtc *crtc)
 {
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	struct drm_crtc_state *crtc_state = crtc->state;
 	struct meson_drm *priv = meson_crtc->priv;
 
-	DRM_DEBUG_DRIVER("\n");
-
 	if (!crtc_state) {
 		DRM_ERROR("Invalid crtc_state\n");
 		return;
@@ -98,6 +96,16 @@ static void meson_crtc_enable(struct drm_crtc *crtc)
 	/* Enable VPP Postblend */
 	writel(crtc_state->mode.hdisplay,
 	       priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
+}
+
+static void meson_crtc_enable(struct drm_crtc *crtc)
+{
+	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
+	struct meson_drm *priv = meson_crtc->priv;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	meson_crtc_setup(crtc);
 
 	/* VD1 Preblend vertical start/end */
 	writel(FIELD_PREP(GENMASK(11, 0), 2303),
@@ -121,6 +129,8 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	if (!meson_crtc->enabled)
 		meson_crtc_enable(crtc);
+	else
+		meson_crtc_setup(crtc);
 
 	priv->viu.osd1_enabled = true;
 }
-- 
2.19.2

