Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C43C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348720657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N8rrlIwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfANPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:31:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfANPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:31:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so23329020wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUIvlmAEcY+BZX4hQKddl2mhdBesFefUIZcyGleRk5A=;
        b=N8rrlIwDdZa3XZ2aOcK0Pzlukp46q4rosZsiSPvmVjCUcN3qsMhkLETRpxWQBOzZm+
         U5vBxWcde47yqquw/J5SdAz3vwdp23ogWKjluA5pAXXj+8JsCs1y3PwaYaM0xQ0frfPd
         aIMvu8atMsVhocSz/KeDI5rPYNVYACPyP4U4QGigj5aoTpZKTk4Ok+5q0VEjszHOJbRK
         3Sx4LpQ+gXuQ5kfpj66amwvpO8Kkr7HwyUjZ1Zj8wtgP8BFtg4cJ0bdZve+zGPvY/u/6
         uHkVUn7odIAVeMh5egf75z0ggW9lIP/YeePMeBFVXiXCG3sCCgaJHzFrW6A4Ofbewqhn
         nfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUIvlmAEcY+BZX4hQKddl2mhdBesFefUIZcyGleRk5A=;
        b=N3f9XRIlrdFPUKYvDfLXDsU44k+wfou9qbvR/DQva7XUGgVWvTCMbA887ib3AB7HMe
         tDA64UJ2o0tmbW0rUKGU9SPhtC91x8P7na/vo8iTHBAOl+n+emAc/lp5m/XdzPEHKnhj
         2J/PhfcY+TOzasot6X5dJzgX5vD+AWW3Vc37vK5YarUwznL6MMD/041EIlGtB42IRKff
         r3innPv3+41S7i985WQDxQbAPvhgnpGHwBXlQJnKYtVb7c2224YrFlP+IFXttizpAZHL
         PwVXnYnKqvMMrFXXpU2iqlovYFfOFK1L42GjdHsKqWQyAyNK/ddcMzviTjDpTpFDZ18U
         bztw==
X-Gm-Message-State: AJcUukeBHrCbzaCbhC4FN0m48xz6UASucCBx/RsdrK295cbOuH+uVEs5
        uyD9B7YayZdl/PP0Ij3bQsxi+Q==
X-Google-Smtp-Source: ALg8bN6PEReudH+rmbahgzbAGTEDX8SWxzJrBkM3b/CGVjiA8uuFlvoM3xK3VTgQPGUUfEDoyywLlA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr25576717wrm.10.1547479881445;
        Mon, 14 Jan 2019 07:31:21 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z12sm63089470wrh.35.2019.01.14.07.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 07:31:20 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tony McKahan <tonymckahan@gmail.com>
Subject: [PATCH v2] drm/meson: Fix atomic mode switching regression
Date:   Mon, 14 Jan 2019 16:31:18 +0100
Message-Id: <20190114153118.8024-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2bcd3ecab773 when switching mode from X11 (ubuntu mate for
example) the display gets blurry, looking like an invalid framebuffer width.

This commit fixed atomic crtc modesetting in a totally wrong way and
introduced a local unnecessary ->enabled crtc state.

This commit reverts the crctc _begin() and _enable() changes and simply
adds drm_atomic_helper_commit_tail_rpm as helper.

Reported-by: Tony McKahan <tonymckahan@gmail.com>
Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Fixes: 2bcd3ecab773 ("drm/meson: Fixes for drm_crtc_vblank_on/off support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c | 23 ++---------------------
 drivers/gpu/drm/meson/meson_drv.c  |  6 ++++++
 2 files changed, 8 insertions(+), 21 deletions(-)

Changes since v1:
- drop the unecessary local ->enabled logic
- use drm_atomic_helper_commit_tail_rpm as atomic_commit_tail helper

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 75d97f1b2e8f..4f5c67f70c4d 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -46,7 +46,6 @@ struct meson_crtc {
 	struct drm_crtc base;
 	struct drm_pending_vblank_event *event;
 	struct meson_drm *priv;
-	bool enabled;
 };
 #define to_meson_crtc(x) container_of(x, struct meson_crtc, base)
 
@@ -82,7 +81,8 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
 
 };
 
-static void meson_crtc_enable(struct drm_crtc *crtc)
+static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
+				     struct drm_crtc_state *old_state)
 {
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	struct drm_crtc_state *crtc_state = crtc->state;
@@ -108,20 +108,6 @@ static void meson_crtc_enable(struct drm_crtc *crtc)
 
 	drm_crtc_vblank_on(crtc);
 
-	meson_crtc->enabled = true;
-}
-
-static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
-				     struct drm_crtc_state *old_state)
-{
-	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
-	struct meson_drm *priv = meson_crtc->priv;
-
-	DRM_DEBUG_DRIVER("\n");
-
-	if (!meson_crtc->enabled)
-		meson_crtc_enable(crtc);
-
 	priv->viu.osd1_enabled = true;
 }
 
@@ -153,8 +139,6 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
 
 		crtc->state->event = NULL;
 	}
-
-	meson_crtc->enabled = false;
 }
 
 static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -163,9 +147,6 @@ static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	unsigned long flags;
 
-	if (crtc->state->enable && !meson_crtc->enabled)
-		meson_crtc_enable(crtc);
-
 	if (crtc->state->event) {
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 3ee4d4a4ecba..a74d861ddceb 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -75,6 +75,11 @@ static const struct drm_mode_config_funcs meson_mode_config_funcs = {
 	.fb_create           = drm_gem_fb_create,
 };
 
+
+static const struct drm_mode_config_helper_funcs meson_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static irqreturn_t meson_irq(int irq, void *arg)
 {
 	struct drm_device *dev = arg;
@@ -266,6 +271,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
 	drm->mode_config.funcs = &meson_mode_config_funcs;
+	drm->mode_config.helper_private	= &meson_mode_config_helpers;
 
 	/* Hardware Initialization */
 
-- 
2.20.1

