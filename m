Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4CAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204472084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323935;
	bh=J8t5NH2QAs2Mc8UuXiW+gotimCDZeK2qOiqFBaod/FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9EJFEf7CfohKbEBfX538UolwesUgchMNwxUXcDdKzTGziB/ttF2zjR+9RTkRQeOv
	 zTPy7BtePwLulzNOuZAz0+2Rl7BCJiqHImWfBWBSWxGnTtFHc6F3LUY6djN+HR3+c3
	 GaIM+UxVF9t1HNNmS43diWJncOMXK6clvBky3134=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAXJ6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfAXJ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:13 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2B4218D4;
        Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323892;
        bh=J8t5NH2QAs2Mc8UuXiW+gotimCDZeK2qOiqFBaod/FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bm+G4eaT9bvivxKSG9IeEq+EHXZyR2IbGX8OR7+R0MdiZf0HFFqy7kzbuZc0ORtnZ
         +lMLAqPS+mr9EJ22ZSYbOhpdUs96rqvzWIrzCtORJS16419wHGJ/dBe0Yo9TrnwV18
         2sC2wD1BWbv/hWMs74TngcPMOOMpJ9tYXgBr8TuI=
Received: by earth.universe (Postfix, from userid 1000)
        id B3EC63C08EA; Wed, 23 Jan 2019 21:54:53 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:54:53 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 4/7] power: supply: olpc_battery: Move priv data to a
 struct
Message-ID: <20190123205453.f7zdvfv5dgxwzmsy@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl3o2g26527t362l"
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-5-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl3o2g26527t362l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:02PM +0100, Lubomir Rintel wrote:
> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

[...]

> -	ret =3D device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
>  		goto eeprom_failed;
> =20
> -	ret =3D device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
>  		goto error_failed;

Could you create another patch, that converts this to use the
functionality introduced in cef8fe6a382c? I missed the
device_create_* functions and you can actually test the change.
An example for such a conversion would be "711aebcfe3ba" (ds2781).

P.S.: This is not mandatory for applying this patchset of course.

-- Sebastian

--sl3o2g26527t362l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI1J0ACgkQ2O7X88g7
+pqLLw/+MA5CoVRhd+/0NbpJHzrZq5JNa9HigOsWWf0vMXxCpT7lvoOR5JqJibob
TPIKlZ1T3VVmTKEhPnIhJt/3zWKZJslm+o7FOn2UvPwKPB10SI2ia1ZzBaUCtc6U
S5bhBYg2yV/mmIzKmuwSjfcJJ0yrcj15jZT7LNJ2IX+TlhI8JU9av0vHVt/RlRtU
ov4/JTqnONlQUyEhiHT8iBqWz0EB3v0E9Op43Q7Ch4oxWIw8Q8cNuuxdenF0GURU
VO96AwXjWwzc4hHw4PAoB9gRa+NrnrTHrZ2J62Y7TQR5XBF5x8iDyCENcYiblFhM
iftkVvn2sOoDoRAp1djNpL+AQg8vObGiIfKkrAUImqR2FAPlc9AK/2+h+NJd58zD
9E2FReqELETZvslyC/XsHXSJEHLaQHnsergoWAUbEUJoxQ8PJiEOmZRpSIVezH6A
WkQYbgbA0UqMuF9g7earDTmd9Oi8BzR7bIvctWkE/+JPEFV9XvTMemnAL0zOTU6M
0jeBkw6uAxMcF+JjXeRUTYzHCVp64t5SYwHeEbr33ZzAI+YA3H/J8/YGLFAu4xX7
5bE1DMAlBCBIneFqZ1xLL4a0ADUzSMDw7cm8SlrfUse0E73AKt2lifKEnOKsSEtE
2H4aPjRaHCXW4Rxqr/WWfiAjLZdHSZ/nEkyzav+WWyizBGTQ+8A=
=Gkee
-----END PGP SIGNATURE-----

--sl3o2g26527t362l--
