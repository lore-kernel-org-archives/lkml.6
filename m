Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853DA20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TcPfZskq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DA20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIKUq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:46:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BoeFs2ZlhfUwkp1I/UuXDFXZufHpVdRfGsGl0cEB2EI=; b=TcPfZskqhtldsO8n127PLZJFU
        cvoRAwwMS2RUTaWsqpuNC1ZIdtkDhfMhiKn9ObFfVuhdma4TPOHxkU4iZ1m/dGEAa8skhA5ZHqUby
        ON7nbHywTHvYZosVQcGbB+eesl2maJks3g3sYzaY19keKxcng7gXkiK48wLcD5+AjX8X/GD+t0t/x
        qlXhBl3Idz0ICkS02MXf8E7ZzLmCKJtG5BecIZvBZJGN1OnN6FXeeW6UMDdgSwyxsbRzyAsqZqtJw
        vSAXsys1ip7qLLb/neNdNT/LbJ/MPw6CAGUlilcRb7a9QJDwtCnQJynv3H9K6HOCcyygazVnIdeut
        euZ1QK9sg==;
Received: from 177.17.246.211.dynamic.adsl.gvt.net.br ([177.17.246.211] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzks3-0005X4-SH; Tue, 11 Sep 2018 15:46:32 +0000
Date:   Tue, 11 Sep 2018 12:46:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
Message-ID: <20180911124625.6759e429@coco.lan>
In-Reply-To: <20180906222442.14825-6-contact@paulk.fr>
References: <20180906222442.14825-1-contact@paulk.fr>
        <20180906222442.14825-6-contact@paulk.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri,  7 Sep 2018 00:24:38 +0200
Paul Kocialkowski <contact@paulk.fr> escreveu:

> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> This introduces the Cedrus VPU driver that supports the VPU found in
> Allwinner SoCs, also known as Video Engine. It is implemented through
> a V4L2 M2M decoder device and a media device (used for media requests).
> So far, it only supports MPEG-2 decoding.
> 
> Since this VPU is stateless, synchronization with media requests is
> required in order to ensure consistency between frame headers that
> contain metadata about the frame to process and the raw slice data that
> is used to generate the frame.
> 
> This driver was made possible thanks to the long-standing effort
> carried out by the linux-sunxi community in the interest of reverse
> engineering, documenting and implementing support for the Allwinner VPU.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

There are several checkpatch issues here. Ok, some can be
ignored, but there are at least some of them that sounda relevant.

Please address them.


CHECK: Comparison to NULL could be written "ctx->ctrls[i]"
#214: FILE: drivers/staging/media/sunxi/cedrus/cedrus.c:51:
+	for (i = 0; ctx->ctrls[i] != NULL; i++)

CHECK: Alignment should match open parenthesis
#304: FILE: drivers/staging/media/sunxi/cedrus/cedrus.c:141:
+		ctrl_test = v4l2_ctrl_request_hdl_ctrl_find(hdl,
+			cedrus_controls[i].id);

CHECK: Alignment should match open parenthesis
#468: FILE: drivers/staging/media/sunxi/cedrus/cedrus.c:305:
+	ret = v4l2_m2m_register_media_controller(dev->m2m_dev,
+			vfd, MEDIA_ENT_F_PROC_VIDEO_DECODER);

CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
#638: FILE: drivers/staging/media/sunxi/cedrus/cedrus.h:47:
+	bool			required;

WARNING: line over 80 characters
#744: FILE: drivers/staging/media/sunxi/cedrus/cedrus.h:153:
+static inline struct cedrus_buffer *vb2_v4l2_to_cedrus_buffer(const struct vb2_v4l2_buffer *p)

WARNING: line over 80 characters
#749: FILE: drivers/staging/media/sunxi/cedrus/cedrus.h:158:
+static inline struct cedrus_buffer *vb2_to_cedrus_buffer(const struct vb2_buffer *p)

CHECK: Alignment should match open parenthesis
#809: FILE: drivers/staging/media/sunxi/cedrus/cedrus_dec.c:47:
+		run.mpeg2.slice_params = cedrus_find_control_data(ctx,
+			V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS);

CHECK: Alignment should match open parenthesis
#811: FILE: drivers/staging/media/sunxi/cedrus/cedrus_dec.c:49:
+		run.mpeg2.quantization = cedrus_find_control_data(ctx,
+			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);

WARNING: line over 80 characters
#1368: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:133:
+	reg |= VE_DEC_MPEG_MP12HDR_INTRA_DC_PRECISION(picture->intra_dc_precision);

WARNING: line over 80 characters
#1369: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:134:
+	reg |= VE_DEC_MPEG_MP12HDR_INTRA_PICTURE_STRUCTURE(picture->picture_structure);

WARNING: line over 80 characters
#1371: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:136:
+	reg |= VE_DEC_MPEG_MP12HDR_FRAME_PRED_FRAME_DCT(picture->frame_pred_frame_dct);

WARNING: line over 80 characters
#1372: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:137:
+	reg |= VE_DEC_MPEG_MP12HDR_CONCEALMENT_MOTION_VECTORS(picture->concealment_motion_vectors);

WARNING: line over 80 characters
#1395: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:160:
+	fwd_luma_addr = cedrus_dst_buf_addr(ctx, slice_params->forward_ref_index, 0);

WARNING: line over 80 characters
#1396: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:161:
+	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, slice_params->forward_ref_index, 1);

WARNING: line over 80 characters
#1401: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:166:
+	bwd_luma_addr = cedrus_dst_buf_addr(ctx, slice_params->backward_ref_index, 0);

WARNING: line over 80 characters
#1402: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:167:
+	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, slice_params->backward_ref_index, 1);

WARNING: line over 80 characters
#1417: FILE: drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c:182:
+	cedrus_write(dev, VE_DEC_MPEG_VLD_OFFSET, slice_params->data_bit_offset);

CHECK: Macro argument reuse 'x' - possible side-effects?
#1552: FILE: drivers/staging/media/sunxi/cedrus/cedrus_regs.h:74:
+#define VE_DEC_MPEG_MP12HDR_F_CODE_MASK(x, y) \
+	GENMASK(VE_DEC_MPEG_MP12HDR_F_CODE_SHIFT(x, y) + 3, \
+		VE_DEC_MPEG_MP12HDR_F_CODE_SHIFT(x, y))

CHECK: Macro argument reuse 'y' - possible side-effects?
#1552: FILE: drivers/staging/media/sunxi/cedrus/cedrus_regs.h:74:
+#define VE_DEC_MPEG_MP12HDR_F_CODE_MASK(x, y) \
+	GENMASK(VE_DEC_MPEG_MP12HDR_F_CODE_SHIFT(x, y) + 3, \
+		VE_DEC_MPEG_MP12HDR_F_CODE_SHIFT(x, y))

CHECK: Macro argument reuse 'x' - possible side-effects?
#1555: FILE: drivers/staging/media/sunxi/cedrus/cedrus_regs.h:77:
+#define VE_DEC_MPEG_MP12HDR_F_CODE(x, y, v) \
+	(((v) << VE_DEC_MPEG_MP12HDR_F_CODE_SHIFT(x, y)) & \
+	 VE_DEC_MPEG_MP12HDR_F_CODE_MASK(x, y))

CHECK: Macro argument reuse 'y' - possible side-effects?
#1555: FILE: drivers/staging/media/sunxi/cedrus/cedrus_regs.h:77:
+#define VE_DEC_MPEG_MP12HDR_F_CODE(x, y, v) \
+	(((v) << VE_DEC_MPEG_MP12HDR_F_CODE_SHIFT(x, y)) & \
+	 VE_DEC_MPEG_MP12HDR_F_CODE_MASK(x, y))

CHECK: Macro argument reuse 'a' - possible side-effects?
#1685: FILE: drivers/staging/media/sunxi/cedrus/cedrus_regs.h:207:
+#define VE_DEC_MPEG_VLD_ADDR_BASE(a) \
+	(((a) & GENMASK(27, 4)) | (((a) >> 28) & GENMASK(3, 0)))

CHECK: Comparison to NULL could be written "fmt"
#1805: FILE: drivers/staging/media/sunxi/cedrus/cedrus_video.c:88:
+	return fmt != NULL;

CHECK: Please use a blank line after function/struct/union/enum declarations
#2214: FILE: drivers/staging/media/sunxi/cedrus/cedrus_video.c:497:
+}
+static struct vb2_ops cedrus_qops = {

total: 0 errors, 11 warnings, 13 checks, 2139 lines checked






Thanks,
Mauro
