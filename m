Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755721AbeDQQJ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:09:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47924 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755702AbeDQQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:09:52 -0400
Date: Tue, 17 Apr 2018 17:09:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>, Lubomir Rintel <lkundrak@v3.sk>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dwc: I2S Controller instance param added
Message-ID: <20180417160908.GH8973@sirena.org.uk>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1523941201-15665-2-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <1523941201-15665-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: Depart in pieces, i.e., split.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2018 at 10:29:51AM +0530, Vijendar Mukunda wrote:

> +#define I2S_SP_INSTANCE		1
> +#define I2S_BT_INSTANCE		2

This is obviously very specific to the system you're working with and
therefore doesn't belong in the generic driver.  The device should be
dealing with its own configuration, it shouldn't need to know about what
specifically is connected to it.  It's not even clear what they're doing
in this driver given that there doesn't appear to be any use of the
information, it feels like this is something that the machine driver
should be encapsulating.

Like I said with previous reviews this use of magic numbers for the
interfaces is a bit of a red flag, internally within a driver they're
fine but they shouldn't leak out too much except with things like
numbering an array.

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrWHCMACgkQJNaLcl1U
h9Di6gf+OJibGxzubgayG7ifz4l34Kbp5ZRW6szH0M6TztbcmeysSMwbAsBzJo3i
DdyCxbfXeci1B0s7/Aa+3vACu7hIfuSkuZVRa72CFVmiNfexf73KIAEpbDNCgWZc
9+VSNvnHx966KOt6vZRdSBN8fyM2DlGWLfSyHyjFVSTJZwXHUGUv1LO3dpVtSLXr
JX+JMJvMUTrr0XnTJ8ptVIKtOgQqAXk45XTBqXAwcpFmDijyXZWlRbDiwcOamm2S
zdD+w2pvpc2QuGfBC9+gUz8LUt9UEwh1RBblrWOiZAzoClhn/xDViahbtgpkt5w8
g52fuIiUnmQvzVdpJuT7b1Yq6AJqMg==
=e7UT
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
