Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD7C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5160520989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548054859;
	bh=FG60ojF+jU+XYDrwm0EV5/XurIpqpLASzLIzV6s09lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEibW8S2re5OmSy0EXdM8gPLztpU5ICohl7J/kx81pRV81NOJtHCG9cURo+0iv6pM
	 MXbnEyla4XWg7A9vcGH31QxN6nG9yXZ5TDHowd2ezHy8v4cAaHGEIHNz3iGJHtWqXV
	 UoS6m0RmYD0aRxx7OZHrbMGh2iVWrWhRIqfKf+C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfAUHM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfAUHM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:12:58 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F07B214C6;
        Mon, 21 Jan 2019 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548029191;
        bh=FG60ojF+jU+XYDrwm0EV5/XurIpqpLASzLIzV6s09lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHPKFzihkThc03aYCPB6QBgqzuxHj0gXSS6FNTjUzjHjPIAf+OU9fTHvn7m4yxCVT
         daMpriCaoTokc5lbxvjyD2MyxBnEpYxE5Z2q9qwGG6O69evF9pJGYOeglMUAjA0c5v
         wiW7z6F6getttiS6W05VTzmwaYePh4ZMJB8kWPvc=
Received: by earth.universe (Postfix, from userid 1000)
        id 50DFD3C08E9; Sun, 20 Jan 2019 22:39:45 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:39:45 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: remove some duplicated includes
Message-ID: <20190120213945.23lf5whwqrcbatg3@earth.universe>
References: <20181226165357.6426-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwcs2pxufa3ede2t"
Content-Disposition: inline
In-Reply-To: <20181226165357.6426-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fwcs2pxufa3ede2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 26, 2018 at 11:53:57AM -0500, Yangtao Li wrote:
> We include of.h twice. It's unnecessary,so
> just remove them.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index e85361878450..529721660e68 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -156,8 +156,6 @@ static void power_supply_deferred_register_work(struc=
t work_struct *work)
>  }
> =20
>  #ifdef CONFIG_OF
> -#include <linux/of.h>
> -
>  static int __power_supply_populate_supplied_from(struct device *dev,
>  						 void *data)
>  {
> --=20
> 2.17.0
>=20

--fwcs2pxufa3ede2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6qEACgkQ2O7X88g7
+prp7g/+P9I8U3fsbBWFa/YCdJjqUsDmn/l8K625J+BK21zRwbDTSPqtSVkDWY8s
5cd8opLYw1UqQgsr5z1oXCJORFm/1cY8C+avHx8kbFiLa07P12iJGGELeFYaX/NM
zxXWx8YebVVf4blbsLcu/z7VkI/KXW8MhmbIMDPEU9cfBri0/ssNmP+CfPgvhFmb
M5XbfO6YBqRhcVRAiSSY8yKpk3xg5m2eMjhIv4hdtFtbjotaen3BXDpg0+9IhO4I
gQjFn9fWOlgiP4fAppwabJ596BDTCAUClYGl+bBW2h3F72U8dao5flkVlrvY7tUD
LCnBZTSVBGJi0AuI+H9vATtbHjDKXfG0Fc3zErHco9DxUO/7wLnEhQ+3WiO0NvMB
BFMfONS5tTCASmIVR76PrR2QW0yBV8GuTfQ6toorLhAQWQIzwQdMx9qoaQz5cM9p
7hp6oe+NwbBvttD9yALfgkGc2iudhs1id9FrJL5wlU772L88SbG3KlC6vX7szIYC
icg1K2q0lh8WngVf6jGk759vv1o0gX65609N/eQFFX4O11yOZj1E0tixf0qFAANt
qrmuoNv23jiWk4um6vmhmh+DeChdeBk16+i79nyZKoO3ghxC9lNN5vKTL7FIVZml
jQ8ndgCTLUKAJA6bQzmZqbl2eK3lkfm2biNQGj6tSSS6WEZNI4g=
=FTJ/
-----END PGP SIGNATURE-----

--fwcs2pxufa3ede2t--
