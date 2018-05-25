Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965817AbeEYKZF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:25:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965102AbeEYKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:25:03 -0400
Date: Fri, 25 May 2018 11:24:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Message-ID: <20180525102458.GJ4828@sirena.org.uk>
References: <20180524055752.GE4249@localhost.localdomain>
 <20180524140118.GS4828@sirena.org.uk>
 <042F8805D2046347BB8420BEAE397A4016C06B47@WILL-MAIL002.REu.RohmEu.com>
 <20180524175721.GB4828@sirena.org.uk>
 <20180525055430.GB16888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmkJtp15SxLq1SbD"
Content-Disposition: inline
In-Reply-To: <20180525055430.GB16888@localhost.localdomain>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jmkJtp15SxLq1SbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2018 at 08:54:30AM +0300, Matti Vaittinen wrote:
> On Thu, May 24, 2018 at 06:57:21PM +0100, Mark Brown wrote:

> > You can look at the regulators node within the parent device, you know
> > that in Linux the parent device will be the MFD.

> So I should parse the device-tree in MFD my driver in order to locate
> the regulators node? Isn't that somewhat like code dublication? If we
> rely on compatibles we can avoid device-tree parsing in MFD driver,

No, there's no need to do this - the child can just look at the of_node
of the parent since it can never be instantiated otherwise.

> right? An in-tree example of this is:

There are some bad examples (and some where the same regulators can get
used with multiple different parents) but that's no reason not to follow
good practice.

--jmkJtp15SxLq1SbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsH5HoACgkQJNaLcl1U
h9Drrwf9H6otj10qIc8vXKx60U0IrSi0dtXfTKSeJMWeuElp1J7E6COsbouwImXE
uh+FgmF2eC5HgXWrkELT7Sc+9FfzxOHmievxmnB+cz5oL3Q64FkLO1W3vV6embAk
VF3Su3R+RPF+0jAFJm1cqOOVXWYKc1q9Dd8VTx3qCNXF93rCA9Q7V1XEBgIGlQqp
wRWI6/1gWaVatWtwGYqOXD9YWxHwMGSZu9QbyxYGY607df0pohuTQH5kHGXAGaVC
cNwyAH20E2i0YJuWhV4y7LDB9wi8+2dtQ57WlB+AT1A/jEQ41vrgMEt3YoubcCJf
KVuH0O+wzznJSPbgEvlcV2+nMIhZOQ==
=Ma5W
-----END PGP SIGNATURE-----

--jmkJtp15SxLq1SbD--
