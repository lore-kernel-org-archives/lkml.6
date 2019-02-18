Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038E121479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh0sJ4cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfBRImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:42:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfBRImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:42:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so16464019wml.2;
        Mon, 18 Feb 2019 00:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ECOl8Xuao5qvMZdeqpfKT2xJk1MxCA7HiZW2hU6iN5k=;
        b=Eh0sJ4cw83Zas7LiGanDJDSudOP2+zt5Ay+OoalEMr9iezR0J2DbkB8vS9z0+608PL
         59RcWUfANGrAFGenpdSoMmx43QdTogg79IbpMRquEHPimnRXYoE3bsFqdqIDzeRYsxVD
         07R2XBUzTjDXemDOGUXKDjOsD8RNk9CeL2KvPvG4cemRNz0h6qqI1UuIA589V7PuImJy
         +/n1eu83DbZsRQbhbx8HSHWthoc8c18ZvP2M2EsSddZEkbltepaYXjMVLYEXDY3xCXbR
         4y3GPsL/kEEGhaEO8NVG2W5WukIreUNe2+JFRhrYdM5+fJ0NeIzPeDbhnYC7LiHqUXxw
         nzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ECOl8Xuao5qvMZdeqpfKT2xJk1MxCA7HiZW2hU6iN5k=;
        b=EccIExbKnarHh7TTJL+4lfNz4tEoMMzDOWCA2dlIjP/zxVrub1qLoWZVQXMn3tDBTV
         fSr1JGo0lOdxPpqlFaxqII6l4NphhY0mugJ+WmcAZXcBPBfb+O9tFC/KQqcn7AFvHueP
         vORRreCdvlHoZtY2PtfXJG62ZrMueO5O/IIQjDgiBvpumR0TSrDLxPlvjKXYyoGBuMrm
         TYA0MhNRUffKhZ6iUWaVOCjGGIcDITtu67lCcoJ5EShGZm2uiSiNDs+y3GJZES7ANAkn
         QaAuBKLOhmAAiYovEI1OREaHL3b9O9fb9H/ojhyB34n4bsobBQKsjiZcHgc4IiCi+FU5
         I8Dw==
X-Gm-Message-State: AHQUAuYrdviLLm8RBObcbB4yZHi5uLz9je4b3BhXgOi9va92uhT/YgHI
        mNyLUDRB2s3rT7MXYfsp4VvdbAwV
X-Google-Smtp-Source: AHgI3IYpGTa0rKMAJtTM3Vat+8OBC3W0vEJd0AhWJHGXijDshGlG7ZGSscDVR3Rh2E8sa+8o3w6MYg==
X-Received: by 2002:a1c:14:: with SMTP id 20mr14334032wma.91.1550479349444;
        Mon, 18 Feb 2019 00:42:29 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id d15sm27842997wrw.36.2019.02.18.00.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 00:42:28 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:42:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, talho@nvidia.com, wsa@the-dreams.de,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
Message-ID: <20190218084227.GB19363@ulmo>
References: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2019 at 08:33:07AM -0800, Sowjanya Komatineni wrote:
> Tegra186 does not support multi-master mode and also there is no
> master fifo control register.
>=20
> This patch fixes supported features of Tegra186 and prevents
> crashing during boot as master fifo control register are not
> present on Tegra186 and prior.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

We really should've caught this earlier. Jon, let's think about ways to
make it easier to catch these things in the future on our test system.

Acked-by: Thierry Reding <treding@nvidia.com>

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxqb/MACgkQ3SOs138+
s6FagxAAvWuwDorw34oreWqmswSIdriQUXtzQQ2p9LQUN4DBp1QRekITOsZejuQH
Ci/HhUghBwqNihkwNwARevAHl2VdswnachySJKOXHCaTYu0jz3qP6xjCSQvKR7WC
U2FUzzgCDW4eeZCh1dYaBOdUevgYFhE9PGoM1SxA+8lV0udsan3G8wF+NoQ4gB/r
l4NCEPz5YndOBvSTQqJWkmHMJ0b0QcwOrigLQAYDM8l/GFmlYS6ZmwvG5ebRhdbt
b7j3A3KfoUGsZjsd90jU7d3DE/f7r/pRW5vL3kcc7iIgR6L/0yss13MNbMuotjK4
ivzMDcz/rASl4WbnSP3POP8TPtE7AlVcXxjadZU7sNHDNWW/HjNnYVaTPwYRxbvc
XgyY0oW5sx266NyLP4fvvvFT7iFBSwtLWq0arsgAU7gUgkFPNKRLwJ3FbrpBIkrH
tY+nzlq1Uvhk+pso5V3xe0K+Qv19uO7Ocwg8PZE60auIN92HeXtiqelf0rG9QU//
ZcmbOgqv7Y9485AS5/hAre1cMXMDv9pUMsWjCb8v9bhzDx6Ct+3bNR9mF0GzAWnS
vFpTCwXlRwmb2Zj68qub39vkRxUbNcatLJ3u+XO6iw6Zanv73CrHR4kABnBYU8jL
e+vjnfrW2rLKmrLn8p/8FIa6B8IM9F5nE/geENvEz/+dG3FJtbo=
=XEK2
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
