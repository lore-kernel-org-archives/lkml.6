Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F09C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C555218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ud1QPlzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbfAaMpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:45:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35444 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbfAaMpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:45:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2452940wmt.0;
        Thu, 31 Jan 2019 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OdwE/LdElt/BizgESoEsjg07ejXbGh+/jptK+bvU0Eo=;
        b=ud1QPlzkXmYBXONU5Xy2xLLVTfuKHTpjKPTu7iyl5mqDK1HLV2fHKJKvnDKumv36cO
         4pOO+Bvu/HPfFlJnEk0YIY1OMjen1W2DsnzdbxIhooLA8v8JKyyqihrY7uEQyuexlQ6s
         wloCzu/njnxwYdr5V2KUP+6/GnTD16XnbOh7Dv3yDc0Q2+TOve+ViFVUtVZhXV8RaR0K
         hv/86iDpoKRH7p2GmvQoa2xl4chrKiY5XAFYhNgnFRekoFPHd8+oFITkzGEb63E39SLM
         s2hIfP0ul1G4YJyjegyWcGcu0hz/FBqQTxmFjPHdQERpER2/DoJ5DpIgO9WJPXxfbkPz
         aacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OdwE/LdElt/BizgESoEsjg07ejXbGh+/jptK+bvU0Eo=;
        b=ShZT0DlR69SHi1t9R8e+MfLnKYkmph602UauTxkcJpf8GPwbSyNyIkBI80kyZRKdMk
         UkgkF8h0ybdlnLPfYUu8l3JGaNRQbW7jDfdlAX534XYA+DWJooDtHoOVpczPsCvl9euQ
         8gXtNMCtO0Tux2/AsOeVnNnC13wrYwfq9QaeD1tIb1cNZ51+SMTkjXWyxt4kxe64rION
         rfrU+Pgo7D3ZupsKcGNLsyTA95JR6dqEpEzboBZ8rJTCezDJcsYBcLwXFjgTEmfBebhy
         RUVIofvglOwLFLO79a9XZrhGI23twlidfynJFEPLHabmPpCnjLQSG+slg/qpPxhD3kU5
         amwA==
X-Gm-Message-State: AJcUukcUdvg04VHVwtAD7nv5+wEeiXT6IaTqoHmhoUuXlorUjKyVx/SC
        BKNdzJ8vaF00d4omRUgFtjDpFCk4NVs=
X-Google-Smtp-Source: ALg8bN5Qjre7fVx7l0YOZSJALKWYQSKg+dweKbCljmcnyyMDpFJ5MH4vgZoFcA1Q7M3tMQhzwfC+TA==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr29504885wmb.23.1548938717979;
        Thu, 31 Jan 2019 04:45:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f2sm4915714wru.14.2019.01.31.04.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:45:17 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:45:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V8 1/5] i2c: tegra: Sort all the include headers
 alphabetically
Message-ID: <20190131124516.GI23438@ulmo>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K1SnTjlYS/YgcDEx"
Content-Disposition: inline
In-Reply-To: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:16:23PM -0800, Sowjanya Komatineni wrote:
> This patch sorts all the include headers alphabetically for the
> I2C tegra driver
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
>  [V2] : Added this in V2 to sort the headers in tegra I2C
>=20
>  drivers/i2c/busses/i2c-tegra.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

See my comments on v7, with those fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--K1SnTjlYS/YgcDEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS7dwACgkQ3SOs138+
s6EcJw/9FbCydnBpjEw7YyZZAdsHzuhaWPusrNOovbr90qroGXYYgwVETl7ibbpj
03EjkzfcXv/uj3IsC9LX0xm7ydrEurN5H5QWqkzABO4WX84lWWJd7yjFDNtbJCQ1
5nRnUXUkberz+reWBMNlp6BB0Nk/b+RUFoR82GaczKIeopqqO1CaWS8AVn42aifm
dHyssstPwb8WOgDLL3cBpJtvcCg+VvcaK7ThmPF8XTmexvzT16vzfJSVe3XXFM8l
gM+hxmSnyJw95WADVA68MAvK9HDyIj2X+PKqIkrzVhXsuvBc0CdXR2D/lWoO1A7z
NSNsvC1i8YZoExoQ8I2DpTXdKWhTze8Kk7KRqwA4FiDSoKk1IjurhXBHMcPeykyZ
z8Gm2CCqucCgnoa16Sm3vYZBKs3+ZzYeBJHQ3OHO266v7jSLh2XSF7ek34BWcuH+
fgDHFTRC977f+E4Uu+R0ZbCKxXSbaDWFRA1E/cnp8mLKXhz2mRDHzQnXSNdGBusz
TqFQJTzQQXSPNN5UtOkfOBVQ1fhn/oONGJdQr+Noas5V25oVolU56M0yiQT/nbb3
micX1EowVca+YT36p3niIG+21pRGWCGNHX/iXdzBL6Hnsmx3R9bVP14eOslqq1VR
lgT59glRXRGELcl1UOfptGM+d0bRBRDXtnHYY0oXFXBH6KRj+5I=
=Ma3T
-----END PGP SIGNATURE-----

--K1SnTjlYS/YgcDEx--
