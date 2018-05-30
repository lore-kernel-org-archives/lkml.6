Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeE3Qdw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:33:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbeE3Qdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:33:47 -0400
Date: Wed, 30 May 2018 17:33:43 +0100
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v4 0/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180530163343.GV6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
Content-Disposition: inline
In-Reply-To: <cover.1527040878.git.collinsd@codeaurora.org>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 07:43:16PM -0700, David Collins wrote:
> This patch series adds a driver and device tree binding documentation for
> PMIC regulator control via Resource Power Manager-hardened (RPMh) on some
> Qualcomm Technologies, Inc. SoCs such as SDM845.  RPMh is a hardware block

So, this is a very big driver and obviously it being RPM based it
doesn't look like other regulators which is causing problems, especially
when coupled with the desire to implement a bunch of more exotic
features like the mode setting.  I think this review is going to go a
lot more smoothly if you split this up into a base driver with just
normal, standard stuff that doesn't add too many custom properties or
unusual ways of working and then a series of patches on top of that
adding things like the mode adjustment and interaction with other RPM
clients.

We've got other RPM based regulators in tree already so the baseline bit
shouldn't be too hard, that'll make the rest of the patches much smaller
and easier to review and mean that the bits that are simpler and easier
to cope with don't need to be reposted.

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsO0mYACgkQJNaLcl1U
h9Ci/Af6AwaPbNNY3vvBsWxCyE2pVb/OfZff8RFOfNQwK7S7T/Q9zMpuT+hGGs+B
LemjKDrAEQbXERmfxDOslAp1+Le2p/b/fphDxhD4y75f1EOCFyo3AdxrYfDuNlW5
6IbTL69vN9u8umsplYEfho1efx8Spigj3zD+sEydmtebVYxPaXPLBIbBXaS13YIo
rApcrZKZM07D+KnLxEQcMCjmWEyNnaav1Rip1KSQ1wx3zrS/juoFMZOmkIvn+qnc
UMDb7U2FSBbfWFhTjVt4U+rAfkvnxNLA/76pWXWf7Gn26WQB/iuhZwcz9BbYgqgf
52pr3JyQSyTIxsfccorB46GD6Tg95w==
=aKLR
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
