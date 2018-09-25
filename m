Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1451BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CDE208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng4HfSto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CDE208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeIYRYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:24:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50809 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:24:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so12977028wmc.0;
        Tue, 25 Sep 2018 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E8iStD2XgvFHQ74hZkbrRyWvsObx3V3M+Df9BcD9toY=;
        b=Ng4HfStoUYSsfdaW9I/rnZF2cSEdweuN7ppeJuX5RTxJgXxiclmpGj/9aL5scbSGki
         TwJZ3A8vjBO1tT7dcRMT9NEkNI/WanZADv9xoQxzzmCJRxGUaCnbd2C4+2hdugsLuIRq
         +eBvfAi9gv2N0nhX+9rPjjYnvMl+eIjloAbdU9LLhlTl1VyKLOEVyewKggK3q3YJpDl3
         UFNZXMrltGPLLDMq5gHN+Iqs3C6+1Th1Jpw0kTUUUdpxfp09j7/A0rfzzfztRDr6f4KJ
         TUg7hkugAGGSKy6wKQbA283hJgneo7isbQzusJlw+gS4uWdjjfVYJVrPtZzLANf2kywT
         zoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8iStD2XgvFHQ74hZkbrRyWvsObx3V3M+Df9BcD9toY=;
        b=Zi+KEaIeZj23SXZGxJ8sL+HTH7laYjDTYMSa+7gA8JgRr7Maq2EUHW+NylqeYildNz
         2SLCaUtrP9SLqpcQ8YrqXyUAJsskFr0xOMpwwMQ/1cNbKYn4HuR4rVGGJZ4fm0gZkVdh
         PxlIMBsWR9L7sHVEfXLUUSOvGKc1fB2sr++i3IGjd2APcZOvD2iTxNTvW/PIX8jJHf+U
         0hoi/K2XrB1HN/GyRdd9EfgBu6LpHe1u+EQQdqhhbAibFqlRbEEEAnhJnHRzzf3uJSCM
         9dnldLtjTXEnvLPp+1jCf3RyjtvNBxfvvTgH4UoYiAdPy1NAE9xxdg82v2QlbMCvS8N+
         HO/g==
X-Gm-Message-State: ABuFfogifKlGwQpk9DEM1rPOGor5KkIjoTSr7RW6cO51A0EJ06wVF2Up
        0Ykq5adq7FPgZof/+3Tukn0=
X-Google-Smtp-Source: ACcGV617n2hyh/zMn94wFc6j48audIteQGoxQqyndEm+e4oFFPEqLq0omkzwaDZqazPS/ag4LVM8PQ==
X-Received: by 2002:a1c:318b:: with SMTP id x133-v6mr254325wmx.145.1537874238718;
        Tue, 25 Sep 2018 04:17:18 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id r30-v6sm3008897wrc.90.2018.09.25.04.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 04:17:17 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:17:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] gpio: Add support for hierarchical IRQ domains
Message-ID: <20180925111716.GA7925@ulmo>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-7-thierry.reding@gmail.com>
 <CACRpkdYnrf7FknvnZyFSgfT5aCrcWT4hxSnQo0UqxYfR6Fkqwg@mail.gmail.com>
 <20180925093315.GB7097@ulmo>
 <CACRpkdbOpVPB5MqgCyF5x_ENzLscz5oYEstYqwVceqeKZq2w5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <CACRpkdbOpVPB5MqgCyF5x_ENzLscz5oYEstYqwVceqeKZq2w5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 12:33:54PM +0200, Linus Walleij wrote:
> On Tue, Sep 25, 2018 at 11:33 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Sep 25, 2018 at 10:11:06AM +0200, Linus Walleij wrote:
>=20
> > > While I think it is really important that we start supporting hierarc=
hical
> > > irqdomains in the gpiolib core, I want a more complete approach,
> > > so that drivers that need hierarchical handling of irqdomains
> > > can get the same support from gpiolib as they get for simple
> > > domains.
> (...)
> > > I can't see if you need to pull more stuff into the core to accomplish
> > > that, but I think in essence the core gpiolib needs to be more helpful
> > > with hierarchies.
> >
> > This is not as trivial as it sounds. I think we could probably provide a
> > simple helper in the core that may work for the majority of GPIO
> > controllers, and would be similar to irq_domain_xlate_twocell(). The
> > problem is that ->gpio_to_irq() effectively needs to convert the offset
> > of the pin in the GPIO controller to an IRQ specifier. If the IRQ domain
> > can use irq_domain_xlate_twocell(), that should be easy, but if it does
> > not, then we likely need a custom implementation as well.
>=20
> This sounds a lot like the "gpio-ranges" we have in the
> gpiochip DT bindings, mapping gpio offsets to pin offsets.
>=20
> I assume that we could just introduce a cross-mapping
> array from IRQ to IRQ in struct gpio_irq_chip for the
> hierarchical irqchip? Is it any
> more complicated than an array of [(int, int)] tuples?
>=20
> I guess this is what you have in mind for twocell?

For twocell I think it would be even easier, because the IRQ specifier
can just be reconstructed from (offset, irq_type). That's all the simple
two-cell does, right? It's a 1:1 mapping of specifier to GPIO offset to
IRQ offset.

> > For example, as you may remember, the Tegra186 GPIO controller is
> > somewhat quirky in that it has a number of banks, each of which can have
> > any number of pins up to 8. However, in order to prevent users from
> > attempting to use one of the non-existent GPIOs, we resorted to
> > compacting the GPIO number space so that the GPIO specifier uses
> > basically a (bank, pin) pair that is converted into a GPIO offset. The
> > same is done for interrupt specifiers.
>=20
> I guess this stuff is what you refer to?
>=20
> #define TEGRA_MAIN_GPIO_PORT(port, base, count, controller)     \
>         [TEGRA_MAIN_GPIO_PORT_##port] =3D {                       \
>                 .name =3D #port,                                  \
>                 .offset =3D base,                                 \
>                 .pins =3D count,                                  \
>                 .irq =3D controller,                              \
>         }
>=20
> static const struct tegra_gpio_port tegra186_main_ports[] =3D {
>         TEGRA_MAIN_GPIO_PORT( A, 0x2000, 7, 2),
>         TEGRA_MAIN_GPIO_PORT( B, 0x3000, 7, 3),
>         TEGRA_MAIN_GPIO_PORT( C, 0x3200, 7, 3),
>         TEGRA_MAIN_GPIO_PORT( D, 0x3400, 6, 3),
> (...)
>=20
> Maybe things have changed slightly.
>=20
> As I see it there are some ways to go about this:
>=20
> 1. Create one gpiochip per bank and just register the number of
> GPIOs actually accessible per bank offset from 0. This works
> if one does not insist on having one gpiochip covering all pins,
> and as long as all usable pins are stacked from offset 0..n.
> (Tegra186 doesn't do this, it is registering one chip for all.)
>=20
> 2. If the above cannot be met, register enough pins to cover all
> (e.g. 32 pins for a 32bit GPIO register) then mask off the
> unused pins in .valid_mask in the gpio_chip. This was fairly
> recently introduced to add ACPI support for Qualcomm, as
> there were valid, but unusable GPIO offsets, but it can be
> used to cut arbitrary holes in any range of offsets.
>=20
> 3. Some driver-specific way. Which seems to be what Tegra186
> is doing.
>=20
> Would you consider to move over to using method (2) to
> get a more linear numberspace? I.e. register 8 GPIOs/IRQs
> per port/bank and then just mask off the invalid ones?
> .valid_mask in gpio_chip can be used for the GPIOs and
> .valid_mask in the gpio_irq_chip can be used for IRQs.
>=20
> Or do you think it is nonelegant?

This is all pretty much the same discussion that I remember we had
earlier this year. Nothing's changed so far.

Back at the time I had pointed out that we'd be wasting a lot of memory
by registering 8 GPIOs/IRQs per bank, because on average only about 60-
75% of the GPIOs are actually used. In addition we waste processing
resources by having to check the GPIO offset against the valid mask
every time we want to access a GPIO.

I think that's inelegant, but from the rest of what you're saying you
don't see it that way.

> > Since there is no 1:1 relationship between the value in the specifier
> > and the GPIO offset, we can't use irq_domain_xlate_twocell().
>=20
> Am I right that if you switch to method (2) above this is solved
> and we get rid of the custom tegra186 xlate function =3D=3D big win?
>=20
> > I think we can probably just implement the simple two-cell version in
> > gpiochip_to_irq() directly and leave it up to drivers that require
> > something more to override ->to_irq().
>=20
> And if what I assume (in my naive thinking) you can do with
> .valid_mask is correct, then you can convert tegra186 to use
> common twocell translation.
>=20
> Sorry for being a pest, I just have a feeling we are reinventing
> wheels here, I really want to pull as many fringe cases as
> possible into gpiolib if I can so the maintenance gets
> simpler.

Like I said, we had this very discussion a couple of months ago, and I
don't think I want to go through all of it again. I think, yes, I could
make Tegra186 work with .valid_mask, even if I consider it wasteful. So
if that's what you want, I'll go rewrite the driver so we'll never have
to repeat this again.

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqGToACgkQ3SOs138+
s6ERHw//XDTW9nxwCPEzsbYFKRwbfu9e7mm8/PI/iu5Gxu1K+4SMa9F++wDJ7OB/
/NoUJU3+dzs+Gft0BqtuTuNzaLXh/J7uTo8KOmUM321oG5zsg/iYbfNDmLgTBVlP
1gDymYvzoKgqhpEoj7dFpLk7UINeJ74mYRJGqdHIqJ2nh9MN+GLM9m/Lbi4mbv42
g3w9/Muuv4U3tVrT1pEiBfDyTCmHwKzqP+Vj7i+t8Z2xoyR3PJBYKK4EXO4d40u7
NnrWmudrzDnchj41GG5Ufpe/VwLtqmsiAfCXIZBMWItFDpTosc8E+6/l1Loq6YvQ
MJd+ASxp0qteKmWXwaJPGfM4X9zT4YmM6w+hCc6thAZ+UtOCnnFAHioEobYwvODw
0taQFrNh/iLtpX29Zrwyl1vArG9yKPtFJBD6xT3O2fU3ZVAQPZyp2kvQ62xwVToT
1620TgkIR1OoSobvUPBsVNZetoaENV3UaRULb+Vf/yfGFHC/vmTKXIwZk1m7ELvc
mhZH1bQFg9TAcBqt8jva5Yz0yKAoYA8wiMcMCrb2oIi80iH3wDROxaBbGH3intiV
ju7F1tH7PHlbLbMwxfNqx96BFnsYJ6H3vP+aqohpJdgqmMKUAbnBkbuBNa8toeeQ
vFULXxlIhIFuuD4Hfw4a3gP1BpCOQT+Nzhnq7sUf1nPA+pRKK2o=
=+PDr
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
