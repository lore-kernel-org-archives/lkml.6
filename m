Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20855ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA512089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IY7cxvV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA512089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeGPXc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:32:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:32:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so33464821wra.13;
        Mon, 16 Jul 2018 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfC0slHfjJ/bG581+iAy+InJEd/e/sJMf57IPi8PysU=;
        b=IY7cxvV1EX9Z0q8Ij+XasGV4mEs7GCJOTU3Sb5IbDSS9tLcRfg3n+2qIkWIeTIsugW
         mPukaCYpenaIoQKay9xEZZUeaNwF73cludig/WbujXko0iNQZ6M90btaJ2pfp79v426A
         SJPHXD+eTF6g9SNJPh5vZ+hS7thWXRaVyhpsUgz4z76FhCjMo55VEwvsbS3g95chwJjs
         PlksGxlblTv9Dagyk80WUtfbMM0hMwGczSIs0kMdF3zB1dg3O4c0cvx6Fxy1jTwzd0Jq
         BQKNDktFrn2RCZfQMQOow69UXwDmPX/1Jb8h30rNZkJ2gKiIRLPUXAhYGax+8WggXKin
         wKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfC0slHfjJ/bG581+iAy+InJEd/e/sJMf57IPi8PysU=;
        b=lFiw0Ty/pNp+G07KvgBp/hn3sT7aXAcliJbKvsYGMDxgfgiaPGftLF8LGbwYK9MpBu
         Gig4LmnjTh8Py5Av73H1k83Bi3oSm6RBNvMoD00bJMRfCc4o8JFTKrEqqhAWf0g19rPw
         zkRiyH8ddmp8AO7WfvZLU7hIDe8PG+g1uNberJDltfcWYcMQemZxiQck59gS/szyZlf9
         Cc6Jp33g8nYtp2rzHw2b+PXf10vS6UDvWK0KIier6SJ9LKTagqTUoRc8TqNvqEPxBQXv
         yUKirL0TX4D2L1CQgO4oHfMYYGPsr9k8I8+dtLV3S/b/2FlZUvUWJJaPNXgu+HlFG2HR
         d8tw==
X-Gm-Message-State: AOUpUlE/ZVoS6OcbMe3Mxtvr9kDtFlGqASxLADgJzeNCuPGPHgMKGiIS
        jAJvypw5WeVOHGh5A+tAew7Jf8S4
X-Google-Smtp-Source: AAOMgpfmt8GGR4jmKgErUvo0O5ohWuYMbGuK5Y1lP8Gu0CexVJxEW+NgzIW/+omWi4eSWN1A6L4NzA==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr14390615wrg.211.1531782203104;
        Mon, 16 Jul 2018 16:03:23 -0700 (PDT)
Received: from homedesk.Speedport_W_724V_09011603_05_013 (p2003006B0F046B23B14570EF68C4BDBB.dip0.t-ipconnect.de. [2003:6b:f04:6b23:b145:70ef:68c4:bdbb])
        by smtp.gmail.com with ESMTPSA id u135-v6sm15324761wmf.2.2018.07.16.16.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 16:03:22 -0700 (PDT)
From:   Carsten Behling <carsten.behling@googlemail.com>
X-Google-Original-From: Carsten Behling <carsten.behling@gmail.com>
Cc:     Carsten Behling <carsten.behling@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Steve Kowalik <steven@wedontsleep.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm/display: negative x/y in cursor move
Date:   Tue, 17 Jul 2018 01:03:11 +0200
Message-Id: <20180716230314.3527-1-carsten.behling@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <201807170504.KBRX6Bew%fengguang.wu@intel.com>
References: <201807170504.KBRX6Bew%fengguang.wu@intel.com>
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
Changes in v2:
- fixed format specifier in debug message

 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 51 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 10271359789e..a7f4a6688fec 100644
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
+	DBG("%s: x=%u, y=%u roi_w=%u roi_h=%u src_x=%u src_y=%u",
+		crtc->name, x, y, roi_w, roi_h, src_x, src_y);
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

