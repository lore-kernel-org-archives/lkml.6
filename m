Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbeEWP4Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:56:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeEWP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:56:20 -0400
Date: Wed, 23 May 2018 16:56:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180523155617.GN4828@sirena.org.uk>
References: <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7VkxxUl3xUvPtoxk"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7VkxxUl3xUvPtoxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 08:50:22AM -0700, Doug Anderson wrote:
> On Wed, May 23, 2018 at 8:40 AM, Mark Brown <broonie@kernel.org> wrote:

> > It's got to be valid to think about the voltage of a disabled regulator
> > since drivers want to be able make sure that the regulator gets enabled
> > with a sensible config.  With most hardware this is really easy since
> > you can just look at the status reported by the hardware but the RPM
> > makes this hard since there's so much write only stuff in there.

> I should be more clear.  Certainly it should be valid to set the
> voltage before enabling it so, as you said, the regulator turns on at
> the right voltage.  I'm saying that it's weird (to me) to expect that
> setting the voltage for a regulator that a client thinks is disabled
> will affect any real voltages in the system until the regulator is
> enabled.  In RPMh apparently setting a voltage of a regulator you
> think is disabled can affect the regulator output if another client
> (unbeknownst to you) happens to have it enabled.

Yes, that's definitely not what's expected but it's unfortunately what
the firmware chose to implement so we may well be stuck with it
unfortunately.

--7VkxxUl3xUvPtoxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFjyAACgkQJNaLcl1U
h9Bbhgf+KPFRcR938/oF3MQB7RnAJXl7M0vkyJAeZEKoCm8Etp3Rju0+rgcUNwOu
oSq43pXLrLGW7yABVYFa1mitG3+0YDXSqt3mDWVkCi+3LIsOe9B0VmYGXbTdlurD
ZYhXO/6dxfqDnRxXuxEPdRxnBp2xwSCu4NW0bDawtPZDzuHu1n+DbE2X4cJL+GFn
PTiigFa9ivjAE7vYO61vCzdJno7CaJeaWvIdz5FMTbf9q9GM94+t02Odxj0EkTAf
qgJ/UBB9z9H43LpplUE7NmP35HBCiJa0xoKVx8nRoe0Y9ca6A8+XJNOS/RY+iYBZ
g4/qb8dGHtw/gPirWWJ30Fe3AH8IFA==
=DvZM
-----END PGP SIGNATURE-----

--7VkxxUl3xUvPtoxk--
