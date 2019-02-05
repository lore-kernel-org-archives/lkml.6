Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B2AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C2920844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPOBDOgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfBEXBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:01:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38294 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfBEXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:01:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so5553577wrw.5;
        Tue, 05 Feb 2019 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lbr4P5N5o7NXW6Y0WDoZCkSdtEf+zUXi/Dt0g0HVwEk=;
        b=cPOBDOgbYe188N5UmKY/+OQ/eR5dHi0XE5mDL02qq/ueypt/ezwDwujhqnqf9xtMyG
         KcuMy229gC3o3pkNLHjYIoxS3D2GQtATi8talwHMDk3U+are/C8YKUHKA/3w+lzwWDjs
         eRn/4sRt2zJP+y4NYXJp6Vs4h3aCZQ/HvJfhQjrTBTUA5telAO+xsyROdpM8QuzjkQ0h
         egzaSCpKsSSBN0owQJy0YEUlCKL77TEbyAADkwC7gPkeiOeCV6dQPa001MhzAePfiCKx
         YAX3/P6hBI56FZYubnf5SVy9KBzOLqj+dXX2TUU7UCCNuS/BhQHsJeAmzwMlhUGbIEE7
         ZNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lbr4P5N5o7NXW6Y0WDoZCkSdtEf+zUXi/Dt0g0HVwEk=;
        b=DqUPDW2EFjlxT+uCXgTiWfWw4GCpG/f4INk4jfoFxJP4expwwGEvSQ5OFhcoHq3Kqr
         m8lRBcZc0w3Ufp/IzrTtYgYy7noHGAusqZJrV+Lo5Pk3Ic7EpDJWd1u8KuozPMkWOoL4
         pcntchuatBtROW5/9vsbo7Z0wHF+HGQLrzxJEVD7zWx7Yzi2Xv3VOZqoGNQaVKuPkpg8
         tpEF++2SaEWzsRBcirNBJmDwmzjO6hFVySVtDtJA9Bp1BvVmy/AKqy4Tqwi2drlTc7oL
         w54h6ukmLLXi9YKODCyne/G6PSaKxWliKFccG1qsr2fAZAppmjsVbDs6aZIGA4kXKJzB
         Iizw==
X-Gm-Message-State: AHQUAuZkPlnDZJJiqWWfj3JreAF1aAFpWuYfGNgzOu+UxYrxMXViQg8f
        IiksTc+EXcyn5yCFvx7d/K2Dt4EGGv8=
X-Google-Smtp-Source: AHgI3IZuANDZ1lOKD1rcDJrMEPSg2uqCjG5bdhnOx4B/DRLJhvJmxVIcDDsgVsc4gpgsmLTSObdpSQ==
X-Received: by 2002:a5d:4cd0:: with SMTP id c16mr5685677wrt.221.1549407687956;
        Tue, 05 Feb 2019 15:01:27 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id q9sm14202519wrv.26.2019.02.05.15.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 15:01:27 -0800 (PST)
Date:   Wed, 6 Feb 2019 00:01:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu.Beznea@microchip.com, corbet@lwn.net,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190205230125.GE1372@mithrandir>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 11:10:40PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Claudiu,
>=20
> On Mon, Jan 07, 2019 at 09:30:55AM +0000, Claudiu.Beznea@microchip.com wr=
ote:
> > On 05.01.2019 23:05, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.co=
m wrote:
> > >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> > >>
> > >> Add basic PWM modes: normal and complementary. These modes should
> > >> differentiate the single output PWM channels from two outputs PWM
> > >> channels. These modes could be set as follow:
> > >> 1. PWM channels with one output per channel:
> > >> - normal mode
> > >> 2. PWM channels with two outputs per channel:
> > >> - normal mode
> > >> - complementary mode
> > >> Since users could use a PWM channel with two output as one output PWM
> > >> channel, the PWM normal mode is allowed to be set for PWM channels w=
ith
> > >> two outputs; in fact PWM normal mode should be supported by all PWMs.
> > >=20
> > > I still think that my suggestion that I sent in reply to your v5 using
> > > .alt_duty_cycle and .alt_offset is the better one as it is more gener=
ic.
> >=20
> > I like it better my way, I explained myself why.
>=20
> I couldn't really follow your argument though. You seemed to acknowledge
> that using .alt_duty_cycle and .alt_offset is more generic. Then you
> wrote that the push-pull mode is hardware generated on Atmel with some
> implementation details. IMHO these implementation details shouldn't be
> part of the PWM API and atmel's .apply should look as follows:
>=20
> 	if (state->alt_duty_cycle =3D=3D 0) {
>=20
> 		... configure for normal mode ...
>=20
> 	} else if (state->duty_cycle =3D=3D state->alt_duty_cycle &&
> 	           state->alt_offset =3D=3D state->period / 2) {
>=20
> 		... configure for push pull mode ...
>=20
> 	} else if (state->duty_cycle + state->alt_duty_cycle =3D=3D state->perio=
d &&
> 		   state->alt_offset =3D=3D state->duty_cycle) {
>=20
> 		... configure for complementary mode ...
>=20
> 	} else {
> 		return -EINVAL;
> 	}
>=20
> If it turns out to be a common pattern, we can add helper functions =C3=
=A0 la
> pwm_is_complementary_mode(state) and
> pwm_set_complementary_mode(state, period, duty_cycle). This allows to
> have a generic way to describe a wide range of wave forms in a uniform
> way in the API (which is good) and each driver implements the parts of
> this range that it can support.

I think this is going to be the rule rather than the exception, so I'd
expect we'll see these helpers used in pretty much all drivers that
support more than just the normal mode.

But I really don't see the point in having consumers jump through hoops
to set one of the standard modes just to have the driver jump through
more hoops to determine which mode was meant.

There are only so many modes and I have never seen hardware that
actually implements the kind of fine-grained control that would be
possible with your proposal.

The goal of an API is to abstract, but .alt_duty_cycle and .alt_offset
would be an inversion of API abstraction. That is, we'd be requiring the
drivers to abstract the inputs of the API, which is the wrong way
around.

> > > I don't repeat what I wrote there assuming you still remember or are
> > > willing to look it up at
> > > e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2n=
d half
> > > of my mail).
> >=20
> > Yes, I remember it.
>=20
> I expected that, my words were more directed to Thierry than you.
> =20
> > > Also I think that if the capabilities function is the way forward add=
ing
> > > support to detect availability of polarity inversion should be
> > > considered.=20
> >=20
> > Yep, why not. But it should be done in a different patch. It is not rel=
ated
> > to this series.
>=20
> Yes, given that polarity already exists, this would be a good
> opportunity to introduce the capability function for that and only
> afterwards add the new use case with modes. (But having said this, read
> further as I think that this capability function is a bad idea.)

I don't think we need to require this. The series is already big enough
as it is and has been in the works for long enough. There's no harm in
integrating polarity support into the capability function later on.

> > > This would also be an opportunity to split the introduction
> > > of the capabilities function and the introduction of complementary mo=
de.
> > > (But my personal preference would be to just let .apply fail when an
> > > unsupported configuration is requested.)
> >=20
> > .apply fails when something wrong is requested.
>=20
> If my controller doesn't support a second output is it "wrong" to
> request complementary mode? I'd say yes. So you have to catch that in
> .apply anyhow and there is little benefit to be able to ask the
> controller if it supports it beforehand.
>=20
> I don't have a provable statistic at hand, but my feeling is that quite
> some users of the i2c frame work get it wrong to first check the
> capabilities and only then try to use them. This is at least error prone
> and harder to use than the apply function returning an error code.
> And on the driver side the upside is to have all stuff related to which
> wave form can be generated and which cannot is a single place. (Just
> consider "inverted complementary mode". Theoretically this should work
> if your controller supports complementary mode and inverted mode. If you
> now have a driver for a controller that can do both, but not at the same
> time, the separation gets ugly. OK, this is a constructed example, but
> in my experience something like that happens earlier or later.)

I think capabilities are useful in order to be able to implement
fallbacks in consumer drivers. Sure the same thing could be implemented
by trying to apply one state first and then downgrade and retry on
failure and so on, but sometimes it's more convenient to know what's
possible and determine what's the correct solution upfront.

Thierry

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxaFcEACgkQ3SOs138+
s6FVjQ//UF5fY+9gMw0xhv0ZqYGHCM53pUyeDPu6Yr6I0O15w9OC2Fu+/aeCxKH+
GzfE6ULNqmbi6BYLm+LXXLzRhXQzWaHCpThEnyVlexcqRy+Smb3UL0k5o6qveW49
HvR/L/hQpfu/I3OH2rWGuH26aenSg96F2V7+elRelVUxpMDVWF7mid1UNtoZVcBt
7HJ73Rkh8e8hNgYNCOKe7nSobxysM370jOmpwFU0XWeqBeS6WA6tNVG4TB6tyjHm
VTLZ9Fb7MiQJQwJ7GCV5VeJsXt4wm1SEW3f0C/sJ9suz7yd9G19FhxQDWndAuzel
PIYdk0NvIe6SNmrBoGupHGixKu3HOwMFv2QOaOBNzOqQ8hnAcTAqanOTAedbrj/O
wfZ1liV5nAgxikmOFIKm2SiHqSj11SLSPsZrsiEEdNo5f6yJs5zj/fXzgG9o9mrE
fCaW/LE+Vqfh8EW84KK2AQnbEmZhxPF0mPwNuKPD0xlbBbYy6skxGllfpjlVil6E
saHJt57E9KoNyCo1Iq88F1ZOFfIhV02se8W/zAuzSuKhY9fsXXGyNEsXorIq9WIH
z2ZTvGyuceFPQ+L2UIYPdaAZCG/gxO1gOob6MjKI9/tRzApnqca+egU/pAEhzxGs
xqbJahbKMPFzOguMGCn0hyQ/X41vNNa5Vyk4NDhei7ei0RCKXoA=
=1eNS
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
