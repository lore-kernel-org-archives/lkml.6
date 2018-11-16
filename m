Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61FFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E682086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHQSYdy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E682086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbeKPUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:03:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeKPUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:03:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so14341128edb.4;
        Fri, 16 Nov 2018 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ChgPKzL+lmVXkXSw+iHJIXpRoQHcFPJzANklYVNlQsY=;
        b=HHQSYdy/7ycT22r0MI3Vm+luKzY9xTRrpNH79d45g8017LkTIyQzUeUuzmFmJ5y5Qs
         AlHan5Io149/cnwOm4EIs85PaqGFORHh7dSD38H0YeVfiQTMktzwIkYG4JWA9ghzOBXt
         MdReVuj9UoQ40n53CUgoOSVrZSc8sTNvKVMj6ji6cp9h7+CFRriueH67NJbL1+tEdQ2X
         9iFB6IgK1IR6XViOk3gAzqf8kkKonH2QKTT7+6djHNUQ8D1ZKh3KfmuLVw3lc78V5/+k
         e+JaYGFtPN0o3jcfSwcrrSb+QXMgi+/q1SuzowBdcABqM+vcS0EFpe6q2Obz0inZKpRn
         3HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ChgPKzL+lmVXkXSw+iHJIXpRoQHcFPJzANklYVNlQsY=;
        b=XymyVAuFKXfRPlT6Hss72c1Y3Qa1TfC8S7d3coT43Parb7CEuj23viGWQN5f+C1Sjj
         D7R+gJpqm/hE3hIcBX5cSkqi+41JL5D1QERNzH1WnUeGAHWDcdvlMWn8o4glX+I5Zl7f
         zA1zPHdoUFMKFrfXgrE1LQXFi6V3tmicmke2525eqBzwy08PDVVmJZZWyBv6ABdGUKKv
         k4VD8ejFXV9C+kt5Xe0G4uNGlUajdm5mWJo/N6jWIxeoUCu1l2BIRkRiPfYsmhBbxxJ2
         PCevjFVddXFVyfwtjoEbVvZRGKUcS8QgqO3HY6OX02Nv0SeE4QZjjenRS3m7WZ7DzVqP
         Rj9Q==
X-Gm-Message-State: AGRZ1gI4ZOShRIlnnef5YRhmzidpEib4HwSRXcsg9c5VWM2+CrDf7eFz
        UUR/U2Y7VDes5a+qcBdd9Q9oqlFF
X-Google-Smtp-Source: AJdET5dRH1ZkLdQraOIH6NxDXFVsOzKFJvZ9Ov/AHeBu+PyI9DKHSlEeBByv1TpV8XFBtrlNQ4BMiw==
X-Received: by 2002:aa7:d597:: with SMTP id r23mr8986974edq.51.1542361886753;
        Fri, 16 Nov 2018 01:51:26 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id e53sm6417435ede.90.2018.11.16.01.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 01:51:25 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:51:24 +0100
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
Message-ID: <20181116095124.GA28631@ulmo>
References: <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 09:37:33PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:
> > On Wed, Nov 14, 2018 at 10:51:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:
> > > > On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vok=C3=A1=C4=8D Michal =
wrote:
> > > > > > On 8.11.2018 20:18, Uwe Kleine-K=C3=B6nig wrote:
> > > > > > > Taking your example with the backlight device you specify an =
"init" and
> > > > > > > a "default" pinctrl and only "default" contains the muxing fo=
r the PWM
> > > > > > > pin everything should be as smooth as necessary: The pwm is o=
nly muxed
> > > > > > > when the backlight device is successfully bound.
> > > > > >=20
> > > > > > Have you tried that Uwe? The bad news is I tested that before a=
nd now
> > > > > > again and it does not work like that. We already discussed that=
 earlier.
> > > > >=20
> > > > > The key is that the pinmux setting for the PWM pin should be part=
 of the
> > > > > bl pinctrl, not the pwm pinctrl. Then "default" is only setup whe=
n the
> > > > > bl device is successfully bound which is after the bl's .probe ca=
llback
> > > > > called pwm_apply().
> > > >=20
> > > > No, that's not at all correct. Pinmux settings should reside with t=
he
> > > > consumer of the pin. In this case, the PWM is the consumer of the p=
in,
> > > > whereas the backlight is the consumer of the *PWM*.
> > >=20
> > > This is news to me. Adding Linus W. to Cc, maybe he can comment?!
> > >=20
> > > Grepping through the arm device trees it really seems common to put t=
he
> > > pinctrl for the pwm pin into the pwm device. I didn't search in depth,
> > > but I didn't find a counter example.
> > >=20
> > > For GPIOs it is common that the pinmuxing is included in the GPIO's
> > > consumer pinctrl. Ditto for mdio busses whose pinctrl is included in =
the
> > > ethernet pinctrl.
> >=20
> > GPIO is different from PWM in that the GPIO is already the pin itself
> > and is otherwise generic. So typically you put the pinmuxing options
> > into the device tree node for the consumer of the GPIO, because it is
> > only when the consumer uses the GPIO that you need to configure that
> > pin as GPIO.
> >=20
> > For PWM, however, the PWM consumer is only the consumer of the PWM, but
> > the PWM device itself is the real consumer of the pin that outputs the
> > PWM signal. So the PWM determines when the pinmux states need to be
> > applied, whereas the consumer of the PWM only deals with the PWM.
> >=20
> > For MDIO busses, I think they are usually part of, and driven by, the
> > ethernet controller, so again it makes sense to put the pinmux into the
> > node of the ethernet controller, because the ethernet controller is the
> > user of the pins.
>=20
> Maybe it was a bad idea to broaden the discussion to talk about gpios
> and ethernet stuff here. I'd still consider it a valid construct to put
> the pwm pin into the backlight's pinctrl unless Linux W. disagrees.

But why? The backlight doesn't care about the specific pinmuxing of the
PWM pin. All it cares about is the PWM signal. That's the level of
abstraction that the PWM consumer expects, anything lower level belongs
in the PWM driver.

> > > > The problem with making the PWM mode the "default" pinctrl state is=
 that
> > > > the default state will be applied before the driver is even probed.=
 That
> > > > makes it unsuitable for this case. I think what we really want here=
 is
> > > > explicitly "active" and "inactive" states for pinctrl where the PWM
> > > > driver controls when exactly each state is applied.
> > >=20
> > > Note that this problem goes away nicely if the pwm pin is attached to
> > > the backlight. Because it's the backlight's driver that "knows" when =
the
> > > pwm is configured correctly and so the already existing mechanisms th=
at
> > > setup the mux when the bl is correctly probed do the right thing at t=
he
> > > right time.
> >=20
> > Actually that's not exactly true. The default pinctrl state will be
> > applied before the driver's ->probe() implementation, so the pinctrl
> > state will be active some time before even the backlight driver gets
> > around to setting up the PWM. If you look at drivers/base/dd.c you'll
> > see that really_probe() calls pinctrl_bind_pins() before calling the
> > driver's ->probe() and will select the default state (unless there's
> > also an "init" state defined, in which case that will get applied and
> > only after successful probe will the default state be selected).
> >=20
> > So if you use only a default state, then you could even get into a
> > situation where ->probe() return -EPROBE_DEFER and it would potentially
> > take several seconds before the driver is reprobed, during which time
> > the pinmux will already be set up but the PWM not configured properly
> > and potentially outputting the wrong level.
>=20
> If you reread my suggestion to Michal completely you will notice I got
> that right.
>=20
> > > > This solves the problem quite nicely because by default the pinctrl
> > > > state isn't touched. For the case where the bootloader didn't initi=
alize
> > > > the PWM pin at all, the driver core won't do anything and keep it a=
t the
> > > > 100k pull-up default.
> > >=20
> > > Ditto if the pwm pinctrl is attached to the consumer without having to
> > > introduce new pwm-specific stuff.
> >=20
> > Well yes, but you'd obviously also have to avoid using the "default"
> > state, otherwise you'd run into the issues that I described above.
>=20
> I'd need "default" and "init", right.
>=20
> > > > > > > No I meant the pwm. Well, it's as easy as that: Whenever with=
 your
> > > > > > > approach you configure the pin as GPIO with the output set to=
 low,
> > > > > > > instead configure the pwm with duty_cycle to zero (or disable=
 it).
> > > > > > > Whenever with your approach you configure the pin as GPIO wit=
h the
> > > > > > > output set to high, configure the pwm with duty_cycle to 100%=
=2E (Keeping
> > > > > > > out inverted PWMs for the ease of discussion, but the procedu=
re can be
> > > > > > > adapted accordingly.) The only difference then is that with y=
our
> > > > > > > approach you already "know" in pwm-imx's .probe the idle leve=
l and can
> > > > > > > configure the GPIO accordingly. With my approach you just hav=
e to wait
> > > > > > > until the first pwm_apply which (as described above) works ju=
st as well.
> > > > > >=20
> > > > > > While here I am quite confident you are talking about kernel co=
de, right?
> > > > > > If yes, then your approach is clear to me.
> > > > > >=20
> > > > > > The problem is I am quite sure your approach does not solve the=
 cases
> > > > > > the pinctrl solution does. And according to my tests so far it =
does not
> > > > > > work at all because the "init" and "default" states does not wo=
rk as you
> > > > > > are saying.
> > > > >=20
> > > > > That's as pointed out above, because you're looking at the pwm's =
pinctrl
> > > > > and I at the pwm-consumer's pinctrl.
> > > > >=20
> > > > > Note that a sysfs consumer cannot be operated smoothly here, beca=
use
> > > > > there is no pinctrl node to add the PWM mode to that only gets ac=
tive
> > > > > after the first configuration. This however is something that sho=
uld not
> > > > > be addressed in the imx driver but in the pwm core (if at all).
> > > >=20
> > > > With the pinctrl-based solution outlined above you can even operate=
 a
> > > > sysfs consumer properly. The pinctrl states are where they belong, =
with
> > > > the PWM device and therefore they can be properly set when the PWM =
is
> > > > used, rather than waiting for a PWM consumer to muck with the pinmu=
x.
> > > >=20
> > > > Note how all the pieces are suddenly falling into place. In my
> > > > experience that's usually a good indication that you're on the right
> > > > track.
> > >=20
> > > OK, sysfs is the only point where the "put pinctrl stuff into the pwm
> > > core (or driver)" is superior to the already existing and otherwise
> > > completely working status quo. (Apart from bugs that need fixing in
> > > your scenario, too.)
> >=20
> > Nope, sorry. It's superior in all of the other cases as well. You've
> > said elsewhere already that the prerequisite for the current solution to
> > support inverse polarity with the i.MX driver is to keep the driver
> > running, even after the PWM is no longer used. Sorry but that's just not
> > an option for me.
>=20
> You want that after pwm_disable() the pin still keeps the idle level. As
> the hardware doesn't provide this feature "as is" something has to be
> done about it. This can be reached either by operating the pin as PWM
> with 0% duty cycle or by switching to GPIO that is configured to the
> desired level. From the PWM driver's POV the first is the more natural,
> as this can be accomplished with the registers this driver cares about
> anyhow.

We've been over this before. Yes, as long as you operate the pin as PWM
it's okay to just actively drive it. But once you no longer use the pin,
why would you want to still actively drive it?

> Also note this is similar in the pwm-bcm-kona driver that doesn't seem
> to have the concept of "disable" at all. kona_pwmc_disable() just sets
> up 0% duty cycle. In my eyes this is an argument that is good enough to
> at least nack the imx-specific implementation of that pinctrl stuff.

It's not a good enough argument for me. It's certainly possible that not
all PWM driver can be made to behave exactly as needed. pwm-bcm-kona
might be one of those, but that doesn't mean that everybody else should
be restricted to the same behaviour. If we can make i.MX behave exactly
right, then we should do that.

> If the pinctrl idea is implemented in the pwm core, I won't object.

Let me see if I get this straight: you're not objecting to the idea of
implementing the pinctrl solution, your only objection is to put it in
the i.MX driver?

> > > Other than that my approach looks more elegant to me (which obviously=
 is
> > > subjective). It works in all cases apart from sysfs (which is special
> > > because it's not integrated into the device model) and there is no ne=
ed
> > > to teach the pwm framework about pinmuxing and invent new pinctrl mod=
es
> > > for it.
> >=20
> > Elegance is useless if what you have doesn't work consistently and
> > reliably.
> >=20
> > I don't understand your resistance to the pinctrl work. It's not rocket
> > science. Michal already posted patches showing how it can be done and
> > they're not very complicated. Also we're not doing anything out of the
> > ordinary here. This is exactly the purpose of the pinctrl framework, so
> > let's use the best tool at hand.
>=20
> In my last exchange with Michal I had the impression that he liked
> my approach, too.

My impression was that he was trying to find concensus. But the way I
read it he was still arguing that the pinctrl solution was still the
most complete, and would therefore still prefer it.

> > > Also dts writes don't need to lookup the needed GPIO numbers and pinc=
trl.
> >=20
> > Just to clarify: I don't think that we need to get the GPIO number
> > involved in this case, because we don't have to reconfigure the pin as
> > GPIO to make this work. The only reason that Michal's proposal did that
> > is because that was believed to be necessary. But if the pin can just be
> > configured with a 100k pull-up, that's enough to pull the pin high when
> > we need it.
>=20
> Unless the gpio happens to be configured as output at the wrong value.
> Further I'm not sure if the pwm in disabled state actively pulls to 0
> and if in this state the PU of the pin is good enough to ensure a one
> here. That would need verification first.

The idea is to *not* configure the GPIO as output and output the wrong
value. The idea is to not use the GPIO at all and instead use whatever
the hardware default is that makes it such that the backlight is off by
default at boot.

Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvukxkACgkQ3SOs138+
s6Gzow/8CAQA93Y9Jl6Bcb59QvOWK+6E12hQ+kK4a2ACKIlxkN8GHdI160Gmdt3e
uBM2NkAYVDptbDQoomu/n7izXWkTx2nGEzJPWBTLWvSQOCpxrhqzuz1dmWLsmHXo
oy0LYkivScfC7xozlvnlDbUfwfQyQUqCRhXmgWBKIvj0nUwLTpHNxyc64lHFWlhY
aMp5h07N3m38z804jUmMGyizr7fXzMWwX5y6uuB659VvREnTnNxYkHgCQBN2oRSR
JexBcyhEY9Ds6ch15YUF6CumVZ0uh/jY/39MDalcY5hW30nVt8/Kb0iY7IrmN2UR
fjlDtJvZrNykAkrzpcJ0MdtqM81SKLb1qpGZal6lMuBPka3JHFfJ7n1Y0GIdLx8H
8j5W0akNL+ugMXFta5qTbLTCgjFA/qbMvC1yftuNEYWtnqjN5n15VI/b0BFyA5XD
Eai4OXc7TtMlKp8laKQT5ulA7M4SBWWJn1TKnl+thMCstKkbhbZ0LjLmUKom2qZV
SevisXmr+SVdx91Evf97UO0wHfF7D7sZJLxCszQ9uX2Z6Qap5ur5GMXBuGQSSlnL
nhYUK110qUhNjWAi5nrWByDPj7zHFpxa8GwP0s8xaEo+k2ym6U4fPqGQ3gQQNjCp
7yJgER8CVJOoOwoHym3yfxGnAeSQN1iXRcBLOOkJftONBYV8u7I=
=k4FX
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
