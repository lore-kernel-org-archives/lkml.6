Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D2F21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brWoLpgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfBSRM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:12:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41670 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBSRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:12:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so10677170wrw.8;
        Tue, 19 Feb 2019 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GKN22z+eZt+a0N2z1UgMr5Ee4KDOCGLkvP2W0Q8ZWEA=;
        b=brWoLpgm+NXQTWa5kGhD/XIXdvUZ2+MkAIUXsbKw846DFcsrJBkTf/3IbI+0Vo7IlG
         y7/4lAS3jKBfgOct3JZqKu3/6fpGInwsQXntBhKDypiV3Xlrjifl1X8kRUOmLHQwj3vi
         I91wRMTUDN7FUua9lvyxIdiIUlLBJzn9ZHEc+FbLN7li1ZqkQD2w7XW76IdL8pxr8Kqk
         lkctGbR57IXs5NxpP3ZloLc8sNHPPc9rHboJTCc5o/V2mkcJ6SHTBUC2j7Qi28pdyrW0
         d+HZhsbc0rE4vUhFTiF81JVxwl0gZyBFivvSjWByScOIC+PFbLB6uYxOSh4gIZTfKRE8
         8m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GKN22z+eZt+a0N2z1UgMr5Ee4KDOCGLkvP2W0Q8ZWEA=;
        b=oqjTr1BNKNlNQD0RcOH9te40LFaKc8ohk2xrBGuHmyoft/7vmRBS9PgIq0PDN00/wO
         UDS/OnhlRQ3ueY8qV+1RIPoLex/2/jLgp3jJSqhCsLYx4m8USQejXaqx8zTYbzUfDFJU
         O2kFO/SfQ1U5SHAoy+4YERF+LbQ+ZqGs8tRKx+X07hDbBLIOxeiIyHxdqccvfPpeoVGh
         Bbj5nYws76aPQeQA8+hFDWWF9eA6L8XyNHYhhvACd+sW+QRZKH9YHNjGJ8y39d2VKA/8
         /Cj0dVgPaJuz5bgVD1dIq8FR+V2i89QmAbOpwAok4onV2QLVn58kA7IdoOvaYOp2jrGc
         zSVA==
X-Gm-Message-State: AHQUAuaP3Bnm3L0TzK2I7umHOsjvEa+BJ6OcWffYpXuzIr89No2iE/8t
        5QU5fRrrSLXzfD8ltegWDBo=
X-Google-Smtp-Source: AHgI3IZUQ63uivHupDnWw/8HaaqJdQMKkNCAsnPe8PwoNcE6dsjDUaGaDxNlXgJ1eEPrBsBmA46HJw==
X-Received: by 2002:adf:8447:: with SMTP id 65mr20475202wrf.328.1550596376901;
        Tue, 19 Feb 2019 09:12:56 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id m189sm3067628wmf.7.2019.02.19.09.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 09:12:56 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:12:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, talho@nvidia.com, wsa@the-dreams.de,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V4 2/2] i2c: tegra: remove multi-master support
Message-ID: <20190219171255.GD14351@ulmo>
References: <1550551825-1245-1-git-send-email-skomatineni@nvidia.com>
 <1550551825-1245-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <1550551825-1245-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 08:50:25PM -0800, Sowjanya Komatineni wrote:
> multi-master support is defeatured on Tegra210 and Tegra186 due to
> known bugs.

Nit: "Multi-master" because it's the beginning of a sentence.

>=20
> This patch removes multi-master support for Tegra210 and Tegra186
> i2c hw feature.

Nit: i2c -> I2C, hw -> HW

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index e6851904acc1..26f686bc3491 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -1409,7 +1409,7 @@ static const struct tegra_i2c_hw_feature tegra210_i=
2c_hw =3D {
>  	.clk_divisor_fast_mode =3D 0x19,
>  	.clk_divisor_fast_plus_mode =3D 0x10,
>  	.has_config_load_reg =3D true,
> -	.has_multi_master_mode =3D true,
> +	.has_multi_master_mode =3D false,
>  	.has_slcg_override_reg =3D true,
>  	.has_mst_fifo =3D false,
>  	.quirks =3D &tegra_i2c_quirks,
> @@ -1434,7 +1434,7 @@ static const struct tegra_i2c_hw_feature tegra186_i=
2c_hw =3D {
>  	.clk_divisor_fast_mode =3D 0x19,
>  	.clk_divisor_fast_plus_mode =3D 0x10,
>  	.has_config_load_reg =3D true,
> -	.has_multi_master_mode =3D true,
> +	.has_multi_master_mode =3D false,
>  	.has_slcg_override_reg =3D true,
>  	.has_mst_fifo =3D false,
>  	.quirks =3D &tegra_i2c_quirks,
> --=20
> 2.7.4
>=20

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxsORcACgkQ3SOs138+
s6HCUw/9FoLedx9d+wNnvZGbn/SxVMxrq5MaFIKY1jbBlaa35hM42BkQg7bdVmBE
mAzDLFTX5/V1afIPovDVrN4ZV7sGMsVRsbua51/9lY/tw2AAuDj5qDIdRRBfht2M
iOVqk5uZtbN74t+GAgZbF86QHupzr0z3byd62TvWWsheErhx6y6njyJ2l2VnYVok
VtDxOVH0T2TaFIXoYSXTZ8Tq4/NeJ8b7Q6+Pac/OonkixZ38ltqXnZuq4yiXUF2k
K6RQriy49xl3FNV+PTEKw4p+6RQy4Mn42r2jbKE9dfqONljcBs3Xc+nulkiUwNs0
avUEeD/gdEP1Iv1bYXxnA0TPeg5Ww56xh1x2epy0+OMvzAY5dPfICuSdLmkfupmA
oI7lzPQN5pdu5ihDS0DRfe8BzfjaHCtx6xtyW3Q0AoffClzywE41aPYc2blGu4g7
NW8cmE3rHQGS7qUUqwU1ZlcesIkKFco5gS9gaejSIxdZg0Kvh2mUmfaGKA1S9JnH
qZfx9Cb3fs7jVNzdYme1rBJiq69Lu1e9ofeOCPoovqIcWBSY3X7pS/Ou/eMUjRlu
a7PqJ5FJm7eWzbSqU40hkTM0JjGf/I71rMWKmf03UuDPVb/JWucy5RFIXiz3Mxe3
BiSrYuqx4/2nnJpWHtukVPBetXDNaJe3NrGd/hdWDBGTgEmDop0=
=LvUh
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
