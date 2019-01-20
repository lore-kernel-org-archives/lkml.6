Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8716C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8344720880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548054781;
	bh=fYPq9sDIcxuXj2oJeKKmDJtZAaGnP2MKcLuIoeufuXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xSVWvqjzbQy0WkGZlerM22dFwrDDB9K9cXdCzqOhNskyyrVpkOYeuIPsvloLpGs+O
	 scx1Jig/6FzHepxB0TQX24aiftJe2pmnO9i1vZHYZiep9EXk6Rzig+RBzetws+30LU
	 bptH/KKskn4qEJ1gY4JjvanKWXjs4ikfCXQpbV2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfAUHNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfAUHM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:12:58 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93502214DA;
        Mon, 21 Jan 2019 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548029191;
        bh=fYPq9sDIcxuXj2oJeKKmDJtZAaGnP2MKcLuIoeufuXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwziozCqczajUflZPoLAeZOyamMhL1ETYu/dYCmGCQK5TjJdVHyOW28UW0zO5xHm9
         d2rT4GufPmoAeNUH+uALga7MlMxLzjUco12ORfD51Ghr6ade9KRzKjGbPNSqPevUAn
         YOYKSAuyBg7gQIrITQi/Ri1NFMDIPTlZFMp1mVU8=
Received: by earth.universe (Postfix, from userid 1000)
        id 71D543C08EA; Sun, 20 Jan 2019 22:41:07 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:41:07 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: cpcap-charger: generate events for userspace
Message-ID: <20190120214107.n2ot5mvggub4aehn@earth.universe>
References: <20181227195221.GA11920@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byreiu6z4ngijxep"
Content-Disposition: inline
In-Reply-To: <20181227195221.GA11920@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byreiu6z4ngijxep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 27, 2018 at 08:52:21PM +0100, Pavel Machek wrote:
> The driver doesn't generate uevents on charger connect/disconnect.
> This leads to UPower not detecting when AC is on or off... and that is
> bad.
>    =20
> Reported by Arthur D. on github (
> https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
> Merlijn Wajer for suggesting a fix.
>    =20
> Cc: stable@kernel.org
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks, queued to power-supply-next.

-- Sebastian

> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 9e8ff5c..7d8b4d5 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -576,6 +576,7 @@ static void cpcap_usb_detect(struct work_struct *work)
>  			goto out_err;
>  	}
> =20
> +	power_supply_changed(ddata->usb);
>  	return;
> =20
>  out_err:
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--byreiu6z4ngijxep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6vMACgkQ2O7X88g7
+prkABAApFEELQA6AnpA5CNX/WpKDkKWb7dVv+2gvum+GwIZR/+c4idPzHOzHHLr
MTDkNE4AoTi/GA06Q7Ed2PE8NNgrLtDKC8edu8KMDM4TW4oo3d1RIS4JPvBDpewy
8KkeHBEPgBT0PDzFc379lAfXYr6V38GhMOR3b/Jqcu81F9jAeOk/gmOLIgdIXjIL
BS/CJMABO3yX5zoFdxiOYM1pkoKGf+bw+un7NW0RSkrSCaxUiDHvfl7+Et0N7ouI
zTSL54vGGvyXGmUE0PXujLrgUQ9jYPedxotL8GlA5uHsIa4mma36My6I4ldowppa
Y5Ys2+bglHbYnk0onp3GbpP4obdXaugsyPs18wpk6lVfxpYQ1hcY33v/E6hhKpLk
rM6urwQ4Fin81txDMMHIuhnXdf4V+BfVQH02B0+iDYjF/0FUs4n9jmHY6nuezXAq
RMMgMZ8sgTtllr4M7OxL2f9ZRrliqb3fAfSXgq7YFYqHQvgjAJUuSuP8OrCHvxUO
woFPWgjhxEjrreS9mzWFQp0EWlfSqGWA2WDbVzwvOMXrZAYnavr5Sjw+4jz9gS/v
yjLJyebiKu1k0558op7GbgwYJkdZO3CSPRvsRv1dnzuMf7cWYhUT5BH5UuUVmXaa
n/Bvcb2knDgaybIWF9gd8nodRBnBbrIwjRsBSj9I+DBOqDiSx+c=
=h22h
-----END PGP SIGNATURE-----

--byreiu6z4ngijxep--
