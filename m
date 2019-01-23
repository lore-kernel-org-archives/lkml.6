Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2124C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF0C218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323892;
	bh=m5B391HGx6lsJfLULHB7pn4PxnKTM+5jBjsLzN8S5gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qn/U+wm+XY4lbS1Alok1Re0U8uOwU5wMGhBPq7sfq4NKNVZcAdd9n10HMmegGwqKl
	 bWAqijpEAJbRdoVeiSzLXyHHLh8WiEtWPkKLuEnV5sZicR6Cl1pOtYBba3jRJcs/PE
	 K2MjodKwTdl9hM8tcLkHMBPEyGrUCiSLS8tc5fxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAXJ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfAXJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:10 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07245218A6;
        Thu, 24 Jan 2019 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323890;
        bh=m5B391HGx6lsJfLULHB7pn4PxnKTM+5jBjsLzN8S5gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pw9vawJoF56RHJDJlKkWe7NeslJSG1cq/cC9JuO5mvcJK7M6O3s+EvGFALp460IKT
         IEXSauEEDRK7wZbO6VVgMBqANdGYCVXajbOgYA3GDFs3Zz3bW3MJOkS/rYM6P0XO6d
         eHyt/RjMjRFI9q6zslJ+wYkdnizI8qNiFf4+PKGk=
Received: by earth.universe (Postfix, from userid 1000)
        id 93E7A3C08E1; Wed, 23 Jan 2019 19:31:06 +0100 (CET)
Date:   Wed, 23 Jan 2019 19:31:06 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] power: supply: core: remove duplicated include
 from power_supply_core.c
Message-ID: <20190123183106.xs7ga7gqwhp5a55q@earth.universe>
References: <20190117071143.14652-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2rowui6hqeukn5r4"
Content-Disposition: inline
In-Reply-To: <20190117071143.14652-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2rowui6hqeukn5r4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 17, 2019 at 03:11:43PM +0800, YueHaibing wrote:
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Thanks, but I already merged the same patch from Yangtao Li (who
sent it a bit earlier).

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 569790e..07a85e1 100644
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
> 2.7.0
>=20
>=20

--2rowui6hqeukn5r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIsuoACgkQ2O7X88g7
+prU2RAAl4lM2vuRA0NKpqctn1kTLuY7tTn2y8N4BaHCdk9L9F/E0Ig9aOuNf4mn
V/IIJj73SCTZOFDzfDEdDAM96STNWmwIzmzoj3DDf8GEiHaqNFblhue6Ij/HyG0+
zQljKUW3ri6LIDvslq7iKWRZps1Z5metom3wljYpif6+VieaCncS7mROzKiIEBP9
q4TG7E6TWY+ogiM5Zhtywgds23OyK8+nffE1ek/4s1PSPUwIpcg/hZqUlkWHg/4l
bSr3j9A1Y4cWML0vmNVyzkubYuc8juA6gXAKKiH1P0GZqalM3fHnNHqcfcTpS9i2
TqkHrhsMofsztW5VbO53/sJjtEv0nikjXh7cuJEyLj3SFzVqe8N72QLAlg/viIy3
r2LwiRedNssU00dS6oYLnMX2kLVGrdivQj8F+14dD7dytlZHMisPdGbiw/Bx0975
9Jw9IJMVoyvywfm1fg4yv+hunHaJVQPAlc5hE2c20RKGresNtdbyUqz4bEvih6QZ
Y+bWlo1qawq9LJuZDskNAal2aoPwz+rpgzYFmdLQx8aN9BTqGF8yeNUktDi5NtVT
hWkYezk7PsWylEKBn/Awwy3fDXI0AuIgjLv46Rb62ig17e6nwqkgTiegHgjMvSiM
uK7Gr6HOG3Aw+whT4gZo4vYOikm6jCbeRA/nS6UM4uPeHe23PoQ=
=5cFx
-----END PGP SIGNATURE-----

--2rowui6hqeukn5r4--
