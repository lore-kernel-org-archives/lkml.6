Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeBVUqU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeBVUqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:46:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC3821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 22 Feb 2018 21:46:15 +0100
From: Sebastian Reichel <sre@kernel.org>
To: "Pierre Bourdon (delroth)" <delroth@google.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andre Heider <a.heider@gmail.com>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] max17042: propagate of_node to power supply device
Message-ID: <20180222204615.ogyplmoq5oxpudtk@earth.universe>
References: <20180220150318.138827-1-delroth@google.com>
 <CAHp75Vck_8G=zTD4ftYC7yd+q_6XiXWvs+kX_zqr6bUtMUf4wg@mail.gmail.com>
 <CANEr7oWE7Po4ReN8+oX4CEzrbjmnhSJpwmfgjyidB6dqP0m8Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="26ephqnfeu7zwo66"
Content-Disposition: inline
In-Reply-To: <CANEr7oWE7Po4ReN8+oX4CEzrbjmnhSJpwmfgjyidB6dqP0m8Gg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--26ephqnfeu7zwo66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 20, 2018 at 06:58:56PM +0100, Pierre Bourdon (delroth) wrote:
> On Tue, Feb 20, 2018 at 6:34 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Feb 20, 2018 at 5:03 PM, Pierre Bourdon <delroth@google.com> wr=
ote:
> >> max17042_get_status uses the core power_supply_am_i_supplied. That
> >> function relies on DT properties to figure out the power supply
> >> topology, and will error out without DT.
> >
> >> +       psy_cfg.of_node =3D dev->of_node;
> >
> > Perhaps do this in general manner, see how GPIOLIB takes care of it:
> >
> > $ git grep -n -A4 -w CONFIG_OF_GPIO -- drivers/gpio/gpiolib.c
> > drivers/gpio/gpiolib.c:1161:#ifdef CONFIG_OF_GPIO
> > drivers/gpio/gpiolib.c-1162-    /* If the gpiochip has an assigned OF
> > node this takes precedence */
> > drivers/gpio/gpiolib.c-1163-    if (chip->of_node)
> > drivers/gpio/gpiolib.c-1164-            gdev->dev.of_node =3D chip->of_=
node;
> > drivers/gpio/gpiolib.c-1165-#endif
> > ...
>=20
> Makes sense. From a quick look in existing drivers, it looks like the
> only values being used currently as psy_cfg.of_node are the nodes from
> the parent device, so it seems like it could be made generic.
>=20
> Are we aware of any driver that is not propagating the of_node on
> purpose? Is this something that should be supported? If not, I guess
> we could get rid of power_supply_config.of_node and always use the one
> from the parent device in __power_supply_register.
>=20
> (I'm very new to this codebase, sorry for the possibly dumb questions!)

I think it makes sense to keep psy_cfg.of_node in case a driver
needs to use a subnode for some reason. I think it makes sense
to use dev->of_node as default value, though. Anyways I have
applied this patch to my fixes branch.

-- Sebastian

--26ephqnfeu7zwo66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqPLBcACgkQ2O7X88g7
+ppjFA/+PRt8FMjEIR1vVxiTVLez1RlvQjwONxqN4dWZ9tcCQC0uRwBOUp0vfEiP
tQA/oqn/ixaiezlDRTw9p8OVxe0olbV4FCn1hcOg8FhEV4KrHsDA35mC/306XRqD
zJql2WqNH/a77xSIuXAKTv9yNClLwXMnR/owBsF7iQBLvi4ntlUlY0lDBL9t8YFk
LqduDO8dOeKj9XtjH/C5KxvZ9+AWi34CiMr6a2/OYggPpNMqwmB6AXgtnuv0uXmK
3IXCDv5peb0zN/7vlbXPdNBokdePuptubQflWF8NqX9ZAyW7UmnJ2k1bqTUT33yb
L6toWlw2Sv/3EwsaDPzaIhhmxMY10F/F9YFi+D10HkVqDYNGSlPSDiuue1RpW4uL
gz35bFWXPbkzppZX+5h6OZL9mEp6+D01XkL+dqcvXxXSezyoSVN4vZ95y4q6N3G3
dDmcM65Ed2kqpm+aAY9Bl0rcxm0k6d6ODqOVs6lU2anWRDX0WEW72EtEqJWclEoF
anCmEXdObmTM6jTDX29vOLFeu0alTiP+4Vs/nzenWk2IlqCaUz0JSF1KDiCHdxSN
3hRahF+RGOsEzY7AUNoaysemKS0A9VJGAciXVIedcfOgGbpUKOxZPuk5E3U4HHbw
sVGdPdVDrvncynvl85SXHg3jkZf09ShMOBKUrLRLfvwIzHRIzPw=
=AY/4
-----END PGP SIGNATURE-----

--26ephqnfeu7zwo66--
