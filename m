Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87600214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JebYaQ6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87600214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeIQSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:34:32 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36045 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:34:32 -0400
Received: by mail-wr1-f50.google.com with SMTP id e1-v6so17256477wrt.3;
        Mon, 17 Sep 2018 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iga7Kq0SLuIuoSBNPytemVE+NQdz4qZkTBjSz/cmr84=;
        b=JebYaQ6t1wEx0yZ7Vp+t6+Gi8FU8EQNWkCSl63fUTBLUndqhZHzNuTpuhqpJb2Ew9+
         JXybobAmcQiSWUyaouzIOjETpOEKvKSssRxDgFrr4U7Rj2TfRww9/1kpvzMnjrCshn8V
         B4NcQuy01tS+x8r5DKfc6s4ZLEuSQfBQsoo8laySw+TDmti3WSXFyynEUwOFK/YCl5m9
         SjYwFNGDKW21yx7Kd9RAtVhWKtmjLdX1bnU673A70CMyXGKKgJgyRugZt/LTRhjLYtG4
         MLIx61tLmkjnRcsI292fwbx/yv1uRB41ctFCfHq73t1SWYFdKATkexzC2nK1OK2pJILT
         /ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iga7Kq0SLuIuoSBNPytemVE+NQdz4qZkTBjSz/cmr84=;
        b=ha8nV8l+BHrN+sghvSdawlClG6Ekk+lWPAJMGa0PXatw/F/aBKxxXzOZZWnJFKJ2VK
         hOFYeCevz+a00IFSuGRoiXs1IDzFvFpGj1HtA5upyAaWX87+kuY1BbTYhnEA4wGRMxd/
         CluYirFeYPI/q/aGIckd8+I9bKXS3bctNYrsCCJxyR7KuIuD1mMiBERf2A02LPyn+Oq1
         Nw2kjaenQvT3R3VyEe/zQsLE1ItZ6WP+BO7j9ZlkieWxSQ+FxFXVXPJX+09eHppl6eLk
         zKvxjtSJIHOpcgXvnv0sGy3BHPJAvMya1m0n1L81iAFbjmyVV1JHZsS5/ODJzZV9qHgP
         VByg==
X-Gm-Message-State: APzg51AadpS4ZdLK8oESNIwuMDpqHvVg4T+xT4EEOuNCbU0igskAkqoa
        gKEKjsjYup/UloY340v3Wj0=
X-Google-Smtp-Source: ANB0VdZ9Z1Va3LPF21E5eXnbR6RCzAJM5pQxvv78nV2b8Wc8LHnOzmBlaVdNNvjXMVTuUE+pCH3zQw==
X-Received: by 2002:adf:80ea:: with SMTP id 97-v6mr17800318wrl.57.1537189634176;
        Mon, 17 Sep 2018 06:07:14 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id b5-v6sm10793575wrs.62.2018.09.17.06.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 06:07:13 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:07:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multi-parent IRQ domains
Message-ID: <20180917130712.GC27927@ulmo>
References: <20180913155945.GA19903@ulmo>
 <alpine.DEB.2.21.1809141211200.1473@nanos.tec.linutronix.de>
 <20180917095222.GA27927@ulmo>
 <alpine.DEB.2.21.1809171358070.16580@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809171358070.16580@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 02:28:01PM +0200, Thomas Gleixner wrote:
> On Mon, 17 Sep 2018, Thierry Reding wrote:
> > On Fri, Sep 14, 2018 at 12:31:18PM +0200, Thomas Gleixner wrote:
> > > Now, you need the PMC for both, the GPIOs and the RTC. What you can d=
o here
> > > is to provide two irq domains in PMC. One which has GIC as its parent=
 and
> > > one which has no parent. Surely they need to share some resources, but
> > > that should be a solvable problem.
> >=20
> > I think I have this working to some degree, finally. GPIO is still
> > proving difficult, but RTC seems to be working fine. I've currently
> > solved this by making the PMC an interrupt controller and then have
> > an interrupt-map property in its device tree node that lists those
> > wake events that we're interested in. It looks something like this:
> >=20
> > 	pmc: pmc@c360000 {
> > 		compatible =3D "nvidia,tegra194-pmc";
> > 		reg =3D <0x0c360000 0x10000>,
> > 		      <0x0c370000 0x10000>,
> > 		      <0x0c380000 0x10000>,
> > 		      <0x0c390000 0x10000>,
> > 		      <0x0c3a0000 0x10000>;
> > 		reg-names =3D "pmc", "wake", "aotag", "scratch", "misc";
> >=20
> > 		#interrupt-cells =3D <1>;
> > 		interrupt-controller;
> >=20
> > 		interrupt-map =3D /*<29 &gpio_aon TEGRA194_AON_GPIO(EE, 4)
> > 					      IRQ_TYPE_LEVEL_HIGH>,*/
> > 				<73 &gic GIC_SPI 10
> > 					 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> >=20
> > Note that I've commented out the GPIO wake event (this is for the power
> > button) because that currently crashes in the GPIO driver, probably
> > because I misunderstood how to properly implement this.
>=20
> I'm not a DT wizerd, but the GPIO cannot be linked there I think.
>=20
>     RTC ---------------------------> [ PMC domain 1] -----> GIC
>=20
>     Button --> [GPIO domain] ------> [ PMC domain 2]
>=20
> The RTC is connected to PMC domain 1 and that allocates the GIC irq.
>=20
> The button is conntected to the GPIO which connect to the PMC domain
> 2. That PMC domain has no connection to anything. It ends there.

Interesting, I was assuming the following:

    Button --> [PMC domain 2] --> [GPIO domain]

based on the hardware documentation that maps the wake events to
specific signals on the chip.

> > When I use the above code on the PMC/GPIO domain, then I see crashes
> > because the GPIO controller doesn't implement things like the ->alloc()
> > callback for its IRQ domain. But perhaps this is what I misunderstand.
> > Are you saying that for the case of GPIO I can just *not* pass through
> > all other operations and just let them be NULL? So that the only
> > callback will be ->irq_set_wake()? What I don't quite understand is how
> > the IRQ code would know how to properly set up the GPIO interrupt in
> > that case.
>=20
> Let's look at the PMC level first:
>=20
>   The PMC has a fixed number of interrupts which are avail
>=20
>   domain 1:
>=20
>        That domain is used for interrupts which have a dedicated GIC
>        interrupt line, e.g. the RTC
>=20
>        The interrupt domain needs at least:
>=20
>        alloc		=3D pmc_domain1_alloc
>=20
>        The interrupt chip has:
>=20
>        irq_mask		=3D irq_chip_mask_parent
>        irq_unmask	=3D irq_chip_unmask_parent
>        irq_eoi		=3D irq_chip_eoi_parent
>        irq_set_affinity	=3D irq_chip_set_affinity_parent
>        irq_set_type	=3D irq_chip_set_type_parent
>        irq_set_wake	=3D pmc_set_wake
>=20
>   domain 2:
>=20
>        That domain is used for interrupts which are not related to the GIC
>        directly, e.g. GPIO
>=20
>        The interrupt domain needs at least:
>=20
>        alloc		=3D pmc_domain2_alloc
>       =20
>        The interrupt chip has:
>=20
>        irq_set_wake	=3D pmc_set_wake
>=20
>=20
> Now the GPIO domain builds on top of PMC domain2
>=20
>     	i.e. the parent of the GPIO domain is PMC domain2, which means that
>     	it's part of a hierarchy and therefore needs an alloc function in
>     	the domain ops.
>=20
> 	The GPIO irq chip gains one extra callback:
>=20
>        	irq_set_wake	=3D irq_chip_set_wake_parent,

This looks interesting. I'm going to give that a try, though it may take
me a little to rework everything.

> So, I don't know how GPIOs are mapped into the PMC when they are a wakeup
> source. It might be all of them have the ability so there is some 1:1
> relation ship or if the whole GPIO -> PMC connection can be built at run
> time, but that's just an implementation detail.

There's a fixed mapping for which signals go to which wake event. Some
of those events are mapped to GPIOs, others to different signals, such
as the RTC alarm. I think I should be able to build a GPIO -> PMC map
at runtime using a static table.

Thanks,
Thierry

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlufpv0ACgkQ3SOs138+
s6ENkA//cu7KWFZKjhXrdnplGq9+Ktpf5B5IX/efs6PNvv3yMt0VTVp0GBvsqApl
W5EcCqyRF6kCZqM5isE23EXbz44dKD71aaopCqIUWDdasGxJdJyH1iLkbHaKdwHb
1PeG/kqGoMWa005Ma/b5pdqKb4e6f4B9DVraqxpQ6l2ZvcukJA7xg9pmO67xRknz
/uFuYxfyi7f7GqJKeM3BLvRnwIEMrAYWoUnqJQoCdbZRyBYukj4FWCNlXoTw5k1m
QwzveZWbF40xt6eDx9cvHibGR/EXjQvKmD3u7afws5ZREZVQ7aOvYaWkwZ2S4Znx
aEGsTLOQLDMte5A3qp/itO4gFtnB48ReHOsI1TEm0I7dn44i9a9Pz7pPhL+ZJuCQ
PLFIjYg8FyaQ0ovnKkjXiK2ODwOT5Xt1Ckh+Uwkk8hlGvvHCtrJoZ7D7hCQAU/Rw
cn23i7ohahstOt9KcGwpu16jRX5MHDBMxqrCGuY4Lq9VVEZSIvfkT7OmVS4+NX4Y
5UoCbl8b40N1i2RUMvOtFujJt9JX5jNQn48eEGgyZT/b59/8SJNPWYTqG810/EL5
To9Rilmrf8NLHWMyjZFJFCQzNTY/ugWbwBNK7WiX8osByvigLUxXNMUggWuw4bof
1KWlYwrxzE3h8go7lr+FqiP6KTwXSIbCST0qdwjv1B6hyKOlVq0=
=9Q/6
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
