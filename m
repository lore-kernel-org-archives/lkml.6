Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeDXRlS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:41:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:41:16 -0400
Date: Tue, 24 Apr 2018 18:41:11 +0100
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, lgirdwood@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180424174111.GH22073@sirena.org.uk>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <20180419120813.GD27188@sirena.org.uk>
 <38f42537-f801-115a-4120-1344a67a0462@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <38f42537-f801-115a-4120-1344a67a0462@codeaurora.org>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 12:28:21PM -0700, David Collins wrote:
> On 04/19/2018 05:08 AM, Mark Brown wrote:

> > This doesn't sound like what the min_dropout_uV constraint is intended
> > to handle - that's there for the regulator driver (not constraints) to
> > indicate how much headroom the regulator needs in the supply voltage in
> > order to provide regulation.  It's not something the regulator uses,
> > it's something that gets fed into voltage requests made on the supply of
> > the regulator which I can't see that the hardware is going to be able to
> > handle unaided.

> RPMh hardware enforces the requested minimum headroom voltage for all
> regulators with a parent.  It has full knowledge of the parent-child
> connections of regulators on the board (as programmed by the bootloader).
> It automatically reconfigures the parent voltage when needed as a result
> of requests changing the voltage of any of its child regulators.

If the hardware has full knowledge of all these constraints and enforces
them transparently then why does the kernel care that it's doing that?
Doesn't it defeat the point of it doing all this stuff if we have to
know about it?

> > Ideally future versions of the RPM will have improved interfaces,
> > there's a bunch of problems like this :(

> Do you have a preference for qcom,regulator-initial-microvolt vs a generic
> framework supported regulator-initial-microvolt property for configuring a
> specific voltage at registration time?  We'll need to have support for one
> or the other in order for the qcom_rpmh-regulator driver to be functional.

This is basically specific to Qualcomm, I can't off hand think of any
other devices with similar issues.

> > Yes, constraints that specify a single voltage are done by setting min
> > and max to the same value.  fixed_uV is *only* for regulators that have
> > a physically fixed voltage.

> XOB managed regulators physically cannot change voltage.  Therefore, do
> you agree that it is reasonable to use fixed_uV for them?  Note that I
> removed init_data->constraints.apply_uV manipulation in version 2 of this
> patch.

If these regulators can't change voltage then surely we know what
voltage they have without needing it to be specified in DT?

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfbDYACgkQJNaLcl1U
h9Cufwf8DKt2VxymLwg5FehUKHJfKGDmmKX/slyzbnJvnx551yP4dfGyDDakVpmX
PwO8eaxHMezYNhc0itCZt4HGUnU2mBtOjRdkN8qM08K7sgWNoL7sK0Tl5xWiaq7h
PsaRiSb4i7iBG4QGa7z8Q7bqRqFS1xiFwwjGA9ljkrB3b7+v5kIj2Ylhx0MQQ8VB
S2dWZlEUz8dSTPLGjBSakFVhtCNs375iqWOYwXowkue1FsxZyn0cCObDrbJAEaBh
4EcuhIuSTkPbXeMNIQZjY3IwdRGy9OeftiVppWzUY2uUn0CGKOCW63tSoQAoj4AT
rLTfKf2CLxpa3KQ5Av6IA4YFNkmNjg==
=hSGr
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--
