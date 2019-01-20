Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9235FC31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068220880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548054870;
	bh=fV0ZHnBBoUSR8Lxw1I1aOYw0uiIT1Rz7RZHXZ/S1dQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ijRSTjX5yZkwhIFPZe3mQO7P7AHpE3KUH+PjG1FjFirz7HITCSNAPvWfl/P7OQ3pp
	 yA97qCcJmcp9MBzG+s1XALFU4CmGgHJSZd9Q7NxHKEH3Z5so6IS5WXVd9rPb+83N/b
	 NdHFWADClyaLdL/NMe51ape0z+TTJ4l59s8mOckU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfAUHO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfAUHM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:12:58 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D0621738;
        Mon, 21 Jan 2019 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548029191;
        bh=fV0ZHnBBoUSR8Lxw1I1aOYw0uiIT1Rz7RZHXZ/S1dQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CE8XMPVDDhWBrZWIy69Z1TMLqmMhW4s/xk3MzUWpTLhsZcrFs+WELE5SVEcX+pJXJ
         SmXjNLEnBk13DCzQFGMNTfbuKy0efFngdtB2t+XD6dsDEz6k5WB45v7/B/tRoX9ixN
         ULLNrxl+E479Oc+LH4VQ0LJnAS8BfLrwI44TTq/Y=
Received: by earth.universe (Postfix, from userid 1000)
        id 3BFCE3C08E7; Sun, 20 Jan 2019 22:38:53 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:38:53 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: twl4030: fix a missing check of return value
Message-ID: <20190120213853.5yh6hiw3ccfgtbmo@earth.universe>
References: <20181220195124.29467-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxnevxnfaejqw6t7"
Content-Disposition: inline
In-Reply-To: <20181220195124.29467-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxnevxnfaejqw6t7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 20, 2018 at 01:51:24PM -0600, Kangjie Lu wrote:
> If twl4030_bci_read() fails, the read data in "s" is incorrect,
> which is however used in the following execution. The fix checks
> the return value of twl4030_bci_read() and returns an error code
> upstream upon the failure of twl4030_bci_read().
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 0e202d4273fb..4299873a1118 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -809,7 +809,9 @@ static int twl4030_bci_get_property(struct power_supp=
ly *psy,
>  		is_charging =3D state & TWL4030_MSTATEC_AC;
>  	if (!is_charging) {
>  		u8 s;
> -		twl4030_bci_read(TWL4030_BCIMDEN, &s);
> +		ret =3D twl4030_bci_read(TWL4030_BCIMDEN, &s);
> +		if (ret < 0)
> +			return ret;
>  		if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_USB)
>  			is_charging =3D s & 1;
>  		else
> --=20
> 2.17.1
>=20

--pxnevxnfaejqw6t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6m0ACgkQ2O7X88g7
+po4vA//bmq+OXH+sKw1H5E3jTUh60l+43qwHxHu6UGCyTr1SQ4PHcB/nyqxTA3s
5XzRj5AT96xlBEBfT2ItxeFzSO1XWUa1ji/zi4pwmc5gCzICu0J4+Fbs9VsmPMtA
JT+oRXTnD6DXzS03Q3A6SBYBfe07s4VL7k5MH/7jqNJQ/AvfVAsAaxVHxWCnUV1W
8dDlp+CFhuIR+Joi1uCPuL2Kibz+9tufQJvGX/ahdHRlUuLTXzyaSWFTpJn0WV7H
HkrfvaVdaP9OCU3n4D0XQQJ+nMbeAmUgqnxTQXZ3vTOPhk0S//zDUFo9CmwBXyHx
BCZ4mbTbLRwYjHQZH+G/DS+qj0+YxWH6G5VA9Nbemqwvs5xyHeRXxWmjqUbPlSeE
pW9y5TUfGtbUSLnZ6fAskH9727sysIlSp9oaXgvw5QqRXoDykF3ISjRvgMZDTjvx
h3EPsKKaj2CKMUMjJ/p7ipSHaqkoqcWWyG0l8nC3g4hAmNUuWluZYsO5CTmUVXCI
Yo6h7gNv6XYrlagvJTbvDCZyNqzd51dPFs+SQWDY0x4amxr99Vjk6n/ZCd/cYwy9
nqb+NrXT0Bx0k6Qa+TOAecRjuFwDVGmNqZZcb7Xbu13VfUVC/KT01bMYWVUosiAP
GFZOpqv9/W+7nnrVAsDzJJfPlfAz692gIlULduPK9plsbpuNgko=
=Cdng
-----END PGP SIGNATURE-----

--pxnevxnfaejqw6t7--
