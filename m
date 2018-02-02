Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBBKyq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:54:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57402 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBBKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:54:40 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180202105438euoutp02be2eeca177b89cfa55f7d7c6bd0479cc~PfNqz9gEz2927329273euoutp02K
X-AuditID: cbfec7f1-f793a6d00000326b-ad-5a74436d343f
From: Maciej Purski <m.purski@samsung.com>
To: dri-devel@lists.freedesktop.org
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2] drm/bridge/sii8620: fix display modes validation
Date: Fri, 02 Feb 2018 11:54:25 +0100
Message-id: <1517568865-25219-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7djPc7q5ziVRBrc3c1ncWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSujdfdZ5oJpchUrzm1mbGA8KNHFyMkh
        IWAi0X/lOhOELSZx4d56ti5GLg4hgaWMEt+ergZLCAl8ZpToOx7TxcgB1jCtA6pmGaPE9C2X
        2CGc/4wSa7bsYAcpYhPQkljTHg/SKyKgLPF34ipGkBpmgatMEicvbwcbKizgIvHn8B02EJtF
        QFXicudRFpBeXqD4hId8EAfJSdw818kMYU9gk5h8OADCdpFo+rUNKi4s8er4FnYIW0bi8uRu
        Fgi7WuLi111sEHaNROPtDVA11hKfJ20B62UW4JOYtG06M8RfvBIdbUIQJR4Ss9cchYaJo8SP
        6UcYQUqEBGIl3jarTWCUWsDIsIpRJLW0ODc9tdhIrzgxt7g0L10vOT93EyMwSk//O/5xB+P7
        E1aHGAU4GJV4eBNki6OEWBPLiitzDzFKcDArifB+3QAU4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zmsb1RYpJJCeWJKanZpakFoEk2Xi4JRqYFz3VrqaZx3rHem6vl6JsPSrPkr6c7QzAyp5ZrwS
        6/8va2wxSyj84HSX60eFn87+mrZn4WqOWmk1FeHy/8U8Cs936ada3nS593pfUcXPez+TVB3+
        aN2z1I2O+rJzo/3zaPG/HPkWy67+eTvBX3ON3DF1uWWPWdJv7P/Q5qTX1/to7tuNejH/mZRY
        ijMSDbWYi4oTAYNRQLnOAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42I5/e/4Nd0c55Iog7P3dSxurTvHatF77iST
        RVPHW1aLjTPWs1pc+fqezaJz4hJ2i8u75rBZLHh5i8Vi7ZG77A6cHpf7epk8ZnfMZPXY/u0B
        q8f97uNMHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXRuvssc8E0uYoV5zYzNjAelOhi5OCQ
        EDCRmNbB1sXICWSKSVy4tx7I5uIQEljCKLHx/SoWkISQQCOTxK3d4SD1bAJaEmva40HCIgLK
        En8nrmIEqWcWuMkk8ffsXlaQhLCAi8Sfw3fAhrIIqEpc7jzKAtLLCxSf8JAPYpecxM1zncwT
        GLkXMDKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAyebcd+btnB2PUu+BCjAAejEg9vgmxx
        lBBrYllxZe4hRgkOZiUR3q8bgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5e/esjhQSSE8sSc1O
        TS1ILYLJMnFwSjUw5q/kvz9v+45Lt0OuVAdlG709vjOc7fzN1ITorXcSd7qmf5hyQq1DVtf6
        gtDG9Rl+i2rzNLZPLlQ84nJrRbf8nMgSl6svZ8QceNlyJaLkRfKyG6VnS6Z/6pB5+uJO2yaR
        H3Yq9sXbDRZvlDlUM337z2/e5t/spNbn7/sdebc2eYVozc3na93eflZiKc5INNRiLipOBABs
        AM8FGgIAAA==
X-CMS-MailID: 20180202105436eucas1p12ed8f4deeff40a0f1c477fdfb99dae04
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180202105436eucas1p12ed8f4deeff40a0f1c477fdfb99dae04
X-RootMTR: 20180202105436eucas1p12ed8f4deeff40a0f1c477fdfb99dae04
References: <CGME20180202105436eucas1p12ed8f4deeff40a0f1c477fdfb99dae04@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of mode_valid() and mode_fixup() callbacks
handle packed pixel modes improperly.

Fix it by using proper maximum clock values from the documentation.

Signed-off-by: Maciej Purski <m.purski@samsung.com>

---
Changes in v2:
- simplify is_packing_required() function
- fix uninitialized variable detected by kbuild robot in mode_valid()
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 81 +++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 5168783..912d8c2 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -34,8 +34,11 @@
 
 #define SII8620_BURST_BUF_LEN 288
 #define VAL_RX_HDMI_CTRL2_DEFVAL VAL_RX_HDMI_CTRL2_IDLE_CNT(3)
-#define MHL1_MAX_LCLK 225000
-#define MHL3_MAX_LCLK 600000
+
+#define MHL1_MAX_PCLK 75000
+#define MHL1_MAX_PCLK_PP_MODE 150000
+#define MHL3_MAX_PCLK 200000
+#define MHL3_MAX_PCLK_PP_MODE 300000
 
 enum sii8620_mode {
 	CM_DISCONNECTED,
@@ -2123,61 +2126,61 @@ static void sii8620_detach(struct drm_bridge *bridge)
 	rc_unregister_device(ctx->rc_dev);
 }
 
+static int sii8620_is_packing_required(struct sii8620 *ctx,
+				 const struct drm_display_mode *mode)
+{
+	int max_pclk, max_pclk_pp_mode;
+
+	if (sii8620_is_mhl3(ctx)) {
+		max_pclk = MHL3_MAX_PCLK;
+		max_pclk_pp_mode = MHL3_MAX_PCLK_PP_MODE;
+	} else {
+		max_pclk = MHL1_MAX_PCLK;
+		max_pclk_pp_mode = MHL1_MAX_PCLK_PP_MODE;
+	}
+
+	if (mode->clock < max_pclk)
+		return 0;
+	else if (mode->clock < max_pclk_pp_mode)
+		return 1;
+	else
+		return -1;
+}
+
 static enum drm_mode_status sii8620_mode_valid(struct drm_bridge *bridge,
 					 const struct drm_display_mode *mode)
 {
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
+	int pack_required = sii8620_is_packing_required(ctx, mode);
 	bool can_pack = ctx->devcap[MHL_DCAP_VID_LINK_MODE] &
 			MHL_DCAP_VID_LINK_PPIXEL;
-	unsigned int max_pclk = sii8620_is_mhl3(ctx) ? MHL3_MAX_LCLK :
-						       MHL1_MAX_LCLK;
-	max_pclk /= can_pack ? 2 : 3;
 
-	return (mode->clock > max_pclk) ? MODE_CLOCK_HIGH : MODE_OK;
+	switch (pack_required) {
+	case 0:
+		return MODE_OK;
+	case 1:
+		return (can_pack) ? MODE_OK : MODE_CLOCK_HIGH;
+	default:
+		return MODE_CLOCK_HIGH;
+	}
 }
 
+
 static bool sii8620_mode_fixup(struct drm_bridge *bridge,
 			       const struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
 {
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
-	int max_lclk;
-	bool ret = true;
 
 	mutex_lock(&ctx->lock);
 
-	max_lclk = sii8620_is_mhl3(ctx) ? MHL3_MAX_LCLK : MHL1_MAX_LCLK;
-	if (max_lclk > 3 * adjusted_mode->clock) {
-		ctx->use_packed_pixel = 0;
-		goto end;
-	}
-	if ((ctx->devcap[MHL_DCAP_VID_LINK_MODE] & MHL_DCAP_VID_LINK_PPIXEL) &&
-	    max_lclk > 2 * adjusted_mode->clock) {
-		ctx->use_packed_pixel = 1;
-		goto end;
-	}
-	ret = false;
-end:
-	if (ret) {
-		u8 vic = drm_match_cea_mode(adjusted_mode);
-
-		if (!vic) {
-			union hdmi_infoframe frm;
-			u8 mhl_vic[] = { 0, 95, 94, 93, 98 };
-
-			/* FIXME: We need the connector here */
-			drm_hdmi_vendor_infoframe_from_display_mode(
-				&frm.vendor.hdmi, NULL, adjusted_mode);
-			vic = frm.vendor.hdmi.vic;
-			if (vic >= ARRAY_SIZE(mhl_vic))
-				vic = 0;
-			vic = mhl_vic[vic];
-		}
-		ctx->video_code = vic;
-		ctx->pixel_clock = adjusted_mode->clock;
-	}
+	ctx->use_packed_pixel = sii8620_is_packing_required(ctx, adjusted_mode);
+	ctx->video_code = drm_match_cea_mode(adjusted_mode);
+	ctx->pixel_clock = adjusted_mode->clock;
+
 	mutex_unlock(&ctx->lock);
-	return ret;
+
+	return true;
 }
 
 static const struct drm_bridge_funcs sii8620_bridge_funcs = {
-- 
2.7.4
