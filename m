Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA9C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1771F2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFGvNezl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1771F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJQHxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeJQHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so11594161pgu.11;
        Tue, 16 Oct 2018 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ud3sZ39TjMzlMzLDf6CVuDQV1gMZF2qHkeRsS7yIoLA=;
        b=VFGvNezl31mnXvNdIcleKAeaCqbGx+IFUBKBfm1LOF5VmSQbPIeWv/QWBBJRnlV2AZ
         JIjo3VvxVXsp9wBskjNDGHFMG73GD60MZNV2KNjMj6dbj+f3tbA21F4KjYSly2Gnblgu
         Bq+Kso8fvc136d8349X+O7GKfD+ooST6POKq6+UbH/KF02zZNx1pgUJ5TgaYy1VYvZtz
         hkgV7nTWrmOvqdkdwAkkrOZZF8ggkrlBFWS3qbJ4WWMo1byObZuE6MafbmAT2K2nvzjq
         VPITHunCQhMresD6rhe7MPk6DXrXcnV3GCJnk0XNho/HegddMl5M/SfOE4/5+eXU4kyo
         qpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ud3sZ39TjMzlMzLDf6CVuDQV1gMZF2qHkeRsS7yIoLA=;
        b=ZgtVoazdlPWEA8aEkIDrOlRWmzAZx3nYqcFjybrZ9FD/TPM+rgTiUB1f1ff/KQCsBI
         V7qU9phoE8Rzo4GQbkVMWDE2SdJIUraXWn/xCcu4yS3637ButTzQCq8I8a/F3t/rvy8G
         8QtEe4r5sdMt7KhCEtSnoEWuTMqbhdl5ea+ajNFypLT/rdeDVbQNNzwnFuDwbQvoq1P0
         ZwXgVJ1e//N6ySWZHTnbZu/fWhh66QiJUqFuXfS3RMANBqOUJNFwEl3Zl944boKuk4d8
         s1cJsTkLKKI2k1dxpNSnDEfJDs2VUDatBAGor615DPwMw/KIrfG6bf5BgwlSLLwm4yAT
         6quQ==
X-Gm-Message-State: ABuFfoj5LzoV6mOFoz4dqP0mdf6eW+w+NRTmCrKovQv/JuebBIBLqP97
        75LHSH+G3LF5WBvcipS2DPx5F4T+
X-Google-Smtp-Source: ACcGV636SgYdiqfQqysECxL4/O20anZNMbtRJIoSXHMbaxsUmv11An6RCtFv4/dlQdjsCRGjkIggOQ==
X-Received: by 2002:a63:e116:: with SMTP id z22-v6mr21803697pgh.20.1539734454312;
        Tue, 16 Oct 2018 17:00:54 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:53 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 11/12] media: imx: Allow interweave with top/bottom lines swapped
Date:   Tue, 16 Oct 2018 17:00:26 -0700
Message-Id: <20181017000027.23696-12-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
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
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
- Removed interweave_offset and replace with boolean interweave_swap,
  suggested by Philipp Zabel.
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 25 +++++++++----
 drivers/staging/media/imx/imx-media-csi.c   | 40 ++++++++++++++++++---
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index cf76b0432371..33ada6612fee 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -106,6 +106,7 @@ struct prp_priv {
 	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;  /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
+	bool interweave_swap; /* swap top/bottom lines when interweaving */
 	struct completion last_eof_comp;
 };
 
@@ -235,6 +236,9 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
 	if (ipu_idmac_buffer_is_ready(ch, priv->ipu_buf_num))
 		ipu_idmac_clear_buffer(ch, priv->ipu_buf_num);
 
+	if (priv->interweave_swap && ch == priv->out_ch)
+		phys += vdev->fmt.fmt.pix.bytesperline;
+
 	ipu_cpmem_set_buffer(ch, priv->ipu_buf_num, phys);
 }
 
@@ -376,8 +380,9 @@ static int prp_setup_channel(struct prp_priv *priv,
 	 * the IDMAC output channel.
 	 */
 	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
-		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field) &&
-		channel == priv->out_ch;
+		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field);
+	priv->interweave_swap = interweave &&
+		image.pix.field == V4L2_FIELD_INTERLACED_BT;
 
 	if (rot_swap_width_height) {
 		swap(image.pix.width, image.pix.height);
@@ -388,6 +393,11 @@ static int prp_setup_channel(struct prp_priv *priv,
 			(image.pix.width * outcc->bpp) >> 3;
 	}
 
+	if (priv->interweave_swap && channel == priv->out_ch) {
+		/* start interweave scan at 1st top line (2nd line) */
+		image.rect.top = 1;
+	}
+
 	image.phys0 = addr0;
 	image.phys1 = addr1;
 
@@ -396,8 +406,8 @@ static int prp_setup_channel(struct prp_priv *priv,
 	 * channels for planar 4:2:0 (but not when enabling IDMAC
 	 * interweaving, they are incompatible).
 	 */
-	if (!interweave && (channel == priv->out_ch ||
-			    channel == priv->rot_out_ch)) {
+	if ((channel == priv->out_ch && !interweave) ||
+	    channel == priv->rot_out_ch) {
 		switch (image.pix.pixelformat) {
 		case V4L2_PIX_FMT_YUV420:
 		case V4L2_PIX_FMT_YVU420:
@@ -424,8 +434,11 @@ static int prp_setup_channel(struct prp_priv *priv,
 	if (rot_mode)
 		ipu_cpmem_set_rotation(channel, rot_mode);
 
-	if (interweave)
-		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline,
+	if (interweave && channel == priv->out_ch)
+		ipu_cpmem_interlaced_scan(channel,
+					  priv->interweave_swap ?
+					  -image.pix.bytesperline :
+					  image.pix.bytesperline,
 					  image.pix.pixelformat);
 
 	ret = ipu_ic_task_idma_init(priv->ic, channel,
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 0d494a7db211..73c9f3ae4221 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -114,6 +114,7 @@ struct csi_priv {
 	u32 frame_sequence; /* frame sequence counter */
 	bool last_eof;   /* waiting for last EOF at stream off */
 	bool nfb4eof;    /* NFB4EOF encountered during streaming */
+	bool interweave_swap; /* swap top/bottom lines when interweaving */
 	struct completion last_eof_comp;
 };
 
@@ -286,6 +287,9 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
 	if (ipu_idmac_buffer_is_ready(priv->idmac_ch, priv->ipu_buf_num))
 		ipu_idmac_clear_buffer(priv->idmac_ch, priv->ipu_buf_num);
 
+	if (priv->interweave_swap)
+		phys += vdev->fmt.fmt.pix.bytesperline;
+
 	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num, phys);
 }
 
@@ -433,6 +437,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	 */
 	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
 		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field);
+	priv->interweave_swap = interweave &&
+		image.pix.field == V4L2_FIELD_INTERLACED_BT;
 
 	switch (image.pix.pixelformat) {
 	case V4L2_PIX_FMT_SBGGR8:
@@ -486,6 +492,12 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	}
 
 	if (passthrough) {
+		if (priv->interweave_swap) {
+			/* start interweave scan at 1st top line (2nd line) */
+			image.phys0 += image.pix.bytesperline;
+			image.phys1 += image.pix.bytesperline;
+		}
+
 		ipu_cpmem_set_resolution(priv->idmac_ch,
 					 image.rect.width * passthrough_cycles,
 					 image.rect.height);
@@ -495,6 +507,11 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 		ipu_cpmem_set_format_passthrough(priv->idmac_ch,
 						 passthrough_bits);
 	} else {
+		if (priv->interweave_swap) {
+			/* start interweave scan at 1st top line (2nd line) */
+			image.rect.top = 1;
+		}
+
 		ret = ipu_cpmem_set_image(priv->idmac_ch, &image);
 		if (ret)
 			goto unsetup_vb2;
@@ -526,6 +543,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 
 	if (interweave)
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
+					  priv->interweave_swap ?
+					  -image.pix.bytesperline :
 					  image.pix.bytesperline,
 					  image.pix.pixelformat);
 
@@ -1336,16 +1355,27 @@ static void csi_try_field(struct csi_priv *priv,
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

