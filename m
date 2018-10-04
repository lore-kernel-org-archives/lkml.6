Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4362087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaz8Cuan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4362087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeJEBtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46324 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeJEBtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id a2-v6so3976634wrc.13;
        Thu, 04 Oct 2018 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TXqb7EibfKFZNUfoztxm+j4OXeEMHT4ZA7z/GZdKwHA=;
        b=iaz8CuannuhzrK7PdLEh490JMu0t+3ZZB4iXA6+tm56VRwO7SIy1ZCEcXMtAdwmN2c
         rdChHBPkbU4gUOEzfj1etU7bqs0CCxjJ4W+gkRtgUktg2jzr8eIYLi69ZCBDj52co6ZC
         Qw1jdk16VtSXidFjagep9Kvo5QOZMwLB1y12dNkaW7BN2WHs5cnaJbAr/KVwemk+DPj/
         c5//lazcbLoLASuGiplro7n91zG9o1jVVAxlEN/75p2Db8r4S7wCHCn2nZCnEGyANj7Q
         PstOKTjzVL4nWuEL+GVruto+71l/3zOX6fUixcRi/6B88yazYBMCruokSFQdy9YKJ3O8
         ClvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TXqb7EibfKFZNUfoztxm+j4OXeEMHT4ZA7z/GZdKwHA=;
        b=SSMR75Wucr6sAXpbIPGEwJgyaoDUbTqq17kgDJ2rD48scECc3yr4DlHcY4KPKVVSx/
         YBARvAQXXWvsqqh5dk59bF9qVbQmqEWwAe+SkAHHhSWbBuiOSNrphwH0G0xFSuwMS2VQ
         w+ZPzlBwd6gDJBqdsMc3Vwaf9h9J6nz+sAGB3XgzTIuzT7E4XtQIwQAqGlwvT4v80VJW
         bGSBcOe1JhVAN8ZwT3ipGlED2rL5fJkfPrf6TH/go7CNFJrcEc2gy6s/9u4zUyz5yFGS
         nsg4uM0r8QtI7svLztHcuwdRUiBILWpBOzorKYhYQhg9qHDghACj+tPoiWIx9Uqma2ny
         ZZZQ==
X-Gm-Message-State: ABuFfoj48p/fQ+O8mHUrnqFrNxclbRbC7M6ofvTprCmQuJkzsZeOuZuu
        j4FuhJ/bl1bAp/a0Hc4/QaiwFfcr
X-Google-Smtp-Source: ACcGV61vQACDxX2iz0UYQmD5gBHvXpRQ2ZMNW1o1Rz06+Hinkee7fsJTd3i8wOav2pIPveVS3dEJ6w==
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr5926393wrm.94.1538679279764;
        Thu, 04 Oct 2018 11:54:39 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:39 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/11] media: imx: Allow interweave with top/bottom lines swapped
Date:   Thu,  4 Oct 2018 11:54:00 -0700
Message-Id: <20181004185401.15751-11-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
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
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 17 +++++++-
 drivers/staging/media/imx/imx-media-csi.c   | 46 +++++++++++++++++----
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index cf76b0432371..1499b0c62d74 100644
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
index 679295da5dde..592f7d6edec1 100644
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
 
@@ -286,7 +288,8 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
 	if (ipu_idmac_buffer_is_ready(priv->idmac_ch, priv->ipu_buf_num))
 		ipu_idmac_clear_buffer(priv->idmac_ch, priv->ipu_buf_num);
 
-	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num, phys);
+	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num,
+			     phys + priv->interweave_offset);
 }
 
 static irqreturn_t csi_idmac_eof_interrupt(int irq, void *dev_id)
@@ -396,10 +399,10 @@ static void csi_idmac_unsetup_vb2_buf(struct csi_priv *priv,
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
@@ -433,6 +436,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	 */
 	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
 		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field);
+	interweave_swap = interweave &&
+		image.pix.field == V4L2_FIELD_INTERLACED_BT;
 
 	switch (image.pix.pixelformat) {
 	case V4L2_PIX_FMT_SBGGR8:
@@ -486,15 +491,25 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
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
@@ -526,6 +541,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 
 	if (interweave)
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
+					  priv->interweave_offset ?
+					  -image.pix.bytesperline :
 					  image.pix.bytesperline,
 					  image.pix.pixelformat);
 
@@ -1334,16 +1351,27 @@ static void csi_try_field(struct csi_priv *priv,
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
2.17.1

