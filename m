Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B1C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314CE217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkWkbdPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfBEWtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:49:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfBEWtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:49:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so700549wmd.2;
        Tue, 05 Feb 2019 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lOe6AhaNDlLFQBii71HlnVRwxXGiCNurcO6nT537OOo=;
        b=ZkWkbdPt+KeIQ1GCoQHS2K1bJCIm6usPHMc4F+kfpaMtQNx0LGJG6078gcxGD4VWgk
         A7mjL2RUMR+my0u2SxOWjUeB6jEC6li6sAZbGej/XAEQxFVjunQDds3c2nlMpsj50q+k
         r2OTb2A1gmEvQMK4Z5FF6+2mnGxt82JTQPkJn4jp74S/m0xE6Z6+c54+3MRp614kl8Y1
         2jgQfIUFdOPqP7O2/CAY8t8o0IAMDGLTmsKecF/2bQEKZUTF7x35IK4OnVFx2z/M1qQ7
         xa0Mg314Qoiv7RlZjhl3jKKv0mYyPPYXdRrXwyh1Lvm5S84khPUmQkW+gRpTYWQsLQ7w
         cdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOe6AhaNDlLFQBii71HlnVRwxXGiCNurcO6nT537OOo=;
        b=aTZwYjSb3u5QQTtbpKKFDPrdxvIFBDDN3f4j7O1FWLI/SRDcaCtOVUFzap97T/46qP
         Umd3VhHIOHnA7RcX+2WUFSKKkEm1xEmtbiDX6LX/7DdEGHypCeyQb99mkmbzfGQdoDlu
         mdsoBhTbZ/AF5XS75C27nJ44t6Y/otwP3zi+PgAZ1XgCSz+dQU1gNvYqslrqTEiXqH7i
         xFK6cj0QeZgsQT3W4c+Dex1z+06UZmAnlCy7d1szL8JdrR5BMJhVKs8oxI1yGUSkLzhl
         CWeufDmGnvUWgqqIzZ7gFf3C0wEVxoyEYR0jdlzZ3QdJ+AUq3FkmGsb06u0rPxrw0mLr
         QsTQ==
X-Gm-Message-State: AHQUAublM93zMXg0Z0LQZzpksYoyan8dr+P/cmRgO2ccy4cZYMSPcGxs
        IQE3hU8r7oYUDYjloKFpnsQ=
X-Google-Smtp-Source: AHgI3IadEyDWrZ0pJsfE6LF3XS7UdCsgH34Z2wrDV1yi5vSdf7vq4K2MaU+Av6l10MW+rM6NoCjtvQ==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr703195wma.85.1549406949562;
        Tue, 05 Feb 2019 14:49:09 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id j3sm11109880wmb.39.2019.02.05.14.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 14:49:08 -0800 (PST)
Date:   Tue, 5 Feb 2019 23:49:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu.Beznea@microchip.com, corbet@lwn.net,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190205224906.GD1372@mithrandir>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2019 at 10:05:22PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com wr=
ote:
> > From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >=20
> > Add basic PWM modes: normal and complementary. These modes should
> > differentiate the single output PWM channels from two outputs PWM
> > channels. These modes could be set as follow:
> > 1. PWM channels with one output per channel:
> > - normal mode
> > 2. PWM channels with two outputs per channel:
> > - normal mode
> > - complementary mode
> > Since users could use a PWM channel with two output as one output PWM
> > channel, the PWM normal mode is allowed to be set for PWM channels with
> > two outputs; in fact PWM normal mode should be supported by all PWMs.
>=20
> I still think that my suggestion that I sent in reply to your v5 using
> .alt_duty_cycle and .alt_offset is the better one as it is more generic.
> A word about that from Thierry before putting the mode into the pwm API
> would be great.
>=20
> I don't repeat what I wrote there assuming you still remember or are
> willing to look it up at
> e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2nd ha=
lf
> of my mail).

The problem I see with .alt_duty_cycle and .alt_offset is that they
provide too much flexibility in my opinion. There may be some variance
in how the values are computed for the different modes and that just
leads to additional code required in drivers to figure out what exactly
the user wanted.

If we only provide the user with a means to say which mode they want to
operate the PWM in they can just tell us and the driver doesn't have to
guess which one was meant.

It also makes validation easier. We can check for capabilites upfront by
just comparing a list of supported modes. With .alt_duty_cycle and
=2Ealt_offset we'd actually need to run code to figure out whether or not
the given set of values corresponds to a supported configuration.

> Also I think that if the capabilities function is the way forward adding
> support to detect availability of polarity inversion should be
> considered. This would also be an opportunity to split the introduction
> of the capabilities function and the introduction of complementary mode.
> (But my personal preference would be to just let .apply fail when an
> unsupported configuration is requested.)
>=20
> > +static int pwm_get_default_caps(struct pwm_caps *caps)
> > +{
> > +	static const struct pwm_caps default_caps =3D {
> > +		.modes_msk =3D PWM_MODE_BIT(NORMAL),
> > +	};
> > +
> > +	if (!caps)
> > +		return -EINVAL;
> > +
> > +	*caps =3D default_caps;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pwm_get_caps() - get PWM capabilities of a PWM device
> > + * @pwm: PWM device to get the capabilities for
> > + * @caps: returned capabilities
> > + *
> > + * Returns: 0 on success or a negative error code on failure
> > + */
> > +int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
> > +{
> > +	if (!pwm || !caps)
> > +		return -EINVAL;
> > +
> > +	if (pwm->chip->ops->get_caps)
> > +		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
> > +
> > +	return pwm_get_default_caps(caps);
>=20
> I'd drop pwm_get_default_caps (unless you introduce some more callers
> later) and fold its implementation into pwm_get_caps.

I think Claudiu and I may have talked past one another here. What I was
suggesting was to make pwm_get_default_caps() an exported symbol so that
drivers could use it if they didn't have extra capabilities. However, it
seems like just handling that in pwm_get_caps() if ops->get_caps =3D=3D NULL
works just as well. I don't think it needs to be a different function in
this case, but I don't mind if it is.

> > +}
> > +EXPORT_SYMBOL_GPL(pwm_get_caps);
> > [...]
> > @@ -53,12 +75,14 @@ enum {
> >   * @period: PWM period (in nanoseconds)
> >   * @duty_cycle: PWM duty cycle (in nanoseconds)
> >   * @polarity: PWM polarity
> > + * @modebit: PWM mode bit
> >   * @enabled: PWM enabled status
> >   */
> >  struct pwm_state {
> >  	unsigned int period;
> >  	unsigned int duty_cycle;
> >  	enum pwm_polarity polarity;
> > +	unsigned long modebit;
>=20
> I fail to see the upside of storing the mode as 2^mode instead of a
> plain enum pwm_mode. Given that struct pwm_state is visible for pwm
> users a plain pwm_mode would at least be more intuitive.

Agreed, we should have only the specific mode in the state and let the
core deal with masks where necessary.

Thierry

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxaEt8ACgkQ3SOs138+
s6H83Q/7BbsGndKEhkUs6rn3y2yDojRF8PGq/2GCK9KCXafqOr+KR5bvhvnyfqMU
ai+UC3Ma3A9dmd2g66znXpevqHqDn2wqwXeZ+Q1wzCZdebLZghKUmifC78yYB4MV
+t0Z7dRJEaqIO89eZasrUf6XNAmN6mFOmg0kEM23a0U6XvkPK7OyS8yxE5YgEqwf
a0VuuaLAT1+xfoeI0hTuOupzqaXaj1n9hQZc8mh9MGJmINOvFMzsjH6TKpibYyVC
tvWjZm3OX9cPjn4C66p1XM2AZ0jxnp282fI882Onbi8O46clYm9PX5sqO38rsUbH
zCpCXx4JYIAjrUXIR1PFKbploAj5HhexC9x0kgL56RZi/74LlgKH7WXawDbxesMh
ZrEPgp5RmdnJM/JCGScx5/Yv97ovQ1V5eFFnSuwbWtdIWYCqsFyi+sUQ9D7XG4CN
iTTyLcaX78eWyE7tyx8/6KDcjAGNSpGwpDMR7wizNaFu3abg5kTvjflhGKpa4mki
DNNYAe9cUrCDLf0LtC1p4ekof49S8RQz38sMaNR+7w5kVGqq30AVnle6tI7qTIpD
4dVIzNJqFl2dTiMXqpNv1Ni7sQ8BtUv9wjpJ6Ui7Pg9p2fDQKJoxT2haT/abSOy2
UlcVf6ipJPNCEnMXb7/jVYp2T6eSmm1XX8yxbjwhzeybvaFyAZI=
=zAsO
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
