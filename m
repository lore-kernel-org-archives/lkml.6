Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeCPWEj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:04:39 -0400
Received: from anholt.net ([50.246.234.109]:48990 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPWEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:04:38 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Stone <daniels@collabora.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: [PATCH 2/3] drm/vc4: Add missing formats to vc4_format_mod_supported().
Date: Fri, 16 Mar 2018 15:04:34 -0700
Message-Id: <20180316220435.31416-2-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316220435.31416-1-eric@anholt.net>
References: <20180316220435.31416-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel's format_mod_supported() patch predated Dave's for NV21/61, and
I didn't catch that when rebasing.  This is a problem since the
formats are now getting validated before being passed to the driver's
atomic hooks.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.org>
Fixes: 423ad7b3cbd1 ("drm/vc4: Advertise supported modifiers for planes")
---
 drivers/gpu/drm/vc4/vc4_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index ce39390be389..ba00c14f989a 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -884,7 +884,9 @@ static bool vc4_format_mod_supported(struct drm_plane *plane,
 	case DRM_FORMAT_YUV420:
 	case DRM_FORMAT_YVU420:
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
 	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
 	default:
 		return (modifier == DRM_FORMAT_MOD_LINEAR);
 	}
-- 
2.16.2
