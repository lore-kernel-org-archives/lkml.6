Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF33C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5EC20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEkZT7FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5EC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbeHAVAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeHAVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so11277466pgu.8;
        Wed, 01 Aug 2018 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ET+33HCBjiNGHEqkdCh/P5V/V5PyHU9loqp/gnJI+qo=;
        b=ZEkZT7FPnjVgJzJBHAZTbqEOmvVFebR4i6tfBBXarBL6hbpMsXqKjCfpEtiG1poX4M
         8O2NhyN6q1q7COeB8InR6cKhnWAp+XiiDdCY2FWeWxs8zefwYpYGWvtvbZ1tezzz51dw
         0kR+rdaXyuCsRF55s/0LpjGOqVe/pGFwKf/P6c2i6ARy14BZeL413IxPLNtlmmjJr8j2
         QmVKxWWO7SMm9izpRhEDwhK5Gc3xkC4cNQbgqFjHl1uEj/oqD5xgBmj9wjV9JnbVmD2B
         SejeQew92t9sFJUNOTn9v3NCRIuUbXtSThPsvKrM6cgd3Y6mzR0kgEG/CmLqt/to/A2a
         doNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ET+33HCBjiNGHEqkdCh/P5V/V5PyHU9loqp/gnJI+qo=;
        b=ti+ohKiNW4k5C04QGTfGdzq5fwbVd3sW5JuU8vNVke8i5PKitZKIzualI0qzuUp69M
         zdM9+xgJaFOq9KGZTwkcS/iD2ZBEHtIba89YfXBUAKU92nA5dGqM5SFsoIXvB3mMfTY5
         yc8VzwY22mrIlyuOWbmkDEIa4Iik0VPgG946gUjsW38+ahGZjct4tThLXEBqClNoe9nO
         R0Gj68N74fnwEHVad7v2hMY16p5IClZVWhPTJgO/w9n/1n/Y997zK3thHR1l+Y81/+dA
         S+JRZuKKdCOCKLgWg4bXI/hFAokBUeTXc1VF0Lf22Hgr5Mkn7WUJmxZGM9UeSGhqNmqR
         jcAw==
X-Gm-Message-State: AOUpUlFvAboT1Fxl3WR0uG7A4u0EIKXMe4tBQra4RVGnVr+BzF+2ypi6
        oQQJhVvmmWmE/BlIDXV6mDTJy+X/
X-Google-Smtp-Source: AAOMgpeuRm2+IKsM/cY10d9gZt/sSHiybs47HIaVb0lTGCmyELDyemcF4Nva0YLu0SOlmn4Y+KIzrA==
X-Received: by 2002:a63:9802:: with SMTP id q2-v6mr25673684pgd.70.1533150767802;
        Wed, 01 Aug 2018 12:12:47 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:46 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/14] media: imx: Fix field negotiation
Date:   Wed,  1 Aug 2018 12:12:20 -0700
Message-Id: <1533150747-30677-8-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDMAC interlaced scan, a.k.a. interweave, should be enabled in the
IDMAC output channels only if the IDMAC output pad field type is
'seq-bt' or 'seq-tb', and field type at the capture interface is
'interlaced*'.

V4L2_FIELD_HAS_BOTH() macro should not be used on the input to determine
enabling interlaced/interweave scan. That macro includes the 'interlaced'
field types, and in those cases the data is already interweaved with
top/bottom field lines.

The CSI will capture whole frames when the source specifies alternate
field mode. So the CSI also enables interweave for alternate input
field type and the field type at capture interface is interlaced.

Fix the logic for setting field type in try_fmt in CSI entity.
The behavior should be:

- No restrictions on field type at sink pad.

- At the output pads, allow sequential fields in TB order, if the sink pad
  field type is sequential or alternate. Otherwise passthrough the field
  type from sink to source pad.

Move this logic to new function csi_try_field().

These changes result in the following allowed field transformations
from CSI sink -> source pads (all other field types at sink are passed
through to source):

seq-tb -> seq-tb
seq-bt -> seq-tb
alternate -> seq-tb

In a future patch, the CSI sink -> source will allow:

seq-tb -> seq-bt
seq-bt -> seq-bt
alternate -> seq-bt

This will require supporting interweave with top/bottom line swapping.
Until then seq-bt is not allowed at the CSI source pad because there is
no way to swap top/bottom lines when interweaving to INTERLACED_BT --
note that despite the name, INTERLACED_BT is top-bottom order in memory.
The BT in this case refers to field dominance: the bottom lines are
older in time than the top lines.

The capture interface device allows selecting IDMAC interweave by
choosing INTERLACED_TB if the CSI/PRPENCVF source pad is seq-tb and
INTERLACED_BT if the source pad is seq-bt (for future support of seq-bt).

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c   | 21 ++++++---
 drivers/staging/media/imx/imx-media-capture.c | 14 ++++++
 drivers/staging/media/imx/imx-media-csi.c     | 64 ++++++++++++++++++++-------
 3 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index af72248..1a03d4c 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -354,12 +354,13 @@ static int prp_setup_channel(struct prp_priv *priv,
 {
 	struct imx_media_video_dev *vdev = priv->vdev;
 	const struct imx_media_pixfmt *outcc;
-	struct v4l2_mbus_framefmt *infmt;
+	struct v4l2_mbus_framefmt *outfmt;
 	unsigned int burst_size;
 	struct ipu_image image;
+	bool interweave;
 	int ret;
 
-	infmt = &priv->format_mbus[PRPENCVF_SINK_PAD];
+	outfmt = &priv->format_mbus[PRPENCVF_SRC_PAD];
 	outcc = vdev->cc;
 
 	ipu_cpmem_zero(channel);
@@ -369,6 +370,15 @@ static int prp_setup_channel(struct prp_priv *priv,
 	image.rect.width = image.pix.width;
 	image.rect.height = image.pix.height;
 
+	/*
+	 * If the field type at capture interface is interlaced, and
+	 * the output IDMAC pad is sequential, enable interweave at
+	 * the IDMAC output channel.
+	 */
+	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
+		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field) &&
+		channel == priv->out_ch;
+
 	if (rot_swap_width_height) {
 		swap(image.pix.width, image.pix.height);
 		swap(image.rect.width, image.rect.height);
@@ -409,9 +419,7 @@ static int prp_setup_channel(struct prp_priv *priv,
 	if (rot_mode)
 		ipu_cpmem_set_rotation(channel, rot_mode);
 
-	if (image.pix.field == V4L2_FIELD_NONE &&
-	    V4L2_FIELD_HAS_BOTH(infmt->field) &&
-	    channel == priv->out_ch)
+	if (interweave)
 		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline,
 					  image.pix.pixelformat);
 
@@ -839,8 +847,7 @@ static void prp_try_fmt(struct prp_priv *priv,
 	infmt = __prp_get_fmt(priv, cfg, PRPENCVF_SINK_PAD, sdformat->which);
 
 	if (sdformat->pad == PRPENCVF_SRC_PAD) {
-		if (sdformat->format.field != V4L2_FIELD_NONE)
-			sdformat->format.field = infmt->field;
+		sdformat->format.field = infmt->field;
 
 		prp_bound_align_output(&sdformat->format, infmt,
 				       priv->rot_mode);
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 256039c..5d3dc92 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -239,6 +239,20 @@ static int capture_try_fmt_vid_cap(struct file *file, void *fh,
 		cc = cc_src;
 	}
 
+	/* allow IDMAC interweave but enforce field order from source */
+	if (V4L2_FIELD_IS_INTERLACED(f->fmt.pix.field)) {
+		switch (fmt_src.format.field) {
+		case V4L2_FIELD_SEQ_TB:
+			fmt_src.format.field = V4L2_FIELD_INTERLACED_TB;
+			break;
+		case V4L2_FIELD_SEQ_BT:
+			fmt_src.format.field = V4L2_FIELD_INTERLACED_BT;
+			break;
+		default:
+			break;
+		}
+	}
+
 	imx_media_mbus_fmt_to_pix_fmt(&f->fmt.pix, &fmt_src.format, cc);
 
 	return 0;
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 1c468ec..8be1033 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -395,16 +395,18 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	struct imx_media_video_dev *vdev = priv->vdev;
 	const struct imx_media_pixfmt *incc;
 	struct v4l2_mbus_framefmt *infmt;
+	struct v4l2_mbus_framefmt *outfmt;
+	bool passthrough, interweave;
 	struct ipu_image image;
 	u32 passthrough_bits;
 	u32 passthrough_cycles;
 	dma_addr_t phys[2];
-	bool passthrough;
 	u32 burst_size;
 	int ret;
 
 	infmt = &priv->format_mbus[CSI_SINK_PAD];
 	incc = priv->cc[CSI_SINK_PAD];
+	outfmt = &priv->format_mbus[CSI_SRC_PAD_IDMAC];
 
 	ipu_cpmem_zero(priv->idmac_ch);
 
@@ -421,6 +423,14 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	passthrough = requires_passthrough(&priv->upstream_ep, infmt, incc);
 	passthrough_cycles = 1;
 
+	/*
+	 * If the field type at capture interface is interlaced, and
+	 * the output IDMAC pad is sequential, enable interweave at
+	 * the IDMAC output channel.
+	 */
+	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
+		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field);
+
 	switch (image.pix.pixelformat) {
 	case V4L2_PIX_FMT_SBGGR8:
 	case V4L2_PIX_FMT_SGBRG8:
@@ -506,8 +516,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 
 	ipu_smfc_set_burstsize(priv->smfc, burst_size);
 
-	if (image.pix.field == V4L2_FIELD_NONE &&
-	    V4L2_FIELD_HAS_BOTH(infmt->field))
+	if (interweave)
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
 					  image.pix.bytesperline,
 					  image.pix.pixelformat);
@@ -1297,6 +1306,38 @@ static int csi_get_fmt(struct v4l2_subdev *sd,
 	return ret;
 }
 
+static void csi_try_field(struct csi_priv *priv,
+			  struct v4l2_subdev_pad_config *cfg,
+			  struct v4l2_subdev_format *sdformat)
+{
+	struct v4l2_mbus_framefmt *infmt =
+		__csi_get_fmt(priv, cfg, CSI_SINK_PAD, sdformat->which);
+
+	/* no restrictions on sink pad field type */
+	if (sdformat->pad == CSI_SINK_PAD)
+		return;
+
+	switch (infmt->field) {
+	case V4L2_FIELD_SEQ_TB:
+	case V4L2_FIELD_SEQ_BT:
+	case V4L2_FIELD_ALTERNATE:
+		/*
+		 * If the sink is sequential or alternating fields,
+		 * allow only SEQ_TB at the source.
+		 *
+		 * This driver does not support alternate field mode, and
+		 * the CSI captures a whole frame, so the CSI never presents
+		 * alternate mode at its source pads.
+		 */
+		sdformat->format.field = V4L2_FIELD_SEQ_TB;
+		break;
+	default:
+		/* Passthrough for all other input field types */
+		sdformat->format.field = infmt->field;
+		break;
+	}
+}
+
 static void csi_try_fmt(struct csi_priv *priv,
 			struct v4l2_fwnode_endpoint *upstream_ep,
 			struct v4l2_subdev_pad_config *cfg,
@@ -1336,25 +1377,14 @@ static void csi_try_fmt(struct csi_priv *priv,
 			}
 		}
 
-		if (sdformat->pad == CSI_SRC_PAD_DIRECT ||
-		    sdformat->format.field != V4L2_FIELD_NONE)
-			sdformat->format.field = infmt->field;
-
-		/*
-		 * translate V4L2_FIELD_ALTERNATE to SEQ_TB or SEQ_BT
-		 * depending on input height (assume NTSC top-bottom
-		 * order if 480 lines, otherwise PAL bottom-top order).
-		 */
-		if (sdformat->format.field == V4L2_FIELD_ALTERNATE) {
-			sdformat->format.field =  (infmt->height == 480) ?
-				V4L2_FIELD_SEQ_TB : V4L2_FIELD_SEQ_BT;
-		}
+		csi_try_field(priv, cfg, sdformat);
 
 		/* propagate colorimetry from sink */
 		sdformat->format.colorspace = infmt->colorspace;
 		sdformat->format.xfer_func = infmt->xfer_func;
 		sdformat->format.quantization = infmt->quantization;
 		sdformat->format.ycbcr_enc = infmt->ycbcr_enc;
+
 		break;
 	case CSI_SINK_PAD:
 		v4l_bound_align_image(&sdformat->format.width, MIN_W, MAX_W,
@@ -1382,6 +1412,8 @@ static void csi_try_fmt(struct csi_priv *priv,
 			sdformat->format.code = (*cc)->codes[0];
 		}
 
+		csi_try_field(priv, cfg, sdformat);
+
 		imx_media_fill_default_mbus_fields(
 			&sdformat->format, infmt,
 			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
-- 
2.7.4

