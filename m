Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A77ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145F2150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5145F2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeIRW43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:56:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:1404 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbeIRW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:56:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 10:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="71005752"
Received: from dkiernan-mobl3.ger.corp.intel.com (HELO eengestr-dev.ger.corp.intel.com) ([10.252.16.103])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2018 10:22:33 -0700
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/fourcc: rename Intel modifiers to follow the naming convention
Date:   Tue, 18 Sep 2018 18:21:59 +0100
Message-Id: <20180918172217.18754-1-eric.engestrom@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Organization: Intel Corp UK
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the other vendors use the format
DRM_FORMAT_MOD_{SAMSUNG,QCOM,VIVANTE,NVIDIA,BROADCOM,ARM}_* for their
modifiers, except Intel.

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Eric Engestrom <eric.engestrom@intel.com>
---
 include/uapi/drm/drm_fourcc.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 139632b871816f9e3dad..170a562223387687592a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -271,7 +271,8 @@ extern "C" {
  * sharing. It exists since on a given platform it does uniquely identify the
  * layout in a simple way for i915-specific userspace.
  */
-#define I915_FORMAT_MOD_X_TILED	fourcc_mod_code(INTEL, 1)
+#define DRM_FORMAT_MOD_INTEL_X_TILED	fourcc_mod_code(INTEL, 1)
+#define I915_FORMAT_MOD_X_TILED	DRM_FORMAT_MOD_INTEL_X_TILED
 
 /*
  * Intel Y-tiling layout
@@ -286,7 +287,8 @@ extern "C" {
  * sharing. It exists since on a given platform it does uniquely identify the
  * layout in a simple way for i915-specific userspace.
  */
-#define I915_FORMAT_MOD_Y_TILED	fourcc_mod_code(INTEL, 2)
+#define DRM_FORMAT_MOD_INTEL_Y_TILED	fourcc_mod_code(INTEL, 2)
+#define I915_FORMAT_MOD_Y_TILED	DRM_FORMAT_MOD_INTEL_Y_TILED
 
 /*
  * Intel Yf-tiling layout
@@ -301,7 +303,8 @@ extern "C" {
  * 64 byte blocks of pixels contain four pixel rows of 16 bytes, where the width
  * in pixel depends on the pixel depth.
  */
-#define I915_FORMAT_MOD_Yf_TILED fourcc_mod_code(INTEL, 3)
+#define DRM_FORMAT_MOD_INTEL_Yf_TILED fourcc_mod_code(INTEL, 3)
+#define I915_FORMAT_MOD_Yf_TILED DRM_FORMAT_MOD_INTEL_Yf_TILED
 
 /*
  * Intel color control surface (CCS) for render compression
@@ -320,8 +323,10 @@ extern "C" {
  * But that fact is not relevant unless the memory is accessed
  * directly.
  */
-#define I915_FORMAT_MOD_Y_TILED_CCS	fourcc_mod_code(INTEL, 4)
-#define I915_FORMAT_MOD_Yf_TILED_CCS	fourcc_mod_code(INTEL, 5)
+#define DRM_FORMAT_MOD_INTEL_Y_TILED_CCS	fourcc_mod_code(INTEL, 4)
+#define I915_FORMAT_MOD_Y_TILED_CCS	DRM_FORMAT_MOD_INTEL_Y_TILED_CCS
+#define DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS	fourcc_mod_code(INTEL, 5)
+#define I915_FORMAT_MOD_Yf_TILED_CCS	DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS
 
 /*
  * Tiled, NV12MT, grouped in 64 (pixels) x 32 (lines) -sized macroblocks
-- 
Cheers,
  Eric

