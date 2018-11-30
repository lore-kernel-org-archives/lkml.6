Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA10C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE56420834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhVCMlUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE56420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLAFGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:06:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45832 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:06:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so6092160wrr.12;
        Fri, 30 Nov 2018 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJwlbZ5/IVbG7qJZyxGIp6mcgd52AsxLmPe3hosBGK8=;
        b=GhVCMlUuTVQvnwqHK2dl2lgPFzulkLtGYY/7IRdEvh7LDzunHNe8w9JzG+Z7Vfl4nu
         qS7Ae3q3KgMKsAP2nKyMnREuilIq7q4A25mCMr9+XMVp7LyJwSyzMq8MDQifDsqLEcjB
         fc6+yjOLoK+xN6m4Ou2VKVsboE7vz6g20srjeH5RHd6BByyZrUvgEmzQP6/i1k+SvvYv
         Vjv/rJwdC9ovtc5b4nl3VKcjaNEodwJQFiU4k5q+r/FXifudbrTgkhZ69QONAwGUN2kW
         +vGySR5uduoWzgaH4ZpBMQAMd6QCBbf5yVN1jbxSBbeTgg0LBC1eHcuwzOogrNW6VwXs
         dsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJwlbZ5/IVbG7qJZyxGIp6mcgd52AsxLmPe3hosBGK8=;
        b=GAFQFMveP69ahvNeo1go45IZICdv0nruYS6gl1gt1IqWHbw2bfySv5lm7MJJVliZYJ
         xyxdaNj6YaQN9eaNYyl5doapsZg+dEPbPWa/y20qg7Dhpp+Yh/cBdBuQyiI5/Y0MshdY
         ON3/BEZiiCAOVivrZAOmvNt/Y6QrvVtKHA5Qe7RqdS8jHl8F5NZHuUXECUWuNx2fFDts
         mQzDxzdg0b64LvRYsKf4iy6UZIG14UQDhoI15TFKxTD6Xjvll8orr63kbk4BSLEkzlgj
         9fYYisZu/IHhoMrX4+WHmQaSUUvU2shse2R3I4VhHo46sCjC/Px+dkbG9eCelsZqmQlf
         Fplg==
X-Gm-Message-State: AA+aEWaMX1BVujVdRjcMbeK+tKba5oepuM0r6yeRX9QCC/SIM9c51AVI
        o8IIDfgqUoikjDZlpy4RO/Q=
X-Google-Smtp-Source: AFSGD/Xga8woUe0LMkNNov4HI35xPEH+122K6osDQvasw8KOhuOMZdSRm/FG+/hBIrf2gsh1xKMCzA==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr6053904wrn.27.1543600604979;
        Fri, 30 Nov 2018 09:56:44 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id s66sm5890057wmf.34.2018.11.30.09.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:56:43 -0800 (PST)
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
Date:   Fri, 30 Nov 2018 18:56:41 +0100
Message-ID: <2869850.yJDP4l804T@jernej-laptop>
In-Reply-To: <20181130073047.auafqe3rzdqfs32d@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com> <6005903.5qHflpuMbl@jernej-laptop> <20181130073047.auafqe3rzdqfs32d@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 30. november 2018 ob 08:30:47 CET je Maxime Ripard napisal(a):
> On Tue, Nov 27, 2018 at 05:30:00PM +0100, Jernej =C5=A0krabec wrote:
> > > > > +static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
> > > > > +				   struct cedrus_run *run,
> > > > > +				   const u8 *ref_list, u8 num_ref,
> > > > > +				   enum cedrus_h264_sram_off sram)
> > > > > +{
> > > > > +	const struct v4l2_ctrl_h264_decode_param *decode =3D
> > > > > run->h264.decode_param; +	struct vb2_queue *cap_q =3D
> > > > > &ctx->fh.m2m_ctx->cap_q_ctx.q;
> > > > > +	struct cedrus_dev *dev =3D ctx->dev;
> > > > > +	u32 sram_array[CEDRUS_MAX_REF_IDX / sizeof(u32)];
> > > > > +	unsigned int size, i;
> > > > > +
> > > > > +	memset(sram_array, 0, sizeof(sram_array));
> > > > > +
> > > > > +	for (i =3D 0; i < num_ref; i +=3D 4) {
> > > > > +		unsigned int j;
> > > > > +
> > > > > +		for (j =3D 0; j < 4; j++) {
> > > >=20
> > > > I don't think you have to complicate with two loops here.
> > > > cedrus_h264_write_sram() takes void* and it aligns to 4 anyway. So =
as
> > > > long
> > > > input buffer is multiple of 4 (u8[CEDRUS_MAX_REF_IDX] qualifies for
> > > > that),
> > > > you can use single for loop with "u8 sram_array[CEDRUS_MAX_REF_IDX]=
".
> > > > This should make code much more readable.
> > >=20
> > > This wasn't really about the alignment, but in order to get the
> > > offsets in the u32 and the array more easily.
> > >=20
> > > Breaking out the loop will make that computation less easy on the eye,
> > > so I guess it's very subjective.
> >=20
> > For some strange reason, code below fixes decoding issue from one of my
> > test
> > samples. This is what I actually meant with 1 loop approach:
> Do you have that test sample somewhere accessible?

yes, it's here:
http://jernej.libreelec.tv/videos/h264/Star%20Wars%20Episode%20VII%20-%20Th=
e%20Force%20Awakens%20-%20Teaser%20Trailer%202.mp4

It needs also prediction weight tables (your early patch for that should wo=
rk=20
ok) and scaling list (code I sent you in one of the previous comments shoul=
d=20
work).

=46or me, if this sample worked without issue, every other non-interlaced s=
ample=20
worked too.

>=20
> > static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
> >=20
> > 				   struct cedrus_run *run,
> > 				   const u8 *ref_list, u8 num_ref,
> > 				   enum cedrus_h264_sram_off sram)
> >=20
> > {
> >=20
> > 	const struct v4l2_ctrl_h264_decode_param *decode =3D
> > 	run->h264.decode_param;
> > 	struct vb2_queue *cap_q =3D &ctx->fh.m2m_ctx->cap_q_ctx.q;
> > 	struct cedrus_dev *dev =3D ctx->dev;
> > 	u8 sram_array[CEDRUS_MAX_REF_IDX];
> > 	unsigned int i;
> > =09
> > 	memset(sram_array, 0, sizeof(sram_array));
> > 	num_ref =3D min(num_ref, (u8)CEDRUS_MAX_REF_IDX);
> > =09
> > 	for (i =3D 0; i < num_ref; i++) {
> > =09
> > 		const struct v4l2_h264_dpb_entry *dpb;
> > 		const struct cedrus_buffer *cedrus_buf;
> > 		const struct vb2_v4l2_buffer *ref_buf;
> > 		unsigned int position;
> > 		int buf_idx;
> > 		u8 dpb_idx;
> > 	=09
> > 		dpb_idx =3D ref_list[i];
> > 		dpb =3D &decode->dpb[dpb_idx];
> > 	=09
> > 		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > 	=09
> > 			continue;
> > 	=09
> > 		buf_idx =3D vb2_find_tag(cap_q, dpb->tag, 0);
> > 		if (buf_idx < 0)
> > 	=09
> > 			continue;
> > 	=09
> > 		ref_buf =3D to_vb2_v4l2_buffer(ctx->dst_bufs[buf_idx]);
> > 		cedrus_buf =3D vb2_v4l2_to_cedrus_buffer(ref_buf);
> > 		position =3D cedrus_buf->codec.h264.position;
> > 	=09
> > 		sram_array[i] |=3D position << 1;
> > 		if (ref_buf->field =3D=3D V4L2_FIELD_BOTTOM)
> > 	=09
> > 			sram_array[i] |=3D BIT(0);
> > =09
> > 	}
> > =09
> > 	cedrus_h264_write_sram(dev, sram, &sram_array, num_ref);
> >=20
> > }
> >=20
> > IMO this code is easier to read.
>=20
> INdeed, thanks!
>=20
> > > > > +			const struct v4l2_h264_dpb_entry *dpb;
> > > > > +			const struct cedrus_buffer *cedrus_buf;
> > > > > +			const struct vb2_v4l2_buffer *ref_buf;
> > > > > +			unsigned int position;
> > > > > +			int buf_idx;
> > > > > +			u8 ref_idx =3D i + j;
> > > > > +			u8 dpb_idx;
> > > > > +
> > > > > +			if (ref_idx >=3D num_ref)
> > > > > +				break;
> > > > > +
> > > > > +			dpb_idx =3D ref_list[ref_idx];
> > > > > +			dpb =3D &decode->dpb[dpb_idx];
> > > > > +
> > > > > +			if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > > > > +				continue;
> > > > > +
> > > > > +			buf_idx =3D vb2_find_tag(cap_q, dpb->tag, 0);
> > > > > +			if (buf_idx < 0)
> > > > > +				continue;
> > > > > +
> > > > > +			ref_buf =3D to_vb2_v4l2_buffer(ctx->dst_bufs[buf_idx]);
> > > > > +			cedrus_buf =3D vb2_v4l2_to_cedrus_buffer(ref_buf);
> > > > > +			position =3D cedrus_buf->codec.h264.position;
> > > > > +
> > > > > +			sram_array[i] |=3D position << (j * 8 + 1);
> > > > > +			if (ref_buf->field =3D=3D V4L2_FIELD_BOTTOM)
> > > >=20
> > > > You newer set above flag to buffer so this will be always false.
> > >=20
> > > As far as I know, the field is supposed to be set by the userspace.
> >=20
> > How? I thought that only flags at queueing buffers can be set and there=
 is
> > no bottom/top flag.
>=20
> https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/buffer.html#c.v4l2_bu=
ffe
> r
>=20
> "Indicates the field order of the image in the buffer, see
> v4l2_field. This field is not used when the buffer contains VBI
> data. Drivers must set it when type refers to a capture stream,
> applications when it refers to an output stream."
>=20
> My understanding is that the application should set it, since we'll
> use the output stream's buffer here. But I might very well be wrong
> about it :/

I'll take a look, thanks.

Best regards,
Jernej



