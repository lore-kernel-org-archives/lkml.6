Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A770DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7222E2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/XdvhT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeLPXCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:02:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeLPXCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:02:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so5395611pfb.4;
        Sun, 16 Dec 2018 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/F0F+CqXLhW7WA2atokM6J2ct7JUi/V9RwCMAL8w/g=;
        b=g/XdvhT4NJw9mDkGHyVQOROjgLIgM4nlz6JVFiJVsvKo2FCYwe4ICrxGJxzqBaXCQh
         Uwka/SpHPc2sD4eyB8WA0mD9ylGgtPy5S+T4IdLdJ2jg/WDMUKsid0lA1G/o415FCYN+
         k0rzv5fnT8IwL01w1QdwvQ0oITRDQBlibwQcVt1kpyr+ZfXRBSuSbRd0ZvdVY+mzhHyE
         7YkvWgnJ92kWXu5QrtjPIGxS9qKND7QogOE9I5wa1x5otBTE9UkCpGNjRLFlOqiPfpcn
         RdDkXIUL7ddXNGqUKXNb02Xnu/QJHtkCt47kEHRltaqzTD2qvSTZ3lmp3+n8xvazsjd5
         t2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1/F0F+CqXLhW7WA2atokM6J2ct7JUi/V9RwCMAL8w/g=;
        b=aRIoRKs1DF14kEP+pc6bcUal4d+3Mt3WTe8kdmS1iipCq62llGy10N9v4TGXd7Jnum
         mD1diNZsPXOMyZTOn97xIMyXfAF9xYuy9GRQXu9Xonn50nyPc0gVEaSRS2n3hfCH/5LE
         Bax7UoClpi4vYbhBg2N3phOFNBKuv8E53EAlrbDRq+idcgS7Yice2aFTruMNr0H5WGHg
         qlZ2AcvjfIwv7plxcgLGCvrUEzhsJwDdbnlLh81TksqnLrvFIuTp8f6PIx+bDJ5A1uoF
         94yyoKd9hj/u9EiZyJrjfDKeuOvqTSSkqaEdytJFMVADuXLH/xERr1xWqm8yk1uSjYeL
         GRkA==
X-Gm-Message-State: AA+aEWaiEDhtxSLW3q8SrIv53o2YH+Sw17luVdlidRUd56B7HJXvF0vU
        Olg1V5bR+sKJBOfsBlSMq0I=
X-Google-Smtp-Source: AFSGD/Vnqe+X4ChJ1eiBj0FbEUM2qkR60Jndem9oO1/NIK8oXmpHL/2QUOhoGeYcslDzocLPONv6qg==
X-Received: by 2002:aa7:8549:: with SMTP id y9mr10942026pfn.83.1545001360514;
        Sun, 16 Dec 2018 15:02:40 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id 139sm14076898pfb.127.2018.12.16.15.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:02:39 -0800 (PST)
Date:   Sun, 16 Dec 2018 13:02:37 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     marvin24@gmx.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] Staging: nvec: nvec: fixed check style issues
Message-ID: <20181216230237.f6efaxfj4ejjemf7@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>, marvin24@gmx.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org
References: <1544996634-10427-1-git-send-email-indigoomega021@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="altdjwdkeypm32xa"
Content-Disposition: inline
In-Reply-To: <1544996634-10427-1-git-send-email-indigoomega021@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--altdjwdkeypm32xa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 16, 2018 at 01:43:54PM -0800, Amir Mahdi Ghorbanian wrote:
> Replaced udelay() by the preferred usleep_range() function.
>=20
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>

Nack, usleep_range isn't for atomic contexts like interrupt handlers.

> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 08027a3..6f35f92 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -626,7 +626,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  		break;
>  	case 2:		/* first byte after command */
>  		if (status =3D=3D (I2C_SL_IRQ | RNW | RCVD)) {
> -			udelay(33);
> +			usleep_range(0, 33);
>  			if (nvec->rx->data[0] !=3D 0x01) {
>  				dev_err(nvec->dev,
>  					"Read without prior read command\n");
> @@ -713,7 +713,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  	 * We experience less incomplete messages with this delay than without
>  	 * it, but we don't know why. Help is appreciated.
>  	 */
> -	udelay(100);
> +	usleep_range(0, 100);
> =20
>  	return IRQ_HANDLED;
>  }
> --=20
> 2.7.4
>=20

--=20
Cheers,
Joey Pabalinas

--altdjwdkeypm32xa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwW2YwACgkQ2rGdfm9D
tVIV/hAA4Jna7ooCtJi65KnkkDxUnGxmapj9qkpOIcgVvBb467uqNmXl2faTHGNE
l9x2d+2m3rmBHCUsz/sZ0mrmOwZi44xLNYvQdrZ1jnBJzHMAaGsPdAyCr2jFBQLO
cP5+16XNIdIzRlhXql7v3Vd+mIXBXCY3Udyg0FWxaGoQWVVb6wX+u8gQ9MR+bM2V
pJC3n/JfD6ScJhvIu+L97yXKSQhruiCEOAHvjGm7zyZ4DSJY5GTcRfarIRKKCjE7
koGBvDpke0mrslRUZa483c655jBJ8g+3gIJJJvosJ/H5Ii67WaxhgO7RTTiojqtS
HYzIAm0KsLuR3us0dAx4/bh2MxmxUBoknip218QQvfEGF0ApCphBFR0PHMOBQ/Q8
yVMLb0XcocS3AZz9Oc7NgFOqUCMhApsJifGLKWRc5Q6FL7LsjN9RDKHSoypyZxBd
HVjXx392r2tNHoMbsS7QFQsxRJOzAqc4qD7T94EJO97PeqOjw4xShDRjNQf8WBT/
IzRMlHOjgoKVlIv2TleCRUAe2eK1X6abWZBoTeAUoojcWq6Ox84oIUUHDaUhqqrO
8wUplCiH6aUUHIK96W5JiPKDyCC4Fx2bk7YU+wgK4CurEZJEUsiHhCNpyvigrf83
rRY9FZ7yl5fi7r8M9Q4w5ObGQtaFE4HAtPmUMk333PJQP1hN0TU=
=bqCe
-----END PGP SIGNATURE-----

--altdjwdkeypm32xa--
