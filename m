Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8B276A9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cOIhOhkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8B276A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeF1Qo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:44:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41426 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeF1QoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:44:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180628164421euoutp020dbcbe70c6989c129b6363e7568b913d~8YKsxne4D1342713427euoutp02P;
        Thu, 28 Jun 2018 16:44:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180628164421euoutp020dbcbe70c6989c129b6363e7568b913d~8YKsxne4D1342713427euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530204261;
        bh=0I4eEOn8stRSPIgk9a1xfTr6v2Ctc6V7l3kBw7Hv1J0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=cOIhOhkD2K3uXWcUZD/TFTZXRN208/99EGJUPaL5IBDj24xdXjO5DO89erXgZDy48
         DHEkUZZs/S/cO9PelRgBgV2rt2J3cfzbiUIMdAALQ/BKJuRwH3DLTeWYL6wZWp+5e8
         Hp4ZCLLxsVeCJLdJOuqAQZFUTY366LNpYGo3cEE0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180628164420eucas1p25ad71a2c5e093c9815c35e1aa73f5d47~8YKrpvonc1087010870eucas1p25;
        Thu, 28 Jun 2018 16:44:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E8.16.05700.460153B5; Thu, 28
        Jun 2018 17:44:20 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180628164419eucas1p138f041d9302891df39f4020032f4cc3f~8YKrAqO0N3253632536eucas1p1Y;
        Thu, 28 Jun 2018 16:44:19 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-6c-5b3510645e85
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.7A.04183.360153B5; Thu, 28
        Jun 2018 17:44:19 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PB1006SUL5Q0Y10@eusync3.samsung.com>;
        Thu, 28 Jun 2018 17:44:19 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 1/3] drm/bridge/sii8620: Send AVI infoframe in all MHL
 versions
Date:   Thu, 28 Jun 2018 18:44:01 +0200
Message-id: <1530204243-6370-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7djP87opAqbRBhdnC1ncWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjwq4NrAW/lSo6fs9maWBslu1i5OSQ
        EDCRuNL+krmLkYtDSGAFo8TBCb1MEM5nRonbR68ydjFygFUd/JcHEV/GKNHSNocJpFtI4D+j
        xMM7+iA1bAJaEmva40HCIgLKEn8nrmIEqWcWuMokcfLydrB6YYFAiUVLn7GC2CwCqhJdv06A
        xXkFnCWe7mxgh7hITuLmuU5mEJtTwEViTuMKsEESAgvYJM5MecAIUeQiMXXtYhYIW1ji1fEt
        UM0yEpcnd0PFqyVWvlzOAtHcwCjx5e5lZoiEtcTh4xfBrmAW4JOYtG06M8SXvBIdbUIQJR4S
        2693sEA8OZ1RYuN/jwmMkgsYGVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIExubpf8c/
        7WD8einpEKMAB6MSD++JKybRQqyJZcWVuYcYJTiYlUR4hThNo4V4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzxmnURQkJpCeWpGanphakFsFkmTg4pRoYk/6YG+8Qm7NHcPne3g3iXbPMX754/LW7
        w9R4Jnd2x39mH12ZmUvy3lyO1wyu2CVUtqkgvv2yXsTLn4wGH/8WvjXc9XhnTHFGZQAjQ7/j
        se/dwkasmYLZMgdY/aWu9774fKZ75ZYujpr4uQ6vzOdYXn3cmNf69tqCB3PCv3ypfsF0iiPl
        Rk+/EktxRqKhFnNRcSIA8PU/HMkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsVy+t/xq7rJAqbRBktfqlrcWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjwq4NrAW/lSo6fs9maWBslu1i5OCQ
        EDCROPgvr4uRi0NIYAmjxM8ta1i7GDmBnEYmiZezfUFq2AS0JNa0x4OERQSUJf5OXMUIUs8s
        cJNJ4u/ZvawgNcIC/hLbV4aB1LAIqEp0/TrBBGLzCjhLPN3ZwA5iSwjISdw818kMYnMKuEjM
        aVzBCLHKWeL03ia2CYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG1bZjP7fsYOx6
        F3yIUYCDUYmH98QVk2gh1sSy4srcQ4wSHMxKIrxCnKbRQrwpiZVVqUX58UWlOanFhxilOViU
        xHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhjty1+6bqiPuFXxIOIqN08+c9pth9YAC6mUS5LB
        T14d111iPit8g0RDc7bJursT71uYNFx6kv5u468fM34fKNw1r66ScYrNMQXBGp7y80YNbF/0
        BFNyFlksOcVzcGH4Poevj4/MLp0lxG9mUdi6Qf+Wi+7eO/eDxP78tTr4f/uys2KlgSsSNhso
        sRRnJBpqMRcVJwIAyre0DiYCAAA=
X-CMS-MailID: 20180628164419eucas1p138f041d9302891df39f4020032f4cc3f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628164419eucas1p138f041d9302891df39f4020032f4cc3f
References: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
        <CGME20180628164419eucas1p138f041d9302891df39f4020032f4cc3f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently AVI infoframe is sent only in MHL3. However, some MHL2 dongles
need AVI infoframe to work correctly in either packed pixel mode or
non-packed pixel mode.

Send AVI infoframe in set_infoframes() in every case. Create an
infoframe using drm_hdmi_infoframe_from_display_mode() instead of
manually filling each infoframe structure's field.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 39 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 250effa..bd30ccf 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -14,6 +14,7 @@
 #include <drm/bridge/mhl.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -72,9 +73,7 @@ struct sii8620 {
 	struct regulator_bulk_data supplies[2];
 	struct mutex lock; /* context lock, protects fields below */
 	int error;
-	int pixel_clock;
 	unsigned int use_packed_pixel:1;
-	int video_code;
 	enum sii8620_mode mode;
 	enum sii8620_sink_type sink_type;
 	u8 cbus_status;
@@ -82,7 +81,6 @@ struct sii8620 {
 	u8 xstat[MHL_XDS_SIZE];
 	u8 devcap[MHL_DCAP_SIZE];
 	u8 xdevcap[MHL_XDC_SIZE];
-	u8 avif[HDMI_INFOFRAME_SIZE(AVI)];
 	bool feature_complete;
 	bool devcap_read;
 	bool sink_detected;
@@ -1082,18 +1080,28 @@ static ssize_t mhl3_infoframe_pack(struct mhl3_infoframe *frame,
 	return frm_len;
 }
 
-static void sii8620_set_infoframes(struct sii8620 *ctx)
+static void sii8620_set_infoframes(struct sii8620 *ctx,
+				   struct drm_display_mode *mode)
 {
 	struct mhl3_infoframe mhl_frm;
 	union hdmi_infoframe frm;
 	u8 buf[31];
 	int ret;
 
+	ret = drm_hdmi_avi_infoframe_from_display_mode(&frm.avi,
+						       mode,
+						       true);
+	if (ctx->use_packed_pixel)
+		frm.avi.colorspace = HDMI_COLORSPACE_YUV422;
+
+	if (!ret)
+		ret = hdmi_avi_infoframe_pack(&frm.avi, buf, ARRAY_SIZE(buf));
+	if (ret > 0)
+		sii8620_write_buf(ctx, REG_TPI_AVI_CHSUM, buf + 3, ret - 3);
+
 	if (!sii8620_is_mhl3(ctx) || !ctx->use_packed_pixel) {
 		sii8620_write(ctx, REG_TPI_SC,
 			BIT_TPI_SC_TPI_OUTPUT_MODE_0_HDMI);
-		sii8620_write_buf(ctx, REG_TPI_AVI_CHSUM, ctx->avif + 3,
-			ARRAY_SIZE(ctx->avif) - 3);
 		sii8620_write(ctx, REG_PKT_FILTER_0,
 			BIT_PKT_FILTER_0_DROP_CEA_GAMUT_PKT |
 			BIT_PKT_FILTER_0_DROP_MPEG_PKT |
@@ -1102,16 +1110,6 @@ static void sii8620_set_infoframes(struct sii8620 *ctx)
 		return;
 	}
 
-	ret = hdmi_avi_infoframe_init(&frm.avi);
-	frm.avi.colorspace = HDMI_COLORSPACE_YUV422;
-	frm.avi.active_aspect = HDMI_ACTIVE_ASPECT_PICTURE;
-	frm.avi.picture_aspect = HDMI_PICTURE_ASPECT_16_9;
-	frm.avi.colorimetry = HDMI_COLORIMETRY_ITU_709;
-	frm.avi.video_code = ctx->video_code;
-	if (!ret)
-		ret = hdmi_avi_infoframe_pack(&frm.avi, buf, ARRAY_SIZE(buf));
-	if (ret > 0)
-		sii8620_write_buf(ctx, REG_TPI_AVI_CHSUM, buf + 3, ret - 3);
 	sii8620_write(ctx, REG_PKT_FILTER_0,
 		BIT_PKT_FILTER_0_DROP_CEA_GAMUT_PKT |
 		BIT_PKT_FILTER_0_DROP_MPEG_PKT |
@@ -1131,6 +1129,9 @@ static void sii8620_set_infoframes(struct sii8620 *ctx)
 
 static void sii8620_start_video(struct sii8620 *ctx)
 {
+	struct drm_display_mode *mode =
+		&ctx->bridge.encoder->crtc->state->adjusted_mode;
+
 	if (!sii8620_is_mhl3(ctx))
 		sii8620_stop_video(ctx);
 
@@ -1167,7 +1168,7 @@ static void sii8620_start_video(struct sii8620 *ctx)
 			  MHL_XDS_LINK_RATE_6_0_GBPS, 0x40 },
 		};
 		u8 p0_ctrl = BIT_M3_P0CTRL_MHL3_P0_PORT_EN;
-		int clk = ctx->pixel_clock * (ctx->use_packed_pixel ? 2 : 3);
+		int clk = mode->clock * (ctx->use_packed_pixel ? 2 : 3);
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(clk_spec) - 1; ++i)
@@ -1196,7 +1197,7 @@ static void sii8620_start_video(struct sii8620 *ctx)
 			clk_spec[i].link_rate);
 	}
 
-	sii8620_set_infoframes(ctx);
+	sii8620_set_infoframes(ctx, mode);
 }
 
 static void sii8620_disable_hpd(struct sii8620 *ctx)
@@ -2242,8 +2243,6 @@ static bool sii8620_mode_fixup(struct drm_bridge *bridge,
 	mutex_lock(&ctx->lock);
 
 	ctx->use_packed_pixel = sii8620_is_packing_required(ctx, adjusted_mode);
-	ctx->video_code = drm_match_cea_mode(adjusted_mode);
-	ctx->pixel_clock = adjusted_mode->clock;
 
 	mutex_unlock(&ctx->lock);
 
-- 
2.7.4

