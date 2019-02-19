Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746292147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdF+6IPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfBSRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:11:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38595 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfBSRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:11:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so22819282wrw.5;
        Tue, 19 Feb 2019 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eb9sKW83PvEOjV96+UYTiuJzgdWEEFcneFSMc9HKh6Q=;
        b=KdF+6IPB0/vaC7PZdNDNUxJznzoqnQikWAYP1J05zYkl24Nms/rPOZ3hV8LGjARU8B
         6QFIf7A8EU9IKaIBs/TKwmHZ+xJ7HBuIkhwdHVwPuFldCajVMHHQallSVDgCFyQ4mz+B
         UjvMItzVfYSHIwXQ3XGk64m24jnEf3kjQJx1F7sP8GZLInRcQZ1CEk+6Mi5Eqof75HPF
         tRcWZXIn6aVLulYYLSVsIKBu1ZSiZrO6UfACWNe4b/Svmv0EbC6tRJH/WXo3llLVZGSK
         fPuHfR027vBntuZkLqyhvVJ9qtFHjDysAED6gm6+x5Iu9d9uAXGmDDfuwcXiLdxs87q/
         6D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eb9sKW83PvEOjV96+UYTiuJzgdWEEFcneFSMc9HKh6Q=;
        b=P4AIWNobFvlq3w0emVfDI/v9Ar32Unv4BVkTB3fmr2OKlGVip27v+ud5IOSNLmTOkg
         9khgN6gFXgdWWuLpw7z86TC6CiML1twJFb6lbNUt4Our3O6QvJStMYGu8YE0Qk6XQBNk
         5yl6fOHOVSACMQfHmpGTl2Xe8G7BFh7NybRBfGf4TOdRufS4IasxfYbbrwmUK7Se3N2p
         8bwq8WpDVMDJxFuB8G888gmHHr+0+DVsc5KH3gfvjHz/ZLWjb3NQHUlrCM97VepC9jC4
         Z9YXGDX9eoZQwAPO1DCznOYv4UIPkvbHAuNrC6p3qla2lC3TMwHQ3LrbpWsOPqXOvh9P
         AMxw==
X-Gm-Message-State: AHQUAuafGsvrnsXbfXmmwuH3KKb7Pg1RcLuifzMfA/QORsTNnfYYan9+
        qVb9vseNKFGND/9DLslgHZ1uXDIU
X-Google-Smtp-Source: AHgI3IZJyClzmwEJPooLTNYfKiUfgfEelc0Ma8mNmMNxb73mDN5pnb2Uz2AfyYUG0twdl8koqUB6Wg==
X-Received: by 2002:a5d:620f:: with SMTP id y15mr3180865wru.101.1550596299460;
        Tue, 19 Feb 2019 09:11:39 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id d2sm8775982wrq.94.2019.02.19.09.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 09:11:38 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:11:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, talho@nvidia.com, wsa@the-dreams.de,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V4 1/2] i2c: tegra: remove master fifo support on tegra186
Message-ID: <20190219171137.GC14351@ulmo>
References: <1550551825-1245-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <1550551825-1245-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 08:50:24PM -0800, Sowjanya Komatineni wrote:
> Tegra186 does not have master fifo control register and instead
> uses fifo control register like prior tegra chipset.
>=20
> This patch fixes this and prevents crashing during boot when
> accessing fifo control registers.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nit: fifo -> FIFO, tegra -> Tegra, but other than that:

Acked-by: Thierry Reding <treding@nvidia.com>

A quick note on why I'm pointing out these capitalization issues so
pedantically: specifically in the "tegra" case, it's difficult to grep
for it because it matches things like "integration", which is a
surprisingly common word in the kernel. Spelling it "Tegra" consistently
make it easier to grep for Tegra related bits specifically.

Thierry

> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index a4cd79c9f7a7..e6851904acc1 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -1436,7 +1436,7 @@ static const struct tegra_i2c_hw_feature tegra186_i=
2c_hw =3D {
>  	.has_config_load_reg =3D true,
>  	.has_multi_master_mode =3D true,
>  	.has_slcg_override_reg =3D true,
> -	.has_mst_fifo =3D true,
> +	.has_mst_fifo =3D false,
>  	.quirks =3D &tegra_i2c_quirks,
>  	.supports_bus_clear =3D true,
>  	.has_apb_dma =3D false,
> --=20
> 2.7.4
>=20

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxsOMkACgkQ3SOs138+
s6EqNw//bxDRgxqyHkMs4N9WNHcZAIdO+ujyfXMbvXWpjBQsXg+Dt0M6tbEdTWDC
SaIYPvsKQL4t+pv+oBDB7VMq8Mbi/Yvnf2DXLAy1Dh0sX5OcxRhFVoW8IxiBadiT
wbMDaQ2tP78474uGWajEpFzTvXaWBt/BzGOneu9id/YzTFIzmz8/dZlzVFoviUXN
4SYqwRw4jUARTm1omPZgeumXAe+QM1o2N/kPV0LXssIN3lCqI2/4jTVSjWKI+4jO
K7jFElptI/SD947jvynWP7VXL23XVLDbJaqeXl5E57R92u9h8jfPXDukch2z5tSf
ASSb0dzqHxupcTZTLU154cxcWeTHAhPxpIWfurWOkvfnPGmSLgdjOmJHPOJQ2Oq7
42xZEatlgsHhvYFID2kDl0hKM4fN9TlafeivZC5AGUtovkG83o4LFXAiv379ohrm
Ffjrbjrm3ahwfQPjDucJvyCfy++VOezflcLQ8HzC6sDNhikt6xDDBBKgPx7bcQ4m
PacotdS/wqPcl6cBhuaTmgB9VQY2uHq6OntOuAhMjXC99hWCvphGjEMaK1XvGTFK
WzSF4ZR7EWuN1T0WbE9Cg/3KfEIMUTV1SThzsRzG7xkmgTJzdMHmdc6my2i6tA+T
MixVNqd1NS/nBPy0TsceQeKRRXz+DlOGob97p/jrTttHukn5uT8=
=pZA7
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
