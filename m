Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2B6F83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01320862
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrmXgkpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A01320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeG2J2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 05:28:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51794 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeG2J2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 05:28:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so9697305wma.1;
        Sun, 29 Jul 2018 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfEJy8uP+N+61Qb6OpILxYfi0cAWMMGMmaDhujuvT90=;
        b=hrmXgkpLMjtSF02oiVs59Fn1yrU1l6zfwabgnXZYlue21fUF+OmbO+hrL5n+HwsajY
         2SQ6HXg4YE8wTC3BPoXL3feWDCLYCUcUVdql0+pOV9BAdJStMg9oUVw0wYj8VnKDWXWr
         bjHhBV373CmB/dfDFlX10cuH5jt1kgFTseWcJJcvG5tk4U+bYCJqGjYzwmqHUn+s+84T
         dQVy+l8Qbx1OczNn7hXLY3uhqfhNPT24QTST9GXtqrIAl0GYEWoeEUsrg0+biC2KOfJn
         AUH04M31F+M5wupvOXNsSYAK+5aZjevKcvuwz63k/DrC3ST6DVC1yZqeoG/CdCA/1HBs
         Uy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfEJy8uP+N+61Qb6OpILxYfi0cAWMMGMmaDhujuvT90=;
        b=giJFkKWrcn6cRBymzozn2jZSMJ+WxIltqQePxjYFn7OsHcgvs6qvLjke7nRxwW/jYV
         /PPcj52lRxyKIoVf++KLjEw9CdBdOF381zxqKj8ERy+iabz0zLfDeh2KS3S/UB+7JA1Y
         SyVxExQ1jzTsE6CK1GVjhcoWeZ5K6+bv57ENiQUiv30BeD+N87+ZM4K2GImZHpsaTArB
         gYQVmaC73tOC4abTi2UsCee4lgb+TuakszPS/td3xsP+/5cS6mFcnfSTzYCcVECFcNFy
         aLK2mi32pXFRopdScQq4upymyMGqt6au57xfzSD4YHiorjfN8viZx8/0Rh9x/N08Cc+p
         KQlw==
X-Gm-Message-State: AOUpUlGsDeHpcBiBUL545AgoE+x6UF4qn8UHDXuJt82QbYV/E87dFAwe
        E4iB92rBaauqOdIiO9/4cPQ=
X-Google-Smtp-Source: AAOMgpf9HNC7uD+P4P/mibmb1IpogB+jWPgG9wOua3mu6JbbIClXC8FD5sCr14rtPQDs5HkLD2NUqA==
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr10384757wme.54.1532851104572;
        Sun, 29 Jul 2018 00:58:24 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id n14-v6sm7145306wmc.14.2018.07.29.00.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 00:58:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [linux-sunxi] [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
Date:   Sun, 29 Jul 2018 09:58:21 +0200
Message-ID: <1703875.6APCh3GEgq@jernej-laptop>
In-Reply-To: <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com> <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 25. julij 2018 ob 12:02:52 CEST je Paul Kocialkowski napisal(a):
> This introduces the Cedrus VPU driver that supports the VPU found in
> Allwinner SoCs, also known as Video Engine. It is implemented through
> a v4l2 m2m decoder device and a media device (used for media requests).
> So far, it only supports MPEG2 decoding.
> 
> Since this VPU is stateless, synchronization with media requests is
> required in order to ensure consistency between frame headers that
> contain metadata about the frame to process and the raw slice data that
> is used to generate the frame.
> 
> This driver was made possible thanks to the long-standing effort
> carried out by the linux-sunxi community in the interest of reverse
> engineering, documenting and implementing support for Allwinner VPU.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---

<snip>

> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c new file mode 100644
> index 000000000000..ca329c0d4699
> --- /dev/null
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sunxi-Cedrus VPU driver
> + *
> + * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> + * Copyright (C) 2016 Florent Revest <florent.revest@free-electrons.com>
> + *
> + * Based on the vim2m driver, that is:
> + *
> + * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> + * Pawel Osciak, <pawel@osciak.com>
> + * Marek Szyprowski, <m.szyprowski@samsung.com>
> + */
> +
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "cedrus.h"
> +#include "cedrus_hw.h"
> +#include "cedrus_regs.h"
> +
> +static const u8 intra_quantization_matrix_default[64] = {
> +	8,  16, 16, 19, 16, 19, 22, 22,
> +	22, 22, 22, 22, 26, 24, 26, 27,
> +	27, 27, 26, 26, 26, 26, 27, 27,
> +	27, 29, 29, 29, 34, 34, 34, 29,
> +	29, 29, 27, 27, 29, 29, 32, 32,
> +	34, 34, 37, 38, 37, 35, 35, 34,
> +	35, 38, 38, 40, 40, 40, 48, 48,
> +	46, 46, 56, 56, 58, 69, 69, 83
> +};
> +
> +static const u8 non_intra_quantization_matrix_default[64] = {
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 16
> +};
> +
> +static enum cedrus_irq_status cedrus_mpeg2_irq_status(struct cedrus_ctx
> *ctx) +{
> +	struct cedrus_dev *dev = ctx->dev;
> +	u32 reg;
> +
> +	reg = cedrus_read(dev, VE_DEC_MPEG_STATUS);
> +	reg &= VE_DEC_MPEG_STATUS_CHECK_MASK;
> +
> +	if (!reg)
> +		return CEDRUS_IRQ_NONE;
> +
> +	if (reg & VE_DEC_MPEG_STATUS_CHECK_ERROR ||
> +	    !(reg & VE_DEC_MPEG_STATUS_SUCCESS))
> +		return CEDRUS_IRQ_ERROR;
> +
> +	return CEDRUS_IRQ_OK;
> +}
> +
> +static void cedrus_mpeg2_irq_clear(struct cedrus_ctx *ctx)
> +{
> +	struct cedrus_dev *dev = ctx->dev;
> +
> +	cedrus_write(dev, VE_DEC_MPEG_STATUS, VE_DEC_MPEG_STATUS_CHECK_MASK);
> +}
> +
> +static void cedrus_mpeg2_irq_disable(struct cedrus_ctx *ctx)
> +{
> +	struct cedrus_dev *dev = ctx->dev;
> +	u32 reg = cedrus_read(dev, VE_DEC_MPEG_CTRL);
> +
> +	reg &= ~VE_DEC_MPEG_CTRL_IRQ_MASK;
> +
> +	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
> +}
> +
> +static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run
> *run) +{
> +	const struct v4l2_ctrl_mpeg2_slice_params *slice_params;
> +	const struct v4l2_ctrl_mpeg2_quantization *quantization;
> +	dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> +	dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> +	dma_addr_t bwd_luma_addr, bwd_chroma_addr;
> +	struct cedrus_dev *dev = ctx->dev;
> +	u32 vld_end, vld_len;
> +	const u8 *matrix;
> +	unsigned int i;
> +	u32 reg;
> +
> +	slice_params = run->mpeg2.slice_params;
> +	quantization = run->mpeg2.quantization;
> +
> +	/* Activate MPEG engine. */
> +	cedrus_engine_enable(dev, CEDRUS_CODEC_MPEG2);
> +
> +	/* Set intra quantization matrix. */
> +
> +	if (quantization && quantization->load_intra_quantiser_matrix)
> +		matrix = quantization->intra_quantiser_matrix;
> +	else
> +		matrix = intra_quantization_matrix_default;
> +
> +	for (i = 0; i < 64; i++) {
> +		reg = VE_DEC_MPEG_IQMINPUT_WEIGHT(i, matrix[i]);
> +		reg |= VE_DEC_MPEG_IQMINPUT_FLAG_INTRA;
> +
> +		cedrus_write(dev, VE_DEC_MPEG_IQMINPUT, reg);
> +	}
> +
> +	/* Set non-intra quantization matrix. */
> +
> +	if (quantization && quantization->load_non_intra_quantiser_matrix)
> +		matrix = quantization->non_intra_quantiser_matrix;
> +	else
> +		matrix = non_intra_quantization_matrix_default;
> +
> +	for (i = 0; i < 64; i++) {
> +		reg = VE_DEC_MPEG_IQMINPUT_WEIGHT(i, matrix[i]);
> +		reg |= VE_DEC_MPEG_IQMINPUT_FLAG_NON_INTRA;
> +
> +		cedrus_write(dev, VE_DEC_MPEG_IQMINPUT, reg);
> +	}
> +
> +	/* Set MPEG picture header. */
> +
> +	reg = VE_DEC_MPEG_MP12HDR_SLICE_TYPE(slice_params->slice_type);
> +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(0, 0, slice_params->f_code[0][0]);
> +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(0, 1, slice_params->f_code[0][1]);
> +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(1, 0, slice_params->f_code[1][0]);
> +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(1, 1, slice_params->f_code[1][1]);
> +	reg |=
> VE_DEC_MPEG_MP12HDR_INTRA_DC_PRECISION(slice_params->intra_dc_precision);
> +	reg |=
> VE_DEC_MPEG_MP12HDR_INTRA_PICTURE_STRUCTURE(slice_params->picture_structure
> ); +	reg |=
> VE_DEC_MPEG_MP12HDR_TOP_FIELD_FIRST(slice_params->top_field_first); +	reg
> |=
> VE_DEC_MPEG_MP12HDR_FRAME_PRED_FRAME_DCT(slice_params->frame_pred_frame_dct
> ); +	reg |=
> VE_DEC_MPEG_MP12HDR_CONCEALMENT_MOTION_VECTORS(slice_params->concealment_mo
> tion_vectors); +	reg |=
> VE_DEC_MPEG_MP12HDR_Q_SCALE_TYPE(slice_params->q_scale_type); +	reg |=
> VE_DEC_MPEG_MP12HDR_INTRA_VLC_FORMAT(slice_params->intra_vlc_format); +	
reg
> |= VE_DEC_MPEG_MP12HDR_ALTERNATE_SCAN(slice_params->alternate_scan); +	reg
> |= VE_DEC_MPEG_MP12HDR_FULL_PEL_FORWARD_VECTOR(0);
> +	reg |= VE_DEC_MPEG_MP12HDR_FULL_PEL_BACKWARD_VECTOR(0);
> +
> +	cedrus_write(dev, VE_DEC_MPEG_MP12HDR, reg);
> +
> +	/* Set frame dimensions. */
> +
> +	reg = VE_DEC_MPEG_PICCODEDSIZE_WIDTH(slice_params->width);
> +	reg |= VE_DEC_MPEG_PICCODEDSIZE_HEIGHT(slice_params->height);
> +
> +	cedrus_write(dev, VE_DEC_MPEG_PICCODEDSIZE, reg);
> +
> +	reg = VE_DEC_MPEG_PICBOUNDSIZE_WIDTH(slice_params->width);
> +	reg |= VE_DEC_MPEG_PICBOUNDSIZE_HEIGHT(slice_params->height);
> +
> +	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> +
> +	/* Forward and backward prediction reference buffers. */
> +
> +	fwd_luma_addr = cedrus_dst_buf_addr(ctx, slice_params->forward_ref_index,
> 0); +	fwd_chroma_addr = cedrus_dst_buf_addr(ctx,
> slice_params->forward_ref_index, 1); +
> +	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> +	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
> +
> +	bwd_luma_addr = cedrus_dst_buf_addr(ctx, slice_params->backward_ref_index,
> 0); +	bwd_chroma_addr = cedrus_dst_buf_addr(ctx,
> slice_params->backward_ref_index, 1); +
> +	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
> +	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR, bwd_chroma_addr);
> +
> +	/* Destination luma and chroma buffers. */
> +
> +	dst_luma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
> +	dst_chroma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
> +
> +	cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
> +	cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> +
> +	cedrus_write(dev, VE_DEC_MPEG_ROT_LUMA, dst_luma_addr);
> +	cedrus_write(dev, VE_DEC_MPEG_ROT_CHROMA, dst_chroma_addr);

It seems that above ROT buffers are not required at all, if (please see next 
comment)

> +
> +	/* Source offset and length in bits. */
> +
> +	cedrus_write(dev, VE_DEC_MPEG_VLD_OFFSET, slice_params->slice_pos);
> +
> +	vld_len = slice_params->slice_len - slice_params->slice_pos;
> +	cedrus_write(dev, VE_DEC_MPEG_VLD_LEN, vld_len);
> +
> +	/* Source beginning and end addresses. */
> +
> +	src_buf_addr = vb2_dma_contig_plane_dma_addr(&run->src->vb2_buf, 0);
> +
> +	reg = VE_DEC_MPEG_VLD_ADDR_BASE(src_buf_addr);
> +	reg |= VE_DEC_MPEG_VLD_ADDR_VALID_PIC_DATA;
> +	reg |= VE_DEC_MPEG_VLD_ADDR_LAST_PIC_DATA;
> +	reg |= VE_DEC_MPEG_VLD_ADDR_FIRST_PIC_DATA;
> +
> +	cedrus_write(dev, VE_DEC_MPEG_VLD_ADDR, reg);
> +
> +	vld_end = src_buf_addr + DIV_ROUND_UP(slice_params->slice_len, 8);
> +	cedrus_write(dev, VE_DEC_MPEG_VLD_END, vld_end);
> +
> +	/* Macroblock address: start at the beginning. */
> +	reg = VE_DEC_MPEG_MBADDR_Y(0) | VE_DEC_MPEG_MBADDR_X(0);
> +	cedrus_write(dev, VE_DEC_MPEG_MBADDR, reg);
> +
> +	/* Clear previous errors. */
> +	cedrus_write(dev, VE_DEC_MPEG_ERROR, 0);
> +
> +	/* Clear correct macroblocks register. */
> +	cedrus_write(dev, VE_DEC_MPEG_CRTMBADDR, 0);
> +
> +	/* Enable appropriate interruptions and components. */
> +
> +	reg = VE_DEC_MPEG_CTRL_IRQ_MASK | VE_DEC_MPEG_CTRL_MC_NO_WRITEBACK |
> +	      VE_DEC_MPEG_CTRL_ROTATE_SCALE_OUT_EN |
> +	      VE_DEC_MPEG_CTRL_MC_CACHE_EN;

... if you remove VE_DEC_MPEG_CTRL_ROTATE_SCALE_OUT_EN. Everything gets still 
correctly decoded. media-codec code for mpeg2 from AW doesn't use that at all. 
I think that VE_DEC_MPEG_CTRL_MC_NO_WRITEBACK flag actually disables rotate/
scale operation.

Best regards,
Jernej

> +
> +	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
> +}
> +
> +static void cedrus_mpeg2_trigger(struct cedrus_ctx *ctx)
> +{
> +	struct cedrus_dev *dev = ctx->dev;
> +	u32 reg;
> +
> +	/* Trigger MPEG engine. */
> +	reg = VE_DEC_MPEG_TRIGGER_HW_MPEG_VLD | VE_DEC_MPEG_TRIGGER_MPEG2 |
> +	      VE_DEC_MPEG_TRIGGER_MB_BOUNDARY;
> +
> +	cedrus_write(dev, VE_DEC_MPEG_TRIGGER, reg);
> +}
> +
> +struct cedrus_dec_ops cedrus_dec_ops_mpeg2 = {
> +	.irq_clear	= cedrus_mpeg2_irq_clear,
> +	.irq_disable	= cedrus_mpeg2_irq_disable,
> +	.irq_status	= cedrus_mpeg2_irq_status,
> +	.setup		= cedrus_mpeg2_setup,
> +	.trigger	= cedrus_mpeg2_trigger,
> +};



