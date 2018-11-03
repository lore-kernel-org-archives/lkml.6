Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684F5C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1320833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F1320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeKDE3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:29:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43043 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeKDE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:29:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 435CC80940; Sat,  3 Nov 2018 20:17:02 +0100 (CET)
Date:   Sat, 3 Nov 2018 20:17:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 4/4] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20181103191703.GJ31179@amd>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
Content-Disposition: inline
In-Reply-To: <20180918205455.25464-5-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-09-18 22:54:55, Lubomir Rintel wrote:
> The device-tree booted MMP2 needs to enable the timer clock, otherwise
> the it would stop ticking when the boot finishes.

"the it" -> "it"

> It can also use the clock rate from the clk, the non-DT boards need to
> keep using the hardcoded rates.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +	clk =3D of_clk_get(np, 0);
> +	if (!IS_ERR(clk)) {
> +		ret =3D clk_prepare_enable(clk);
> +		if (ret)
> +			goto out;
> +		rate =3D clk_get_rate(clk) / 2;
> +	} else if (cpu_is_pj4 ()) {

extra space.

> +		rate =3D 6500000;
> +	} else {
> +		rate =3D 3250000;
> +	}
> +
>  	irq =3D irq_of_parse_and_map(np, 0);
>  	if (!irq) {
>  		ret =3D -EINVAL;
> @@ -231,7 +239,7 @@ void __init mmp_dt_init_timer(void)
>  		ret =3D -ENOMEM;
>  		goto out;
>  	}
> -	timer_init(irq);
> +	timer_init(irq, rate);
>  	return;
>  out:
>  	pr_err("Failed to get timer from device tree with error:%d\n", ret);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvd9C8ACgkQMOfwapXb+vIdJwCfaeay0bWti/7I3s5Da2HuEjld
ldcAni2viteHFI690zWRwhuWJGUu3Kq6
=3oi8
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--
