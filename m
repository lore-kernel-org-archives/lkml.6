Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF308C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB75206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnmr3HAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB75206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLBJzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:55:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35989 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:55:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so4965438plo.3;
        Sun, 02 Dec 2018 01:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sc6sz4GEUOpH6BKH0xK2Sdce9nuDLNWLjIGlw1NCtb8=;
        b=Dnmr3HAeDPrNt+oRQxx/XtEOGR4KijFJSvgIjai49jKq7zNuO19JC2HG9CVgG/EfbZ
         HaUjnH5pPnseVyoqry6sVosPCZfa7D/MoLliKJ/FWNSoAb0ojwNbcfKfGDwjgvvE4IM3
         Bdv4QDnf6lnk4eYIm9qMNS0wtAa95V4hviEq3thdiLJ/T959TSqSieZokdtpBw0esXN4
         aCRRyf9vq8G91Kw0lNaucxQLro6MScWmaMvFcn5FzLsgglW7xGXzNpTUOuZaXGTWG1qz
         U6J/6JdRwJRPWu8+0PFVAzl40UdiH/NiSUuqNoFFfGG1GitTzUxseWLfrNAaabwFgWOh
         Wbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sc6sz4GEUOpH6BKH0xK2Sdce9nuDLNWLjIGlw1NCtb8=;
        b=E0qWqx2s9E6pDc3YQcopHO5EbnXKcXn9dYMlSDxPTuzEnTwRGVRlTZZb6AtNKfWrcm
         3xqNj4wU5SZXFKzl+n8wVhGFPJum2AAp8icXx+PcquUXpBGDAjGTk7G07OKaMUBWGOL0
         j2sihrt0uBpxXJq5hba84GokMN0xzLZgTbeDk06JYb1kToupcQ31cZb8OOwzo24MdTNM
         /o5UWneXHY6crg2RJ09+Iw4RV5gtu57M4KSj2AkMsnY5G+iPFG9FFyaZlRmQqtHIkYED
         HOBg/uQr1Vp2EthI0uLFDr2n7JqjjQOiq7aEkqqo9eQM4WWglQ3hXyjOjE1RYXmgT5Vs
         9rTg==
X-Gm-Message-State: AA+aEWZrc5nc7UwOuEvCyLxnPl2tJHXSaZmWqXXY8bjbDumT2ks4B5WN
        lvbR29NxIxyzWHU/CAU3+As=
X-Google-Smtp-Source: AFSGD/VfNqE/bFMa1xCvZ6cl3obRrp0meqL7YabBKtOIPpomWVExd+T8VSmzWChUJ3R4tTD4bFSuEw==
X-Received: by 2002:a17:902:b903:: with SMTP id bf3mr11624240plb.289.1543744533773;
        Sun, 02 Dec 2018 01:55:33 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id t12sm14821961pfi.45.2018.12.02.01.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 01:55:33 -0800 (PST)
Date:   Sat, 1 Dec 2018 23:55:30 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Machek <pavel@ucw.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
Message-ID: <20181202095530.562gfuawbuc4jxyn@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181202093257.3918-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqoj4rchc2qbcndk"
Content-Disposition: inline
In-Reply-To: <20181202093257.3918-1-geert@linux-m68k.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aqoj4rchc2qbcndk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 10:32:57AM +0100, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.
>=20
> Furthermore, this list is already overly long, polarizing,
> politically-laden, and reinstating the concept of human races.
> None of these is related to the goals of the Linux kernel project.
>=20
> Avoid any ambiguity or political undertone by removing the list, to
> ensure "a harassment-free experience for everyone", period.

I think this is a very important change as well.

Acked-by: Joey Pabalinas <joeypabalinas@gmail.com>

> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@iki.fi>
> Acked-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
> v3:
>   - Add 2 Acked-bys,
>   - Add more rationale to the patch description.
>=20
> v2:
>   - Add 3 Acked-bys.
> ---
>  Documentation/process/code-of-conduct.rst | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/pr=
ocess/code-of-conduct.rst
> index be50294aebd5db37..4379cce85faa804d 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -8,10 +8,7 @@ Our Pledge
> =20
>  In the interest of fostering an open and welcoming environment, we as
>  contributors and maintainers pledge to making participation in our proje=
ct and
> -our community a harassment-free experience for everyone, regardless of a=
ge, body
> -size, disability, ethnicity, sex characteristics, gender identity and
> -expression, level of experience, education, socio-economic status, natio=
nality,
> -personal appearance, race, religion, or sexual identity and orientation.
> +our community a harassment-free experience for everyone.
> =20
>  Our Standards
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --=20
> 2.17.1
>=20

--=20
Cheers,
Joey Pabalinas

--aqoj4rchc2qbcndk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwDrBEACgkQ2rGdfm9D
tVIWTQ//bE3d8N6OOpdejxGiy7692dF2wS3VL5ShRR4V1/pBMzcrXes84Gu6iyfO
hevDyyR7hqehT02EfMthJ5zgqzpLO9uLoT3u7oG99AHMHTZZ8CuuNqBRr/M9RgAd
udCm3bGDWgctZOxQxaqu1hoQPlA27BYIMoYqKD9vbVw5bbqzge/fITnKvLhYEGX+
IEREjfBf3doq3oD1gvi/8xpY/Qvg6VVgY5ywNH+apAyW3mbYsdpdoSVFGOEBdET8
sBGyLADJCwfv3Gspc0n2Y+tKDeJx12HiQstxbcWOjTdIo2F0wgi9PGV0SJtiqa0S
Vp/8fddYvZvbXW9SV8lHzqDODxKF9pXALuxvgRFLwn7GgOWj+uJqGxngM2kSJlMU
VlZyFzyyw3SybHd1O37/Cn/C1rgLlXAWzxJGSsoXAY9bp59h+uGoxD+G2R5oOjFK
ca1HkFldUdYCA2lt9rpe+8EBhCRysb1tnSv2BT9a4U9bh7O3fFP/RDpxe8dslEfx
h1Xbvb83wuAhv3crJ9fKA/fX/q5ZU0SshuMPofyzzPFrU9WPm0fukhcUFMX9S7Hv
Z7hIY5ZhGUXOMPMRYVKBquyxaqYpVLjiB3nxLmaYPTKh2yk3BCm3xbFPVZ0gLjDb
cEst6k+6wiBMvXCDx4G5cYhu3e1njjz1T9X5duheNOQgHrLdj6g=
=n9Vs
-----END PGP SIGNATURE-----

--aqoj4rchc2qbcndk--
