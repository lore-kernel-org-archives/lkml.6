Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4F02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6kfIhSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4F02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbeK1D2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:28:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55876 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbeK1D2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:28:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so22373270wmc.5;
        Tue, 27 Nov 2018 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1vxwY12ZnXna5PNRNOHm0KYChO+Mdkzl895E5hCXDY=;
        b=V6kfIhSMTL4TsFEhyzWFj6cr9r+/BrtjjEVc0qn8NsNfTB9rIX876de18w6vjMYAqn
         n0DP9NpgiHDR8j+JfH7aJxHdIfA+/MiUp5uzogpN3Xi2KEKuMXFREUBafFXMtVpE8Z/k
         ICY01kog/zNMHU2v/VMjgFMAjw2J442AMTna+F+juoRrmKVyXiVzqLYL6LLiFJUjLPNj
         bHn/T+k56f/30oC2uj3/jjjusPHHa2FbwffE6DUuKybWErQJU0c4zOZrLBoZy2xHiU/o
         s9uj4feX+rBvvCt86txw8B/S29ZYOgtAxClOy6OhxoJ09e8UH6wUYUCrQQ0agIT67M88
         GY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1vxwY12ZnXna5PNRNOHm0KYChO+Mdkzl895E5hCXDY=;
        b=M0CGi2SEnUcM/LK8IC6Q7wQsXj496a2s5ZD9aOis6TUYrwr8vh/jhoFoB/eVYb3blY
         0HriFBcN3DmRoVBJznu40t+OrAnU/1FsZDVXSZP3nt42mr2/Loczz7B4sSYazYaU+cO1
         WaDl3R9yTHJUjnJYFTl+CzA0fxqfcGSgbBjC0nEe+TUIUsOWCJdpWWGaDqcT3GN3D2Yz
         /bs1b7eJRONLUXJB3YpKZFi5gkJXvihy/PEa9FTDyOLYuICumjL4WCKC76UL1Y2F+muW
         C57HH8RyWSevWTDHs2/A+2zWP6auwfk//Ub7Hb+iXoa/EeKHv5R3qkvVPaUCjx9B9U0s
         fCUQ==
X-Gm-Message-State: AA+aEWbNouo92Rzk4HmobWhOE2A4H4Jn3Xg0GZgsC2pRlKo+jtaOiJSI
        ehJWtJ7r/NgdP90Ri/PY7lI=
X-Google-Smtp-Source: AFSGD/USsbceCzHgChRgY8bPfMjeJ4aUcMOKPjgmVFRPWR64lJbn/rWi4GzvKM+EDAmwJwSsevQgfw==
X-Received: by 2002:a1c:1f81:: with SMTP id f123mr23129928wmf.64.1543336204630;
        Tue, 27 Nov 2018 08:30:04 -0800 (PST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net. [213.161.8.82])
        by smtp.gmail.com with ESMTPSA id b13sm5327097wrn.28.2018.11.27.08.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:30:02 -0800 (PST)
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH v2 2/2] media: cedrus: Add H264 decoding support
Date:   Tue, 27 Nov 2018 17:30:00 +0100
Message-ID: <6005903.5qHflpuMbl@jernej-laptop>
In-Reply-To: <20181127155028.5ukw3g6zjbnvarbp@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com> <2826880.kP3DS59ZBy@jernej-laptop> <20181127155028.5ukw3g6zjbnvarbp@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 27. november 2018 ob 16:50:28 CET je Maxime Ripard napisal(a):
> Hi Jernej,
>=20
> Thanks for your review!
>=20
> On Sat, Nov 24, 2018 at 09:43:43PM +0100, Jernej =C5=A0krabec wrote:
> > > +enum cedrus_h264_sram_off {
> > > +	CEDRUS_SRAM_H264_PRED_WEIGHT_TABLE	=3D 0x000,
> > > +	CEDRUS_SRAM_H264_FRAMEBUFFER_LIST	=3D 0x100,
> > > +	CEDRUS_SRAM_H264_REF_LIST_0		=3D 0x190,
> > > +	CEDRUS_SRAM_H264_REF_LIST_1		=3D 0x199,
> > > +	CEDRUS_SRAM_H264_SCALING_LIST_8x8	=3D 0x200,
> > > +	CEDRUS_SRAM_H264_SCALING_LIST_4x4	=3D 0x218,
> >=20
> > I triple checked above address and it should be 0x220. For easier
> > implementation later, you might want to add second scaling list address
> > for
> > 8x8 at 0x210. Then you can do something like:
> >=20
> > cedrus_h264_write_sram(dev, CEDRUS_SRAM_H264_SCALING_LIST_8x8_0,
> >=20
> > 			       scaling->scaling_list_8x8[0],
> > 			       sizeof(scaling->scaling_list_8x8[0]));
> >=20
> > cedrus_h264_write_sram(dev, CEDRUS_SRAM_H264_SCALING_LIST_8x8_1,
> >=20
> > 			       scaling->scaling_list_8x8[3],
> > 			       sizeof(scaling->scaling_list_8x8[0]));
> >=20
> > cedrus_h264_write_sram(dev, CEDRUS_SRAM_H264_SCALING_LIST_4x4,
> >=20
> > 			       scaling->scaling_list_4x4,
> > 			       sizeof(scaling->scaling_list_4x4));
> >=20
> > I know that it's not implemented here, just FYI.
>=20
> Ack. I guess I can just leave it out entirely for now, since it's not
> implemented.
>=20
> > > +static void cedrus_fill_ref_pic(struct cedrus_ctx *ctx,
> > > +				struct cedrus_buffer *buf,
> > > +				unsigned int top_field_order_cnt,
> > > +				unsigned int bottom_field_order_cnt,
> > > +				struct cedrus_h264_sram_ref_pic *pic)
> > > +{
> > > +	struct vb2_buffer *vbuf =3D &buf->m2m_buf.vb.vb2_buf;
> > > +	unsigned int position =3D buf->codec.h264.position;
> > > +
> > > +	pic->top_field_order_cnt =3D top_field_order_cnt;
> > > +	pic->bottom_field_order_cnt =3D bottom_field_order_cnt;
> > > +	pic->frame_info =3D buf->codec.h264.pic_type << 8;
> > > +
> > > +	pic->luma_ptr =3D cedrus_buf_addr(vbuf, &ctx->dst_fmt, 0) - PHYS_OF=
=46SET;
> > > +	pic->chroma_ptr =3D cedrus_buf_addr(vbuf, &ctx->dst_fmt, 1) -
> > > PHYS_OFFSET;
> >=20
> > I think subtracting PHYS_OFFSET breaks driver on H3 boards with 2 GiB of
> > RAM. Isn't that unnecessary anyway due to
> >=20
> > dev->dev->dma_pfn_offset =3D PHYS_PFN_OFFSET;
> >=20
> > in cedrus_hw.c?
> >=20
> > This comment is meant for all PHYS_OFFSET subtracting in this patch.
>=20
> PHYS_OFFSET was needed on some older SoCs, and the dma_pfn_offset
> trick wasn't working, I hacked it and forgot about it. I'll try to
> figure it out for the next version.
>=20
> > > +static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
> > > +				   struct cedrus_run *run,
> > > +				   const u8 *ref_list, u8 num_ref,
> > > +				   enum cedrus_h264_sram_off sram)
> > > +{
> > > +	const struct v4l2_ctrl_h264_decode_param *decode =3D
> > > run->h264.decode_param; +	struct vb2_queue *cap_q =3D
> > > &ctx->fh.m2m_ctx->cap_q_ctx.q;
> > > +	struct cedrus_dev *dev =3D ctx->dev;
> > > +	u32 sram_array[CEDRUS_MAX_REF_IDX / sizeof(u32)];
> > > +	unsigned int size, i;
> > > +
> > > +	memset(sram_array, 0, sizeof(sram_array));
> > > +
> > > +	for (i =3D 0; i < num_ref; i +=3D 4) {
> > > +		unsigned int j;
> > > +
> > > +		for (j =3D 0; j < 4; j++) {
> >=20
> > I don't think you have to complicate with two loops here.
> > cedrus_h264_write_sram() takes void* and it aligns to 4 anyway. So as l=
ong
> > input buffer is multiple of 4 (u8[CEDRUS_MAX_REF_IDX] qualifies for tha=
t),
> > you can use single for loop with "u8 sram_array[CEDRUS_MAX_REF_IDX]".
> > This should make code much more readable.
>=20
> This wasn't really about the alignment, but in order to get the
> offsets in the u32 and the array more easily.
>=20
> Breaking out the loop will make that computation less easy on the eye,
> so I guess it's very subjective.
>=20

=46or some strange reason, code below fixes decoding issue from one of my t=
est=20
samples. This is what I actually meant with 1 loop approach:

static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
				   struct cedrus_run *run,
				   const u8 *ref_list, u8 num_ref,
				   enum cedrus_h264_sram_off sram)
{
	const struct v4l2_ctrl_h264_decode_param *decode =3D run->h264.decode_para=
m;
	struct vb2_queue *cap_q =3D &ctx->fh.m2m_ctx->cap_q_ctx.q;
	struct cedrus_dev *dev =3D ctx->dev;
	u8 sram_array[CEDRUS_MAX_REF_IDX];
	unsigned int i;

	memset(sram_array, 0, sizeof(sram_array));
	num_ref =3D min(num_ref, (u8)CEDRUS_MAX_REF_IDX);

	for (i =3D 0; i < num_ref; i++) {
		const struct v4l2_h264_dpb_entry *dpb;
		const struct cedrus_buffer *cedrus_buf;
		const struct vb2_v4l2_buffer *ref_buf;
		unsigned int position;
		int buf_idx;
		u8 dpb_idx;

		dpb_idx =3D ref_list[i];
		dpb =3D &decode->dpb[dpb_idx];

		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
			continue;

		buf_idx =3D vb2_find_tag(cap_q, dpb->tag, 0);
		if (buf_idx < 0)
			continue;

		ref_buf =3D to_vb2_v4l2_buffer(ctx->dst_bufs[buf_idx]);
		cedrus_buf =3D vb2_v4l2_to_cedrus_buffer(ref_buf);
		position =3D cedrus_buf->codec.h264.position;

		sram_array[i] |=3D position << 1;
		if (ref_buf->field =3D=3D V4L2_FIELD_BOTTOM)
			sram_array[i] |=3D BIT(0);
	}

	cedrus_h264_write_sram(dev, sram, &sram_array, num_ref);
}

IMO this code is easier to read.

> > > +			const struct v4l2_h264_dpb_entry *dpb;
> > > +			const struct cedrus_buffer *cedrus_buf;
> > > +			const struct vb2_v4l2_buffer *ref_buf;
> > > +			unsigned int position;
> > > +			int buf_idx;
> > > +			u8 ref_idx =3D i + j;
> > > +			u8 dpb_idx;
> > > +
> > > +			if (ref_idx >=3D num_ref)
> > > +				break;
> > > +
> > > +			dpb_idx =3D ref_list[ref_idx];
> > > +			dpb =3D &decode->dpb[dpb_idx];
> > > +
> > > +			if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > > +				continue;
> > > +
> > > +			buf_idx =3D vb2_find_tag(cap_q, dpb->tag, 0);
> > > +			if (buf_idx < 0)
> > > +				continue;
> > > +
> > > +			ref_buf =3D to_vb2_v4l2_buffer(ctx->dst_bufs[buf_idx]);
> > > +			cedrus_buf =3D vb2_v4l2_to_cedrus_buffer(ref_buf);
> > > +			position =3D cedrus_buf->codec.h264.position;
> > > +
> > > +			sram_array[i] |=3D position << (j * 8 + 1);
> > > +			if (ref_buf->field =3D=3D V4L2_FIELD_BOTTOM)
> >=20
> > You newer set above flag to buffer so this will be always false.
>=20
> As far as I know, the field is supposed to be set by the userspace.

How? I thought that only flags at queueing buffers can be set and there is =
no=20
bottom/top flag.

>=20
> > > +	// sequence parameters
> > > +	reg =3D BIT(19);
> >=20
> > This one can be inferred from sps->chroma_format_idc.
>=20
> I'll look into this
>=20

I'm using this:
reg |=3D (sps->chroma_format_idc & 0x7) << 19;

Although I can't tell if I tested anything else than 1 there (same as it wa=
s=20
before).

> > > +	reg |=3D (sps->pic_width_in_mbs_minus1 & 0xff) << 8;
> > > +	reg |=3D sps->pic_height_in_map_units_minus1 & 0xff;
> > > +	if (sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY)
> > > +		reg |=3D BIT(18);
> > > +	if (sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)
> > > +		reg |=3D BIT(17);
> > > +	if (sps->flags & V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE)
> > > +		reg |=3D BIT(16);
> > > +	cedrus_write(dev, VE_H264_FRAME_SIZE, reg);
> > > +
> > > +	// slice parameters
> > > +	reg =3D 0;
> > > +	/*
> > > +	 * FIXME: This bit marks all the frames as references. This
> > > +	 * should probably be set based on nal_ref_idc, but the libva
> > > +	 * doesn't pass that information along, so this is not always
> > > +	 * available. We should find something else, maybe change the
> > > +	 * kernel UAPI somehow?
> > > +	 */
> > > +	reg |=3D BIT(12);
> >=20
> > I really think you should use nal_ref_idc here as it is in specificatio=
n.=20
> > You can still fake the data from libva backend. I don't think that any
> > driver needs this for anything else than check if it is 0 or not.
>=20
> Yeah, Tomasz suggested the same thing as a reply to the cover letter,
> I'll change that in the next version.
>=20
> > > +	reg |=3D (slice->slice_type & 0xf) << 8;
> > > +	reg |=3D slice->cabac_init_idc & 0x3;
> > > +	reg |=3D BIT(5);
> > > +	if (slice->flags & V4L2_H264_SLICE_FLAG_FIELD_PIC)
> > > +		reg |=3D BIT(4);
> > > +	if (slice->flags & V4L2_H264_SLICE_FLAG_BOTTOM_FIELD)
> > > +		reg |=3D BIT(3);
> > > +	if (slice->flags & V4L2_H264_SLICE_FLAG_DIRECT_SPATIAL_MV_PRED)
> > > +		reg |=3D BIT(2);
> > > +	cedrus_write(dev, VE_H264_SLICE_HDR, reg);
> > > +
> > > +	reg =3D 0;
> >=20
> > You might want to set bit 12 here, which enables active reference pictu=
re
> > override. However, I'm not completely sure about that.
>=20
> Did you find some videos that were broken because of this?

No, not really. That's why I don't really know if it is needed or not.

Best regards,
Jernej



