Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeE3Qgx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:36:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51954 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeE3Qgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:36:48 -0400
Date: Wed, 30 May 2018 17:36:44 +0100
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
Message-ID: <20180530163644.GW6920@sirena.org.uk>
References: <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk>
 <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
 <20180530161311.GT6920@sirena.org.uk>
 <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aXNiKu4lnbRqA5kZ"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aXNiKu4lnbRqA5kZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 09:31:55AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:

> > If we're just going to use the most recently set voltage then hopefully
> > the hardware already knew that, and it might not be the lowest available
> > voltage if the last consumer to get turned off was holding the voltage
> > higher.

> To circle back to the original point: the problem is that (IMHO) the
> hardware is doing the wrong thing by still counting Linux's vote for a
> voltage even though Linux also voted that the regulator should be
> disabled.  So basically we're working around the hardware by
> pretending to vote for a dummy lower voltage whenever Linux wants the
> regulator disabled.  From Linux's point of view everything works as
> normal--we just tell the hardware a falsehood so it doesn't count our
> vote for a voltage while the regulator is disabled.

Yeah, and I don't think that's unreasonable for the core to do - just
drop the voltage to the constraint minimum after it has turned off the
regulator, then recheck and raise if needed before it enables again.

--aXNiKu4lnbRqA5kZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsO0xsACgkQJNaLcl1U
h9Agtwf+I81NatfMRn647f4v1D+5TzY5LKIT63m6HP7ZlC6S1WdaLKEZ+TU2wnWk
fcuCPLxowzFTwBRLgI3yg258uT9eir/f5m0jteKact4i3o4uAzpzXtgb6pMMvnug
k16LIeX2My8QeeJFSaKOH9UPhlavA4JI9gZo+yNje3b7oO0fuTlcJcQp7QSWfCAn
aEcEO/oovw6qrNyG9+U01J3fjkMtWvAAaX75tErSeswLFw5OAzyM6qrRfzwDHHgN
ySW29niz7c/X5Vqi+FUcRG8IBeBNJwzQdXhRvYH6chiiwmrhcVgIgw9ztMu/bXas
1V5YuFilrVaenIaenzesMJ9l3r5KRg==
=KkMi
-----END PGP SIGNATURE-----

--aXNiKu4lnbRqA5kZ--
