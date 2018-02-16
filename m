Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965213AbeBPLjX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:39:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53878 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965162AbeBPLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:39:13 -0500
Date: Fri, 16 Feb 2018 11:39:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Message-ID: <20180216113901.GC5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 11:07:39PM +0100, Sebastian Reichel wrote:

> +config SND_SOC_CPCAP
> +	tristate "Motorola CPCAP codec"
> +	depends on MFD_CPCAP
> +	default MFD_CPCAP
> +

We don't have default lines like this for other MFDs...

> +	SOC_ENUM("Hifi Left Phase Playback Switch",
> +		cpcap_hifi_l_phase_inv_enum),
> +	SOC_ENUM("Ext Left Phase Playback Switch",
> +		cpcap_ext_l_phase_inv_enum),

If this is a Switch control it should be a simple on/off binary control.
If it's an enumeration it shouldn't have Switch at the end of the name
since that's a keyword interpreted by userspace.  Either option seems
fine in this case, if it's a switch it should be "Foo Invert Switch" or
similar.

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGwtUACgkQJNaLcl1U
h9Bl0Qf9G0/FzroOGeLykBCGn9UJFAuxOww1IVCOSq1yX5MXbRzKLndkj7wl8xSr
0LZlqyI9uEMR7neVga+k982xlUUNz1OfJxbBJyiH/26Y3BXi1kZ+DOnjb/LItj8Y
IAHYvEn3ND6HjZtm2jf73BBCvkyAxBt/KuT87P/eOPov/F/ASsGhKZhs4agvGAId
2rUnSrG3X++fgMd2GhxOgl58MsGW+5O2CEgwom06UUTeiPgCoF1HaEuZoh3p4dZY
r6SPYStZlMFCNRqWrlfy2Yi5KwNCJwd2Y7u9spg94xMXI7j2V5Vbt42yrH1F6uz2
fReE5awls/jlY8KpC4hmo4tb0zDutQ==
=vnov
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
