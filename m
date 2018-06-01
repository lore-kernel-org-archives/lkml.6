Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeFAJgV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:36:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50202 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeFAJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:36:17 -0400
X-Google-Smtp-Source: ADUXVKI1yXcuqTnSIMfYP9Wfy5jtsDyKn/U/8wLS+Nt0Hdnn9pQeGwPKjOmc8LgE1sWwMK7bt8kQcQ==
Date: Fri, 1 Jun 2018 11:36:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO
 descriptor only
Message-ID: <20180601093614.GA29298@ulmo>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org>
 <20180601093511.GA11734@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20180601093511.GA11734@ulmo>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 11:35:11AM +0200, Thierry Reding wrote:
> On Mon, May 14, 2018 at 10:06:22AM +0200, Linus Walleij wrote:
> > As we augmented the regulator core to accept a GPIO descriptor instead
> > of a GPIO number, we can augment the fixed GPIO regulator to look up
> > and pass that descriptor directly from device tree or board GPIO
> > descriptor look up tables.
> >=20
> > Some boards just auto-enumerate their fixed regulator platform devices
> > and I have assumed they get names like "fixed-regulator.0" but it's
> > pretty hard to guess this. I need some testing from board maintainers to
> > be sure. Other boards are straight forward, using just plain
> > "fixed-regulator" (ID -1) or "fixed-regulator.1" hammering down the
> > device ID.
> >=20
> > The OMAP didn't have proper label names on its GPIO chips so I have fix=
ed
> > this with a separate patch to the GPIO tree, see
> > commit 088413bc0bd5f5fb66ca22a19d66a49d7154ba4c
> > "gpio: omap: Give unique labels to each GPIO bank/chip"
> >=20
> > It seems the da9055 and da9211 has never got around to actually passing
> > any enable gpio into its platform data (not the in-tree code anyway) so=
 we
> > can just decide to simply pass a descriptor instead.
> >=20
> > The fixed GPIO-controlled regulator in mach-pxa/ezx.c was confusingly n=
amed
> > "*_dummy_supply_device" while it is a very real device backed by a GPIO
> > line. There is nothing dummy about it at all, so I renamed it with the
> > infix *_regulator_* as part of this patch set.
> >=20
> > For the patch hunk hitting arch/blackfin I would say I do not expect
> > testing, review or ACKs anymore so if it works, it works.
> >=20
> > The hunk hitting the x86 BCM43xx driver is especially tricky as the num=
ber
> > comes out of SFI which is a mystery to me. I definately need someone to
> > look at this. (Hi Andy.)
> >=20
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Check the x86=
 BCM stuff
> > Cc: Alexander Shiyan <shc_work@mail.ru> # i.MX boards user
> > Cc: Haojian Zhuang <haojian.zhuang@gmail.com> # MMP2 maintainer
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi> # OMAP1 maintainer
> > Cc: Tony Lindgren <tony@atomide.com> # OMAP1,2,3 maintainer
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com> # EM-X270 maintainer
> > Cc: Robert Jarzmik <robert.jarzmik@free.fr> # EZX maintainer
> > Cc: Philipp Zabel <philipp.zabel@gmail.com> # Magician maintainer
> > Cc: Daniel Mack <zonque@gmail.com> # Raumfeld maintainer
> > Cc: Marc Zyngier <marc.zyngier@arm.com> # Zeus maintainer
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO =
maintainer
> > Cc: Russell King <rmk+kernel@armlinux.org.uk> # SA1100
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v2->v3:
> > - Resending.
> > ChangeLog v1->v2:
> > - Rebase the patch on mainline with Blackfin gone and other changes.
> > - Fix up the new users that appeared in sa1100
> > - Drop some suplus comments in x86.
> > ---
> >  arch/arm/mach-imx/mach-mx21ads.c              | 13 +++++++-
> >  arch/arm/mach-imx/mach-mx27ads.c              | 12 ++++++-
> >  arch/arm/mach-mmp/brownstone.c                | 12 ++++++-
> >  arch/arm/mach-omap1/board-ams-delta.c         | 14 +++++++-
> >  arch/arm/mach-omap2/pdata-quirks.c            | 16 ++++++++-
> >  arch/arm/mach-pxa/em-x270.c                   |  1 -
> >  arch/arm/mach-pxa/ezx.c                       | 33 ++++++++++++-------
> >  arch/arm/mach-pxa/magician.c                  |  2 +-
> >  arch/arm/mach-pxa/raumfeld.c                  | 12 +++++--
> >  arch/arm/mach-pxa/zeus.c                      | 23 +++++++++++--
> >  arch/arm/mach-s3c64xx/mach-crag6410.c         |  1 -
> >  arch/arm/mach-s3c64xx/mach-smdk6410.c         |  1 -
> >  arch/arm/mach-sa1100/assabet.c                | 21 ++++++++----
> >  arch/arm/mach-sa1100/generic.c                |  5 +--
> >  arch/arm/mach-sa1100/generic.h                |  3 +-
> >  arch/arm/mach-sa1100/shannon.c                |  4 +--
> >  arch/sh/boards/mach-ecovec24/setup.c          | 22 +++++++++++--
> >  .../intel-mid/device_libs/platform_bcm43xx.c  | 17 ++++++++--
> >  drivers/regulator/fixed-helper.c              |  1 -
> >  drivers/regulator/fixed.c                     | 33 +++++++++----------
> >  include/linux/regulator/fixed.h               |  3 --
> >  21 files changed, 187 insertions(+), 62 deletions(-)
>=20
> This causes an HDMI display regression on Jetson TK1. From what I can
> tell, the problem is that we now get a double-inversion for low-active
> GPIOs. For example, we have this in the Jetson TK1 device tree:
>=20
> 		vdd_hdmi_pll: regulator@11 {
> 			compatible =3D "regulator-fixed";
> 			reg =3D <11>;
> 			regulator-name =3D "+1.05V_RUN_AVDD_HDMI_PLL";
> 			regulator-min-microvolt =3D <1050000>;
> 			regulator-max-microvolt =3D <1050000>;
> 			gpio =3D <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
> 			vin-supply =3D <&vdd_1v05_run>;
> 		};
>=20
> We've got GPIO_ACTIVE_LOW for the regulator's enable GPIO and since we
> don't have enable-active-high, the regulator core will treat the GPIO as
> low active. The presence of the GPIO_ACTIVE_LOW flag will cause the GPIO
> polarity to be inversed, transparently in gpiolib, and the lack of the
> enable-active-high property causes the GPIO polarity to inversed as
> well, so we effectively end up with a high-active enable GPIO for one
> which should really be low-active.
>=20
> This has always been a bit of an ambiguity since we've had two places
> for expressing the polarity. But I think given the move to pervasively
> using GPIO descriptors, it'd be reasonable to just ignore the
> enable-active-high property, or perhaps warn if we stumble across a
> low-active GPIO (via the flags in the specifier) if the regulator is
> also marked enable-active-high.
>=20
> > diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> > index 988a7472c2ab..1142f195529b 100644
> > --- a/drivers/regulator/fixed.c
> > +++ b/drivers/regulator/fixed.c
> > @@ -24,10 +24,9 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/driver.h>
> >  #include <linux/regulator/fixed.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/regulator/of_regulator.h>
> >  #include <linux/regulator/machine.h>
> > =20
> > @@ -78,10 +77,6 @@ of_get_fixed_voltage_config(struct device *dev,
> >  	if (init_data->constraints.boot_on)
> >  		config->enabled_at_boot =3D true;
> > =20
> > -	config->gpio =3D of_get_named_gpio(np, "gpio", 0);
> > -	if ((config->gpio < 0) && (config->gpio !=3D -ENOENT))
> > -		return ERR_PTR(config->gpio);
> > -
> >  	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
> > =20
> >  	config->enable_high =3D of_property_read_bool(np, "enable-active-high=
");
> > @@ -102,6 +97,7 @@ static int reg_fixed_voltage_probe(struct platform_d=
evice *pdev)
> >  	struct fixed_voltage_config *config;
> >  	struct fixed_voltage_data *drvdata;
> >  	struct regulator_config cfg =3D { };
> > +	enum gpiod_flags gflags;
> >  	int ret;
> > =20
> >  	drvdata =3D devm_kzalloc(&pdev->dev, sizeof(struct fixed_voltage_data=
),
> > @@ -150,25 +146,28 @@ static int reg_fixed_voltage_probe(struct platfor=
m_device *pdev)
> > =20
> >  	drvdata->desc.fixed_uV =3D config->microvolts;
> > =20
> > -	if (gpio_is_valid(config->gpio)) {
> > -		cfg.ena_gpio =3D config->gpio;
> > -		if (pdev->dev.of_node)
> > -			cfg.ena_gpio_initialized =3D true;
> > -	}
> >  	cfg.ena_gpio_invert =3D !config->enable_high;
>=20
> Change this line to:
>=20
> 	cfg.ena_gpio_invert =3D false;
>=20
> fixes the regression and is pretty much the implementation of my above
> suggestion to ignore enable-active-high, though we may eventually want
> to get rid of ena_gpio_invert altogether, provided that everyone has
> moved over to GPIO descriptors.
>=20
> Thierry

Forwarding this to linux-tegra for visibility.

Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsRE44ACgkQ3SOs138+
s6FuDQ/9HqEfVHiLOn0qYQtKJiMqyECDhv9PN1a9dVH9VErl1FSiNGc55CGdtE4k
/hlNpx4b54wcKsNMNGF6/UUO9LlMOHMl26c0RaGG+OC3Yux+2sw7lgCpnQIf5jUu
fE15AMcmuuHv2f04hP5YzHlPyd30YnDMuBoKKdICCDNh/sGZMBMm+a94+EqG9c/9
FHow6AjaZmxcOEBC4AhYDNyOS0z5XfXCFn0K0k75oZr1ujbg+u7cKDn2lI7r+yTU
Qjh0O6ejwLX+NoXPTB9x0iTwxB8MabWcB8EgC+SIaa4z1AMkxJIIpL92UBN4gYDN
Y9YAgbdU2DgJdOajtphysk48C5qA/su6ZNf+70sg3VXpFPOEFeUY75E4tfVriI+I
Rh5THMevylnuHJrsJ/5X0B4pN3ClXzwCcK3fs/h+mS898OdHRcmBuRoymMTewKlg
sJ4KiPVpz7OajWopndkaaj0Qo9Fc2cnYYlPd+pwZOzsisdkmFv7maQ3iT+ysiFit
GYJh/GvFgjZq/DyzFDpEFF2LDo46oLvkzHDFGh7pEjbPIdgow5ho26If1PfU5K+2
SKU7/CIUKaNvywVoiX0Brtga29NCpIWjP2EfOwuKt0c+4RSSjiM8GR1DYgHEgTu3
15ecpvHaw0ytOMj7HWucju9CC3P8bC11eQUrsQb7sIvZswO7H6E=
=S4e6
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
