Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeEQQq6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:46:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59070 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeEQQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:59 -0400
Date: Thu, 17 May 2018 15:09:48 +0900
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, lgirdwood@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180517060948.GI20254@sirena.org.uk>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <20180419120813.GD27188@sirena.org.uk>
 <38f42537-f801-115a-4120-1344a67a0462@codeaurora.org>
 <20180424174111.GH22073@sirena.org.uk>
 <d82ef514-b94f-8ed9-6b1e-e07de2a5f455@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <d82ef514-b94f-8ed9-6b1e-e07de2a5f455@codeaurora.org>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 24, 2018 at 01:46:21PM -0700, David Collins wrote:
> On 04/24/2018 10:41 AM, Mark Brown wrote:

> > If the hardware has full knowledge of all these constraints and enforces
> > them transparently then why does the kernel care that it's doing that?
> > Doesn't it defeat the point of it doing all this stuff if we have to
> > know about it?

> The RPMh hardware is aware of the parent-child connections between
> regulators as well as minimum headroom to ensure stable LDO voltage output
> for subregulated LDOs.  The intention of having the headroom be a
> configurable property for processors is to support usecases in which
> subregulated LDO loads are particularly sensitive to noise and require
> additional headroom.  Such usecases are board dependent and beyond the
> baseline configurations set in RPMh hardware.

So the hardware implementation is some hard coding stuff that doesn't
really adequately reflect reality?  This seems unfortunate.  However do
we really need to tell the hardware about the fact that we're adding
extra headroom - are there actual interactions with non-Linux things
here?

> >> XOB managed regulators physically cannot change voltage.  Therefore, do
> >> you agree that it is reasonable to use fixed_uV for them?  Note that I
> >> removed init_data->constraints.apply_uV manipulation in version 2 of this
> >> patch.

> > If these regulators can't change voltage then surely we know what
> > voltage they have without needing it to be specified in DT?

> In the case of XOB managed LDO regulators, the LDOs physically can be
> configured to different voltages by the bootloader.  However, the RPMh
> interface provides no mechanism for the application processor to read or
> change that voltage.  Therefore, we need a way to specify such voltages in
> a board specific (as opposed to driver specific) manner (i.e. device tree).

Is the kernel somehow prevented from varying these voltages?

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9HKgACgkQJNaLcl1U
h9BNLAf+MXHtZxYJQq5vjkWDr1x4ZTeTs9eBmLvqlxpkL2U2URCm2ZJWVirJt5fF
G9f+bcDiJTCeW0dNCR8Cs01LWKgYzoXa/pXlse8LEj3eUO9+RdqjsiyDoD5UfVPU
TAuMpkvwwnnA46U6OfIV4KIUf8/hNx5rI3R0fyURsrANuBdp47GvHKVhqIBwWYMc
n8rjy1bzOFT3TYTAwVtXVczMJrwDe0t1qshGfvOaMK7j7fmra2YVtRXFmCW8VVY1
bwpJwrfKpR1FOGitcqvyP7TLKQy9VtZiuNKpxI4akhIXuSwK5GaFxqwtmO1x8eKk
XoJRm8dQhKEpblnzBR2Urx7Fg131SA==
=vmht
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
