Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394144AbeKWUM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:12:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49411 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408925AbeKWUK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B40EE20E3C; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5BBF220EB2;
        Fri, 23 Nov 2018 10:26:35 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 30/43] drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
Date:   Fri, 23 Nov 2018 10:25:02 +0100
Message-Id: <20181123092515.2511-31-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces specific definitions for vendor Allwinner and its
associated tiled format modifier. This modifier is used for the output
format of the VPU, that can be imported directly with the display
engine hardware supported by the sun4i-drm driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 include/uapi/drm/drm_fourcc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e7e48f1f4a74..841535172507 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -237,6 +237,8 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -643,6 +645,20 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
 
+/*
+ * Allwinner tiled modifier
+ *
+ * This tiling mode is implemented by the VPU found on all Allwinner platforms,
+ * codenamed sunxi. It is associated with a YUV format that uses either 2 or 3
+ * planes.
+ *
+ * With this tiling, the luminance samples are disposed in tiles representing
+ * 32x32 pixels and the chrominance samples in tiles representing 32x64 pixels.
+ * The pixel order in each tile is linear and the tiles are disposed linearly,
+ * both in row-major order.
+ */
+#define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.19.1

