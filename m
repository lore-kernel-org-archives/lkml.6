Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B9214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8LCvnja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139B9214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeKNVhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:37:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39160 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeKNVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:37:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so10828647edt.6;
        Wed, 14 Nov 2018 03:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=byX/OtL+rL+zuP2p6k3mv/phcsyHwq71c8JrYnHISfg=;
        b=h8LCvnjanEDFTC0khlBCCIHgfHopf55jORfPUDccnYegKddvuv9Onc+uo/NVcwqS99
         ekoWRE4ORzUpJc/VHiMgcnrFA7Ojl4XA6WCHttXwcD3/2h6iH6LZZMml6cfjNQoQr4DS
         B41TrhK1EabdqROTiM9P57EIDH80tyNlY4rbSkfrBd0QkAQhhWLH/hSe2lwXwJ2RPZVy
         uFFzH+WLc7VmEr1anBEDt6mh5GbvQrL1u/sY15Vo2x8IE2WVKafOSSY7OSCa6aAJPtyp
         BeO7MTiK2GzaE0pyDC8gyQ9hESu9OP19P35zbWOiTPn2NXk77WXYnGb/6ayRO2d/K8Hj
         9QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byX/OtL+rL+zuP2p6k3mv/phcsyHwq71c8JrYnHISfg=;
        b=UVNhKNz9OYUKL2sheH6eiqwzwwuHGmVDiqVeojsGkzjnCcekuz3LRenj8MQ1AuUAsE
         nX4JcZO6EXyT4LCzt0LYuFGDCRnZ8TlgPs88ypBJdX89QdVH6eRDoZz+y2GSFqC9j+3N
         c5tz0OQhJqb2ON2u4ukj7lZ3bjfNvrVoobK/8OEK9XFNxqEtITbPYqac5Vkx0FaQRNrB
         f/HmisX1BdUDQFwq+XDqSPrEm2ZKzTNTjFaAIKefuiRxE7huyElMUpbARSiB+7LqcpE5
         LA4D2Z3GgusQG421vzrbYWEs48BFEPfQYDLrt6ZMCdzDkcb0DHpMnoSOvq+yTXXMtSsj
         X7vQ==
X-Gm-Message-State: AGRZ1gJ+hkE/Hvg2sABkF6Jd6owuvRpZFa4u9ZyL9vbBkpyKiYSNFuz7
        lGUyIhsIH9N49ROl1CMoIOk=
X-Google-Smtp-Source: AJdET5dgdPULOF4Ch0X74KhA+wQyKc6A6mKqnlJ9klCBLuVOtp8Mr1TReDfXU+DxFQUsxjxafmTGOg==
X-Received: by 2002:a50:b3c9:: with SMTP id t9-v6mr1852357edd.181.1542195292014;
        Wed, 14 Nov 2018 03:34:52 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id s6-v6sm6220253edh.89.2018.11.14.03.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 03:34:50 -0800 (PST)
Date:   Wed, 14 Nov 2018 12:34:49 +0100
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
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Message-ID: <20181114113449.GB2620@ulmo>
References: <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> > On 8.11.2018 20:18, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Nov 08, 2018 at 03:21:44PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> > >> Hi Uwe,
> > >>
> > >> On 7.11.2018 16:01, Uwe Kleine-K=C3=B6nig wrote:
> > >>>> Interesting idea. I just wonder why nobody else did not come up wi=
th such
> > >>>> a simple solution before.
> > >>>
> > >>> I think I mentioned it already in this thread, but it went unnotice=
d :-)
> > >>
> > >> I meant it like "How happened this was not invented years ago, when =
people
> > >> first noticed the issue with using inverted PWM for backlight on i.M=
X6."
> > >> In our project, this issue dates back to 2015 :(
> > >>
> > >>> Then the patch isn't correct yet. The idea is always keep the hardw=
are
> > >>> running and only disable it if it's uninverted.
> > >>
> > >> OK, I got the point.
> > >>
> > >>> In imx_pwm_probe it's not yet known what the polarity is supposed t=
o be,
> > >>> right?
> > >>
> > >> Not really. It can already be known but currently there is no way ho=
w to
> > >> pass the information to the probe function. I, as a creator of the d=
evice
> > >> (and author of a DTS file) know that the circuit needs inverted PWM =
signal.
> > >> And I know that the circuit needs to be disabled until I say it can =
be
> > >> enabled. How I say that can warry. It may be default brightness leve=
l > 0
> > >> in DTS file or from a userspace program using PWM sysfs interface.
> > >>
> > >>>   So the right thing to do there is to not touch the configuration
> > >>> of the pwm. I think all states that are problematic then are also
> > >>> problematic with the gpio/pinmux approach.
> > >>
> > >> I think my use-case I already presented before is an example where
> > >> involving pinctrl solves the problem while the "leave PWM enabled
> > >> for inverted users" does not. That is all the time between
> > >> imx_pwm_probe() and imx_pwm_apply_v2().
> > >=20
> > > You're doing in probe:
> > >=20
> > >    if (pwm_is_running()):
> > >      mux(pin, function=3Dpwm)
> > >    else:
> > >      gpio_set_value(gpio, 0)
> > >      mux(pin, function=3Dgpio)
> > >=20
> > > This gives you the right level assuming the gpio specification uses t=
he
> > > right flag (GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW).
> >=20
> > Agree.
> >=20
> > > Taking your example with the backlight device you specify an "init" a=
nd
> > > a "default" pinctrl and only "default" contains the muxing for the PWM
> > > pin everything should be as smooth as necessary: The pwm is only muxed
> > > when the backlight device is successfully bound.
> >=20
> > Have you tried that Uwe? The bad news is I tested that before and now
> > again and it does not work like that. We already discussed that earlier.
>=20
> The key is that the pinmux setting for the PWM pin should be part of the
> bl pinctrl, not the pwm pinctrl. Then "default" is only setup when the
> bl device is successfully bound which is after the bl's .probe callback
> called pwm_apply().

No, that's not at all correct. Pinmux settings should reside with the
consumer of the pin. In this case, the PWM is the consumer of the pin,
whereas the backlight is the consumer of the *PWM*.

The problem with making the PWM mode the "default" pinctrl state is that
the default state will be applied before the driver is even probed. That
makes it unsuitable for this case. I think what we really want here is
explicitly "active" and "inactive" states for pinctrl where the PWM
driver controls when exactly each state is applied.

This solves the problem quite nicely because by default the pinctrl
state isn't touched. For the case where the bootloader didn't initialize
the PWM pin at all, the driver core won't do anything and keep it at the
100k pull-up default. Only when the PWM is actually taken into active
use will the "active" state (i.e. PWM mode) be applied, so that the PWM
can drive it with the right configuration to give the desired result. If
the bootloader did initialize the PWM it would also work because then at
PWM driver probe time we don't do anything either, keeping the pin in
the PWM mode as configured by the bootloader and not touching the PWM
configuration either. If hardware readout is implemented, we can load
the exact state that we're in and seamlessly take over in the kernel
driver. Enabling the PWM in this case would apply the current setting,
which should be a no-op, or at least idempotent.

> > > No I meant the pwm. Well, it's as easy as that: Whenever with your
> > > approach you configure the pin as GPIO with the output set to low,
> > > instead configure the pwm with duty_cycle to zero (or disable it).
> > > Whenever with your approach you configure the pin as GPIO with the
> > > output set to high, configure the pwm with duty_cycle to 100%. (Keepi=
ng
> > > out inverted PWMs for the ease of discussion, but the procedure can be
> > > adapted accordingly.) The only difference then is that with your
> > > approach you already "know" in pwm-imx's .probe the idle level and can
> > > configure the GPIO accordingly. With my approach you just have to wait
> > > until the first pwm_apply which (as described above) works just as we=
ll.
> >=20
> > While here I am quite confident you are talking about kernel code, righ=
t?
> > If yes, then your approach is clear to me.
> >=20
> > The problem is I am quite sure your approach does not solve the cases
> > the pinctrl solution does. And according to my tests so far it does not
> > work at all because the "init" and "default" states does not work as you
> > are saying.
>=20
> That's as pointed out above, because you're looking at the pwm's pinctrl
> and I at the pwm-consumer's pinctrl.
>=20
> Note that a sysfs consumer cannot be operated smoothly here, because
> there is no pinctrl node to add the PWM mode to that only gets active
> after the first configuration. This however is something that should not
> be addressed in the imx driver but in the pwm core (if at all).

With the pinctrl-based solution outlined above you can even operate a
sysfs consumer properly. The pinctrl states are where they belong, with
the PWM device and therefore they can be properly set when the PWM is
used, rather than waiting for a PWM consumer to muck with the pinmux.

Note how all the pieces are suddenly falling into place. In my
experience that's usually a good indication that you're on the right
track.

Thierry

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsCFYACgkQ3SOs138+
s6EEmg/+IVegheNPysHXpL7YpVsJ7M5r3GzQH1CtJymARhVbzxcOIBwAH6RN3e2n
CCrksv//ottANi195fRhXimdMyyZcIpasounYxLR/a/KYRtUsKoaZlJ3QOu1WcAW
vv7BvQ+sDXh87ZkQp39hUhPND410k9MAmkh4U+H46a8fU3I7yw1pS4U/vENxMHyM
u/d+dlH9qz1iB0sG9xyeZCDB1QHLBItoynbqnaU3M8okPC/b6lUWxfCiBj2vy6Sz
W1IAa+VaxXuvHQJSj27NAODrC5l7jQm4JjPJV0qn5wh+ljmJYS2kAJ4W/wAitD+E
ETvI8jq6P2t2EeSxSpOVFBf+LEYC/bgMac7pQiCGUC8So5Tz3w4inOYx/rncvoDd
Qz9HE3tzhZoVm6bN7y5+IbGFFzTKQFZaLBcf5keFHFa5U5upjsTaAY2YlP7GgONd
baQl1kP+EQCQ+5ACMxVBclvnOTyQapgeMaY95l3EzwXDFAYZUC5q83ow59RtP2wt
NF7x2BU/VJDdfuC+PxVuP4SRjTbXCeSX3VCzGiwIV1CRJEN90F7AQU6KO/q6rbm/
o9To/xisWO/ruJB6MHDpkOeJG/vi9T9vRJUUjhCwlbs0EZPo1fDBaJ/f268hyKog
u9ZKFLgZVJMBCpiJSRszyNhqX4vr05Q9HksdANSnmvg+pl/0+aA=
=CHJ6
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
