Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeECJJi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:09:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21260 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeECJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:09:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180503090931epoutp0246682d93257c0b5b7c2f5e8dcf1311a5~rF1lnHHxO1082310823epoutp02K
X-AuditID: b6c32a49-56bff700000010df-a0-5aead1cab057
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 07/13] drm/kms/mode/meson-encoder: using helper function
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:39:21 +0530
Message-Id: <905f0ccf6c9abc97b6d77855b14d3bf8af892372.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+87Z5ZguDtPoS8LG6Wrg2lmbnkVW0oUTRUn9Uc7KTvrlLLfZ
        zpYVQY0ybaYlGZQJaho2K41pN8uySYXVFKmkG2YllcMwrYnd23Ym/fc87/t7eD5ePgKXl0ii
        iSyTFVlMXDYlGS+62hY7O+5hl1evGm1mmKKOdozpvdiAM099gxLG2zmAM9/zmzCm8kw443rf
        LWaeNJdLmLaTNRLGXZzKXOrMEy0OZwef50lZR3sxxl4b6RWzbwofYGxjzX62uKkOsF9dMclS
        PVpgQFwGsiiQKd2ckWXKTKRWrktbkqaNV9FxtI5JoBQmzogSqaWrkuOWZ2X7X0gpdnHZNv8o
        meN5au7CBRazzYoUBjNvTaRSaVqtpFUJSrVardRoN81Xa/3IFmTo6fRhOSXbdg98smMHwLc1
        DhBGQFIDa6/4cAcYT8jJmwAOV9VKBTMMYE1lS8iMAOjxOPGxyN3aH0BYtADosg+LBOMD8MbN
        qiAl8VMfy0+JA4soshqDztFzwRacLASwqOVQ0ESSDgBL370FgYiInAHv+S74NUHIyI0w/1GS
        0BcDX3QcwQPjMHI+vPVtayAKyccS2NPVLxWYpbCi0xPSkdD7oCmko2H/scNSIXAQwN76qpA5
        CmDBkfshahE8VNoqCjTgZCxsaJ4rjBOh/fWdIIKTE2DRzz4sgEBSBgsOywVkOnR+asPHun5V
        OsSCZuHQ+W6JoJPgQ+dI6F5FABZWN0qPg6ll/9sqAagDk1EOb8xEvDaHNqFcJc8ZeZspU5lu
        NrpA8DvOWXEdlHWscgOSAFSErNXTr5eLuV38HqMbQAKnomSlhV69XJbB7dmLLOY0iy0b8W6g
        9R+2BI+emG72f26TNY3W6FSa+PgEWqXSaahJshftPXo5mclZ0Q6EcpBlLIcRYdEHAH//1Xbn
        UJcl5fbAvnWa40mXN2wqk05Zax2snkd6JzdOW21It4vKji1LOeOu2ZzVN4FdnzvL2vf79Oud
        Z8ftnQl2nohI+vO58WtJxM/cSe5nH2bq7DEVUV2jdV+kNpGi4Fns+1fhf1/6vLU6xw/ksjas
        qE+9mjeuenjQk98aub97CKNEvIGj5+AWnvsHY9aX5qQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvO6pi6+iDLb/FbHoPXeSyeLBmvXM
        Fle+vmezeHX+DbPFz/YtTBYLZnNbbHp8jdXi8q45bBaHpy5hszjUF22x9nwriwO3x/sbrewe
        XSf7mDy2f3vA6nG/+ziTx+Yl9R59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CVce/8V6aCiWkV
        b140MjUwfvHvYuTkkBAwkTi4/BdjFyMXh5DAbkaJV+0HWSASUhLL3mxjg7CFJVb+e84OUfSZ
        UaJj13FGkAQbUPfzOTNYQRIiAiuZJL6eXwI2ilmgl1Hixf79YC3CAh2MEqsftLCCtLAIqEoc
        /boaqIqDg1cgRqL9tCPECjmJm+c6mUHCnAJWEnu+JIGEhQQsJdr7DrNOYORbwMiwilEytaA4
        Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOFy1NHcwXl4Sf4hRgINRiYc34/TLKCHWxLLiytxD
        jBIczEoivFO6X0UJ8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvE
        wSnVwLhK7OCf02uahLiuN2QXvfqqMmHV243dM/c58LzlsGvTOlNvuqo37pTqWkWPJgdLnsCb
        bswrfZwK0r59LLcV+nuE9Wj5gd82IosfHr66XvDNg6q1a7lSFsWFHHlgsGdprb778m8bPmd8
        kNG9eEPfyKjnx7rzms/7YmxmaPQGMPXJPCqekcx0K1OJpTgj0VCLuag4EQDAFz/7UwIAAA==
X-CMS-MailID: 20180503090930epcas5p23ef09c1e72c344bf8d879a344d0998cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503090930epcas5p23ef09c1e72c344bf8d879a344d0998cf
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503090930epcas5p23ef09c1e72c344bf8d879a344d0998cf
X-RootMTR: 20180503090930epcas5p23ef09c1e72c344bf8d879a344d0998cf
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503090930epcas5p23ef09c1e72c344bf8d879a344d0998cf@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Duplicate logic for the timing params is avoided
-Arithmatic operator *,/ are replaced by logical >>, << operators
-The flags DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags
-Combined similar if statements

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 149 ++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 6e27013..dddf914 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -25,7 +25,7 @@
 #include "meson_vpp.h"
 #include "meson_vclk.h"
 #include "meson_registers.h"
-
+#include <video/videomode.h>
 /**
  * DOC: Video Encoder
  *
@@ -1125,9 +1125,6 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	bool hdmi_repeat = false;
 	unsigned int venc_hdmi_latency = 2;
 	unsigned long total_pixels_venc = 0;
-	unsigned long active_pixels_venc = 0;
-	unsigned long front_porch_venc = 0;
-	unsigned long hsync_pixels_venc = 0;
 	unsigned long de_h_begin = 0;
 	unsigned long de_h_end = 0;
 	unsigned long de_v_begin_even = 0;
@@ -1143,9 +1140,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	unsigned long vs_eline_odd = 0;
 	unsigned long vso_begin_evn = 0;
 	unsigned long vso_begin_odd = 0;
-	unsigned int eof_lines;
-	unsigned int sof_lines;
-	unsigned int vsync_lines;
+	struct videomode vm = {};
 
 	if (meson_venc_hdmi_supported_vic(vic))
 		vmode = meson_venc_hdmi_get_vic_vmode(vic);
@@ -1156,9 +1151,9 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 			DRM_MODE_FMT "\n", __func__, DRM_MODE_ARG(mode));
 		return;
 	}
-
+	drm_display_mode_to_videomode(mode, &vm);
 	/* Use VENCI for 480i and 576i and double HDMI pixels */
-	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
+	if (vm.flags & DISPLAY_FLAGS_DOUBLECLK) {
 		hdmi_repeat = true;
 		use_enci = true;
 		venc_hdmi_latency = 1;
@@ -1167,40 +1162,25 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	/* Repeat VENC pixels for 480/576i/p, 720p50/60 and 1080p50/60 */
 	if (meson_venc_hdmi_venc_repeat(vic))
 		venc_repeat = true;
-
-	eof_lines = mode->vsync_start - mode->vdisplay;
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-		eof_lines /= 2;
-	sof_lines = mode->vtotal - mode->vsync_end;
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-		sof_lines /= 2;
-	vsync_lines = mode->vsync_end - mode->vsync_start;
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-		vsync_lines /= 2;
+	if (vm.flags & DISPLAY_FLAGS_INTERLACED) {
+		vm.vfront_porch >>= 1;
+		vm.vback_porch >>= 1;
+		vm.vsync_len >>= 1;
+	}
 
 	total_pixels_venc = mode->htotal;
-	if (hdmi_repeat)
-		total_pixels_venc /= 2;
-	if (venc_repeat)
-		total_pixels_venc *= 2;
-
-	active_pixels_venc = mode->hdisplay;
-	if (hdmi_repeat)
-		active_pixels_venc /= 2;
-	if (venc_repeat)
-		active_pixels_venc *= 2;
-
-	front_porch_venc = (mode->hsync_start - mode->hdisplay);
-	if (hdmi_repeat)
-		front_porch_venc /= 2;
-	if (venc_repeat)
-		front_porch_venc *= 2;
-
-	hsync_pixels_venc = (mode->hsync_end - mode->hsync_start);
-	if (hdmi_repeat)
-		hsync_pixels_venc /= 2;
-	if (venc_repeat)
-		hsync_pixels_venc *= 2;
+	if (hdmi_repeat) {
+		total_pixels_venc >>= 1;
+		vm.hactive >>= 1;
+		vm.hfront_porch >>= 1;
+		vm.hsync_len >>= 1;
+	}
+	if (venc_repeat) {
+		total_pixels_venc <<= 1;
+		vm.hactive <<= 1;
+		vm.hfront_porch <<= 1;
+		vm.hsync_len <<= 1;
+	}
 
 	/* Disable VDACs */
 	writel_bits_relaxed(0xff, 0xff,
@@ -1302,7 +1282,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 					_REG(ENCI_VFIFO2VD_PIXEL_START))
 					+ venc_hdmi_latency,
 				    total_pixels_venc);
-		de_h_end  = modulo(de_h_begin + active_pixels_venc,
+		de_h_end  = modulo(de_h_begin + vm.hactive,
 				   total_pixels_venc);
 
 		writel_relaxed(de_h_begin,
@@ -1312,10 +1292,10 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 
 		de_v_begin_even = readl_relaxed(priv->io_base +
 					_REG(ENCI_VFIFO2VD_LINE_TOP_START));
-		de_v_end_even  = de_v_begin_even + mode->vdisplay;
+		de_v_end_even  = de_v_begin_even + vm.vactive;
 		de_v_begin_odd = readl_relaxed(priv->io_base +
 					_REG(ENCI_VFIFO2VD_LINE_BOT_START));
-		de_v_end_odd = de_v_begin_odd + mode->vdisplay;
+		de_v_end_odd = de_v_begin_odd + vm.vactive;
 
 		writel_relaxed(de_v_begin_even,
 				priv->io_base + _REG(ENCI_DE_V_BEGIN_EVEN));
@@ -1327,16 +1307,16 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				priv->io_base + _REG(ENCI_DE_V_END_ODD));
 
 		/* Program Hsync timing */
-		hs_begin = de_h_end + front_porch_venc;
-		if (de_h_end + front_porch_venc >= total_pixels_venc) {
+		hs_begin = de_h_end + vm.hfront_porch;
+		if (de_h_end + vm.hfront_porch >= total_pixels_venc) {
 			hs_begin -= total_pixels_venc;
 			vs_adjust  = 1;
 		} else {
-			hs_begin = de_h_end + front_porch_venc;
+			hs_begin = de_h_end + vm.hfront_porch;
 			vs_adjust  = 0;
 		}
 
-		hs_end = modulo(hs_begin + hsync_pixels_venc,
+		hs_end = modulo(hs_begin + vm.hsync_len,
 				total_pixels_venc);
 		writel_relaxed(hs_begin,
 				priv->io_base + _REG(ENCI_DVI_HSO_BEGIN));
@@ -1344,12 +1324,13 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				priv->io_base + _REG(ENCI_DVI_HSO_END));
 
 		/* Program Vsync timing for even field */
-		if (((de_v_end_odd - 1) + eof_lines + vs_adjust) >= lines_f1) {
+		if (((de_v_end_odd - 1) + vm.vfront_porch + vs_adjust)
+							>= lines_f1) {
 			vs_bline_evn = (de_v_end_odd - 1)
-					+ eof_lines
+					+ vm.vfront_porch
 					+ vs_adjust
 					- lines_f1;
-			vs_eline_evn = vs_bline_evn + vsync_lines;
+			vs_eline_evn = vs_bline_evn + vm.vsync_len;
 
 			writel_relaxed(vs_bline_evn,
 				priv->io_base + _REG(ENCI_DVI_VSO_BLINE_EVN));
@@ -1363,7 +1344,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				priv->io_base + _REG(ENCI_DVI_VSO_END_EVN));
 		} else {
 			vs_bline_odd = (de_v_end_odd - 1)
-					+ eof_lines
+					+ vm.vfront_porch
 					+ vs_adjust;
 
 			writel_relaxed(vs_bline_odd,
@@ -1372,9 +1353,9 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 			writel_relaxed(hs_begin,
 				priv->io_base + _REG(ENCI_DVI_VSO_BEGIN_ODD));
 
-			if ((vs_bline_odd + vsync_lines) >= lines_f1) {
+			if ((vs_bline_odd + vm.vsync_len) >= lines_f1) {
 				vs_eline_evn = vs_bline_odd
-						+ vsync_lines
+						+ vm.vsync_len
 						- lines_f1;
 
 				writel_relaxed(vs_eline_evn, priv->io_base
@@ -1384,7 +1365,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 						+ _REG(ENCI_DVI_VSO_END_EVN));
 			} else {
 				vs_eline_odd = vs_bline_odd
-						+ vsync_lines;
+						+ vm.vsync_len;
 
 				writel_relaxed(vs_eline_odd, priv->io_base
 						+ _REG(ENCI_DVI_VSO_ELINE_ODD));
@@ -1395,11 +1376,11 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 		}
 
 		/* Program Vsync timing for odd field */
-		if (((de_v_end_even - 1) + (eof_lines + 1)) >= lines_f0) {
+		if (((de_v_end_even - 1) + (vm.vfront_porch + 1)) >= lines_f0) {
 			vs_bline_odd = (de_v_end_even - 1)
-					+ (eof_lines + 1)
+					+ (vm.vfront_porch + 1)
 					- lines_f0;
-			vs_eline_odd = vs_bline_odd + vsync_lines;
+			vs_eline_odd = vs_bline_odd + vm.vsync_len;
 
 			writel_relaxed(vs_bline_odd,
 				priv->io_base + _REG(ENCI_DVI_VSO_BLINE_ODD));
@@ -1417,7 +1398,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				priv->io_base + _REG(ENCI_DVI_VSO_END_ODD));
 		} else {
 			vs_bline_evn = (de_v_end_even - 1)
-					+ (eof_lines + 1);
+					+ (vm.vfront_porch + 1);
 
 			writel_relaxed(vs_bline_evn,
 				priv->io_base + _REG(ENCI_DVI_VSO_BLINE_EVN));
@@ -1429,9 +1410,9 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 			writel_relaxed(vso_begin_evn, priv->io_base
 					+ _REG(ENCI_DVI_VSO_BEGIN_EVN));
 
-			if (vs_bline_evn + vsync_lines >= lines_f0) {
+			if (vs_bline_evn + vm.vsync_len >= lines_f0) {
 				vs_eline_odd = vs_bline_evn
-						+ vsync_lines
+						+ vm.vsync_len
 						- lines_f0;
 
 				writel_relaxed(vs_eline_odd, priv->io_base
@@ -1440,7 +1421,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				writel_relaxed(vso_begin_evn, priv->io_base
 						+ _REG(ENCI_DVI_VSO_END_ODD));
 			} else {
-				vs_eline_evn = vs_bline_evn + vsync_lines;
+				vs_eline_evn = vs_bline_evn + vm.vsync_len;
 
 				writel_relaxed(vs_eline_evn, priv->io_base
 						+ _REG(ENCI_DVI_VSO_ELINE_EVN));
@@ -1548,7 +1529,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 					_REG(ENCP_VIDEO_HAVON_BEGIN))
 					+ venc_hdmi_latency,
 				    total_pixels_venc);
-		de_h_end = modulo(de_h_begin + active_pixels_venc,
+		de_h_end = modulo(de_h_begin + vm.hactive,
 				  total_pixels_venc);
 
 		writel_relaxed(de_h_begin,
@@ -1559,11 +1540,11 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 		/* Program DE timing for even field */
 		de_v_begin_even = readl_relaxed(priv->io_base
 						+ _REG(ENCP_VIDEO_VAVON_BLINE));
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		if (vm.flags & DISPLAY_FLAGS_INTERLACED)
 			de_v_end_even = de_v_begin_even +
-					(mode->vdisplay / 2);
+					(vm.vactive >> 1);
 		else
-			de_v_end_even = de_v_begin_even + mode->vdisplay;
+			de_v_end_even = de_v_begin_even + vm.vactive;
 
 		writel_relaxed(de_v_begin_even,
 				priv->io_base + _REG(ENCP_DE_V_BEGIN_EVEN));
@@ -1571,14 +1552,14 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				priv->io_base + _REG(ENCP_DE_V_END_EVEN));
 
 		/* Program DE timing for odd field if needed */
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		if (vm.flags & DISPLAY_FLAGS_INTERLACED) {
 			unsigned int ofld_voav_ofst =
 				readl_relaxed(priv->io_base +
 					_REG(ENCP_VIDEO_OFLD_VOAV_OFST));
 			de_v_begin_odd = to_signed((ofld_voav_ofst & 0xf0) >> 4)
 						+ de_v_begin_even
 						+ ((mode->vtotal - 1) / 2);
-			de_v_end_odd = de_v_begin_odd + (mode->vdisplay / 2);
+			de_v_end_odd = de_v_begin_odd + (vm.vactive >> 1);
 
 			writel_relaxed(de_v_begin_odd,
 				priv->io_base + _REG(ENCP_DE_V_BEGIN_ODD));
@@ -1587,18 +1568,18 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 		}
 
 		/* Program Hsync timing */
-		if ((de_h_end + front_porch_venc) >= total_pixels_venc) {
+		if ((de_h_end + vm.hfront_porch) >= total_pixels_venc) {
 			hs_begin = de_h_end
-				   + front_porch_venc
+				   + vm.hfront_porch
 				   - total_pixels_venc;
 			vs_adjust  = 1;
 		} else {
 			hs_begin = de_h_end
-				   + front_porch_venc;
+				   + vm.hfront_porch;
 			vs_adjust  = 0;
 		}
 
-		hs_end = modulo(hs_begin + hsync_pixels_venc,
+		hs_end = modulo(hs_begin + vm.hsync_len,
 				total_pixels_venc);
 
 		writel_relaxed(hs_begin,
@@ -1608,19 +1589,19 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 
 		/* Program Vsync timing for even field */
 		if (de_v_begin_even >=
-				(sof_lines + vsync_lines + (1 - vs_adjust)))
+			(vm.vback_porch + vm.vsync_len + (1 - vs_adjust)))
 			vs_bline_evn = de_v_begin_even
-					- sof_lines
-					- vsync_lines
+					- vm.vback_porch
+					- vm.vsync_len
 					- (1 - vs_adjust);
 		else
 			vs_bline_evn = mode->vtotal
 					+ de_v_begin_even
-					- sof_lines
-					- vsync_lines
+					- vm.vback_porch
+					- vm.vsync_len
 					- (1 - vs_adjust);
 
-		vs_eline_evn = modulo(vs_bline_evn + vsync_lines,
+		vs_eline_evn = modulo(vs_bline_evn + vm.vsync_len,
 					mode->vtotal);
 
 		writel_relaxed(vs_bline_evn,
@@ -1635,12 +1616,12 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 				priv->io_base + _REG(ENCP_DVI_VSO_END_EVN));
 
 		/* Program Vsync timing for odd field if needed */
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		if (vm.flags & DISPLAY_FLAGS_INTERLACED) {
 			vs_bline_odd = (de_v_begin_odd - 1)
-					- sof_lines
-					- vsync_lines;
+					- vm.vback_porch
+					- vm.vsync_len;
 			vs_eline_odd = (de_v_begin_odd - 1)
-					- vsync_lines;
+					- vm.vsync_len;
 			vso_begin_odd  = modulo(hs_begin
 						+ (total_pixels_venc >> 1),
 						total_pixels_venc);
@@ -1660,8 +1641,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	}
 
 	writel_relaxed((use_enci ? 1 : 2) |
-		       (mode->flags & DRM_MODE_FLAG_PHSYNC ? 1 << 2 : 0) |
-		       (mode->flags & DRM_MODE_FLAG_PVSYNC ? 1 << 3 : 0) |
+		       (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ? 1 << 2 : 0) |
+		       (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ? 1 << 3 : 0) |
 		       4 << 5 |
 		       (venc_repeat ? 1 << 8 : 0) |
 		       (hdmi_repeat ? 1 << 12 : 0),
-- 
2.7.4
