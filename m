Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30779ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D648820870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ceDMcRZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D648820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPSSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:18:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:18:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id c4-v6so20104230wrs.12;
        Mon, 16 Jul 2018 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wlWGiLsBGo9jsAKxzp5f0stqxD7cyqTnKGJg4hSjbPE=;
        b=ceDMcRZ77jED7NJ6pF69f0vMMnDpdL3YwgkN05glTmTbH57vsbQXYZ3rVYaW2NWSBX
         CkUwye4UKNgGaBwuJG96LCy4aIbnXN/e2ylTMevqjn8l215sFGuh7qyy1lFgxfw/rqBu
         U2NDfOZZe+rezGbLzsM8zTWLPjZqTqnNYX8G+ULdlh3U2iUUA/PPjwdJwZb/ZUc0PNr7
         2wkALClKgRak/1m/7Yin3sp2uReD2VdL3ROE9x/HbkEsbd8M/YQlvTtPt3BSlnIlTNta
         Aqg/pD/ph0m/Q+Hcq4ZASsnC4Ofbq7Tew9YvO9s0zHbSUo87j23X6zL1c9IYAzomEcnN
         QnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wlWGiLsBGo9jsAKxzp5f0stqxD7cyqTnKGJg4hSjbPE=;
        b=b2+UQhjuTBWbJYZgn31z+lmKUnIV3b/1M5CFCLLMrdMFDH4nzeE+jIRCEUBhlEyxEQ
         inqq0GkHJPJpOPnEbZ0pCHN6c0/W3XAiACkykFXagECVyw6bnaoL6ffzqTyU9ZnD2KYY
         gjgZk12lH24azwXY9lAnWX9iv0k6CEetDHqoiHHHZFdvatyGDJBwNXj2X/4Kn6fzc8OW
         f8SdAKbIYf9uxRxDFDKmlnEBva2Z0d5HgVPYc0bw813hkX08sm42zP75jpJlhfCd8DVg
         ITDdv07HAV9/2EVGTkcRpTVJ9tCsoZ3jg8VX4DZXnAUtwgxOchmIu72X7G0IXVRgfrR0
         WvoQ==
X-Gm-Message-State: AOUpUlE1We8sHfxhcye5VGO5jlcWWmjPMURYSqJ2Aj3B7bMN8Xkj6wd2
        krXSJlLuNvs9fiWWv3PWQDQ=
X-Google-Smtp-Source: AAOMgpeSkkp3A0QbgxFUiSlUS6qZI3nR2gaYHhr+nQhBUm3wpYiYXzSJMrM5e2cguVMYJjW07ys4Wg==
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr13353159wre.115.1531763416101;
        Mon, 16 Jul 2018 10:50:16 -0700 (PDT)
Received: from homedesk.Speedport_W_724V_09011603_05_013 (p2003006B0F046B2330125DF093E70AB4.dip0.t-ipconnect.de. [2003:6b:f04:6b23:3012:5df0:93e7:ab4])
        by smtp.gmail.com with ESMTPSA id g4-v6sm26233064wrq.32.2018.07.16.10.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 10:50:15 -0700 (PDT)
From:   Carsten Behling <carsten.behling@googlemail.com>
X-Google-Original-From: Carsten Behling <carsten.behling@gmail.com>
Cc:     Carsten Behling <carsten.behling@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Steve Kowalik <steven@wedontsleep.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/display: negative x/y in cursor move
Date:   Mon, 16 Jul 2018 19:49:56 +0200
Message-Id: <20180716174957.5977-1-carsten.behling@gmail.com>
X-Mailer: git-send-email 2.14.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modesetting X11 driver may provide negative x/y cordinates in
mdp5_crtc_cursor_move call when rotation is enabled.

Cursor buffer can overlap down to its negative width/height.

ROI has to be recalculated for negative x/y indicating using the
lower/right corner of the cursor buffer and hotspot must be set
in MDP5_LM_CURSOR_XY_SRC_Y MDP5_LM_CURSOR_XY_SRC_X.

Signed-off-by: Carsten Behling <carsten.behling@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 51 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 10271359789e..43a86582876c 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -65,7 +65,7 @@ struct mdp5_crtc {
 		struct drm_gem_object *scanout_bo;
 		uint64_t iova;
 		uint32_t width, height;
-		uint32_t x, y;
+		int x, y;
 	} cursor;
 };
 #define to_mdp5_crtc(x) container_of(x, struct mdp5_crtc, base)
@@ -760,20 +760,31 @@ static void get_roi(struct drm_crtc *crtc, uint32_t *roi_w, uint32_t *roi_h)
 	 * Cursor Region Of Interest (ROI) is a plane read from cursor
 	 * buffer to render. The ROI region is determined by the visibility of
 	 * the cursor point. In the default Cursor image the cursor point will
-	 * be at the top left of the cursor image, unless it is specified
-	 * otherwise using hotspot feature.
+	 * be at the top left of the cursor image.
 	 *
+	 * Without rotation:
 	 * If the cursor point reaches the right (xres - x < cursor.width) or
 	 * bottom (yres - y < cursor.height) boundary of the screen, then ROI
 	 * width and ROI height need to be evaluated to crop the cursor image
 	 * accordingly.
 	 * (xres-x) will be new cursor width when x > (xres - cursor.width)
 	 * (yres-y) will be new cursor height when y > (yres - cursor.height)
+	 *
+	 * With rotation:
+	 * We get negative x and/or y coordinates.
+	 * (cursor.width - abs(x)) will be new cursor width when x < 0
+	 * (cursor.height - abs(y)) will be new cursor width when y < 0
 	 */
-	*roi_w = min(mdp5_crtc->cursor.width, xres -
+	if (mdp5_crtc->cursor.x >= 0)
+		*roi_w = min(mdp5_crtc->cursor.width, xres -
 			mdp5_crtc->cursor.x);
-	*roi_h = min(mdp5_crtc->cursor.height, yres -
+	else
+		*roi_w = mdp5_crtc->cursor.width - abs(mdp5_crtc->cursor.x);
+	if (mdp5_crtc->cursor.y >= 0)
+		*roi_h = min(mdp5_crtc->cursor.height, yres -
 			mdp5_crtc->cursor.y);
+	else
+		*roi_h = mdp5_crtc->cursor.height - abs(mdp5_crtc->cursor.y);
 }
 
 static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
@@ -783,7 +794,7 @@ static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
 	struct mdp5_kms *mdp5_kms = get_kms(crtc);
 	const enum mdp5_cursor_alpha cur_alpha = CURSOR_ALPHA_PER_PIXEL;
 	uint32_t blendcfg, stride;
-	uint32_t x, y, width, height;
+	uint32_t x, y, src_x, src_y, width, height;
 	uint32_t roi_w, roi_h;
 	int lm;
 
@@ -800,6 +811,26 @@ static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
 
 	get_roi(crtc, &roi_w, &roi_h);
 
+	/* If cusror buffer overlaps due to rotation on the
+	 * upper or left screen border the pixel offset inside
+	 * the cursor buffer of the ROI is the positive overlap
+	 * distance.
+	 */
+	if (mdp5_crtc->cursor.x < 0) {
+		src_x = abs(mdp5_crtc->cursor.x);
+		x = 0;
+	} else {
+		src_x = 0;
+	}
+	if (mdp5_crtc->cursor.y < 0) {
+		src_y = abs(mdp5_crtc->cursor.y);
+		y = 0;
+	} else {
+		src_y = 0;
+	}
+	DBG("%s: x=%d, y=%d roi_w=%d roi_h=%d src_x=%d src_y=%d",
+		x, y, roi_w, roi_h, src_x, src_y);
+
 	mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_STRIDE(lm), stride);
 	mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_FORMAT(lm),
 			MDP5_LM_CURSOR_FORMAT_FORMAT(CURSOR_FMT_ARGB8888));
@@ -812,6 +843,9 @@ static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
 	mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_START_XY(lm),
 			MDP5_LM_CURSOR_START_XY_Y_START(y) |
 			MDP5_LM_CURSOR_START_XY_X_START(x));
+	mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_XY(lm),
+			MDP5_LM_CURSOR_XY_SRC_Y(src_y) |
+			MDP5_LM_CURSOR_XY_SRC_X(src_x));
 	mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_BASE_ADDR(lm),
 			mdp5_crtc->cursor.iova);
 
@@ -932,8 +966,9 @@ static int mdp5_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
 	if (unlikely(!crtc->state->enable))
 		return 0;
 
-	mdp5_crtc->cursor.x = x = max(x, 0);
-	mdp5_crtc->cursor.y = y = max(y, 0);
+	/* accept negative x/y coordinates up to maximum cursor overlap */
+	mdp5_crtc->cursor.x = x = max(x, -(int)mdp5_crtc->cursor.width);
+	mdp5_crtc->cursor.y = y = max(y, -(int)mdp5_crtc->cursor.height);
 
 	get_roi(crtc, &roi_w, &roi_h);
 
-- 
2.14.1

