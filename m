Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95DBECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF70208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX9N0cZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF70208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeGPKhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeGPKhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:37:50 -0400
Received: from mail.kernel.org (host-091-097-051-136.ewe-ip-backbone.de [91.97.51.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434D9208AD;
        Mon, 16 Jul 2018 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531735869;
        bh=zW/9OHI6qT/vPrKErOesdFVIGRNPHA4ZGo5w3mIcjVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX9N0cZsLNSH24H+84HjXKlwmANast2FwFfTsfnZOT/bDAq/SyOkmXLpPMxWBBTPL
         9fA1on6L8mibxU1wqB6fAtbS8zNT1TFSLLo+E4Ml/+wAJacgAMGHKPsr3pSLJ5pCR/
         AtAojcmuynwU2nFN6ENYuADzqkcdg/GFRI63z0yc=
Date:   Mon, 16 Jul 2018 12:11:06 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: [PATCH] dts/droid4: fix dts w.r.t. pwm
Message-ID: <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071048.GA23110@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qshvk5u2dnfjfb3e"
Content-Disposition: inline
In-Reply-To: <20180716071048.GA23110@amd>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qshvk5u2dnfjfb3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 16, 2018 at 09:10:48AM +0200, Pavel Machek wrote:
> pwm node should not be under gpio6 node in the device tree.
>   =20
> This fixes detection of the pwm on Droid 4.
>    =20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> index 45305e8..c27fc87 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -159,13 +159,7 @@
> =20
>  		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
>  	};
> -};
> -
> -&dss {
> -	status =3D "okay";
> -};
> =20
> -&gpio6 {
>  	pwm8: dmtimer-pwm-8 {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&vibrator_direction_pin>;
> @@ -192,7 +186,10 @@
>  		pwm-names =3D "enable", "direction";
>  		direction-duty-cycle-ns =3D <10000000>;
>  	};
> +};
> =20
> +&dss {
> +	status =3D "okay";
>  };
> =20
>  &dsi1 {
>=20
>=20
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--qshvk5u2dnfjfb3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltMbzcACgkQ2O7X88g7
+por8A//buhi/5dQvTTjCwl1wz4IvrTxE9qONWMbjxu2xjA/5rQciYLQ5uvkozWd
ZvpLsWuIMXdkg5CAxTjwPJMlTI3D4iRGaxBg+pW3JTuWdyGgZcbbRfaJ9mGFfZbF
O0qHKLA4Cv6l5rOVz4UP7yvgPXsTYlm6S4byt3JPzbK/gCEig+ciZ4XyI9pkyhi0
bvd9AnauYRkoZVyoChOp9uLesNRDOBuBKynQlIrRUa2d8O8Dr6M4Lpx80EQFqQcc
aS9PdgIK3tQLlW2VJvYi+hmZGoLH57c2o//W0ocsiFBEY3QtXz5mujMsPPssQiUA
vpzsmDUTYls7Z2fQsHjGbpCX1RzB6YPfVgTE5+WjcncK0YMVWiqLzyqizdwaevwp
ur6qK2K6y+khPcmqkgvKosmKBDNsUdJ9hUmTVpY1iNGcfXo4NAmMV6RMnSAPD9is
qISNVZiW7nj8Y/MRH0cbIXbV4qx3xRwaYxS3A/XgRjxWkLUxQJbkjTwQYUu1BBUp
WgEdkkt8d4MxYnovMcu6SRAm5yz2sKK6rJMstFqISm6I+po41dwJHkzHn+DRCogH
5mvXHb/RDkwa29H3sATcmQiJ2hJmNNAAOdkpWRa6aZZF0Mm9MqN8rg73HRh5hbJg
1BkGCfyO2/kCU9NhwHnhANymygXOde9ix9gudmRpmtxigTjJygs=
=o33p
-----END PGP SIGNATURE-----

--qshvk5u2dnfjfb3e--
