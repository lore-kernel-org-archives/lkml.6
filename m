Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3622504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KTV4uo5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E3622504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeKMEfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:35:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:35:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id u5-v6so5238615wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=iuAX5TYkA3a3jJaJm+03pdZzSpJ7OiC/CynShEo+Iy4=;
        b=KTV4uo5X+KCYBd7YptF9gsa7JNL2YfLnmQcAP7xvFTxUqVrkqUdvc48uGn9ZGOeitp
         D7gN7PURRLA7QN4NU5UQcL5pZDF43JDUZ0biRGlsE1RNA43Z5/ckQuw1aBtnHopGHIhD
         71mfa/IpcTpUAl3IBbJdQAMjH4aeiEKTkhzxwNlWfKJZG2CgwZ5GOlK9VSSfSlSA0vzY
         osWR6RUB+wKfs2x5tctSCcBV5AlwMqKifZTpK8szli7CX7CIdayHgE5bRnB062dNpFzF
         em6cX3W8qZggiQsnkzLWqWnMcmwk2UBlJnW5RugH5M8ZIS80tmlAzsSSJW3g4efw+Dbw
         wsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iuAX5TYkA3a3jJaJm+03pdZzSpJ7OiC/CynShEo+Iy4=;
        b=hmWS1ve798jztQxqSAVMyAHItCIvu7AewuJC0mS/q1tiK+KDfZ6JVi4xmluyqWOQrw
         wvQXAs39GZQdX8SBPoncmUWg5qU1JslCdM/jUqQWzIka5nQUUp1s9kg0JmBNLACgXQKE
         k7nxMdgKQZ5mb0DsFb4ymeR8JlVc5A0z3qmJJ2Rw3zvzSI3IHxSKioigO3zYdlDTl36f
         I/WR1pY5yFP4lLuvLMoK2HkmS+vpL9/Nl/4ruYA9w7shd9tNVCZWTC+SUA/IpPJd5cry
         hFwbw8ieJS41sJr8qw4eklf5xCDGtOgua1F/gLbakM4gXzolXqK8AU/HdjlrZUYui1OM
         NE3A==
X-Gm-Message-State: AGRZ1gLcLuutHGdczvoEdC59k43CwxdcnnV8VToEZ5xqzMLyDEDZ1oE+
        7H1wXOz2qLzvK0lCD2dAAJomng==
X-Google-Smtp-Source: AJdET5dpmxVrYLXxDsd/bDPpuhPisHwFp8cCm4mnSBlTTfZf0jLHWgDdMxsIUxeTWFtwhmx9C9r5OA==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr1927777wre.55.1542048074434;
        Mon, 12 Nov 2018 10:41:14 -0800 (PST)
Received: from localhost.localdomain (12.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.12])
        by smtp.gmail.com with ESMTPSA id h198-v6sm9750315wmd.31.2018.11.12.10.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 10:41:13 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jramirez@baylibre.com>
To:     jramirez@baylibre.com, narmstrong@baylibre.com, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: venc: dmt mode must use encp
Date:   Mon, 12 Nov 2018 19:41:09 +0100
Message-Id: <1542048069-22603-1-git-send-email-jramirez@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>

The video mode for DMT is only populated to support encp.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 514245e..acbbad3 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -854,6 +854,13 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	unsigned int sof_lines;
 	unsigned int vsync_lines;
 
+	/* Use VENCI for 480i and 576i and double HDMI pixels */
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
+		hdmi_repeat = true;
+		use_enci = true;
+		venc_hdmi_latency = 1;
+	}
+
 	if (meson_venc_hdmi_supported_vic(vic)) {
 		vmode = meson_venc_hdmi_get_vic_vmode(vic);
 		if (!vmode) {
@@ -865,13 +872,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	} else {
 		meson_venc_hdmi_get_dmt_vmode(mode, &vmode_dmt);
 		vmode = &vmode_dmt;
-	}
-
-	/* Use VENCI for 480i and 576i and double HDMI pixels */
-	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
-		hdmi_repeat = true;
-		use_enci = true;
-		venc_hdmi_latency = 1;
+		use_enci = false;
 	}
 
 	/* Repeat VENC pixels for 480/576i/p, 720p50/60 and 1080p50/60 */
-- 
2.7.4

