Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67384C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2791D2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBigg9Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2791D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeKXLVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:21:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38291 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbeKXLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:21:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so12062748qtl.5;
        Fri, 23 Nov 2018 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IEWXOl1MYbwRFC09jkUW59qSOC1AMKcWJWbpyk31RbU=;
        b=WBigg9Mjd7bNMHMSualHy7t1x3eeIiyTTcrKeQ5nPqeHGyVWLDhtx4v8sHYUmAlBPL
         3hCFohyIcJRJYNqkDaYunokxT2K+sRVi5WUcccPtlVWAN64aqw37b5Pp/m7zg6DtBsyQ
         WaF00+nFUfYwjSz70yhJFaMda+ObkuzipkkUYhVTCWF/aKYuf4P3IJfeq8SDiGYt9xr+
         rQsR6uzSEQkJ1QMOpKKFMJeStx2Yl4C1lwvouG+XsT5t2j4/9mTqh8ruFbipxomZG/wZ
         91JDAiIbONwvCSY5JnAIisbf8DJjr18gVEBrTV9mdwh4UwUxeHgdcJsCmr5jJp8VLaRz
         yqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IEWXOl1MYbwRFC09jkUW59qSOC1AMKcWJWbpyk31RbU=;
        b=bkc2EcLPCmtTaKhDmeZ8qIXdxsvbeoWh1ZokI1UkGfjjo6qAvjlhupaU1d7RymkMvP
         pgZ8HT49mEGcLXN4YHCfC7N6r1bmR4t6pWHkOCtMdMNwwuoQ7zElFz6z9fIObeSyCFv6
         iokomy+/ix6cYKdcEdv/V4FaxORCBeizemqruBRajpyDbhd2dk2GqME4f3dZFPb0WsjT
         NIbGX669+E/rU8vPVIcQktSb20ruMJK3HhHuz3MjfuqDDas7BKu/GEQU6tokbhuDGAql
         YbmGpu6o4J6s4TEb7NDL2f2d5VmltRLJhfriq6RQAozgJdqMdTLp6l20qry5/K7xqK8/
         PZ3w==
X-Gm-Message-State: AA+aEWaXv3yAZI6HMiYF+ife2y66n05E5enHDZT178/xZXs5RmxhG42f
        HFmvIbMj+fbVsjBaihbdNTU=
X-Google-Smtp-Source: AFSGD/VJg30LKrOeXjHAXmskqDc/sb1KuQIeRgXXiPshvJtBdp4Sk/n4Nls1efueQ93OXLKcnAl/Xg==
X-Received: by 2002:a0c:b786:: with SMTP id l6mr17275947qve.244.1543019723154;
        Fri, 23 Nov 2018 16:35:23 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v10sm20222045qkb.57.2018.11.23.16.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 16:35:22 -0800 (PST)
Date:   Fri, 23 Nov 2018 22:35:18 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: finalized device-tree support
Message-ID: <20181124003518.6heacjyxuwh6l32y@smtp.gmail.com>
References: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a37eh5f7bmtphsys"
Content-Disposition: inline
In-Reply-To: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a37eh5f7bmtphsys
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

I believe that a proper commit message for this patch could be something
like "Add device tree support".

On 11/23, Marcelo Schmitt wrote:
> Added a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to complete device-tree support for this
> driver.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/st=
aging/iio/impedance-analyzer/ad5933.c
> index edb8b540bbf1..19e8b6d2865c 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] =3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, ad5933_id);
> =20
> +static const struct of_device_id ad5933_of_match[] =3D {
> +	{ .compatible =3D "analog-devices,ad5933" },
> +	{ .compatible =3D "analog-devices,ad5934" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
>  static struct i2c_driver ad5933_driver =3D {
>  	.driver =3D {
>  		.name =3D "ad5933",
> +		.of_match_table =3D ad5933_of_match,
>  	},
>  	.probe =3D ad5933_probe,
>  	.remove =3D ad5933_remove,
> --=20
> 2.17.1
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kernel-usp/20181123235159.hh43xnvvwsil4on2%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

--=20
Rodrigo Siqueira
https://siqueira.tech
https://twitter.com/siqueirajordao
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--a37eh5f7bmtphsys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlv4nMUACgkQWJzP/com
vP8KCg//auRaWyCY+ySHog5NMcujjY9e19krbXNQ0vj0mLQ3spLEtZrRxvMA6p/p
6mEkK0MPvOUn2gpnQeoFgIWwnVM6XTYqG4quYKrbux/eHlfPa+udtwYNSl0nBGsU
PvUjZWCS0BGe+mZObVi49EXRBfw6lTdPZ4E8SMygueq26G4oAvcYRKxtoX3BDtZE
m3zWz50TIVcTmG/SpCsELWzfBNqmU9RGHm5wDBM6cIErHvnIUqJQvUMoFIRFCg8t
EngBomPyTsDwuteLm7hJy3pmGbtalJOWqfeFVaCpNKL4cAJw0DpEUJqCmbIj8Oy1
aisKyM/Dby5hyrB6fD2QwYib7FYGPcNpjpHl+net5dz+lyjFHKWU+Y1nodQpD9EU
RQ3nVrg6ciPQsjCI97uqop72K6bDYPnYcJQls+6BPfhCW7QUCVDsGOwMiiY8eF0w
a3bDyAeF1AhJz6UPtEJgYbSIP/0iMmLMFqbx09TCJckQaO+E5rpuNzDWcMQrmWLn
cWb7fdHvVPt/gUtnPRzdSh1XT3PKh2MgDeYrV7+7o+7P0SDvu3VOomKRKPCSwjCF
0n4dRM4iZSRvApB6wTJUdlw7GReARe9FiB7NLnWGlGk1Lrr2yDexdXSlhcbipLTk
tT+vPMK235PI3S0uO636ms5VqqoGlemt3JFlSIaNzpAcBKnb1LE=
=xl0V
-----END PGP SIGNATURE-----

--a37eh5f7bmtphsys--
