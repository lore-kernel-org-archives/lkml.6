Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966513AbeCAK2o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:28:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38114 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935764AbeCAK2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:28:40 -0500
Date: Thu, 1 Mar 2018 11:28:36 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 0/3] Allwinner sunxi message box support
Message-ID: <20180301102836.odxjy4lak2spujii@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228082459.o3juhfiml3logxwl@flea>
 <398d54c4-8bfc-c459-f7d4-fba4665d1250@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q2dip6buehh4gsh7"
Content-Disposition: inline
In-Reply-To: <398d54c4-8bfc-c459-f7d4-fba4665d1250@sholland.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q2dip6buehh4gsh7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 11:18:50AM -0600, Samuel Holland wrote:
> On 02/28/18 02:24, Maxime Ripard wrote:
> > On Tue, Feb 27, 2018 at 08:27:11PM -0600, Samuel Holland wrote:
> >> This series adds support for the "hardware message box" in recent
> >> Allwinner sunxi SoCs, used for communication with the ARISC management
> >> processor (the platform's equivalent of the ARM SCP). The end goal is =
to
> >> use the arm_scpi driver as a client, communicating with firmware runni=
ng
> >> on the ARISC CPU.
> >>
> >> This driver has been tested with the base arm_scpi driver (which sends
> >> the SCPI_CMD_SCPI_CAPABILITIES command at probe time) and an in-progre=
ss
> >> firmware application running on the ARISC CPU. Because no firmware for
> >> the other end of the mailbox is complete at the moment, I have not
> >> included changes to the SoC device trees.
> >=20
> > This is not directly related to this series, but what is your end goal
> > with regard to SCPI? What features do you expect to have there?
>=20
> Current plans are to support in SCPI:
> - SMP bringup and CPU hotplug (via PSCI in ATF)
> - System reset and poweroff (via PSCI in ATF)
> - System standby and suspend (via PSCI in ATF)
> - DVFS for ARM CPUs
> - Clock control for clocks in R_PRCM (e.g. R_CIR_RX)
> - Thermal sensor reading
>=20
> Other planned features of the firmware:
> - System wakeup from poweroff (via GPIO or interrupt to firmware)
> - System power/suspend LED control (connected to GPIO or PMIC GPIO)
> - Polling of thermal sensor in firmware for thermal throttling

Nice.

> > I'm asking because last time we discussed this, SCPI wasn't able to abs=
tract
> > all the features the PMIC provides, and thus Linux needed to still be a=
ble to
> > access it.
>=20
> This should only be an issue for devices with AXP PMICs.

So this should only be an issue for most devices out there :)

> Other devices with GPIO or simple I=B2C regulator control, such as H3
> and H5 boards, can have all necessary features described with
> standard SCPI commands. SCPI provides for 127 vendor-defined
> "extended" commands, which could be used to build a full AXP PMIC
> driver, or simply provide commands to read/write PMIC registers.

So I'm not sure whether it was your plan, but the last plan that was
discussed was that the whole RSB bus would be put outside of Linux
control, hence why I was asking.

And in this case the RSB bus is used to access the PMIC, but also its
secondary devices such as the audio codec on the AC100/AC200, so we
really need to have access to the RSB bus in Linux. If you can
implement that through custom SCPI commands, that works for me though.

Another thing that I'm not quire sure about is how would interrupts be
reported throuh that mecanism? We want to use the PMIC as an interrupt
controller for things like VBUS detection, GPIOs or the Jack detect in
the codec. Is that doable?

> For the moment I'm not concerned with battery powered devices. So
> right now the relevant boards either a) don't have a PMIC, or b) can
> have everything but DVFS voltage hard-coded in the firmware.

I wasn't asking you to implement everything from the start, just that
you consider the rest in your design.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--q2dip6buehh4gsh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqX1dMACgkQ0rTAlCFN
r3QhAQ/9EnasFCsnPOlSBd8Lq9/+KLWQE3QSm4Xtzz4p1ZPF/e0Ph62kHmd86J62
smdkdbOfONuxRbIWw8qUFeQ5+HKRxUJDs58XnVK8pT9ylZBHhfphUPDe/QpzAJRf
1mdvceU1d01e6Ea/b4/QzMkt9QzasFMkqd1ZfUT6WE7DZp3pRy2UHGoOX00uG5Kf
1GaaJsLLfeMo8Qr/pealxr2PkoS+NPhpA+N0zOJFEsKkz/bblQaMYUEFgU0Q6VFh
H1z7qZnRKHzAMvkRUthNSJ3UISI1gKoRWo3SX9p2XtdKOzYxhqqYTUodRgcww10+
oJvnfeoD5hG+Hc5UhPIcIYuZAZMbdMYo9wNkQFtS+KpBGUEWU4wFG7Uql5lqv6kq
SBFhrt92IAF3vUVo7+RX9ZKKOv6JSJJXjiJVngijX7lwcmMNTeUW2NWoc7ZOUyOc
o2ImMrgyNIR1I7Z6Flj81EqVtorW1/WlthBftbob79rajPiMudyCAVriJQngoYYT
Dfe33ns25F1KqWhJ+oJZyCi/Yclji6P6CIY4JuAa1InG4iBsNiKRXRkkY+xOEh0U
6Z00IkiNOs4s+VFD1+VhBIguNsaqN4ulbmIuucyFuf3LZznf/gwdTW5h6oHAZ4dD
Aed6lDU99COANPbbJPoJFZeHXFaKwePruoNQtJ65yht4lUXtN6Y=
=4jx+
-----END PGP SIGNATURE-----

--q2dip6buehh4gsh7--
