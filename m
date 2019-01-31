Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E16CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9AE2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TmPstpLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfAaX1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:27:17 -0500
Received: from ozlabs.org ([203.11.71.1]:35075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfAaX1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:27:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rGbj4SgVz9s4Z;
        Fri,  1 Feb 2019 10:27:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548977233;
        bh=kmMrJrfSeHBcL143C0AFidOvv2G9Z/fr+PerbxyjfQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TmPstpLKoi12vRWq7iAWeIYzel4wZQztm6Hy2UuQw51FeWu2veC4aflSPDLe0hINq
         OTvKw2xim2yp6W6zl7ko7A+wszZNI2noLyGEX5tJeavfmzxWmGxfF8JE+18HnJVETy
         7gTJWDxK+g9We96VyQFUBtmx7Rpbj2SaCsUaPqOCCe3WLMgmyPSzWBnCIZg1inrmHt
         vER5MfnGCuUJOr1WHlvBShrUtIWWbR/mdTrcWBKfPBXMTffAeefad18tUwNceDuhQz
         hOSP6OETaqiE8ZAWCZKE9FhAzdBU4+sPjv3xFEw/cZfSMlE52GQIFC/R1d0wttD4xZ
         MaWve4Mp9lI1w==
Date:   Fri, 1 Feb 2019 10:27:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: linux-next: manual merge of the v4l-dvb tree with Linus' tree
Message-ID: <20190201102713.4c490de4@canb.auug.org.au>
In-Reply-To: <20190201102233.4643f528@canb.auug.org.au>
References: <20190201102233.4643f528@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hLAhYLqJ32CnJYmwQxFWBMT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hLAhYLqJ32CnJYmwQxFWBMT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Feb 2019 10:22:33 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the v4l-dvb tree got a conflict in:
>=20
>   drivers/media/platform/vim2m.c
>=20
> between commit:
>=20
>   240809ef6630 ("media: vim2m: only cancel work if it is for right contex=
t")
>=20
> from Linus' tree and commit:
>=20
>   b3e64e5b0778 ("media: vim2m: use per-file handler work queue")
>=20
> from the v4l-dvb tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> diff --cc drivers/media/platform/vim2m.c
> index 89d9c4c21037,e31c14c7d37f..000000000000
> --- a/drivers/media/platform/vim2m.c
> +++ b/drivers/media/platform/vim2m.c
> @@@ -806,10 -904,7 +904,9 @@@ static void vim2m_stop_streaming(struc
>   	struct vb2_v4l2_buffer *vbuf;
>   	unsigned long flags;
>  =20
>  -	cancel_delayed_work_sync(&ctx->work_run);
>  +	if (v4l2_m2m_get_curr_priv(dev->m2m_dev) =3D=3D ctx)
> - 		cancel_delayed_work_sync(&dev->work_run);
> ++		cancel_delayed_work_sync(&ctx->work_run);
>  +
>   	for (;;) {
>   		if (V4L2_TYPE_IS_OUTPUT(q->type))
>   			vbuf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);

Well, that wasn't right, so instead I just effectively reverted the
commit from Linus' tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/hLAhYLqJ32CnJYmwQxFWBMT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxThFEACgkQAVBC80lX
0GyJQAf/TBZGTgKm2pqNXLG7G5nEfgLYsN0RnIbQcGjgesJIbjjsqprPuNpAyTp2
8K1ePWvR4TkVna4xerbYBDCRo42vpJJxBTIJfyQShGmhliPnple+SMZNoWH/1jZE
kq/jRXjVepGVwr21Nt0Vtyz41XPCtGmSecfPDM8DRQHV7kZaAae8Izu/MqW2lnSC
tDYp92NZyTJKQj0kpcfYf7wMv1Ip4hTXahFbhHzPrb4FsuH6CvIK6wS2tA96J5Cg
YVpu+YYjBBKWezJFLVUnNwUjQMcoMSzfbpNL/sWGgTOj4ksXzOZ/B5YjNQNq1ZUm
Lt9SEHV53Xpy7SysLno/XtJMBDR+BA==
=CiFi
-----END PGP SIGNATURE-----

--Sig_/hLAhYLqJ32CnJYmwQxFWBMT--
