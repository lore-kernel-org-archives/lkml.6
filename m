Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4705AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98402087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjPbI2qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98402087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJQHxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40666 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeJQHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so11604572pgm.7;
        Tue, 16 Oct 2018 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGupLtCrLcyDF9k/0ilGtmDXmWL8CPouV9cE/AdG6B4=;
        b=kjPbI2qaKW35r63115kiKXIgPDfzfjjNHlngeXi2UVwPKqUQBvXo5YiRR1HX9id1Mi
         mh6v4JaLvZs0wfP1VPIjtwduE3Qg8LAu3oCs0pqdnjFt3Yc7z3eWRslQLqzUxM/BYhag
         jVsHlDFWtTVzB4a4O4fYRRlfYcQvWYGr3WPahibtRULUZTDRPFvQYbd7z27rDoLQb9fs
         VntjpEajhOXk3sSX+Z1+Y+/UUPUSni0Yrp9eXOpMKAFdthxw49D3kKB8ckIeOggXYSd7
         c4uxsvSvz4eShuz4ZmzSoN2njsplmvnEKUWy9brADbiI5Kny0KvJ4Lpo2drhjMapkx+X
         8bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGupLtCrLcyDF9k/0ilGtmDXmWL8CPouV9cE/AdG6B4=;
        b=W9muXsax2OdtXXvykWKTmYpfNwZJJe+SosSpL6Up8AoEGluINpAoGFkKCt8b8o2KeK
         SjOd1peCUXBskk6YHMqXqDrmYbnfc8DtZDQSU2zlxidPbHuM4XjFpG8qyt8vikZyVQiT
         FvUo9sDOCBMjqNKhT1IdxVcAc6QeMuubbnfU+U3nFWyy+i/WuPw6S5CTx+RauEOPoTnm
         JP76Gvg0KCslc6u17xqzX46n7FS8/MAVr1n44SJkK+2Yhc5E2DCEYaxHLrgKpJ0vpuzG
         rqXeUEjaKGKlgZq7toAnl4a/brw6fpbWPeCKdRqOHPr+gJHDdHm34CipGSnQ0YBN4tfz
         +gNg==
X-Gm-Message-State: ABuFfoh4njUB1b0YKb1oGqJPynbbnVB6FSlIRtHg0yLrGMijzfIA11W3
        xw4Ggf5+jkpq1QcHXwe8B6pI4eDA
X-Google-Smtp-Source: ACcGV611laWqjTCTn7zPu1ZmDhnPj8r9ifJDYsgCCO+U6IfaBIuUF+r+yUHkJrejzhc2VseiKdQbpQ==
X-Received: by 2002:a62:fcd8:: with SMTP id e207-v6mr23752706pfh.132.1539734443032;
        Tue, 16 Oct 2018 17:00:43 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:42 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/12] media: imx: Fix field negotiation
Date:   Tue, 16 Oct 2018 17:00:19 -0700
Message-Id: <20181017000027.23696-5-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
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

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c   | 21 ++++--
 drivers/staging/media/imx/imx-media-capture.c | 14 ++++
 drivers/staging/media/imx/imx-media-csi.c     | 64 ++++++++++++++-----
 3 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index af7224846bd5..1a03d4c9d7b8 100644
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
index b37e1186eb2f..01ec9443de55 100644
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
index 4aa20ae72608..176978c7dfe7 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -398,16 +398,18 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
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
 
@@ -424,6 +426,14 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
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
@@ -509,8 +519,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 
 	ipu_smfc_set_burstsize(priv->smfc, burst_size);
 
-	if (image.pix.field == V4L2_FIELD_NONE &&
-	    V4L2_FIELD_HAS_BOTH(infmt->field))
+	if (interweave)
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
 					  image.pix.bytesperline,
 					  image.pix.pixelformat);
@@ -1302,6 +1311,38 @@ static int csi_get_fmt(struct v4l2_subdev *sd,
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
@@ -1341,25 +1382,14 @@ static void csi_try_fmt(struct csi_priv *priv,
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
@@ -1387,6 +1417,8 @@ static void csi_try_fmt(struct csi_priv *priv,
 			sdformat->format.code = (*cc)->codes[0];
 		}
 
+		csi_try_field(priv, cfg, sdformat);
+
 		imx_media_fill_default_mbus_fields(
 			&sdformat->format, infmt,
 			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
-- 
2.17.1

