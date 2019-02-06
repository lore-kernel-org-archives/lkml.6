Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745A920B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZd8RDB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfBFTOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:14:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:14:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3325524pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 11:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8Vu5yOu1JDG39cA79xhXO91rI2VWZ3s7mq0aNMlYZc=;
        b=OZd8RDB5+U/4n0NomVwcFlmBPY2528D+pnk2Mg7Vjip3LTjbOzAmy79jPR+Qzgdrt+
         UtijdT3G6vsDNdlMS3ahoQCROewcoRC9ZCjmWic9Qxh6fhGndEEOYE90klyYE2q+2Td2
         XE85GF8LlUT+woU4nna8cQvFEfDT18h1ns9+3H9nz053PqUA8UxJouXSmmtdzFIsHmLG
         eYFApjKEsT0DZHte8TkCXd8zgTYHe8D7Q4IoWvckA6i4/zInJ6onFyb8PFtYjBjYZtsV
         BPusLlLQ6Cj4AJn0in+P8TkUBCWL17rATX2Z9v2p/83E1GMhdF8FA6qxPZUhIBg8r5YZ
         Bbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8Vu5yOu1JDG39cA79xhXO91rI2VWZ3s7mq0aNMlYZc=;
        b=dAM83uLZvj+mCJwRSvJJiEyhpH2NTKNKgcKOYls8e8tflxuGvHifLRzO/uayH5Aarr
         cfign/CK281Fm5d9OeZgYRgJzc65ThYCGUijna9KlOApunYi0aQIAxuh6sw5tbZW1YcV
         Lr8Ei9E2VumyY3/ffSAfouyEnco8AU+tMR2qbmNDHy94qj4HhfCK4a1LJKDhrytyssXC
         NlR41O3rodJ3IdW19gDkotdgZOpszJ57FqNPlFjeamD4De/tAlDtIvJT8LcorKqn+acC
         oPP9X6hfV5pQGDu4Go2KrzPon2W+TuH9A5nVmuxapXNC0fN+pDDTdBOpJ+Qm7vFOEib1
         k9YA==
X-Gm-Message-State: AHQUAuZGRl9Gp2Vsh0tU5MPU7OG5kFKalhvmXvarnIk/fQf1qPkz1ErV
        k7j4IWKTI27oNm+SAgA+dG3ITg==
X-Google-Smtp-Source: AHgI3IY0AKWgPByQV0MluQkJ9W2/nfLetFxbVNfC1YgA7EFclMsNyAZ3z6x0pOW23VV6hBtlDUjFdw==
X-Received: by 2002:a62:e201:: with SMTP id a1mr11848164pfi.75.1549480462102;
        Wed, 06 Feb 2019 11:14:22 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id y1sm9233301pfe.9.2019.02.06.11.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:14:20 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:14:19 -0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        dmitry.torokhov@gmail.com, bleung@chromium.org,
        kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: chrome-platform: change the git tree to a
 chrome-platform group git tree
Message-ID: <20190206191419.GB94443@google.com>
References: <20190201094133.13772-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20190201094133.13772-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Fri, Feb 01, 2019 at 10:41:33AM +0100, Enric Balletbo i Serra wrote:
> Update the git tree URL for Chrome Platform drivers to point to a Chrome
> Platform Group managed URL.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Looks good to me. Applied to our chrome-platform-5.1 branch.

> ---
>=20
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a425dbe..a3c8b094228c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3675,7 +3675,7 @@ CHROME HARDWARE PLATFORM SUPPORT
>  M:	Benson Leung <bleung@chromium.org>
>  M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platf=
orm.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/lin=
ux.git
>  F:	drivers/platform/chrome/
> =20
>  CHROMEOS EC SUBDRIVERS
> --=20
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlxbMgoACgkQHwn1ewov
5lhSphAAuhUV7KZWNRB2LuJH9GJrY5FaNxIcmUFXvmATgdf+onFbtAjrO8fpXNTe
tY79mg8lfUuRF4m4VT2i9tdUzK61/t8S6YSp5558/6CTA/T62d/Ip3kGobEqzVXX
bTmfkL3BkkE2CfLfDmNn5LXR8HHGY0QuZSooJOwZFJ1fq0aisEGcjzJfmK2UUALr
Yi+E9YvHJD+eguD33xv5Ift/ROZ9/kQVzzT5wFlnEIgT9N3XUZec89aOELZChUk1
HYNQPpFwL8ctoxfTflL5dvIZFovtLPrJEp5XfjgrCA9qnG51XxvFQkcaWiCyMrDu
JSq8hnv1DhzGNMTRMaKsl9Dj8fpzpnrDV/UxyPWGCzeiNSVpCGF/lxHgYtrQy9Qq
N0xV52t9mlVYkrbM73v5Bbs20wsz9BYiwXdFzmtriza40dlUhh0dPc16paSAgpCW
SWroa6ATePauJrlCarPlFTEZFNaFnD+WjxurKY/NFceYCefdpCUAjhv0cQM6LkIR
J2SNH2mhpIl82yvecsriTyHK92NP2dHD7uu5y8G5Txqb1RZSAAdKs+wt46dULyxH
1Bh0nrKTVI25sMh5hzQ4VB1F6UJhJWY9byFVUf2OmWPvqlHqjETgyouI+p6zo8nK
VcHRhUdiroXCYLn65af7MEs9qZB2bejZ6hI8lSZrIqxNpUj1TSY=
=F9kZ
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
