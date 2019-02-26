Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4258C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB262063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmCRIwh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfBZTgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfBZTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so6669827pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHCWP+rKo+1bipESnROXwjb4cL5WEAepx8uQ8cIY+0E=;
        b=JmCRIwh+JgmbxP6kU/5wLPoU3642zolf+13Qj4p4hocBVokN2injt4C0wS8dDcf9zI
         KDnhoIIHOA5JD0997v7ZDddSjQPJm0mNlWHJyfb/awXPKr8Gvoc/opWs3R+M7mNFCSsB
         isWnhKsrYSnVnswoXsEEnBmLZP2hdEeK6h6HYScGdk0awMdAFSdUt2wYi76DJqEqzbRM
         rt01tcXvBn6CLOI+neDaQ6LQUGwNsGsIxZkdvd8FIxOw5L/KbxQDmaWbxh8n0F57PSAz
         Sh1t8D5FZtr1jhmgfMSyNHZFnK6g28LznwePkmFC+1wtn4fLcmtEMaWVifdVk8v8rwyW
         LvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHCWP+rKo+1bipESnROXwjb4cL5WEAepx8uQ8cIY+0E=;
        b=LX9sJYH6rT+RrxoXGVDkijZhs7TjOAmZW1ghUDosEsOQttlh5bHPYchSuhxi+CbfQ2
         EL2Xv1OyLbIt6hpulM0xoSDbertsaei2UiRcQCOzHNX3VM6sOSgUQ4e36kYizXHopQC+
         Q8MflnjRnJXNANLWcmdVljkzdkhAZJlm/7/GjIN6DuaIDL6260J4uwVQRKnUo7T1R4b0
         U/U49NCJVT5TEblnwjUGqtQFUFi4zEpnCHRpeYNRvVesoHD2ctYuKhFL9vT9X9UheGt0
         9peWQPr2FUyjFTsGKX7u1dX/A75F8LqhTU1Dx5QQ9W5UhsAyKu2KQ/xEKpGV/2fyWSDC
         SsBg==
X-Gm-Message-State: AHQUAubt1lLlWi9gRD8lcjw7ul9OA59jBhjqB95rwcw5iZE7+LskhGm9
        rBJT9yTPVgbEUwuYiTDHJCdCHHN/B5k=
X-Google-Smtp-Source: AHgI3Ia11o68LXeakQsz1TtH0H/RD8+5qUrHGKhV/wonBpm1qTmSRvwvotxf36RK+SpbEQIks/PG+w==
X-Received: by 2002:a65:62c2:: with SMTP id m2mr13668924pgv.348.1551209790530;
        Tue, 26 Feb 2019 11:36:30 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:29 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] drm/bridge: tc358767: Simplify tc_set_video_mode()
Date:   Tue, 26 Feb 2019 11:36:03 -0800
Message-Id: <20190226193609.9862-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify tc_set_video_mode() by replacing repreated calls to
tc_write()/regmap_write() with a single call regmap_multi_reg_write().
No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 125 ++++++++++++++++--------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 86ebd49194b7..c85468fcc157 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -641,10 +641,6 @@ static int tc_get_display_props(struct tc_data *tc)
 
 static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 {
-	int ret;
-	int vid_sync_dly;
-	int max_tu_symbol;
-
 	int left_margin = mode->htotal - mode->hsync_end;
 	int right_margin = mode->hsync_start - mode->hdisplay;
 	int hsync_len = mode->hsync_end - mode->hsync_start;
@@ -653,76 +649,85 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 	int vsync_len = mode->vsync_end - mode->vsync_start;
 
 	/*
-	 * Recommended maximum number of symbols transferred in a transfer unit:
+	 * Recommended maximum number of symbols transferred in a
+	 * transfer unit:
 	 * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
 	 *              (output active video bandwidth in bytes))
 	 * Must be less than tu_size.
 	 */
-	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
-
-	dev_dbg(tc->dev, "set mode %dx%d\n",
-		mode->hdisplay, mode->vdisplay);
-	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
-		left_margin, right_margin, hsync_len);
-	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
-		upper_margin, lower_margin, vsync_len);
-	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
-
+	int max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
 
+	/* DP Main Stream Attributes */
+	int vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
 	/*
 	 * LCD Ctl Frame Size
 	 * datasheet is not clear of vsdelay in case of DPI
 	 * assume we do not need any delay when DPI is a source of
 	 * sync signals
 	 */
-	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
-		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
-	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
-			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
-	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
-			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
-	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
-			 (vsync_len << 0));		/* Vsync */
-	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
-			 (mode->vdisplay << 0));	/* height */
-	tc_write(VFUEN0, VFUEN);		/* update settings */
-
+	u32 vpctrl0 = (0 << 20) /* VSDELAY */ |
+		      OPXLFMT_RGB888 | FRMSYNC_DISABLED |
+		      MSF_DISABLED;
+	u32 htim01 = (ALIGN(left_margin, 2) << 16) | /* H back porch */
+		     (ALIGN(hsync_len, 2) << 0); /* Hsync */
+	u32 htim02 = (ALIGN(right_margin, 2) << 16) | /* H front porch */
+		     (ALIGN(mode->hdisplay, 2) << 0); /* width */
+	u32 vtim01 = (upper_margin << 16) | /* V back porch */
+		     (vsync_len << 0); /* Vsync */
+	u32 vtim02 = (lower_margin << 16) | /* V front porch */
+		     (mode->vdisplay << 0); /* height */
 	/* Test pattern settings */
-	tc_write(TSTCTL,
-		 (120 << 24) |	/* Red Color component value */
-		 (20 << 16) |	/* Green Color component value */
-		 (99 << 8) |	/* Blue Color component value */
-		 (1 << 4) |	/* Enable I2C Filter */
-		 (2 << 0) |	/* Color bar Mode */
-		 0);
-
-	/* DP Main Stream Attributes */
-	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
-	tc_write(DP0_VIDSYNCDELAY,
-		 (max_tu_symbol << 16) |	/* thresh_dly */
-		 (vid_sync_dly << 0));
+	u32 tstctl = (120 << 24) |  /* Red Color component value */
+		     (20 << 16)  |  /* Green Color component value */
+		     (99 <<  8)  |  /* Blue Color component value */
+		     (1 <<  4)   |  /* Enable I2C Filter */
+		     (2 <<  0);     /* Color bar Mode */
+	u32 dp0_vidsyncdelay = (max_tu_symbol << 16) |	/* thresh_dly */
+			       (vid_sync_dly << 0);
+	u32 dp0_totalval = (mode->vtotal << 16) | (mode->htotal);
+	u32 dp0_startval = ((upper_margin + vsync_len) << 16) |
+			   ((left_margin + hsync_len) << 0);
+	u32 dp0_activeval = (mode->vdisplay << 16) | (mode->hdisplay);
+	u32 dp0_syncval = (vsync_len << 16) | (hsync_len << 0) |
+			  (mode->flags & DRM_MODE_FLAG_NHSYNC) ?
+			  SYNCVAL_HS_POL_ACTIVE_LOW : 0 |
+			  (mode->flags & DRM_MODE_FLAG_NVSYNC) ?
+			  SYNCVAL_VS_POL_ACTIVE_LOW : 0;
+	u32 dpipxlfmt = VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
+			DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
+			DPI_BPP_RGB888;
+	u32 dp0_misc = (max_tu_symbol << 23) |
+		       (TU_SIZE_RECOMMENDED << 16) |
+		       BPC_8;
+
+	const struct reg_sequence video_mode_settings[] = {
+		{ VPCTRL0, vpctrl0 },
+		{ HTIM01, htim01 },
+		{ HTIM02, htim02 },
+		{ VTIM01, vtim01 },
+		{ VTIM02, vtim02 },
+		{ VFUEN0, VFUEN },  /* update settings */
+		{ TSTCTL, tstctl },
+		{ DP0_VIDSYNCDELAY, dp0_vidsyncdelay },
+		{ DP0_TOTALVAL, dp0_totalval },
+		{ DP0_STARTVAL, dp0_startval },
+		{ DP0_ACTIVEVAL, dp0_activeval },
+		{ DP0_SYNCVAL, dp0_syncval },
+		{ DPIPXLFMT, dpipxlfmt },
+		{ DP0_MISC, dp0_misc },
+	};
 
-	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
-
-	tc_write(DP0_STARTVAL,
-		 ((upper_margin + vsync_len) << 16) |
-		 ((left_margin + hsync_len) << 0));
-
-	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
-
-	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
-		 ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
-		 ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
-
-	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
-		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
-
-	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
-			   BPC_8);
+	dev_dbg(tc->dev, "set mode %dx%d\n",
+		mode->hdisplay, mode->vdisplay);
+	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
+		left_margin, right_margin, hsync_len);
+	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
+		upper_margin, lower_margin, vsync_len);
+	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
 
-	return 0;
-err:
-	return ret;
+	return regmap_multi_reg_write(tc->regmap,
+				      video_mode_settings,
+				      ARRAY_SIZE(video_mode_settings));
 }
 
 static int tc_link_training(struct tc_data *tc, int pattern)
-- 
2.20.1

