Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBAO0G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:26:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeBAO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:26:05 -0500
Date: Thu, 1 Feb 2018 14:24:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: Ladislav Michl <ladis@linux-mips.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: stm32: add of dependency for
 stm32 drivers
Message-ID: <20180201142455.GB10785@sirena.org.uk>
References: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
 <20180201091012.GA10746@lenoch>
 <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
X-Cookie: $3,000,000.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 01:19:28PM +0000, Olivier MOYSAN wrote:
> On 02/01/2018 10:10 AM, Ladislav Michl wrote:

> > depends on (ARCH_STM32 && OF) || COMPILE_TEST ?

> I can find in many configs "depends on OF && (ARCH_X || COMPILE_TEST)"
> This seems reasonable to me, as the driver always requires OF=20
> dependency, regardless the compilation context.
> In fact, I cannot see why OF would not have to be selected
> for COMPILE_TEST.

There are some OF functions that are stubbed out when OF is disabled and
some that aren't, if the driver is using the more obscure APIs that
aren't stubbed it needs the hard dependency but if it's using the other
bits that do have the stubs then it can be compile tested without OF
being abled.

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpzIzYACgkQJNaLcl1U
h9AyAQf+Meui41IfjGEXX68Ml4jX9krdGjzE3bdVK6etUerjl4R1RgKGvB2cXyeI
u0NVrVL4We94NUHB6jVnZPOPkRmIOWHB15TkJd4Zp9Nc6tObQMmn0tJsuU6TJjer
3PE342uRbyI6Z4LuXjSbZI7iiwCdgYxVFVF6cDKNzKbaPTUqyNLwDHnmVIXxd8X5
LC61ITMnH4/hDPoKSep92Uv2FgDpydIXs3RINSLKH+fbisw/Cm756990anK9t8EB
ffP0QSbfQoDWN+FHul00zYhSOpv9BqJEfFhaFdLiI6k5wTgRTs54w9xJWfzPYNNL
sdqvOLxUrnVcx7I3TIp71+8KNy44XA==
=Dn27
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
