Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBIPrx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:47:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35468 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeBIPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:47:51 -0500
Date: Fri, 9 Feb 2018 15:47:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Message-ID: <20180209154746.GA10104@sirena.org.uk>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
 <20180131170330.GB7763@sirena.org.uk>
 <1518171736.19973.7.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1518171736.19973.7.camel@nxp.com>
X-Cookie: f u cn rd ths, itn tyg h myxbl cd.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2018 at 10:22:16AM +0000, Cosmin Samoila wrote:

> > > +static const char * const ak4458_dac_select_texts[] = { "OFF",
> > > "ON" };
> > This looks like the users should be switch controls - what's the goal
> > here?

> I think this is to allow users to switch off sound for all channels but
> it seems silly to have 4 controls doing the same thing.
> We now have two options:
> - one control to switch off sound for all channels
> - one controll per DAC

If they're mutes they shouldn't be in DAPM at all, just make them
standard controls - they should stack up with the matching volume
controls.

> What do you mean by "users should be switch controls" ?
> Should we use SND_SOC_DAPM_SWITCH instead of SND_SOC_DAPM_MUX?

They quite clearly aren't muxes so if they need to be in DAPM probably
switches but it's not clear that they need to be in DAPM.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp9wqIACgkQJNaLcl1U
h9Dytwf7BvqgidVkfdFep3z7nEGdH+Z7pP7MHkL9WikBp0BQ1dNw2I2RYeRWdSeC
I8Pg9HZnr25ofiC6VZhBZzxlk3EEFxHtWxscaqDe7atcj9RJWEjGFoJAQpBW+kwi
BcDjUlq5Gr6wNvJ+mw58hRzI3r6rJ3Fz60k+AkeekeFxqBbvh8yOv/+fbKQ412re
bEBk0WDYwSXyO7AoaFsYVAO5JJOkek0hhnkla9m/NjuViRP+IUnM069wmywxSp05
KybSKljp+HO3Atg4fzZZ/i6W/XI9To/6ShS/GblUwVH+u5udaMgynplsAOtrOF33
c2Kz91eTV/Z7CxYqp26xc8978Cm2Vg==
=nfT0
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
