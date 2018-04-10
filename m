Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeDJODr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:03:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60302 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeDJODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:03:46 -0400
Date: Tue, 10 Apr 2018 15:02:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Adam.Thomson.Opensource@diasemi.com,
        Jia-Ju Bai <baijiaju1990@gmail.com>, lgirdwood@gmail.com,
        sathyanarayana.nujella@intel.com, perex@perex.cz,
        alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Message-ID: <20180410140251.GB14657@sirena.org.uk>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
 <482591fb-bf12-2e0a-e0ef-2ae0b4095000@linux.intel.com>
 <s5h3704dvad.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <s5h3704dvad.wl-tiwai@suse.de>
X-Cookie: You will lose an important disk file.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 09:39:06PM +0200, Takashi Iwai wrote:

> It must be sleepable context as it's a standard platform driver probe
> callback.

> And now looking at grep output, only sound/soc/intel contains so many
> calls with GFP_ATOMIC.  I bet that almost all can be done with
> GFP_KERNEL, maybe only one or two in atom/sst would be conditionally
> with GFP_ATOMIC.

Yeah, it's not like it'd be the first code quality problem found in the
Intel drivers.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrMxAoACgkQJNaLcl1U
h9Af9Qf9G3jjm88KOaPES27ZSNhU49vRVZfy2H5IzqPPi6vt/ibAMs7WLTzKA7Bi
94SoRQjmZZRjXOq2x2kMLmR1m/+EmkvExHFwy3pFiFJ8yWak64egJDUR2lOnb5Fm
PEzJyMpEPBxySkhkhLs2JSlHhqxyErrLHX070fPviy68c7kkmO4JadcMVHqzclAf
chQvTrP+PG17VuzfcUFjIuziSEOQqDSz/ZRC7wpptorIHhVw9JK0p/6P47lkb0/M
9F9oQ5tpDwZlg+T965LUh98vBFE7J1jdRI3jqhrV3C/JAk4yM0X6+kscZsjiTAQY
7DD/S0COX89nr6Ih9wJQjCnU404nzA==
=H+RI
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
