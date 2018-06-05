Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeFENy0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:54:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37103 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFENyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:23 -0400
X-Google-Smtp-Source: ADUXVKLvOnz7TLb5ByN0PMmWw0iPl+8QM7J8fCknRhKd7MLpiHd9dnwzOQD/yBzBV1XWBKknEbvD1A==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 1/7] drm: print plane state normalized zpos value
Date: Tue,  5 Jun 2018 15:54:01 +0200
Message-Id: <20180605135407.20214-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping plane state print normalized zpos value as done for
the other plane state fields.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/drm_atomic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 07fef42869aa..cd1d677617c8 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -988,6 +988,7 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 	drm_printf(p, "\tcrtc-pos=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&dest));
 	drm_printf(p, "\tsrc-pos=" DRM_RECT_FP_FMT "\n", DRM_RECT_FP_ARG(&src));
 	drm_printf(p, "\trotation=%x\n", state->rotation);
+	drm_printf(p, "\tnormalized-zpos=%x\n", state->normalized_zpos);
 	drm_printf(p, "\tcolor-encoding=%s\n",
 		   drm_get_color_encoding_name(state->color_encoding));
 	drm_printf(p, "\tcolor-range=%s\n",
-- 
2.15.0
