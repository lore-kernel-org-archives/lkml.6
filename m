Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ECCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB119222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwJddVxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfBMMjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:39:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53612 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBMMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:39:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so2278161wmb.3;
        Wed, 13 Feb 2019 04:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjBxex/GBl4CAEwzbH+6nioKydaEdqdIiLMixcUckTU=;
        b=BwJddVxhpibvY8XNI3heJCalgCZWTKnykcdmOuFs9+5GokGExn+aBi/gStIJwpyT62
         8iJX1sSQpgc/qeWTH4HtQ1KwRg9siUvMUuPooJv2cnE1mJ31+ZJFSGdXAOLRJ8K/oGZt
         UXPZFSGIX+SF4F2tD2y+Hj6sl530jHiRQGV1/J0fESaZ+xEwQa5IZmShbPIXGWTIkBCo
         iYwqAqpFBU04yrNtWu/dcdOe5+e8sDN+mt+5t2Q/xDVtPsjD4S5getHDG3oVjJQstgEo
         cSpaMuSzDYNAG30QSthzlHi9kTMnvFkuXDHx1oCkI0yPFc58yBMwa6OrrYw5pdpKhCXP
         j9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjBxex/GBl4CAEwzbH+6nioKydaEdqdIiLMixcUckTU=;
        b=QHLHvOAp8c/3DY5ShhQ7HD+sVraK2G//vUT0ATUNAnVSqchV4iM+DCjd9R9eOXbpl3
         zDPFfsvs6QSEcNHtkAhqFz/N2wXsdHTalKm72vBr1gGjAwF22En00PQm1RBEq2XyQ0Ki
         zwddtipBWqvtn/OwPseiFCEgQqe2E/2V1vovQXR5j6CaBERx97uWhfbyzEXImLqDUxUM
         Qj3idSUbXmtWCF+VcUbU5BBaXjUMVs8faMhFTAFdGkqPhhw4e04yFn9oxo0xJf9MqRGN
         l8uyanqDV0ql++tqTLjU1vbod74r907xk+TWtqoG/9AfoaXhlbCnVNGLTp5HX5+8UhwZ
         EHNA==
X-Gm-Message-State: AHQUAua3axhiLqKHd1BzV7cmwhybWorI/MqcjxR8hZ0BOIwhShVCPwF+
        OWywMbi4iZcgUVwG67ExpV4=
X-Google-Smtp-Source: AHgI3IbMLf+T17QAekYkmX7qKJvi8QhJ13L2VyLjmne1Bft18I5syZ6xrO+6gcsW0Tu9QqpI8fkN/A==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr142384wmb.85.1550061544264;
        Wed, 13 Feb 2019 04:39:04 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id f187sm6998739wma.4.2019.02.13.04.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 04:39:03 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:39:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v6 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190213123902.GF647@ulmo>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-3-git-send-email-yash.shah@sifive.com>
 <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 11:34:59AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 13, 2019 at 02:56:18PM +0530, Yash Shah wrote:
[...]
> > +	unsigned long scale_pow =3D
> > +			div64_ul(pwm->real_period * (u64)rate, NSEC_PER_SEC);
> > +	int scale =3D clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0xf);
> > +
> > +	writel((1 << PWM_SIFIVE_PWMCFG_EN_ALWAYS) | (scale <<
> > +	       PWM_SIFIVE_PWMCFG_SCALE), pwm->regs + PWM_SIFIVE_PWMCFG);
>=20
> I think this would be better readable with the newline after the |. With
> my editor's configuration when broken like this, the 2nd line would be
> intended with the opening ( after the |.
>=20
> > +
> > +	/* As scale <=3D 15 the shift operation cannot overflow. */
> > +	pwm->real_period =3D div64_ul(1000000000ULL << (PWM_SIFIVE_CMPWIDTH +
> > +				    scale), rate);
>=20
> ditto. Maybe break after the =3D?
>=20
> > +	dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_perio=
d);
> > +}
> > +
> > +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +				 struct pwm_state *state)
> > +{
> > +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +	u32 duty;
> > +	int val;
> > +
> > +	duty =3D readl(pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm *
> > +		     PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +	val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +	state->enabled =3D (val & BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS)) > 0;
> > +
> > +	val &=3D 0x0F;
> > +	pwm->real_period =3D div64_ul(1000000000ULL << (PWM_SIFIVE_CMPWIDTH +
> > +				    val), clk_get_rate(pwm->clk));
>=20
> Another bad line break.

Maybe just split all of these very long expressions up by introducing
temporary variables to make things more palatable?

Thierry

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkD+YACgkQ3SOs138+
s6E7jQ//UQwS8ncrUfiucp+4IA2Ttqa0MkZBKpHZFYd5NABgdUdAFrxiUkNHRx3k
Ziz1Og6o1xAcdhlQwFsirpvgkSuB27t0UPwVEfjhOtE2nsp4NlMrulqzLhhTMRqm
dJOXUdnz5DlnmXAvTVLEqwM0oVdcotD7flgqcSbJ5/C9Xj3GVnybLsYvluNrfkgD
FOO6uXAl84hwzk8eoPMVZ4xyT4M08FVyxUG4S4abayZ+ZO7qGuMCFByebbfk3qXI
9Wp/5TgEfndb5vYv0BGHwRLjTtjm7zk5x/cAQgd+i9vB3dQRTekdPg87XiY3gq2j
+Do5Otmno1yBowJ2Q5HTatN+o246BEgbaUjyqS/ZxSK5T8ei2HKZgR2fv6DQqPYy
etOx8wOfVOxgF7allr4E5hAnKhUlfV1nXE+K15vXNVeE8vTggpdQa8y8cj0Qvx2g
xfEFBlf92sEQ1uSQEvPoEBLRLKNK1N4ZlscIhKz84vrMfeN+l5vchJ9j6jCqq29l
Qi6xTgCb49tBLdhjO7Od7evIY6E7tPzax1YAg1oeNjNGm0q5xEmXH85mSILeeCO3
jdfOyaEIGGDziBcJ6xVROejOHowX+09hJQDFyK/xUQ8/U4rppxSs/cuhPAXCFRQG
/Axaqlt3wF1V1Oj0ZEwDc27VQT3I31heLxz4cyeLjCjJknUi0zU=
=VfjV
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
