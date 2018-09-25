Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D579C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243F020867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6NxeHj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243F020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeIYPkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:40:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:39:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so1548525wrs.0;
        Tue, 25 Sep 2018 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H0Wb0j6WarwEMAYgUXKPTL0QaODPmEkqOoQ2Crmi6MM=;
        b=b6NxeHj27QUppcutJoA5tKSjvFESVc+IJuHvfi0Bg6/hnEMKhDqrFg/KvQmBONxldW
         4ScrRzG42Xc1HQqNC5fNXIru4jcYrjepVWOmV4Gkqxpk6Ndns+H/y4T1JC9rkfnLP0Kg
         a95+oasXCALcXe3gquDB16Uq0bKCyubLWwc/wSKOVEcqqacQjJu2I3AIehPIax+JDKhW
         YQJpQy83BdD2Iv83N7r/ZTpj+EfZYsl6/x6lhDrDgJAVsWyYrdjyaKidgvzPwgyng97Y
         WjOC44kod8T8lcNuze694czphPSS4PGlFQ/T7BqrORgFmFJ/2LACrf2YUBvDOcQ+H/SU
         zl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H0Wb0j6WarwEMAYgUXKPTL0QaODPmEkqOoQ2Crmi6MM=;
        b=GxtKjpfEjXvbQ7hD+dSEJeFLmJElODyl69W6p8Xz9bwG+65FCxcQhT0r3bhrLOfga4
         QNRqp6vAXccy1waRAsUwBhGjrBzNF/kUFd91RlOe8M4M1jjDJgsV18Wv0qK0k6qAdk6M
         vKa5HwsAhShFQshO62zGXS1Y0iMrmfXdljaHoJX5Ulq0i5bDFQ530HqP2d53O4+bzIQT
         Mkrgl9/MC8xMBhLVoniuzJQPA4NUyWkb1iYPxv0CvnRAUkbb2HpUZsxWw7+tIz847Xo2
         qW8tBkU0jg7/OZGKZCUzmkocp5dEB8ys9tzV5sL1uHfvg223bnY7zmE4vaysv707c3fG
         dMXw==
X-Gm-Message-State: ABuFfogCCqaTkH+UaqgwkvdQjffhzGMNgwJKd+79FMmwbBrkq1OyDtsr
        6muXyRVaS6tDK9qO/XFKLLPjBg7D
X-Google-Smtp-Source: ACcGV62/3MLdJrF53nDGReGNxPbfNu02yKcPU77mxf3V1C955xiLBBruhEiU4oYO1irLdbTCL7YunA==
X-Received: by 2002:adf:f291:: with SMTP id k17-v6mr103005wro.263.1537867997172;
        Tue, 25 Sep 2018 02:33:17 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id h7-v6sm1635671wrs.3.2018.09.25.02.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 02:33:16 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:33:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] gpio: Add support for hierarchical IRQ domains
Message-ID: <20180925093315.GB7097@ulmo>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-7-thierry.reding@gmail.com>
 <CACRpkdYnrf7FknvnZyFSgfT5aCrcWT4hxSnQo0UqxYfR6Fkqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <CACRpkdYnrf7FknvnZyFSgfT5aCrcWT4hxSnQo0UqxYfR6Fkqwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 10:11:06AM +0200, Linus Walleij wrote:
> Hi Thierry!
>=20
> Thanks for the patch!
>=20
> I am a bit ignorant about irqdomains so I will probably need an ACK
> from some irq maintainer before I can apply this.
>=20
> On Fri, Sep 21, 2018 at 12:25 PM Thierry Reding
> <thierry.reding@gmail.com> wrote:
>=20
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hierarchical IRQ domains can be used to stack different IRQ controllers
> > on top of each other. One specific use-case where this can be useful is
> > if a power management controller has top-level controls for wakeup
> > interrupts. In such cases, the power management controller can be a
> > parent to other interrupt controllers and program additional registers
> > when an IRQ has its wake capability enabled or disabled.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> While I think it is really important that we start supporting hierarchical
> irqdomains in the gpiolib core, I want a more complete approach,
> so that drivers that need hierarchical handling of irqdomains
> can get the same support from gpiolib as they get for simple
> domains.
>=20
> > @@ -1918,7 +1918,9 @@ static int gpiochip_add_irqchip(struct gpio_chip =
*gpiochip,
> >                 type =3D IRQ_TYPE_NONE;
> >         }
> >
> > -       gpiochip->to_irq =3D gpiochip_to_irq;
> > +       if (!gpiochip->to_irq)
> > +               gpiochip->to_irq =3D gpiochip_to_irq;
>=20
> So here you let the drivers override the .to_irq() function and that
> I think gets confusing as we are asking gpiolib to handle our
> irqchip.
>=20
>=20
> > -       gpiochip->irq.domain =3D irq_domain_add_simple(np, gpiochip->ng=
pio,
> > -                                                    gpiochip->irq.firs=
t,
> > -                                                    ops, gpiochip);
> > +       if (gpiochip->irq.parent_domain)
> > +               gpiochip->irq.domain =3D irq_domain_add_hierarchy(gpioc=
hip->irq.parent_domain,
> > +                                                               0, gpio=
chip->ngpio,
> > +                                                               np, ops=
, gpiochip);
> > +       else
> > +               gpiochip->irq.domain =3D irq_domain_add_simple(np, gpio=
chip->ngpio,
> > +                                                            gpiochip->=
irq.first,
> > +                                                            ops, gpioc=
hip);
>=20
> So this part is great: if we pass in a parent domain the core helps us
> create the hierarchy.
>=20
> But the stuff in .to_irq() should also be handled in the gpiolib core:
> the irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec) for
> example. That way you should not need any external .to_irq() function.
>=20
> I can't see if you need to pull more stuff into the core to accomplish
> that, but I think in essence the core gpiolib needs to be more helpful
> with hierarchies.

This is not as trivial as it sounds. I think we could probably provide a
simple helper in the core that may work for the majority of GPIO
controllers, and would be similar to irq_domain_xlate_twocell(). The
problem is that ->gpio_to_irq() effectively needs to convert the offset
of the pin in the GPIO controller to an IRQ specifier. If the IRQ domain
can use irq_domain_xlate_twocell(), that should be easy, but if it does
not, then we likely need a custom implementation as well.

For example, as you may remember, the Tegra186 GPIO controller is
somewhat quirky in that it has a number of banks, each of which can have
any number of pins up to 8. However, in order to prevent users from
attempting to use one of the non-existent GPIOs, we resorted to
compacting the GPIO number space so that the GPIO specifier uses
basically a (bank, pin) pair that is converted into a GPIO offset. The
same is done for interrupt specifiers.

Since there is no 1:1 relationship between the value in the specifier
and the GPIO offset, we can't use irq_domain_xlate_twocell(). Similarly
we won't be able to use the standard gpiochip_to_irq() counterpart for
two cell specifiers to construct the IRQ specifier, but instead we'll
have to convert it based on the offset and the number of pins per bank
(that is, the inverse of what we do in tegra186_gpio_of_xlate()).

I think we can probably just implement the simple two-cell version in
gpiochip_to_irq() directly and leave it up to drivers that require
something more to override ->to_irq().

Another alternative that I had pondered about was to add another level
of indirection and have a generic implementation in gpiochip_to_irq()
that calls back into a new ->to_irq_fwspec() function that drivers can
implement to fill in the struct irq_fwspec as required by the
irq_domain_alloc_irqs() function. We could still provide a default
implementation for the common two-cell case, so most drivers wouldn't
have to know about it.

I don't think any of the above has massive advantages over the other.
The latter will be slightly more compact, I would assume, but the former
gives us more flexibility if we need it.

Thierry

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqANcACgkQ3SOs138+
s6FOohAAnjOywHub21XI16qhVfLaOGOM3VRJ9YjtLXEdYKmfIciVQMeVN9M72j/K
hZ+0WRz1OFtvvTIayJlGebviYwBBh2fPqSExJl018eVoOCr11usgl1EHkPITswxd
zmEuC3E0hx19wR0iBjm8O5cD02M5tJwGZrihUaWCtR2BIly98zI2YA1cDTM5aveZ
heZoW4r4NebMj+FHJZmHGx6II+JIkTkIaVd/QhGbBOmldxuMwllfTXumVE0dDtSd
bPhnqZSdWNKznn5yxxhE9jXtpN2Rnc1gCejdUDfu8iDpKhYHTvJp8tLFkm4q4cGx
rdfW1BUY45zfPTKZl7B6FSg0L/DoAw+i3TlSVj3cniqGDgp1av5P5lpjoBe2BfLK
xhRS49jjIk0FVuBClLp/dGucdHQDOYHY5iNqdizdQ+pn57B/xYtq8KGdpSZBntLX
uXUDPJfb6HGI7K+SoSyn9pZEwTZZE0R9gu5IkrR5vQ7cIaZL8lzD0l8nTeRyoUMo
hU8CINGMY5TJwWDjai20AawNQv818rFoXKmZuChowkAQOdXf9vnEWSVI8co52M5T
3qUi7I6EtjJjmxs8wlm59PCxgkGsj3hcnlHCtqi/wKmQ2OJp0pHUNLRdz+4/kWq5
8DX+oCTXpSjDOKLiCg3JJdf7vgAbx41XTfLmWNWB0b1DndOFtzE=
=eTIG
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
