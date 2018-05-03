Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeECIrF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:47:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62870 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeECIq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:46:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180503084656epoutp0257f2324615227c65156b8ef0bee2042a~rFh3kuLTR2525425254epoutp02J
X-AuditID: b6c32a4a-a61ff700000010d4-63-5aeacc7ffe5f
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 05/13] drm/kms/mode/gma500-mdfld_dsi_dpi: using helper
 function drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:16:38 +0530
Message-Id: <8998a71d799fe807fa199c0bf0d63ea5bff0985c.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmpm79mVdRBjOuyFr0njvJZHHl63s2
        i1fn3zBbXN41h83i8NQlbBYrF31ls1h7vpXFgd1j56y77B7bvz1g9bjffZzJo2/LKkaPz5vk
        AlijUm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
        UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqRRsaGukZGpjrGRkZ6ZmYxloZmQKVJKRmXJ+6
        mK2gU6TiwOuJLA2M5wS6GDk5JARMJHbOucvSxcjFISSwm1Gib98bKOcTo8S8fe2sIFVCAt8Y
        JS79SIfp+LJ9DhNE0V5Gia/3frNAFH1llGj+5A9iswEVPZ8zgxWkSERgOqPEq9OXmEEcZoFu
        RonevS1gjrDAREaJw8engrWzCKhKLFx3jAnE5hWIkZjwro8dYp+cxM1znUANHBycAlYSe74k
        gfRKCCxhk7j+/CojRI2LxImWG8wQtrDEq+NboHqlJD6/28sG0dDMKPFg3UJ2CKeHUaKj8xhU
        lb1Ey5QDLCAbmAU0Jdbv0gcxJQRsJfa8ALuNWYBPovf3EyaIMK9ER5sQRKOKxMoXh5lhVv1Z
        0MUKYXtI3Jo9GWq4o8SunovQYOxllHi7N28Co/wshF0LGBlXMUqmFhTnpqcWmxYY5aWW6xUn
        5haX5qXrJefnbmIEJzgtrx2My875HGIU4GBU4uE9cPZllBBrYllxZe4hRgkOZiUR3indr6KE
        eFMSK6tSi/Lji0pzUosPMZoCw3Uis5Rocj4w+eaVxBuaWBqYmJmZGxoYWJooifPePHkvSkgg
        PbEkNTs1tSC1CKaPiYNTqoFRnO12pZdW1d+62rBIF8FUVc9bH3nnyrSZPDzrd+Ut/wa9Xy2n
        jsjbi6evNfee4TDxZsPG6HvshY08825uFXuzekm0sEHmjq/Tfq6q7ip05lm5jVvQzGb3+aTi
        yCmqhVtX/dl2iGtz/KmdysdXbLjL7v97xRHn9Vc+Gjv0Ken9aIsqcbK23eCoxFKckWioxVxU
        nAgAtKi/kIYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSvG79mVdRBjcOMVr0njvJZHHl63s2
        i1fn3zBbXN41h83i8NQlbBYrF31ls1h7vpXFgd1j56y77B7bvz1g9bjffZzJo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDKuT13MVtApUnHg9USWBsZzAl2MnBwSAiYSX7bPYepi5OIQEtjN
        KDHrwkwWiISUxLI329ggbGGJlf+es0MUfWaUuPT5BlgRG1D38zkzWEESIgIzGSWaO/4xgjjM
        Ar2MEi/27wdrERboZ5S4fv8p2CwWAVWJheuOMYHYvAIxEhPe9bFD7JCTuHmuk7mLkYODU8BK
        Ys+XJJCwkIClRHvfYdYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh56W
        5g7Gy0viDzEKcDAq8fBmnH4ZJcSaWFZcmXuIUYKDWUmEd0r3qygh3pTEyqrUovz4otKc1OJD
        jNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGKcF5AfPN6oKd202eBIh251Z/rw6VU+4
        0aN54t3gmewK5zK3CWivuO3oZNnhybMxd+e/ywJ9xlHMXkUMJQZ7ZxWb9q28v2kX69V5spHO
        R+9auR1wkq7Jf87YwLBSMspfOVmm+u3+fRyz1v+J2dCrqJI/y7/4w0XWvgcqYVNLi37KbLrd
        FPpSiaU4I9FQi7moOBEAR5NXMjkCAAA=
X-CMS-MailID: 20180503084655epcas5p127066f560b7c2d75f679e682c914abd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503084655epcas5p127066f560b7c2d75f679e682c914abd6
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503084655epcas5p127066f560b7c2d75f679e682c914abd6
X-RootMTR: 20180503084655epcas5p127066f560b7c2d75f679e682c914abd6
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503084655epcas5p127066f560b7c2d75f679e682c914abd6@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
index a05c0206..0ac3e1f 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
@@ -24,7 +24,7 @@
  * jim liu <jim.liu@intel.com>
  * Jackie Li<yaodong.li@intel.com>
  */
-
+#include <video/videomode.h>
 #include "mdfld_dsi_dpi.h"
 #include "mdfld_output.h"
 #include "mdfld_dsi_pkg_sender.h"
@@ -429,36 +429,28 @@ int mdfld_dsi_dpi_timing_calculation(struct drm_display_mode *mode,
 				struct mdfld_dsi_dpi_timing *dpi_timing,
 				int num_lane, int bpp)
 {
-	int pclk_hsync, pclk_hfp, pclk_hbp, pclk_hactive;
-	int pclk_vsync, pclk_vfp, pclk_vbp;
-
-	pclk_hactive = mode->hdisplay;
-	pclk_hfp = mode->hsync_start - mode->hdisplay;
-	pclk_hsync = mode->hsync_end - mode->hsync_start;
-	pclk_hbp = mode->htotal - mode->hsync_end;
+	struct videomode vm;
 
-	pclk_vfp = mode->vsync_start - mode->vdisplay;
-	pclk_vsync = mode->vsync_end - mode->vsync_start;
-	pclk_vbp = mode->vtotal - mode->vsync_end;
+	drm_display_mode_to_videomode(mode, &vm);
 
 	/*
 	 * byte clock counts were calculated by following formula
 	 * bclock_count = pclk_count * bpp / num_lane / 8
 	 */
 	dpi_timing->hsync_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_hsync, num_lane, bpp);
+						vm.hsync_len, num_lane, bpp);
 	dpi_timing->hbp_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_hbp, num_lane, bpp);
+						vm.hback_porch, num_lane, bpp);
 	dpi_timing->hfp_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_hfp, num_lane, bpp);
+						vm.hfront_porch, num_lane, bpp);
 	dpi_timing->hactive_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_hactive, num_lane, bpp);
+						vm.hactive, num_lane, bpp);
 	dpi_timing->vsync_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_vsync, num_lane, bpp);
+						vm.vsync_len, num_lane, bpp);
 	dpi_timing->vbp_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_vbp, num_lane, bpp);
+						vm.vback_porch, num_lane, bpp);
 	dpi_timing->vfp_count = mdfld_dsi_dpi_to_byte_clock_count(
-						pclk_vfp, num_lane, bpp);
+						vm.vfront_porch, num_lane, bpp);
 
 	return 0;
 }
-- 
2.7.4
