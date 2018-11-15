Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7504C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFC3224E0
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHSBO6Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFC3224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbeKPBeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:34:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42474 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:34:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so12053521edp.9;
        Thu, 15 Nov 2018 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dbW9BKBu2zCHy3D60n96n5hPLvxxNewIs9vhfCDIdb0=;
        b=GHSBO6Jh+EoTmrd+MP3hl0jJXCEBb4PGfVuuZX3yr2cQHIDqLO5y7RIz9pkiSdXP9g
         WtSkymfKv7kXROPP181mSXkO1mG3ZFU86AxOh0i5wbWpDzlnCCEIoxS8ypUSzQ3TUuBW
         x3nArm2jBp8lKdfEgIOcwHxKYAi1zrh+L0IDuu5QIxsCSXyQpE58Z/kxmG8sCMTcEfHn
         in7/uuM/ZHTei7rKlZkbqjQEn7gxGHUJ7Eg63mNzHw5qj9qOAQPCf6VVxRS+z4shkTln
         V4/i5OPSg7aZepcqJ9a1x1z6+1ex+7EMcjOB0ue5+9fcq4ROFJ3+M594VtZfvXsU/XMd
         qeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dbW9BKBu2zCHy3D60n96n5hPLvxxNewIs9vhfCDIdb0=;
        b=ag9Icedr89Vk3UVCmSxXsnssRFlh0fv3UAqoeIoC4YwHHindOzdlg9MpF8FxSZGPjZ
         5lT8DJ6nw/HOnPHaomwMjkMnnCaQuMZ6VBS78tPOI6UyobEYcbeW3J/TA3gvEv0t8feS
         TnmwIyO61AzZbn95PuozrK407uqUj2WbyOrxchlzaEfzq7FvgTjzK+Kavyah5JvhiAzn
         m1evUGM5HmkznjkJ1P72l/PwscuunWPV9Md8hBuE4horyTsMl+c1MWoH0Jd3ugdbQeeg
         Qk/zIdFmxR4XPOmw/SibzAFO0t7VVrLqtu/bxRyfaJAYq9qAliqS9MXj4zdGGRHsuuNw
         1+eA==
X-Gm-Message-State: AGRZ1gK9C2CCuNAtvzyERzwY465904j4qaD/pLai2L4LUgSALu+c6P8q
        Oz1M43oTxOmi12ODPnjr5no=
X-Google-Smtp-Source: AJdET5duIORfzFW5Ahlbp9Pj3+i7l9Irgq7mxueVtNKLjkgUjTMYY/7XyGmhN8QJesvuzoNGXnZ3Nw==
X-Received: by 2002:a50:b883:: with SMTP id l3-v6mr5837764ede.188.1542295547790;
        Thu, 15 Nov 2018 07:25:47 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id s3sm4400182edm.31.2018.11.15.07.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 07:25:46 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:25:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Message-ID: <20181115152545.GA8611@ulmo>
References: <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20181114215120.vddykljqyavm64wj@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 10:51:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:
> > On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> > > > On 8.11.2018 20:18, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Taking your example with the backlight device you specify an "ini=
t" and
> > > > > a "default" pinctrl and only "default" contains the muxing for th=
e PWM
> > > > > pin everything should be as smooth as necessary: The pwm is only =
muxed
> > > > > when the backlight device is successfully bound.
> > > >=20
> > > > Have you tried that Uwe? The bad news is I tested that before and n=
ow
> > > > again and it does not work like that. We already discussed that ear=
lier.
> > >=20
> > > The key is that the pinmux setting for the PWM pin should be part of =
the
> > > bl pinctrl, not the pwm pinctrl. Then "default" is only setup when the
> > > bl device is successfully bound which is after the bl's .probe callba=
ck
> > > called pwm_apply().
> >=20
> > No, that's not at all correct. Pinmux settings should reside with the
> > consumer of the pin. In this case, the PWM is the consumer of the pin,
> > whereas the backlight is the consumer of the *PWM*.
>=20
> This is news to me. Adding Linus W. to Cc, maybe he can comment?!
>=20
> Grepping through the arm device trees it really seems common to put the
> pinctrl for the pwm pin into the pwm device. I didn't search in depth,
> but I didn't find a counter example.
>=20
> For GPIOs it is common that the pinmuxing is included in the GPIO's
> consumer pinctrl. Ditto for mdio busses whose pinctrl is included in the
> ethernet pinctrl.

GPIO is different from PWM in that the GPIO is already the pin itself
and is otherwise generic. So typically you put the pinmuxing options
into the device tree node for the consumer of the GPIO, because it is
only when the consumer uses the GPIO that you need to configure that
pin as GPIO.

For PWM, however, the PWM consumer is only the consumer of the PWM, but
the PWM device itself is the real consumer of the pin that outputs the
PWM signal. So the PWM determines when the pinmux states need to be
applied, whereas the consumer of the PWM only deals with the PWM.

For MDIO busses, I think they are usually part of, and driven by, the
ethernet controller, so again it makes sense to put the pinmux into the
node of the ethernet controller, because the ethernet controller is the
user of the pins.

> > The problem with making the PWM mode the "default" pinctrl state is that
> > the default state will be applied before the driver is even probed. That
> > makes it unsuitable for this case. I think what we really want here is
> > explicitly "active" and "inactive" states for pinctrl where the PWM
> > driver controls when exactly each state is applied.
>=20
> Note that this problem goes away nicely if the pwm pin is attached to
> the backlight. Because it's the backlight's driver that "knows" when the
> pwm is configured correctly and so the already existing mechanisms that
> setup the mux when the bl is correctly probed do the right thing at the
> right time.

Actually that's not exactly true. The default pinctrl state will be
applied before the driver's ->probe() implementation, so the pinctrl
state will be active some time before even the backlight driver gets
around to setting up the PWM. If you look at drivers/base/dd.c you'll
see that really_probe() calls pinctrl_bind_pins() before calling the
driver's ->probe() and will select the default state (unless there's
also an "init" state defined, in which case that will get applied and
only after successful probe will the default state be selected).

So if you use only a default state, then you could even get into a
situation where ->probe() return -EPROBE_DEFER and it would potentially
take several seconds before the driver is reprobed, during which time
the pinmux will already be set up but the PWM not configured properly
and potentially outputting the wrong level.

> > This solves the problem quite nicely because by default the pinctrl
> > state isn't touched. For the case where the bootloader didn't initialize
> > the PWM pin at all, the driver core won't do anything and keep it at the
> > 100k pull-up default.
>=20
> Ditto if the pwm pinctrl is attached to the consumer without having to
> introduce new pwm-specific stuff.

Well yes, but you'd obviously also have to avoid using the "default"
state, otherwise you'd run into the issues that I described above.

> > > > > No I meant the pwm. Well, it's as easy as that: Whenever with your
> > > > > approach you configure the pin as GPIO with the output set to low,
> > > > > instead configure the pwm with duty_cycle to zero (or disable it).
> > > > > Whenever with your approach you configure the pin as GPIO with the
> > > > > output set to high, configure the pwm with duty_cycle to 100%. (K=
eeping
> > > > > out inverted PWMs for the ease of discussion, but the procedure c=
an be
> > > > > adapted accordingly.) The only difference then is that with your
> > > > > approach you already "know" in pwm-imx's .probe the idle level an=
d can
> > > > > configure the GPIO accordingly. With my approach you just have to=
 wait
> > > > > until the first pwm_apply which (as described above) works just a=
s well.
> > > >=20
> > > > While here I am quite confident you are talking about kernel code, =
right?
> > > > If yes, then your approach is clear to me.
> > > >=20
> > > > The problem is I am quite sure your approach does not solve the cas=
es
> > > > the pinctrl solution does. And according to my tests so far it does=
 not
> > > > work at all because the "init" and "default" states does not work a=
s you
> > > > are saying.
> > >=20
> > > That's as pointed out above, because you're looking at the pwm's pinc=
trl
> > > and I at the pwm-consumer's pinctrl.
> > >=20
> > > Note that a sysfs consumer cannot be operated smoothly here, because
> > > there is no pinctrl node to add the PWM mode to that only gets active
> > > after the first configuration. This however is something that should =
not
> > > be addressed in the imx driver but in the pwm core (if at all).
> >=20
> > With the pinctrl-based solution outlined above you can even operate a
> > sysfs consumer properly. The pinctrl states are where they belong, with
> > the PWM device and therefore they can be properly set when the PWM is
> > used, rather than waiting for a PWM consumer to muck with the pinmux.
> >=20
> > Note how all the pieces are suddenly falling into place. In my
> > experience that's usually a good indication that you're on the right
> > track.
>=20
> OK, sysfs is the only point where the "put pinctrl stuff into the pwm
> core (or driver)" is superior to the already existing and otherwise
> completely working status quo. (Apart from bugs that need fixing in
> your scenario, too.)

Nope, sorry. It's superior in all of the other cases as well. You've
said elsewhere already that the prerequisite for the current solution to
support inverse polarity with the i.MX driver is to keep the driver
running, even after the PWM is no longer used. Sorry but that's just not
an option for me.

> Given that I would not want to encourage people to stick to the sysfs
> interface for their use case, that's ok IMHO. (And note that with the
> bootloader's help you can even do this in a smooth way today.)

No it's not. sysfs is a supported interface, so we shouldn't treat it
differently from the other in-kernel users. And we also shouldn't rely
on bootloaders to always do the right thing. People may not always be
able to update the bootloader, or they may not have a use to drive a
PWM from the bootloader and hence choose to leave it uninitialized.

> Other than that my approach looks more elegant to me (which obviously is
> subjective). It works in all cases apart from sysfs (which is special
> because it's not integrated into the device model) and there is no need
> to teach the pwm framework about pinmuxing and invent new pinctrl modes
> for it.

Elegance is useless if what you have doesn't work consistently and
reliably.

I don't understand your resistance to the pinctrl work. It's not rocket
science. Michal already posted patches showing how it can be done and
they're not very complicated. Also we're not doing anything out of the
ordinary here. This is exactly the purpose of the pinctrl framework, so
let's use the best tool at hand.

> Also dts writes don't need to lookup the needed GPIO numbers and pinctrl.

Just to clarify: I don't think that we need to get the GPIO number
involved in this case, because we don't have to reconfigure the pin as
GPIO to make this work. The only reason that Michal's proposal did that
is because that was believed to be necessary. But if the pin can just be
configured with a 100k pull-up, that's enough to pull the pin high when
we need it.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvtj/YACgkQ3SOs138+
s6GX3g/+LdhfKYozQSlo+oi7db8jjx/mGKLv2OhdL4m8nSlogp+YFkGNVW+oTpLd
IthlESqcWUYT5PhYeyg6uGSKyt/dfCslYIgylRTKh/cgUiz4F+IE6IxIgMXtIP01
TzUKE4ZncnxJQIm4vv99oh1ONsjffmJdo9Yd/gTVLm6K+jVv8m7YRBSujLcwdWxo
HLfioDyzce7TN1GbfNhyediHJKsOqU8lPtIOfvmfSXY/xwrvejsV6qQTIQRx6f0D
pMebt3pCF+sKKnb5/TCgRZm/ZOOOKugg5ZJx7GwW/M2v9mBowC93hgzno+qh2Up+
Y6opy/OKbKmwHCngxSeDQTpgGmB7yVxUzQW/zWm6y/MbBSxHqauZtkt8w+ddJgvn
4nPv1tVRIhk19Duq6BxXtQkxssedRl8wzPdy+H/2MdKZlodsSA4Usxb9Fwi8o7/t
UTHDM8Tobux5uf6rIf0j3xLkN7yMSPprOr9ZYi0aHGpLNkITNlyGafCG0oMGzuc8
sMMlMQJOFhAt6HNDcSFstHq7sEtIYCg/hZxO/FzYjIJJJdc/PKqQ5whKPrjOnsxv
6xcgU6XADqwqC8G+4s6tPGRxK1jBJbHEEuHxFr0TCsxk2Te2Qoz7wFEgKf3zBA+W
KKyo3xcJ2NgARVIXFdD8M5HqNvT6Iib2WWAjCmnX0tQssIJtkyw=
=M5r+
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
