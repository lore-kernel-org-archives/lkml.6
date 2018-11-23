Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0DE20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0DE20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408955AbeKWUK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49412 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502722AbeKWUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5D23820DF0; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7659720DF9;
        Fri, 23 Nov 2018 10:26:33 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 23/43] drm/sun4i: backend: Detail the YUV to RGB values coding explanation
Date:   Fri, 23 Nov 2018 10:24:55 +0100
Message-Id: <20181123092515.2511-24-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <contact@paulk.fr>

The values in the BT601 YUV to RGB colorspace translation are not
simply coded as multiples, but rather as fixed-point signed fractional
values on a given number of bits. Add an explanation about that.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index a39d8b75d76a..986bdb64521c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -48,8 +48,12 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
 /*
  * These coefficients are taken from the A33 BSP from Allwinner.
  *
- * The formula is for each component, each coefficient being multiplied by
- * 1024 and each constant being multiplied by 16:
+ * The first three values of each row are coded as 13-bit signed fixed-point
+ * numbers, with 10 bits for the fractional part. The fourth value is a
+ * constant coded as a 14-bit signed fixed-point number with 4 bits for the
+ * fractional part.
+ *
+ * The values in table order give the following colorspace translation:
  * G = 1.164 * Y - 0.391 * U - 0.813 * V + 135
  * R = 1.164 * Y + 1.596 * V - 222
  * B = 1.164 * Y + 2.018 * U + 276
-- 
2.19.1

