Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161088AbeEXQ3u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:29:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34192 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031758AbeEXQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:29:44 -0400
Date: Thu, 24 May 2018 17:29:40 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mahadevan, Girish" <girishm@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180524162940.GA4828@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RUvhGz2nhX7DIu1B"
Content-Disposition: inline
In-Reply-To: <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RUvhGz2nhX7DIu1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 10:25:58AM -0600, Mahadevan, Girish wrote:

> The reason I have the cur_speed_hz is that there is a max_speed_hz which
> is the max frequency the slave can do; but every transfer can also
> specify a speed_hz and override this.

Every transfer *will* specify a speed, you should never see a transfer
that doesn't specify a speed.

> > delay_usecs is for inter-transfer delays within a message rather than
> > after the initial chip select assert (it can be used to keep chip select
> > asserted for longer after the final transfer too).  Obviously this is
> > also something that shouldn't be configured in a driver specific
> > fashion.

> Hmmm ok, so you mean don't send these as controller_data, rather add new
> members to the spi_device struct ?

Yes, that'd be one way to do it.

--RUvhGz2nhX7DIu1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsG6HQACgkQJNaLcl1U
h9As8Qf+MknPLWq8X+nQFKB+YjPA0NvhhdxC9pJqz2vwbRsNbhCgo9XcuC5YNFvD
BOyJy1yS3nM01E4E+4ZOsM1mTxRNk39lN46JxC9/SPtxcA/V9YF9AFMXyT1osHH7
YJPC+Roj+E23Q2gOzX6GLVKzn8fuk9gm1NNdVMpVzMuSXJssFOcBduuqWYxIpl/5
1vs/cOrqVTvaG3aXS6UsrjzWGvYH+OpmtTzlrk0W0pFRShSHCawostYh3rDQ8cSS
PgR2eXImIpIEOSdAU5DUi4m6QQQZN0kpqfrdBS9vBKQUB2LcPRZE+Wf4h1lQuz1P
Uh7p3NMTqtqahNOxXrCPnb6W7syDfg==
=4nP2
-----END PGP SIGNATURE-----

--RUvhGz2nhX7DIu1B--
