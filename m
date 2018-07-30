Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCACA16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814E320857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814E320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeG3S4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:56:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33181 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbeG3S4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:56:30 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 61861E000A;
        Mon, 30 Jul 2018 17:20:29 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR RENESAS),
        linux-renesas-soc@vger.kernel.org (open list:DRM DRIVERS FOR RENESAS),
        linux-kernel@vger.kernel.org (open list),
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/3] drm: rcar-du: Rename var to a more precise name
Date:   Mon, 30 Jul 2018 19:20:13 +0200
Message-Id: <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532971214-17962-1-git-send-email-jacopo@jmondi.org>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the 'value' variable, only used to for writing to DMSR register to a
more precise 'dmsr' name.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 6d55cec..4d7907c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -208,7 +208,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
 	struct rcar_du_device *rcdu = rcrtc->group->dev;
 	unsigned long mode_clock = mode->clock * 1000;
-	u32 value;
+	u32 dsmr;
 	u32 escr;
 
 	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
@@ -299,11 +299,11 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? OTAR2 : OTAR, 0);
 
 	/* Signal polarities */
-	value = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DSMR_VSL : 0)
-	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DSMR_HSL : 0)
-	      | ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? DSMR_ODEV : 0)
-	      | DSMR_DIPM_DISP | DSMR_CSPM;
-	rcar_du_crtc_write(rcrtc, DSMR, value);
+	dsmr = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DSMR_VSL : 0)
+	       | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DSMR_HSL : 0)
+	       | ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? DSMR_ODEV : 0)
+	       | DSMR_DIPM_DISP | DSMR_CSPM;
+	rcar_du_crtc_write(rcrtc, DSMR, dsmr);
 
 	/* Display timings */
 	rcar_du_crtc_write(rcrtc, HDSR, mode->htotal - mode->hsync_start - 19);
-- 
2.7.4

