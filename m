Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE1C208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNzlBddq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE1C208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeHAVAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33051 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeHAVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so11288266pgv.0;
        Wed, 01 Aug 2018 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vul4BX0gqUQj2X+LXwtup1oCQZDlN1EYdrwF6xIY0wM=;
        b=vNzlBddqB2IFoBskK28rdOSB+KkOEhb2VpQFVM7Fbmgxihg7NEgJlLfAnC5gZJdu8Q
         32DWa32cmQ5qHWXU/B3ayT4+7/PpBBE6L02iJg3AeUISKz4OkT1BeQKDIi6aefB+XnRu
         PupAhkJpDvRBznW9BbZ7BY61ToFB49PVrZEXEdhthHPbbCRJh3kX3XPOMXXpLObhBySq
         FJcJ+g8ulQA3MJgqcADJZmzDUo/KMorNlGCUNwUP12EL1TFBXeEscYnftLzc2PKM5n+I
         ROHw5g/wVJ6O8RCZwoRSHfkcxz1Hf3SDQIh/xeOJVbh41G6DcRBK6i/EsR4+8cNkkR6C
         VZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vul4BX0gqUQj2X+LXwtup1oCQZDlN1EYdrwF6xIY0wM=;
        b=SY173VmM85iLcHcx5zAjidG51cjCbbsCcLREBNB0RByr5XqrR9mTva8Ubt3wh2Dqpe
         wCyQWEPoBzGTIADowVmwWbEMd0AHDhJRs8seQQGNZW+jqFEhsIb5UUskGJYXfVyiEuik
         Ay4bbBsXFeKH9QO79ldLAyKqLbKK2kkLcDd+ojx9IW/rPXq2zBwpicQ1cwUwlHMDjiOy
         nbdR3BBI/HSZzxNOIk/Kk+33EaHWtGa6DOaDBQi72PsjsYbFxXJCL6DDcMbOYLH/obdE
         eoDOqbeMiquJJMpllkA1RAiJiGhZtOEPxg0y9vikWQWW8kUL66FJCWBL6OhbkOHrueAt
         jhlw==
X-Gm-Message-State: AOUpUlGZcpS6XorkSekgfur/w6usVv02FeYY8DSJXuhjhbIc9umZ7jQy
        2GxIeen7ykPY2iMsmxSPZYetKLy1
X-Google-Smtp-Source: AAOMgpfv6arENTk73DuY+TpIarGmW1HmfmXuak+5FHjmRFrbOxQKnwHh/jcu1SVSqom6+22yEaH33g==
X-Received: by 2002:a62:9d14:: with SMTP id i20-v6mr28164809pfd.3.1533150778361;
        Wed, 01 Aug 2018 12:12:58 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:57 -0700 (PDT)
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
Subject: [PATCH v3 13/14] media: imx: Allow interweave with top/bottom lines swapped
Date:   Wed,  1 Aug 2018 12:12:26 -0700
Message-Id: <1533150747-30677-14-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sequential->interlaced interweaving but with top/bottom
lines swapped to the output buffer.

This can be accomplished by adding one line length to IDMAC output
channel address, with a negative line length for the interlace offset.

This is to allow the seq-bt -> interlaced-bt transformation, where
bottom lines are still dominant (older in time) but with top lines
first in the interweaved output buffer.

With this support, the CSI can now allow seq-bt at its source pads,
e.g. the following transformations are allowed in CSI from sink to
source:

seq-tb -> seq-bt
seq-bt -> seq-bt
alternate -> seq-bt

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 17 ++++++++++-
 drivers/staging/media/imx/imx-media-csi.c   | 46 +++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index cf76b04..1499b0c 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -106,6 +106,8 @@ struct prp_priv {
 	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;  /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
+	u32 interweave_offset; /* interweave line offset to swap
+				  top/bottom lines */
 	struct completion last_eof_comp;
 };
 
@@ -235,6 +237,9 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
 	if (ipu_idmac_buffer_is_ready(ch, priv->ipu_buf_num))
 		ipu_idmac_clear_buffer(ch, priv->ipu_buf_num);
 
+	if (ch == priv->out_ch)
+		phys += priv->interweave_offset;
+
 	ipu_cpmem_set_buffer(ch, priv->ipu_buf_num, phys);
 }
 
@@ -388,6 +393,13 @@ static int prp_setup_channel(struct prp_priv *priv,
 			(image.pix.width * outcc->bpp) >> 3;
 	}
 
+	priv->interweave_offset = 0;
+
+	if (interweave && image.pix.field == V4L2_FIELD_INTERLACED_BT) {
+		image.rect.top = 1;
+		priv->interweave_offset = image.pix.bytesperline;
+	}
+
 	image.phys0 = addr0;
 	image.phys1 = addr1;
 
@@ -425,7 +437,10 @@ static int prp_setup_channel(struct prp_priv *priv,
 		ipu_cpmem_set_rotation(channel, rot_mode);
 
 	if (interweave)
-		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline,
+		ipu_cpmem_interlaced_scan(channel,
+					  priv->interweave_offset ?
+					  -image.pix.bytesperline :
+					  image.pix.bytesperline,
 					  image.pix.pixelformat);
 
 	ret = ipu_ic_task_idma_init(priv->ic, channel,
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 6f24b3b..a5f88ae 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -114,6 +114,8 @@ struct csi_priv {
 	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;   /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
+	u32 interweave_offset; /* interweave line offset to swap
+				  top/bottom lines */
 	struct completion last_eof_comp;
 };
 
@@ -283,7 +285,8 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
 	if (ipu_idmac_buffer_is_ready(priv->idmac_ch, priv->ipu_buf_num))
 		ipu_idmac_clear_buffer(priv->idmac_ch, priv->ipu_buf_num);
 
-	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num, phys);
+	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num,
+			     phys + priv->interweave_offset);
 }
 
 static irqreturn_t csi_idmac_eof_interrupt(int irq, void *dev_id)
@@ -393,10 +396,10 @@ static void csi_idmac_unsetup_vb2_buf(struct csi_priv *priv,
 static int csi_idmac_setup_channel(struct csi_priv *priv)
 {
 	struct imx_media_video_dev *vdev = priv->vdev;
+	bool passthrough, interweave, interweave_swap;
 	const struct imx_media_pixfmt *incc;
 	struct v4l2_mbus_framefmt *infmt;
 	struct v4l2_mbus_framefmt *outfmt;
-	bool passthrough, interweave;
 	struct ipu_image image;
 	u32 passthrough_bits;
 	u32 passthrough_cycles;
@@ -430,6 +433,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	 */
 	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
 		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field);
+	interweave_swap = interweave &&
+		image.pix.field == V4L2_FIELD_INTERLACED_BT;
 
 	switch (image.pix.pixelformat) {
 	case V4L2_PIX_FMT_SBGGR8:
@@ -483,15 +488,25 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	}
 
 	if (passthrough) {
+		priv->interweave_offset = interweave_swap ?
+			image.pix.bytesperline : 0;
 		ipu_cpmem_set_resolution(priv->idmac_ch,
 					 image.rect.width * passthrough_cycles,
 					 image.rect.height);
 		ipu_cpmem_set_stride(priv->idmac_ch, image.pix.bytesperline);
-		ipu_cpmem_set_buffer(priv->idmac_ch, 0, image.phys0);
-		ipu_cpmem_set_buffer(priv->idmac_ch, 1, image.phys1);
+		ipu_cpmem_set_buffer(priv->idmac_ch, 0,
+				     image.phys0 + priv->interweave_offset);
+		ipu_cpmem_set_buffer(priv->idmac_ch, 1,
+				     image.phys1 + priv->interweave_offset);
 		ipu_cpmem_set_format_passthrough(priv->idmac_ch,
 						 passthrough_bits);
 	} else {
+		priv->interweave_offset = 0;
+		if (interweave_swap) {
+			image.rect.top = 1;
+			priv->interweave_offset = image.pix.bytesperline;
+		}
+
 		ret = ipu_cpmem_set_image(priv->idmac_ch, &image);
 		if (ret)
 			goto unsetup_vb2;
@@ -523,6 +538,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 
 	if (interweave)
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
+					  priv->interweave_offset ?
+					  -image.pix.bytesperline :
 					  image.pix.bytesperline,
 					  image.pix.pixelformat);
 
@@ -1331,16 +1348,27 @@ static void csi_try_field(struct csi_priv *priv,
 	switch (infmt->field) {
 	case V4L2_FIELD_SEQ_TB:
 	case V4L2_FIELD_SEQ_BT:
+		/*
+		 * If the user requests sequential at the source pad,
+		 * allow it (along with possibly inverting field order).
+		 * Otherwise passthrough the field type.
+		 */
+		if (!V4L2_FIELD_IS_SEQUENTIAL(sdformat->format.field))
+			sdformat->format.field = infmt->field;
+		break;
 	case V4L2_FIELD_ALTERNATE:
 		/*
-		 * If the sink is sequential or alternating fields,
-		 * allow only SEQ_TB at the source.
-		 *
 		 * This driver does not support alternate field mode, and
 		 * the CSI captures a whole frame, so the CSI never presents
-		 * alternate mode at its source pads.
+		 * alternate mode at its source pads. If user has not
+		 * already requested sequential, translate ALTERNATE at
+		 * sink pad to SEQ_TB or SEQ_BT at the source pad depending
+		 * on input height (assume NTSC BT order if 480 total active
+		 * frame lines, otherwise PAL TB order).
 		 */
-		sdformat->format.field = V4L2_FIELD_SEQ_TB;
+		if (!V4L2_FIELD_IS_SEQUENTIAL(sdformat->format.field))
+			sdformat->format.field = (infmt->height == 480 / 2) ?
+				V4L2_FIELD_SEQ_BT : V4L2_FIELD_SEQ_TB;
 		break;
 	default:
 		/* Passthrough for all other input field types */
-- 
2.7.4

