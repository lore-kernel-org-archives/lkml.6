Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001F206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0001F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeLDOY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:24:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbeLDOXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 97B5E20E86; Tue,  4 Dec 2018 15:23:17 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4899520D23;
        Tue,  4 Dec 2018 15:22:41 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 10/21] drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
Date:   Tue,  4 Dec 2018 15:22:07 +0100
Message-Id: <20181204142218.16284-11-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
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
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/uapi/drm/drm_fourcc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 0b44260a5ee9..ea108e88ae03 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -238,6 +238,8 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -644,6 +646,20 @@ extern "C" {
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
2.19.2

