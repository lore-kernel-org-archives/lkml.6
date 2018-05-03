Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeECIhk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:37:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23750 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeECIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:37:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180503083729epoutp045160ebba84ab9014efbd678c5039f4ba~rFZn42xLp1351213512epoutp04F
X-AuditID: b6c32a49-583ff700000010df-16-5aeaca49d59a
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 02/13] drm/kms/mode/bridge-tc358767: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:07:17 +0530
Message-Id: <58baec838d69fd445c2189be68f71e74024e730f.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH++3u3k1pcZtWvyRMbkYYuHbHpnfhepDmRhJGSLAe6+Z+bNJe
        7k6tMLC0nNNFC4NcQgZWlI+yp1aWKClGLehpFmUZtSwtNMWsqG1X6b/POef75Xs4HDEmLSXi
        xHk2F3LaWAtFRAuvdyUtS9bdH9LLh4MU098cwBlvoFfAHHQP48zT8W8EM/ToK8ZU+OpFzJOb
        tQTTdbyeYJoeHRKuidI+OeIVaE+6a3DtjYkBXPu2skegPXL1AtCOXY7PJvQozYxYI3ImIFuu
        3ZhnM2moDZsN6wyqFDmdTKuZVCrBxlqRhkrPyk5en2cJbUUlFLKWglArm+U4asWqNKe9wIUS
        zHbOpaG20rRCRstTZQqFQqZUbV+pUIUkO5H5VfUg4bhD7QnUDopKwJVFHiAWQ1IJJweEHhAt
        lpK3AGybOoDxxSiAH9uuCfhiAsDev6PAA6IijjMXX+P8oB3Ag98np/3jAP7omIqoiJDqU+0J
        PMyx5BcAb78whkUYWQmgt70sEhJDugFs9PdFHEJyKaw64yPCLCG3waC3QcDnxcOXgQosvG0U
        uRLe/rGLb7cS8FfNdp7TYfDYc4LnGDjUc1XEcxwcG2knwlmQLAVwoPm0iC+qAHRXdE+rVsOy
        6g5hOAAjk+DFmyv4tgYO/5mMSDByDvT++iDgLyaB7sNSXpIIzwe7sJms33UenGct/Fv/bJrX
        wv6WMhF/IS+ANR/7wVGw2P8/rQ6AC2AhcnBWE+JUDtqGimQca+UKbCZZrt16GUQecLmuFfgD
        WZ2AFANqtqTj4We9FGcLub3WTgDFGBUrqa4c0kslRnbvPuS0G5wFFsR1AlXosD4sbl6uPfTO
        NpeBVqrlypSUVFouVyupBZKXvW/0UtLEutBuhBzIOeMTiKPiSgAuyljv0L1tyU4PdnaUB1P3
        5GxiY9sezB1h/Imtv8u7z14y+dJOjSjxfN+9T/13l3Q1Pq4X3L87Z/JdZY4hx9OnaWo93Ndw
        6ZAxvjhzY+O5Lb3HJt6rM2PKf5YMzppfrOuRm2fdiS/yWnZIyvLvPchsmRorNPtfb1Drdd3V
        GZb9NyghZ2bp5ZiTY/8B9jLMAZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnK7nqVdRBidOMFncWneO1aL33Ekm
        i6aOt6wWV76+Z7N4df4Ns0XnxCXsFpd3zWGzODx1CZvF2vOtLA6cHpf7epk8ZnfMZPXY/u0B
        q8f97uNMHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJVxe8pjtoJ9ShXn5jxmb2DcLNPFyMkh
        IWAisXT9HdYuRi4OIYHdjBIPVv1jhEhISSx7s40NwhaWWPnvOTtE0WdGiUv3vjODJNiAup/P
        mcEKYosIvGeUaN+UCFLELNDLKPFi/36wDmGBNkaJvjXnwKpYBFQlepZOBBvLKxAj8aJ3NRPE
        CjmJm+c6gaZycHAKWEns+ZIEEhYSsJRo7zvMOoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc
        4tK8dL3k/NxNjOCw1NLawXjiRPwhRgEORiUe3gNnX0YJsSaWFVfmHmKU4GBWEuGd0v0qSog3
        JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAOjpOXvn+vCLFz3
        iHEERG6dfW1LTJRe3x6Zs3J79D9+v7psav1ltqj6DyyPI04ealTkUT3mV7vGZ4bPBT3uX89t
        an5uaxbsfie39P6XWtbS6QolB0P0+rsKf2SebdDclvKvqdrAVcPr57x/f+83RUquPPeOcZZu
        VyC7cen0mj1l78ozc7VOLDVSYinOSDTUYi4qTgQARcnYB0cCAAA=
X-CMS-MailID: 20180503083729epcas5p16b374ea53fd3cf338ce7085d6467da13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503083729epcas5p16b374ea53fd3cf338ce7085d6467da13
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503083729epcas5p16b374ea53fd3cf338ce7085d6467da13
X-RootMTR: 20180503083729epcas5p16b374ea53fd3cf338ce7085d6467da13
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503083729epcas5p16b374ea53fd3cf338ce7085d6467da13@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for timing parameters

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 42 ++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 08ab7d6a..d90ac27 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -39,6 +39,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
+#include <video/videomode.h>
 
 /* Registers */
 
@@ -653,14 +654,9 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 	int ret;
 	int vid_sync_dly;
 	int max_tu_symbol;
+	struct videomode vm;
 
-	int left_margin = mode->htotal - mode->hsync_end;
-	int right_margin = mode->hsync_start - mode->hdisplay;
-	int hsync_len = mode->hsync_end - mode->hsync_start;
-	int upper_margin = mode->vtotal - mode->vsync_end;
-	int lower_margin = mode->vsync_start - mode->vdisplay;
-	int vsync_len = mode->vsync_end - mode->vsync_start;
-
+	drm_display_mode_to_videomode(mode, &vm);
 	/*
 	 * Recommended maximum number of symbols transferred in a transfer unit:
 	 * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
@@ -670,11 +666,11 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
 
 	dev_dbg(tc->dev, "set mode %dx%d\n",
-		mode->hdisplay, mode->vdisplay);
+		vm.hactive, vm.vactive);
 	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
-		left_margin, right_margin, hsync_len);
+		vm.hback_porch, vm.hfront_porch, vm.hsync_len);
 	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
-		upper_margin, lower_margin, vsync_len);
+		vm.vback_porch, vm.vfront_porch, vm.vsync_len);
 	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
 
 
@@ -686,14 +682,14 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 	 */
 	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
 		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
-	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
-			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
-	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
-			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
-	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
-			 (vsync_len << 0));		/* Vsync */
-	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
-			 (mode->vdisplay << 0));	/* height */
+	tc_write(HTIM01, (ALIGN(vm.hback_porch, 2) << 16) | /* H back porch */
+			 (ALIGN(vm.hsync_len, 2) << 0));	 /* Hsync */
+	tc_write(HTIM02, (ALIGN(vm.hfront_porch, 2) << 16) | /* H front porch */
+			 (ALIGN(vm.hactive, 2) << 0)); /* width */
+	tc_write(VTIM01, (vm.vback_porch << 16) |	/* V back porch */
+			 (vm.vsync_len << 0));		/* Vsync */
+	tc_write(VTIM02, (vm.vfront_porch << 16) |	/* V front porch */
+			 (vm.vactive << 0));	/* height */
 	tc_write(VFUEN0, VFUEN);		/* update settings */
 
 	/* Test pattern settings */
@@ -706,7 +702,7 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 		 0);
 
 	/* DP Main Stream Attributes */
-	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
+	vid_sync_dly = vm.hsync_len + vm.hback_porch + vm.hactive;
 	tc_write(DP0_VIDSYNCDELAY,
 		 (max_tu_symbol << 16) |	/* thresh_dly */
 		 (vid_sync_dly << 0));
@@ -714,12 +710,12 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
 
 	tc_write(DP0_STARTVAL,
-		 ((upper_margin + vsync_len) << 16) |
-		 ((left_margin + hsync_len) << 0));
+		 ((vm.vback_porch + vm.vsync_len) << 16) |
+		 ((vm.hback_porch + vm.hsync_len) << 0));
 
-	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
+	tc_write(DP0_ACTIVEVAL, (vm.vactive << 16) | (vm.hactive));
 
-	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0));
+	tc_write(DP0_SYNCVAL, (vm.vsync_len << 16) | (vm.hsync_len << 0));
 
 	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
 		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
-- 
2.7.4
