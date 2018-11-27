Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C57C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CDA20659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgbAygGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CDA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeK1EVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:21:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52439 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbeK1EVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:21:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so22577446wmb.2;
        Tue, 27 Nov 2018 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQAGrI12brA3Wd7D87+OXKGvAaSFouSDn1ZyPAJIYIo=;
        b=lgbAygGkJj0xdVpVYd8uCRqPuJZQbQtZ8X0U5VtNr1ky3AnAsyxPRBsf04KVqmx1Uc
         xWxaY31PPOec6k/6L4zy1M2AfCGq4gobWQQ6T+8b6rlNNvOD+lILc4KGU4cMv8JiD0TE
         /keUwTnjoEYZd24IwmlbPYLwU4r/NpS4RLDFgPee5YJctvSy8eKtd1e9Co5AcswCn78c
         LeE6Hj1p+6C0cXRW60WIf2qEbD5zRVM9ArT07XZZ140ULl7aNTgLDRiykWnnc/AnDfFA
         44h7qQtszxbCKuco+NOQlBsDelkZybSOJgSGA8J2fhuXFXcZ+pf36VygoEWkZEPpN0XW
         qoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQAGrI12brA3Wd7D87+OXKGvAaSFouSDn1ZyPAJIYIo=;
        b=UiLiSTeNDvkLQpr6thMAwY2NEyM3aLCAquN4RhrdLauyXqlBa+CnL2UblMTKnCdUi4
         zQzvhXHD6+wy5xa09a6KOphtZswzNZvzz9UY3t3bNhlO2k9LDJOHL2xYjN8LiZEyGaQk
         ZFqmlZm69G0k1CSg080W1PGyWJcjkr4iMl9kt9jqti1PMUXaj1MeyvTPtWOKK8DuYffY
         jI5AIcH/5gAC6iduL7HNrPDZG4M448EqEklZOO1DjKVNZKl48iX5rNyHp+lKLUXFI7A1
         G3wYlyHzOJ4Xo0LVtOP6CS1IuAQx8dh7reSzvJf69SdPyrUlFCNbUQM7YSeH1KCy5EFk
         YnFQ==
X-Gm-Message-State: AGRZ1gJ3wwmuDSNUM8zDPM+hoRIA2z3EF7TEUuiMHPt8v1+6JHOdLfRN
        3FtUCDBnJ4AbAsvaydwswNY=
X-Google-Smtp-Source: AJdET5dVEG2XdClKpiUyUR2C3lER7mKDmNCC8tyaiNdLmPFOZ46iChKQyzZcZ9WDU+hf1Le2Ttw8hw==
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr28321627wma.92.1543339393688;
        Tue, 27 Nov 2018 09:23:13 -0800 (PST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net. [213.161.8.82])
        by smtp.gmail.com with ESMTPSA id q12sm3715966wrx.31.2018.11.27.09.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 09:23:12 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API compound controls.
Date:   Tue, 27 Nov 2018 18:23:10 +0100
Message-ID: <2123591.3TCVFQjlgd@jernej-laptop>
In-Reply-To: <20181115145650.9827-2-maxime.ripard@bootlin.com>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com> <20181115145650.9827-2-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne =C4=8Detrtek, 15. november 2018 ob 15:56:49 CET je Maxime Ripard napisa=
l(a):
> From: Pawel Osciak <posciak@chromium.org>
>=20
> Stateless video codecs will require both the H264 metadata and slices in
> order to be able to decode frames.
>=20
> This introduces the definitions for a new pixel format for H264 slices th=
at
> have been parsed, as well as the structures used to pass the metadata from
> the userspace to the kernel.
>=20
> Co-Developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/media/uapi/v4l/biblio.rst       |   9 +
>  .../media/uapi/v4l/extended-controls.rst      | 364 ++++++++++++++++++
>  .../media/uapi/v4l/pixfmt-compressed.rst      |  20 +
>  .../media/uapi/v4l/vidioc-queryctrl.rst       |  30 ++
>  .../media/videodev2.h.rst.exceptions          |   5 +
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  42 ++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
>  include/media/v4l2-ctrls.h                    |  10 +
>  include/uapi/linux/v4l2-controls.h            | 166 ++++++++
>  include/uapi/linux/videodev2.h                |  11 +
>  10 files changed, 658 insertions(+)
>=20

<snip>

> @@ -1156,4 +1164,162 @@ struct v4l2_ctrl_mpeg2_quantization {
>  	__u8	chroma_non_intra_quantiser_matrix[64];
>  };
>=20
> +/* Compounds controls */
> +
> +#define V4L2_H264_SPS_CONSTRAINT_SET0_FLAG			0x01
> +#define V4L2_H264_SPS_CONSTRAINT_SET1_FLAG			0x02
> +#define V4L2_H264_SPS_CONSTRAINT_SET2_FLAG			0x04
> +#define V4L2_H264_SPS_CONSTRAINT_SET3_FLAG			0x08
> +#define V4L2_H264_SPS_CONSTRAINT_SET4_FLAG			0x10
> +#define V4L2_H264_SPS_CONSTRAINT_SET5_FLAG			0x20

How are these constraint flags meant to be used?

> +
> +#define V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE		0x01
> +#define V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS	0x02
> +#define V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO		0x04
> +#define V4L2_H264_SPS_FLAG_GAPS_IN_FRAME_NUM_VALUE_ALLOWED	0x08
> +#define V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY			0x10
> +#define V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD		0x20
> +#define V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE			0x40
> +
> +struct v4l2_ctrl_h264_sps {
> +	__u8 profile_idc;
> +	__u8 constraint_set_flags;
> +	__u8 level_idc;
> +	__u8 seq_parameter_set_id;
> +	__u8 chroma_format_idc;
> +	__u8 bit_depth_luma_minus8;
> +	__u8 bit_depth_chroma_minus8;
> +	__u8 log2_max_frame_num_minus4;
> +	__u8 pic_order_cnt_type;
> +	__u8 log2_max_pic_order_cnt_lsb_minus4;
> +	__u8 max_num_ref_frames;
> +	__u8 num_ref_frames_in_pic_order_cnt_cycle;
> +	__s32 offset_for_ref_frame[255];
> +	__s32 offset_for_non_ref_pic;
> +	__s32 offset_for_top_to_bottom_field;
> +	__u16 pic_width_in_mbs_minus1;
> +	__u16 pic_height_in_map_units_minus1;
> +	__u8 flags;
> +};
> +
> +#define V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE				0x0001
> +#define V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT	0x0002
> +#define V4L2_H264_PPS_FLAG_WEIGHTED_PRED				0x0004
> +#define V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT		0x0008
> +#define V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED			0x0010
> +#define V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT			0x0020
> +#define V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE				0x0040
> +#define V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT			0x0080
> +
> +struct v4l2_ctrl_h264_pps {
> +	__u8 pic_parameter_set_id;
> +	__u8 seq_parameter_set_id;
> +	__u8 num_slice_groups_minus1;
> +	__u8 num_ref_idx_l0_default_active_minus1;
> +	__u8 num_ref_idx_l1_default_active_minus1;
> +	__u8 weighted_bipred_idc;
> +	__s8 pic_init_qp_minus26;
> +	__s8 pic_init_qs_minus26;
> +	__s8 chroma_qp_index_offset;
> +	__s8 second_chroma_qp_index_offset;
> +	__u8 flags;
> +};
> +
> +struct v4l2_ctrl_h264_scaling_matrix {
> +	__u8 scaling_list_4x4[6][16];
> +	__u8 scaling_list_8x8[6][64];
> +};
> +
> +struct v4l2_h264_weight_factors {
> +	__s8 luma_weight[32];
> +	__s8 luma_offset[32];
> +	__s8 chroma_weight[32][2];
> +	__s8 chroma_offset[32][2];
> +};

Regarding weight type __s8 - isn't too small just a bit?

ITU-T Rec. H264 (05/2003) says that this field has value between -128 to 12=
7 if=20
weight flag is set. That fits perfectly. However, when weight flag is 0, de=
fault=20
value is 2^luma_log2_weight_denom (for example). luma_log2_weight_denom can=
=20
have values between 0 and 7, which means that weight will have values from =
1=20
to 128. That is just slightly over the max value for __s8.

__s8 is fine for offsets, though.

Best regards,
Jernej

> +
> +struct v4l2_h264_pred_weight_table {
> +	__u8 luma_log2_weight_denom;
> +	__u8 chroma_log2_weight_denom;
> +	struct v4l2_h264_weight_factors weight_factors[2];
> +};



